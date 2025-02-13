Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A9BC02198
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 10:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739527602; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=7iePxuXWSN/h7k3lMeNdM+XA74XsOFUGQsYu+/I5yos=;
 b=ZzMiD0qNjrfMv6tWN7snb9GIF4U0QCZJBdqBVrC6uM6xXi5RWJUyDhqdgr+b5nK6IkKcv
 TzgMb3KDBg/toJO4epX4A+BMiP49NkSvbC8x5faAtCHPcUaknRJbD/bOE0MVPUnh136XTti
 XJQdvAtigRvscdRJ8R0I9YSdRT93TJs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2074A3C9ACE
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 11:06:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 896C73C1B29
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 15:25:03 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=rhythm.m.mahajan@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 06C951020960
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 15:25:00 +0100 (CET)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fVsV022152;
 Thu, 13 Feb 2025 14:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:message-id:mime-version:subject:to; s=
 corp-2023-11-20; bh=+9s2NotD/oEu4ie2oBee+4ZxKao6BTyxLdanXir5HMA=; b=
 c3DAkqgJeWIJmVYIZM/qSPNzAMd2dB6RrQhL5jZ8hPspAOt8+eYSPFxxGeva6sNK
 5s+gtoHBPMr3MUECPbGxEcdlEQhxIzRBLs9VZbHBV1kYafWf204A6rlo7uVnc5zB
 HqfuhCBVXH04C6P31ePEzCnsAGsNuIuWzXgseLI95xp7BjE8g6TSnI5Klco83ZLd
 VztR/qKPL8EBzueHWlpxLVLUMpcCOMcVzb/NtNbc7gjWEEcppr5OXyqHD2UPjgmr
 ik/idPigjO6TWwtjON0ZKY9ReZRD5sC64ZKejDrJIndUPhCyBYtQbfm0mgLJWj2O
 sxqOxiVIWY5FTT92Y5uNRA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sq9uht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2025 14:24:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51DEOrnJ016304; Thu, 13 Feb 2025 14:24:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqbt3mv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2025 14:24:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rreUvYovFORmIqp+jyUGD8jPWXyCrN8L8yTNEuefazqDSmyCuAdT/iDv9DnCA5qTjNbQTbhAo34fKY4jpnI/rCpzbu58aq7DXG+3AZvF0v2EnJR8U33K7wOZ767/W7lZtLt+jPVs2BbPwPLKbNIaDOEYI9ilZ37MN+9XbUZjjIjQV2BCrWNt+NoLLSCrG6pesHJ2/3Y2stak3cJ3fCbReuv5RT2r87VxiTwWr+iijoA/jTEPSI5Ygj07yBDMZ0aWB5DXJ919E0O4TUcVNZ126g5EK5skv0pJbLNg9zNUOTkHIKM1lT6WJoDTA8tq+9xnoDLYIs9BWwm2NAPpk93iag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9s2NotD/oEu4ie2oBee+4ZxKao6BTyxLdanXir5HMA=;
 b=gsSX7LioidnhD3Solh6sw3ib7wp1/QM8crltJHcyWxqRjA7UrRFqaRE1UMCyKMMPWHqytnalSU8Y34Xmua+ex1h5nnsaVHiQg9Wu6LmIQb+Bn4uD+9288n0fQ6+knekqRM+UKrxHOtY73A5i0hfwgryET6SI+MllHlwT9M0vM0S3bJtDJix4gu6nNqiSDEhG+2TUQCmjIz2jktOdbY3UPUF26u2/H6RNSxRycWOnWVujqOVTYWX/llb4G86yQhm2gFFW6nf7ws5BuAH3sF+B/2Q8mPfiBsrPFkC66uGrcdX2Oy2R5tfWeQcJk92ta4J9NLpO9QQyGm7c5pMeTLI7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9s2NotD/oEu4ie2oBee+4ZxKao6BTyxLdanXir5HMA=;
 b=V0J+zuaBdU3ucz4Ejv+6N4111b5gRYvB38ZWssD8wU740gIqBT1Tqb3FA+rpI0jpIPkY2GBK+VFxHYK9J0kX4/h+aoKs82kdsnln+CxYnD7lN4zDqs5QVGwEfCAhPv/w6sObPRWg/NzQ7CdF2803enyRv83bs7DjVt8edGHxE0c=
Received: from BLAPR10MB5380.namprd10.prod.outlook.com (2603:10b6:208:333::14)
 by CYYPR10MB7675.namprd10.prod.outlook.com (2603:10b6:930:b8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 14:24:27 +0000
Received: from BLAPR10MB5380.namprd10.prod.outlook.com
 ([fe80::ef73:6117:7d5b:3227]) by BLAPR10MB5380.namprd10.prod.outlook.com
 ([fe80::ef73:6117:7d5b:3227%5]) with mapi id 15.20.8445.015; Thu, 13 Feb 2025
 14:24:27 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] fcntl27 and fcntl27_64 tests fail on nfsv3& nfsv4 for
 mainline 6.14 kernels
Thread-Index: AQHbfiFWNsfx/yDYjEaTGAeekwdZPw==
Date: Thu, 13 Feb 2025 14:24:27 +0000
Message-ID: <BLAPR10MB53806691A64D8003A5D0FD5CBCFF2@BLAPR10MB5380.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR10MB5380:EE_|CYYPR10MB7675:EE_
x-ms-office365-filtering-correlation-id: 8769195b-a578-427b-68d0-08dd4c3a1f93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JaNfRCtejG0WRlIhovqPjZsLAGxf+r+7mFirasTUZU/HJ3mcJZ0Aivh3AekF?=
 =?us-ascii?Q?7unNEsipTmNJZQrQ50vJKcMeP9Ya7kLSxEZv85JMXxliaZIWr5h12F+hXWBx?=
 =?us-ascii?Q?4VYCamgHjHWz32yzVIrb6goXojuWigw0wmNZE9YuLDemU4lG3GJH8/FTs+6j?=
 =?us-ascii?Q?EJm2fDbHbcPrXcW4KySsaBnXDe26FTmFpzfB4rhipSu7y8upwCUI078RllC5?=
 =?us-ascii?Q?2p4spbUqe/cR6Gm7Yv3GT/+nx8gc6dVktai+jCXFL64EhMsMbQTX5DgscQBt?=
 =?us-ascii?Q?OusHEnEPmURosS1YTsWooQ8KtYEzlrCrfb5SDThXjOLyPA/6RKTLZS/W3EYw?=
 =?us-ascii?Q?Vs9kGuSySqZ3crkmWbUMceQi2TA0Fw1sMR9D4PCf+A66fbDI083EgmrLw7gi?=
 =?us-ascii?Q?u9qNYmGBYWdddh1g5jAEUhvgEkQEoLj9GSmknRCR/tsBh5teQRmHfhv3TMxQ?=
 =?us-ascii?Q?ZFbXLroh6lHH07SpMZKptYdjcd2kdB2CHzUe2HYMcTprYQZgNhlChHSQDlYl?=
 =?us-ascii?Q?F/zSilc4iBAbqKLrNCymWOzUPCDWj8vESFYaUZQs0KEEW8VgU52Ft6ncIvqP?=
 =?us-ascii?Q?4podfo2Idp29Iu/tWnlawbxvxMVTRBm7/B9gYFjbLzhxLd4hK6OzurnJELRl?=
 =?us-ascii?Q?EyrWc9I0GkGwiFhsVWZk0TQS+KjKjsPOzuQ4QoMT4Ff2ohkGQpC4tL1Dmywa?=
 =?us-ascii?Q?jfAIUYCPVbxr/CeNH6i2pF6W/JuLebw5yCZuh2yJv7XTMx8VeRSt1UBgbkJd?=
 =?us-ascii?Q?Nb5qijsqcmf5PGEBEzOYAgWsfeDtwmwKj/7xfRx4SQbdJLbKKXbaBHxJ5KAL?=
 =?us-ascii?Q?nNfXdo81LdmjW7lHUjk4EM1EeO6Js9WH7uKZCYwvoPOArVGlsMYzvsVYHPaf?=
 =?us-ascii?Q?yFOX8rYnNx29J0kAy8/ggdHNH/k+anQN4I6AT3EnptWtNtPmaA+1YgF2oXIq?=
 =?us-ascii?Q?TrxE9FMmM4C11GLBqaBMp+gXOHdSjtWVNUHicPa6BwW2fA+qtimj0aqWT2NS?=
 =?us-ascii?Q?jpEzAn+QUfmtK+dYhWHwlTSvoByamFXQmXEqOLqdlOvSKP60CPkyXc+/oepI?=
 =?us-ascii?Q?dObJ+OBKpOUPYIhAkXn9GAHY5GP/wizMXCXbGRipMnIKJdkXiIqCkDRP078y?=
 =?us-ascii?Q?0MYUYWj4xfA6x56D5mwarodc+A0nv/Ovk274rQAUCKanouXSQ85uv5tT1yCu?=
 =?us-ascii?Q?QTqZqINiZSfLZOQgfnFqCRhe6+l6WAr9AqVdSSms02Ai6IK9YqxCPfwPmqta?=
 =?us-ascii?Q?/rwJb+RnFHSIRdurD4qpm/CeyGHjGvvYNxWzqZPgmze2ofx48gfsFPSCdFK3?=
 =?us-ascii?Q?swwyxIKfuhH0k42bOgunyFEP4CSp84nZKilQq4ccwoUrjGcKxfz4rWzeuvBT?=
 =?us-ascii?Q?qj/tTlBP2sOncH76IAAyVMXc2VwtfhogZ/jJhVzwI+g77T4oyY8biubAB4MH?=
 =?us-ascii?Q?CN9HGujJXTuQrKgWv7PVFmH4wDVtToyn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5380.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(38070700018)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cnAkJa1wDcKDC6Gc27igWwBreLop1A3ODDWJK4yEQO5IJ+l/N6WEGkYgYvJt?=
 =?us-ascii?Q?+WG5c97xF0eG8Rz9IdmC17vPSWlPt4/gXsHu8UkrGaKTBOnn+VfnvHtqq+0h?=
 =?us-ascii?Q?cE85gizREnbtcwWMJW7ByxhYS7ee3M21f8U54ZEu+f3eyrX/ClZCmEINb1RF?=
 =?us-ascii?Q?Rphy1dtUoUUm7iNj2jSwm6qoPoJ4uvNcPGhtyzsj1ceP7m93VE964uXp8f2Y?=
 =?us-ascii?Q?e88yfbFS9Vp4cQS2fmRZvbmj7Vtu019jkkSBtcvSZyP8tOcllmbtCOI7xbfz?=
 =?us-ascii?Q?U8zh4x3AX3QLnCsIywf3nVqF9r3gDIPlmxWLH/E1xSTujDses0hnb/tetuxL?=
 =?us-ascii?Q?ce7j5uBm0F2E5bXv+DKyt6QsSZzsNun62hjfaAbwPHZUNfAQ9eF9EFPhKfVH?=
 =?us-ascii?Q?3xIAj41ddmt0yEbBjBNObJltq9o0VHna77aQTaMqQ5cZvnsfXfR5T711kVOw?=
 =?us-ascii?Q?LcSDgKi30ufGBzqpNDU+LMn/WD/eyAb0eqd9Py15hi0K30EVlH9ZwEyV7dfv?=
 =?us-ascii?Q?NZKfOaRnPcNocPmiDUJxhoQ+MRoTUVFFGsrTmXoXwPSnZQM2aMcVGe+5YLQ5?=
 =?us-ascii?Q?Prv1eY1tC+sclPapApBQULXLd15faPRrR09/N2B8+zI0xs7nJ7gmVfECs6Qi?=
 =?us-ascii?Q?8V2xYWmL18vy3KZ7sQ/ze8v+FTWu7zLrDg//sN4q4iR3cpKkK3dV9Hgiura6?=
 =?us-ascii?Q?gNi0gIguM+wuZWQC8giTg2QnwKfgeh1XdwHpy5NDEqGlFJkJzSHJjHGmy4bL?=
 =?us-ascii?Q?GuefxZewhehJ5lWBj96lFxSp5EA8jxJDK8DWryb84lm2iBlp8klJoaoyVzP0?=
 =?us-ascii?Q?CfACOsR/DlLGhn51PX10w5FzZt28Q7QG0wYyjtBak8ZfFSGtfpEggiGRIoSR?=
 =?us-ascii?Q?4wtChTo5JOPehXWLZYKgLaANz4seNrPSxwBOkUmN5+6GTy0HzlbgEtR40j1D?=
 =?us-ascii?Q?57ETo2eT1TyWqmV2D7+fVe3Xmeo8Qmgqu1a+hlS4P7IIa/FUuFl3wFV47n+o?=
 =?us-ascii?Q?wcr9rBNro2D2PTCSetAZQjRpmTwea8TCQb4uWaSCjxyYAUdDSERlxOZq+O3c?=
 =?us-ascii?Q?1K3eutBYr1meMcyU9IxsYrCnu4WqK8izb/sSoGFQZPWng4/ltafKviH5+dyg?=
 =?us-ascii?Q?lw9DbSj6GX/VXkbwK6OYZV662Fhj9VXcc/u+XnbfBwtm9F0w9JbO/Pw/kqQC?=
 =?us-ascii?Q?DB1Opp9jgS292vmxaXyQ+1WLu7lF+AdLYuJ2jcOnenEJwDxE76SpIPDVc865?=
 =?us-ascii?Q?W13COlv6EGAflrT5GV+TLGIO0hDQ3nSLC9ByGOi1717tmx+z45URBfZORoWr?=
 =?us-ascii?Q?ETuWz5h/0zNs4kJe+2KOMClwma1WI+rmQITMtQkGh7H6RRuo1+Qjtv5/6CuD?=
 =?us-ascii?Q?Ka7AOzh25Vx/lQ7stqExBCHVXBm2018BoW8+vtVRAXlWziXIsF6nNyoN+3AO?=
 =?us-ascii?Q?32D4HCbtysESHwmwoHKQjVpObkRP59AiUSoUWfhijePZl4bsYq4p+lHm5MNB?=
 =?us-ascii?Q?xMVphn3rUpfbGY8X9sVyLby4G3j6GwOB/m2OO0CS4LfoUvDOVNQ/UYARvaG5?=
 =?us-ascii?Q?ygqoph165k1UUNqEle8mN04jia739EcZi/1ALjs7tWQbC2UFpnBVzuh3RDhH?=
 =?us-ascii?Q?p69c+hj6Xoo9SrOBeWkAibA=3D?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e2y+E/R2wEMY0SV0d5RMfmmy8wPuso/VvNvhWCSLb0CfUAGuOgNpNWz93VtfoAfn2qUGx60kPqI7qETsqRrtl12AiPfXTEGTS2T+piYyPqezqaSXAKkiRZdktASFb8sUSEWx6Q3PVkFuChV98OgOtGuDL720akub4slps+i3Lp/dJppb0iSPgLILNRONrfnajdOM8aJu82HDfwGPzuwe3ZMrU1ez44HJ37uUimfs3DFjhSoNziZzXcnV6ZSvBqbiAav4LEwr8Awp/nXTCgjqAXxRGYkfMAqkYO56PUCyOIU8dgezIFHaPuXt54dUkCx952Etu0LY++husUjYjHJuW8AaXz42g/1npBk8kLVJ89UzIjj/+yG3AMqpgqHr6b0/GiiVgVWOkKzYfLtVqASCqdPB/zx2qu0OMjwNPjXwDHPd5VlTBUibrceBYJiBcOqdtKkUz9pvFlcoNwDo9Y5k0aXg0N5C+zuiGw7pZCIZEZtjhJOHiGdA4pbD14gmy/EMKJcahx2fJeRhx1K22QzUHRfcFueWzF4d4+vFcUmsw/qdCN5vEn19ar2rFdwMjwkMqkBrZsi94GLcUinRkA1tUWO1fyViKM5LCCZwB3DwLgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8769195b-a578-427b-68d0-08dd4c3a1f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 14:24:27.7802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vw9iTHeitiDHGqMl5l35vwd6o6XO2lQEbDUraW2CXrxzD1hF5uAme6V2VXs03kAhewDR2b94SknVLKJyejqudNM6gKK2OCuvoIz2a+RkuxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502130109
X-Proofpoint-ORIG-GUID: rwb9NFWAj01_xktoD77fZX13xjWlzfgn
X-Proofpoint-GUID: rwb9NFWAj01_xktoD77fZX13xjWlzfgn
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 14 Feb 2025 11:05:57 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] fcntl27 and fcntl27_64 tests fail on nfsv3& nfsv4 for
 mainline 6.14 kernels
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Rhythm Mahajan via ltp <ltp@lists.linux.it>
Reply-To: Rhythm Mahajan <rhythm.m.mahajan@oracle.com>
Cc: "jack@suse.cz" <jack@suse.cz>, Darren Kenny <darren.kenny@oracle.com>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
fcntl27 and fcntl27_64 tests fail on nfsv3& nfsv4 for mainline 6.14 kernels.

mkdir /tmpdir
yum install nfs-utils  -y
echo "/media *(rw,no_root_squash,sync)" >/etc/exports
systemctl start nfs-server.service
mount -o rw,nfsvers=3 127.0.0.1:/media /tmpdir

cd /opt/ltp
./runltp -d /tmpdir  -s fcntl27
./runltp -d /tmpdir  -s fcntl27_64

fcntl27.c:39: TFAIL: fcntl(fd, F_SETLEASE, F_RDLCK) expected EAGAIN/EWOULDBLOCK: EINVAL (22)
fcntl27.c:39: TFAIL: fcntl(fd, F_SETLEASE, F_RDLCK) expected EAGAIN/EWOULDBLOCK: EINVAL (22)
fcntl27.c:39: TFAIL: fcntl(fd, F_SETLEASE, F_RDLCK) expected EAGAIN/EWOULDBLOCK: EINVAL (22)
fcntl27.c:39: TFAIL: fcntl(fd, F_SETLEASE, F_RDLCK) expected EAGAIN/EWOULDBLOCK: EINVAL (22)

We have been seeing this failure since 6.9

The test no longer fails with the revert of the commit
cce93d3a3 Refactor with new API and merge fcntl27 + fcntl28
https://github.com/linux-test-project/ltp/commit/cce93d3a3

Could you please confirm if this is a test case issue or a kernel issue?

Thanks,
Rhythm


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
