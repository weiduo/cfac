C
      SUBROUTINE RECOMB(Z,S,TE,RR,RDIEL)
C
C=====================================================
C CE SOUS-PROGRAMME CALCULE LE TAUX DE RECOMBINAISON
C EN UTILISANT ALDROVANDI ET PEQUIGNOT, SHULL ET AL.
C SEATON,PRADHAN,YOUNGER,STOREY,BELY DUBAU,JACOBS
C
C S EST LE NUMERO DE L'ION QUI VA SE RECOMBINER
C Z EST LA CHARGE NUCLEAIRE DE L ELEMENT
C TE EST LA TEMPERATURE EN KELVIN
C RR LE TAUX DE RECOMBINAISON RADIATIVE EN CM+3/S
C RDIEL LE TAUX DE RECOMBINAISON DIELECTRONIQUE
C=====================================================
C
      IMPLICIT REAL*8 (A-H,O-Z)
      REAL*8 KTEV
      INTEGER Z,S,Z1
      DIMENSION AR(166),ETA(166),POTLI(28)
      DIMENSION ASTOR(18),BSTOR(18),CSTOR(18),DSTOR(18),FSTOR(18)
      DIMENSION ID(28),KSTOR(28),ISTOR(28)
      DIMENSION ADI(166),T05(166),BDI(166),T15(166)
      DATA POTLI/0.,0.,5.39,18.2,37.9,64.5,97.9,138.,185.,239.,
     &300.,367.,442.,523.,612.,700.,809.,918.,1034.,1157.,1288.,
     &1425.,1569.,1721.,1880.,2045.,2218.,2399./
      DATA ID/0,1,3*0,2,8,15,0,23,0,33,0,45,0,59,0,
     &75,0,93,5*0,113,0,139/
      DATA KSTOR/5*0,4,5,6,3*0,2,3,4,14*0/
      DATA ISTOR/5*0,1,4,8,3*0,13,14,16,14*0/
      DATA ASTOR/.0108,1.8267,2.3196,0.,.032,-.8806,.4134,0.,
     &-.0036,0.,.0061,-2.8425,1.2044,0.0710,0.7086,-0.0219,
     &3.2163,0.1203/
      DATA BSTOR/-.1075,4.1012,10.7328,.6310,-.6624,11.2406,
     &-4.6319,.0238,.7519,21.879,.2269,.2283,-4.6836,-0.4079,-3.1083,
     &0.4364,-12.0571,-2.6900/
      DATA CSTOR/.2810,4.8443,6.883,.199,4.3191,30.7066,25.9172,
     &.0659,1.5252,16.273,32.1419,40.4072,7.6620,2.3487,7.0422,
     &0.0684,16.2118,19.1943/
      DATA DSTOR/-.0193,.2261,-.1824,-.0197,.0003,-1.1721,-2.229,
     &.0349,-.0838,-.7020,1.9939,-3.4956,-0.5930,-0.1309,0.5998,
     &-0.0032,-0.5886,-0.1479/
      DATA FSTOR/-.1127,.596,.4101,.4398,.5946,.6127,.2360,.5334,
     &.2769,1.1899,-.0646,1.7558,1.6260,0.6126,0.4194,0.1342,0.5613,
     &0.1118/
      DATA ADI/1.27,2.54,6.15,1.62,47.8,32.2,0.,2.98,7.41,11.3,2.62,75.,
     &46.1,
     $0.,1.11,5.07,14.8,18.4,4.13,106.,47.2,0.,.977,2.65,3.69,11.8,2
     $4.4,30.2,6.10,252.,71.4,0.,.449,1.95,5.12,7.74,11.7,36.9,36.3,41.5
     $,8.86,252.,92.8,0.,1.1,5.87,5.03,5.43,8.86,16.8,24.9,31.3,42.5,61.
     $8,13.8,327.,113.,0.,1.62,10.9,33.5,31.4,12.7,14.7,13.4,23.8,31.9,
     $71.3,80.,79.6,13.4,402.,145.,0.,1.,11.,34.,48.0,75.,63.5,26.,24.,2
     $1.,35.,43.,71.3,96.,85.,17.,476.,178.,0.,.328,58.4,112.,132.,133.,
     $126.,139.,95.5,40.2,41.9,25.7,44.5,54.8,71.3,109.,110.,20.5,54
     $9.,268.,0.,1.58,8.38,15.4,37.5,117.,254.,291.,150.,140.,100.,200.,
     $240.,260.,190.,120.,350.,66.,100.,130.,230.,140.,110.,41.,747.,
     $369.,0.,1.41,5.2,13.8,23.,41.9,68.3,122.,300.,150.,697.,709.,644.,
     $525.,446.,363.,302.,102.,270.,46.7,83.5,99.6,199.,240.,115.,31.6,
     $803.,345.,0./
      DATA BDI/300.,44.2,58.8,343.,362.,315.,0.,0.,76.4,164.,243.,350.,
     &309
     $.,0.,92.5,181.,305.,100.,162.,340.,0.,0.,73.,242.,1010.,391.,252
     $0.,445.,254.,304.,296.,0.,21.,74.,323.,636.,807.,351.,548.,233.,31
     $8.,315.,0.,0.,0.,753.,188.,450.,0.,1800.,1880.,2010.,1220.,303.,
     $1420.,306.,286.,0.,0.,12.,65.9,68.9,187.,129.,1040.,1120.,1400.,
     $1000.,555.,1630.,304.,298.,281.,0.,5.,45.,57.,87.,76.9,140.,120.,
     $100.,1920.,1660.,1670.,1400.,1310.,1020.,245.,294.,277.,0.,90.7,1
     $10.,17.4,132.,114.,162.,87.8,263.,62.7,61.6,2770.,2230.,2000.,1820
     $.,1740.,243.,185.,292.,0.,0.,456.,323.,310.,411.,359.,97.5,229.,
     $4200.,3300.,5300.,1500.,700.,600.,500.,1000.,0.,7800.,6300.,5500.,
     $3600.,4900.,1600.,4200.,284.,0.,0.,469.,357.,281.,128.,41.7,55.8
     $,34.6,0.,1900.,277.,135.,134.,192.,332.,337.,121.,51.4,183.,7560.,
     $4550.,4870.,2190.,1150.,1230.,132.,289.,286.,0./
      DATA T05/4.7,1.57,1.41,.819,34.,40.6,0.,2.2,2.01,1.72,1.02,47.5,54
     $.4,0.,1.75,1.98,2.41,2.12,1.25,62.5,60.,0.,3.11,2.84,2.24,2.70,3.
     $09,2.83,1.68,140.,110.,0.,.501,6.06,4.69,3.74,3.28,4.80,3.88,3.39,
     $2.11,140.,145.,0.,.77,.963,.875,10.5,11.4,4.85,4.15,3.66,3.63,3.88
     $,2.51,188.,199.,0.,1.25,1.92,1.89,1.68,1.38,18.,6.90,5.84,5.17,
     $6.66,6.,5.09,2.91,241.,254.,0.,3.2,2.9,2.39,2.56,2.50,2.1,1.8,27
     $.,8.3,6.95,6.05,6.68,6.5,5.3,3.55,301.,313.,0.,.346,3.85,4.08,
     $3.82,3.53,3.19,3.22,2.47,2.29,37.3,9.26,7.96,6.9,6.7,7.00,5.67,4.2
     $1,365.,374.,0.,.6,1.94,3.31,4.32,6.28,7.5,7.73,2.62,2.5,2.57,2.84,
     $8.69,4.21,4.57,2.85,81.8,15.1,13.0,11.9,10.9,9.62,7.23,4.23,584.,
     $600.,0.,.982,2.01,3.05,4.2,5.56,6.72,7.93,9.,10.,7.81,7.64,7.44,
     $6.65,5.97,5.24,4.96,4.46,84.9,13.6,12.3,10.6,12.5,12.3,3.32,6.45,
     $665.,681.,0./
      DATA T15/.94,3.74,1.41,1.59,5.87,8.31,0.,0.,.737,2.25,1.25,8.35
     $,11.4,0.,1.45,3.35,2.83,2.83,2.27,11.2,14.7,0.,2.06,3.07,2.94,
     $5.5,9.91,17.3,6.13,18.,22.4,0.,.281,14.4,7.55,7.88,10.2,9.73,
     $7.38,3.82,15.4,26.4,30.9,0.,0.,0.646,0.471,7.98,0.,10.3,19.1,21.1,
     $21.4,11.2,39.3,36.,41.4,0.,0.,0.180,1.59,.804,1.71,17.5,21.5,25.9,
     $29.1,23.2,24.1,63.7,10.4,46.7,53.,0.,3.1,5.5,6.,3.81,3.3,2.15,2.15
     $,33.,35.,36.,38.,29.,36.,28.,11.,60.5,65.4,0.,.164,2.45,4.27,6.92,
     $8.78,7.43,6.99,4.43,2.81,58.4,48.9,46.2,45.2,33.2,49.3,44.1,22.7,
     $72.5,76.8,0.,.897,1.71,2.73,3.49,5.29,4.69,6.54,13.2,13.3,14.1,
     $15.2,15.1,18.2,18.4,23.1,0.,99.8,99.8,100.,110.,83.4,101.,107.,
     $117.,99.7,0.,1.01,1.91,2.32,3.18,4.55,5.51,5.28,0.,5.5,8.87,18.,
     $12.5,18.9,8.84,12.9,6.24,15.9,80.1,93.2,94.5,94.5,80.1,75.7,26.4,
     $19.3,119.,90.8,0./
      DATA AR/4.3,4.7,23.,49.,91.6,170.,330.,4.1,22.,50.,94.,157.,290.,
     #480.,3.1,20.,51.,96.,159.,244.,720.,671.,2.2,15.,44.,91.,150.,
     #230.,346.,570.,860.,1160.,1.4,8.8,35.,77.,140.,230.,320.,460.,
     #683.,1130.,2160.,1810.,5.9,10.,37.,55.,120.,210.,300.,430.,580.,
     #770.,1430.,2150.,3200.,2640.,4.1,18.,27.,57.,120.,170.,270.,400.,
     #550.,740.,920.,1400.,2000.,2910.,4300.,3680.,3.77,19.5,32.3,60.3,
     ]91.2,158.,269.,355.,490.,692.,955.,1230.,1580.,2140.,3070.,
     ]4360.,5800.,4910.,1.12,6.78,39.6,70.8,107.,180.,240.,376.,504.,
     $646.,851.,1180.,1580.,2040.,2600.,3240.,4610.,5620.,8440.,
     ]6350.,1.42,10.2,33.2,78.,151.,262.,412.,605.,813.,1090.,
     ]1330.,1640.,2000.,2410.,2890.,3420.,3870.,4520.,5250.,6070.,
     ]6980.,7720.,11500.,15800.,14000.,12000.,3.6,10.,14.,16.,38.5,
     ]90.5,175.,304.,891.,1190.,1500.,1910.,2290.,2630.,3160.,
     ]3630.,4030.,4730.,5250.,5750.,6380.,7080.,7940.,8710.,13600.,
     ]18700.,10600.,14500./
      DATA ETA/.672,.624,.645,.803,.791,.721,.726,.608,.639,.676,.765,
     $.780,.750,.726,.678,.646,.666,.670,.759,.774,.834,.726,.759,.693,
     $.675,.668,.684,.704,
     $.742,.803,.769,.726,.855,.838,.734,.718,.716,.695,.691,.711,.765,
     $.829,.821,.726,.601,.786,.693,.821,.735,.716,.702,.688,.703,.714,
     $.823,.858,.818,.726,.630,.686,.745,.755,.701,.849,.733,.696,.711,
     $.716,.714,.755,.806,.840,.807,.726,.651,.752,.869,.812,.811,.793,
     $.744,.910,.801,.811,.793,.702,.790,.774,.819,.854,.803,.726,.900,
     $.800,.700,.780,.840,.820,.820,.810,.780,.900,.820,.810,.800,.730,
     $.800,.780,.833,.839,.819,.726,.891,.843,.746,.682,.699,.728,.759,
     $.790,.810,.829,.828,.834,.836,.840,.846,.850,.836,.824,.816,.811,
     $.808,.800,.852,.875,.787,.726,.700,.700,.700,.700,.746,.682,.699,
     $.728,.759,.790,.810,.829,.828,.834,.836,.840,.846,.850,.836,.824,
     $.816,.811,.808,.800,.842,.868,.732,.726/
C
      U = 0.0
      
      KTEV=TE/11605.
      TL=DLOG10(TE)
      RDIEL=0.
      RR=0.
      RSTOR=0.
C
      IZ=ID(Z)+(S-2)
      Z1=Z-1
C
C========================================================
C RECOMBINAISON RADIATIVE
C========================================================
C
C
C IONS HYDROGENOIDES ( SEATON)
C------------------------------------------------------
C
      IF(S.GT.Z.OR.Z.EQ.1) THEN
      ALAM=157890.*Z*Z/TE
      RR=5.197D-14*Z*DSQRT(ALAM)*(.4288+.5*DLOG(ALAM)+.469*
     &(ALAM**(-1./3.)))
      RETURN
      ENDIF
C
C AUTRES IONS
C---------------------------------------------
C
      IF(Z.EQ.11) GO TO 51
      IF(Z.EQ.13) GO TO 52
      RR=1.E-13*AR(IZ)/((TE/10000.)**ETA(IZ))
C
C=======================================================
C RECOMBINAISON DIELECTRONIQUE
C========================================================
C
C
C RECOMBINAISON DES HELIUMOIDES DE YOUNGER
C-----------------------------------------
  21  IF(S.EQ.Z1) THEN
      ZA=DFLOAT(Z-1)
      ZB=DFLOAT(Z-2)
      X=3.*ZA/4.
      AX=DSQRT(X)/(2.*(1.+0.21*X+.03*X*X))
      D=3.*ZA*ZA/(ZB*ZB*(1.+.015*(ZB**3.)/(ZA*ZA)))
      XY=ZB*ZB+13.4
      XX=ZA**2.5
      B=ZB*(XX)/(2.*DSQRT(XY))
      CHI=KTEV/POTLI(Z)
      Y3=D/CHI
      IF(Y3.GT.150.) Y3=150.
      RDIEL=3.2D-10*B*AX*DEXP(-Y3)/((CHI**1.5)*(ZB**3.))
      RETURN
      ENDIF
C
C AUTRES IONS
C------------
      ARG = 1.D+5 * T15(IZ) / TE
      IF (ARG .GT. 150.) ARG = 150.
      FF=1.E-3*BDI(IZ)*DEXP(-ARG)
      ARG = 1.D+5 * T05(IZ) / TE
      IF (ARG .GT. 150.) ARG = 150.
      FACT=DEXP(-ARG)*(1+FF)
      RDIEL=1.E-3*ADI(IZ)*(TE**(-1.5))*FACT
C
C CORRECTION DES FITS DE SHULL A HAUTE TEMPERATURE
C POUR NEVII,NEVIII,SVI,SXIII,SXIV,CAXVIII
C--------------------------------------------------
C
      IF(Z.EQ.10) THEN
      IF(S.EQ.7.AND.TL.GE.6.35) RDIEL=1.22D-6/(TE**.81)
      IF(S.EQ.8.AND.TL.GE.6.35) RDIEL=1.52D-7/(TE**.77)
      RETURN
      ENDIF
C
      IF(Z.EQ.16) THEN
      IF(S.EQ.6.AND.TL.GE.6.5) RDIEL=1.08D-2/(TE**1.46)
      IF(S.EQ.13.AND.TL.GE.6.6) RDIEL=5.20D-6/(TE**.86)
      IF(S.EQ.14.AND.TL.GE.6.7) RDIEL=8.00D-10/(TE**.41)
      RETURN
      ENDIF
C
      IF(Z.EQ.20) THEN
      IF(S.EQ.18.AND.TL.GE.6.8) RDIEL=6.29D-3/(TE**1.41)
      RETURN
      ENDIF

C
C CORRECTION A BASSE TEMPERATURE
C
C I- RECOMBINAISON DE CII,CIII,CIV;NII,NIII,NIV,NV;OII,OIII,OIV,OV,OVI
C    MGII,ALII,ALIII,SiII,SiIII,SiIV A BASSE TEMPERATURE NUSSBAUMER ET STOREY
C---------------------------------------------------------------------------
C
  22  IF(TE.LE.6.D+4.AND.S.LE.KSTOR(Z)) THEN
      IST=ISTOR(Z)+S-2
      T4=TE/10000.
      AS=DEXP(-FSTOR(IST)/T4)
      AS=AS/(T4**1.5)
      AS=AS*(BSTOR(IST)+T4*CSTOR(IST)+T4*T4*DSTOR(IST)+ASTOR(IST)/T4)
      RSTOR=1.D-12*AS
C
C II- CORRECTION DES FITS DE SHULL A BASSE TEMPERATURE
C     POUR SI II,SI III
C-----------------------------------------------------
C
      IF(Z.EQ.14) THEN
      IF(S.EQ.2.AND.TL.LE.4.3) RDIEL=4.35D-23*(TE**2.64)
      IF(S.EQ.3.and.TL.LE.4.7) RDIEL=8.16D-3*DEXP(-1.07D+5/TE)/(TE**1.5)
      ENDIF
C
      RDIEL=RSTOR+RDIEL
      RETURN
      ENDIF
C
C
C-----------------------------------------------------------------------------
      RETURN
C
C
C
C CALCUL DE NA, AL PAR 'INTERPOLATION' (ORDRE ZERO)
C-------------------------------------------------
  51  IF(S.EQ.2) THEN
        IZ1=34
        IZ2=48
      ELSE
        IZ1=23+(S-3)
        IZ2=33+(S-1)
      ENDIF
      GO TO 53
C
  52  IF(S.EQ.2) THEN
        IZ1=46
        IZ2=62
      ELSE
        IZ1=33+(S-3)
        IZ2=45+(S-1)
      ENDIF
C
C RECOMBINAISON RADIATIVE
C
  53  RR1=1.E-13*AR(IZ1)/((TE/10000.)**ETA(IZ1))
      IF(RR1.LT.1.D-38) RR1=1.D-38
      RR2=1.E-13*AR(IZ2)/((TE/10000.)**ETA(IZ2))
      IF(RR2.LT.1.D-38) RR2=1.D-38
      IF(S.EQ.2) THEN
      RR=RR1*RR1/RR2
      else
      AA=DFLOAT(S-1)/DFLOAT(S-2)
      AB=DFLOAT(S)/DFLOAT(S-2)
      U=DLOG10(AA)/DLOG10(AB)
      RR=RR1*((RR2/RR1)**U)
      ENDIF
      IF (S.EQ.Z1) GO TO 21
C
C RECOMBINAISON DIELECTRONIQUE
C
 54   Y1=1.E+5*T15(IZ1)/TE
      IF(Y1.GT.150.) Y1=150.
      FF1=1.E-3*BDI(IZ1)*DEXP(-Y1)
      Y1=1.E+5*T05(IZ1)/TE
      IF(Y1.GT.150.) Y1=150.
      FF1=DEXP(-Y1)*(1+FF1)
      RDIEL1=1.E-3*ADI(IZ1)*(TE**(-1.5))*FF1
      IF(RDIEL1.LT.1.D-38) RDIEL1=1.D-38
      Y2=1.E+5*T15(IZ2)/TE
      IF(Y2.GT.150.) Y2=150.
      FF2=1.E-3*BDI(IZ2)*DEXP(-Y2)
      Y2=1.E+5*T05(IZ2)/TE
      IF(Y2.GT.150.) Y2=150.
      FF2=DEXP(-Y2)*(1+FF2)
      RDIEL2=1.E-3*ADI(IZ2)*(TE**(-1.5))*FF2
      IF(RDIEL2.LT.1.D-38) RDIEL2=1.D-38
      IF(S.EQ.2) THEN
      RDIEL=RDIEL1*RDIEL1/RDIEL2
      ELSE
      RDIEL=RDIEL1*((RDIEL2/RDIEL1)**U)
      ENDIF
C
      GO TO 22
C
      END
