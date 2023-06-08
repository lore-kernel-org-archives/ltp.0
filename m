Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B685EB64DA
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 07:58:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9DF93CB9DC
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 09:58:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BC023C9EE7
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 04:30:41 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E748B200381
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 04:30:39 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3582EQuO006164 for <ltp@lists.linux.it>; Thu, 8 Jun 2023 02:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-type : mime-version; s=pp1;
 bh=uY2WtUScjO670pqc29tcDsfQfSV4YfGRkoLTLw7V5qE=;
 b=pQOiucEaDf1OGqU9oJkcMs4673tdQaboD+Cknlt9uwhT67Tli0wjBXjZEsHAAz4D2+jO
 P34dvLEV4fGQ4RIaCRYEIIQmEw6rv1bHLHd5qPMHzpAX/CCT0Plw+kc6D3VgrE/ArZVU
 EmdQS3HxuyNgSPRXqgXqPPSd+N9Eh3d5yQNfb0UPlJPQii7B1GYrmpGx6GaXdr9lC2gx
 zcTBs/DTrKhlgyVU5PwQqSPLn5IJ7OSwVEKL2cg+WFvSJ3hCSk5BbYWWBup53hKZ8pWc
 /Zy1BDt/ld0P8REyVhwtVL5bB/cAEU7n2c4BangyNnOR7t8338NFCYM3tdoJkD6Io0Id nQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r3619g9wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 08 Jun 2023 02:30:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cyio6jLPR7yFVM/FpjiI9PHUH0v3iyyLPK5EZQYh2AWmsX69JfkSOeXvtBCk9qgLiB7DRZBcZxKrpIfmGv7nAy67WeciY2K6XXw2hyTl2VjiqZxu8odVMsD4WCzzpdWpskCTAstdDwLErHnP2VFXqKnTMoVQbda/N+qtxOUEiB86WOKrGPl92skl10ErIhD9svlAI17g09T224fXgHMIAO15o6LZg1WhcczHI2o9GFtXsiU7a010J05qwyJR9YbrZhNRGWhhmH4iF5yWNbfTMp0Msnd05T6+piwK9bOFnnUkaVdR8XDCtCpfp1kr2dJZXJLR55z7caG++jNpDl8d9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY2WtUScjO670pqc29tcDsfQfSV4YfGRkoLTLw7V5qE=;
 b=AHRtvYXmIOusdNLbN1nZ/2q7p4hKP7PnR7iQWjLMa7gRUZP0z1z8BimS7MT3w/Q+DikoVA0Usy0qAiHab5kcfLMFkaZrGUvKQLoIlhuo4nFBWuvyoORIZBQQ3ZQGigrjkq2BQD05pAxNrzXdyPSeNUchBgE47KLzOKBWVBekA782q8IIYHfWzrK5SQODOVhMp4ylTufk0dlPFDDk4NbzYmHWxOBYbCsBl04UmPCwqMX22DJUM13AfrEXA1r6m2gx3RbshLgNsRoKSo3toT6XzW7/745ztSPzaOkT4Z4ClPN+VdLdJnRIYwevFRKrWn/JzPWxeaWyRjmCtPFyKmjDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from BLAPR15MB3987.namprd15.prod.outlook.com (2603:10b6:208:275::12)
 by DM6PR15MB3782.namprd15.prod.outlook.com (2603:10b6:5:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 02:30:35 +0000
Received: from BLAPR15MB3987.namprd15.prod.outlook.com
 ([fe80::ef68:c631:5d05:2280]) by BLAPR15MB3987.namprd15.prod.outlook.com
 ([fe80::ef68:c631:5d05:2280%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 02:30:34 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: LTP Test Case mapping based on Changelog
Thread-Index: AQHZmbDNJCJhLC1ItkKop1gTVnkO4g==
Date: Thu, 8 Jun 2023 02:30:34 +0000
Message-ID: <BLAPR15MB39870F810F9FC1E9A89F78CCCE50A@BLAPR15MB3987.namprd15.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR15MB3987:EE_|DM6PR15MB3782:EE_
x-ms-office365-filtering-correlation-id: 7e8ff10f-b981-43b7-2b7a-08db67c8569d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?Windows-1252?Q?b7VZIB5Qc/O5UAqb3SdM74U9JDUeVD3reHjL/pEUVgDmUOamNIpKNy20?=
 =?Windows-1252?Q?t1EQfKnVNhN/Ne7Ip9GsyMswVaotm9Fga6LhGg3uZPoDrwEbvvAlfGW0?=
 =?Windows-1252?Q?3q7SJDUWWMsi9GWjO41vfPi7dBlzn0Oe6PeD2T3LfcnXhqY2suhyzopo?=
 =?Windows-1252?Q?UcaR9bKMYrvEDRKCPq7RVIPzBsJYhQDtDJ61uqlc68tknUOOJxqI/Vbj?=
 =?Windows-1252?Q?jQUbhrX5PmGPegyUiNuKjAk6Uh+mdR6yLavQEABxh2WTTOSa3NOEzYvK?=
 =?Windows-1252?Q?vATp9mAT4VIbKNYgnhmn/u/nxAXn/9oPD14N/FPNpwctsUc0S0pWfCwB?=
 =?Windows-1252?Q?45KXu33KrT8aD9YJlocdp/SIjXGh7nBd10k47d60cQOTtLL1DMiUG965?=
 =?Windows-1252?Q?U4h++a4ya2euiQ9VFNkjpGfsXPZTdoZYCt6ol9VO4x1A4yl+3RZrHKMe?=
 =?Windows-1252?Q?tQTj7T+4ngH8NGCYJTP6VNdyup9dQ7p/CAVBHwLuSk43YsAR0EFwH/oJ?=
 =?Windows-1252?Q?irAdecxxujeoMfCA0jip1uazRaPKGIiAl2zq6iTh8ChtOxsTWC9jny4O?=
 =?Windows-1252?Q?ovdGQW35WVH9P6+dd9nOBLzO2JXdoB41iYJhf54rDWKHciyZIqQztfFH?=
 =?Windows-1252?Q?fAH1GPeXiJ7J9Z9OoAAUWyNzbZwE8U+R4NEB8Uu4W+48mJEvYmGmZfFn?=
 =?Windows-1252?Q?g+FT8KW8rC1BDXESSNZoUTr/RQpFbSVs/UDSA6NkB2jtvVZJB/cZpRaK?=
 =?Windows-1252?Q?AbqD8PRBWOE+8nPPtV2+VNoFAm5m/PmbIIKVQvlvxnMSAGwBYgFbsBDl?=
 =?Windows-1252?Q?8N35GWtkQ8yPm67bwvTDoOhBkbeG5TyxfN07rRNG80yV18zahHM4AoeY?=
 =?Windows-1252?Q?tu3G4jM/AKFAqfEkAQ3pbWfae3VJbp6YZx08RYfJTuELjODwFRgUHjy9?=
 =?Windows-1252?Q?9P2suqT3hx5mkOowFP4qcP3+KUd9GdP9y9dnWBfVxd/+aiHROQ62rOpc?=
 =?Windows-1252?Q?IgbxQiBEgtIMcaneqiELWswo46r+e9vc5d4mZMnAskfI0t6oprF2hemA?=
 =?Windows-1252?Q?ICf3epxroLzzAR6VEoRhQU7ZwPdJjvTmL2Cd57PgBCxe89mjDtxK1ub4?=
 =?Windows-1252?Q?biESol6gcr6axXd/Lcjg8aR/VppWtY9cCrfCdmWe5pNUfw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:5; SRV:;
 IPV:NLI; SFV:SPM; H:BLAPR15MB3987.namprd15.prod.outlook.com; PTR:; CAT:OSPM;
 SFS:(13230028)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199021)(66476007)(76116006)(478600001)(66446008)(66946007)(6916009)(316002)(4744005)(2906002)(64756008)(8936002)(41300700001)(4326008)(8676002)(66556008)(5660300002)(52536014)(91956017)(7696005)(71200400001)(26005)(6506007)(9686003)(55236004)(38100700002)(55016003)(186003)(86362001)(38070700005)(33656002)(122000001)(71176010)(59356011)(207903002);
 DIR:OUT; SFP:1501; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?SoarqMHAgK99V/+2DZ1uhNnOsREGMNtYvH9H9Tsr42vsC4xu8Q0Km+yJ?=
 =?Windows-1252?Q?fzJ3AEIeQGwqKQWUnyPiPDdjdTtQJsx1Ni5Iz3YcjVhzSA+LrOnGt30m?=
 =?Windows-1252?Q?mFKbZ6PdeIPgOVpwY84sihdjo9R8fN9orkkgVVHlHIkExFr/3Zr9OWLQ?=
 =?Windows-1252?Q?1MWF6p+2GP6wNf4Bc8DuUiNcnAGdhayRCYNR1UO+jjkaDYuQ8RSxw+ZW?=
 =?Windows-1252?Q?oCQlN8Roj381px3LpHogvninRdzaasaLbH3FzRd2iegXQdekSOy8UqDT?=
 =?Windows-1252?Q?LE/wMybkaDdpEwtZc/re86p5e5NNyUAob7+8iVDt5gve9gqPz1SEh/d8?=
 =?Windows-1252?Q?hZqG7OHQspq6N79K26gCjIFJdUK7NmlbU5qIw5iNUf6dRgMDwBbwkbk5?=
 =?Windows-1252?Q?VZ7wR27UWvDGFtuWINfb2j1Z5BenhpdX+HLNnrW5oojo8Y1dGD8HRcSW?=
 =?Windows-1252?Q?syeCshOdwCoTgE5LZ3y3uBpaEz+3Ad2Uek2uH6x2JJ5Vr4d7xTCPAtpn?=
 =?Windows-1252?Q?9965zVw4frO4SA7xLTSEUz8cLUH5WS+fGB93SqKAtOs1Ahx7/XJNpddU?=
 =?Windows-1252?Q?aFzXffsC5zz1IgnMepCcr/TxTcGd1R6gHeWSBWja58Ra3nvUPUdvEsUt?=
 =?Windows-1252?Q?EIzYWUzTYDMOm3lTi/6Insc6k/r4K0RnkFq/DUlQ+5PrXZl77nQYsoPA?=
 =?Windows-1252?Q?3tFcc1sFnmzr4gba5XRj5+krJo7vhQ4j35mCkNgsTbPxVlPTKPxdyEc3?=
 =?Windows-1252?Q?/1x4XGl+/PNpgxNj5H9bGccnScAIWNxGaOhUjJx88tmBO1YCwKZhKhKx?=
 =?Windows-1252?Q?99hNR7pfKIFAwvtEUoRju50pj3rVl94LXlQHhfkXnez9ukx8huLkX+/x?=
 =?Windows-1252?Q?Zc9fvd465C3bl3RJyB+j49yuwfU/wbGwpLm84355DH/mP/6XF4B9hfuw?=
 =?Windows-1252?Q?CWNiPargq6X29EyfIpxa9m+BTbkzTfGctE4oA122LP5BiDYCrYnmLrmo?=
 =?Windows-1252?Q?ywJ1uPFHaY/qcYX5iBoppDQzB6C/gPvw2pOkZ0stvebhOJ5iZJRhK2GN?=
 =?Windows-1252?Q?jEjiMraKQvYlCGAiqnI2a8vCUMEIEsme6oCMa0WM5o5zeMxJ44O7gvD3?=
 =?Windows-1252?Q?gaBGB91xa6T44lxljDotEuaIM53TgvhK1Hr1lbxtRkNEEtbw5eRf+Kvw?=
 =?Windows-1252?Q?KaWNOd2V8qRe/HakYB+jhPyKqG5H5Hz2P4SaUvmomauOzvLFrkCNrEB/?=
 =?Windows-1252?Q?V2o0uPH2EanqPdhdA2rLDwdCoJhcW4zdVyytHOlR7VKTbkbZC/XPnALJ?=
 =?Windows-1252?Q?MG1r7iaEupm2dKtnVBqsIsBPPOy1/d849tL21GWkGGfIJyQfeyg5SD2j?=
 =?Windows-1252?Q?cOR354k+p0bbPPdbleI99dquaROJ2Z6ueyadSNXsJm2SQvj5FA5xcCg2?=
 =?Windows-1252?Q?YpTmiUTD/r/r4o7JuPj0qzs+Fiuni9BneC/vfobtrkrlt5K2xgKRwtVv?=
 =?Windows-1252?Q?OWn9Qzb4NP9Ce1zQLr4cflp5hegNvK9VUcuaOV/Kb7Plgshp6Cv1oayU?=
 =?Windows-1252?Q?2pauncScBO/yiCgTjFDm9s5bEn5Wk2nsJkudVBNF+BkkiDE6Nen7EuOD?=
 =?Windows-1252?Q?Uu9K4Te7HCt3fp5j6yavoirt7VQXwDREAXovz3gjnGJ52NK4roHzQ5RM?=
 =?Windows-1252?Q?GfmbI12JvTW9u7nZNtOnNxtxT6jHpV5A0P+awUgOcS87gh913xLClA?=
 =?Windows-1252?Q?=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3987.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8ff10f-b981-43b7-2b7a-08db67c8569d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 02:30:34.7305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVAM+LPBwxOosZo6s/sbPy+cqyqqsPMZJPDBg0s+zXvy+OnifwQSnTtGDzyloo3XuLfMYkVrm8e18zEyS0s1Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3782
X-Proofpoint-GUID: KwwTJGd1zxKFL3s4suNaeV4R3p4zsMFg
X-Proofpoint-ORIG-GUID: KwwTJGd1zxKFL3s4suNaeV4R3p4zsMFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxscore=0
 mlxlogscore=781 spamscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080015
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 19 Jun 2023 09:58:05 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] LTP Test Case mapping based on Changelog
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
From: Mahesh Kumar G via ltp <ltp@lists.linux.it>
Reply-To: Mahesh Kumar G <Mahesh.Kumar.G@ibm.com>
Cc: Krishnaja Balachandran1 <kribalac@in.ibm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Greetings!!

We want to check the changelog of a particular Linux build and identify the=
 files, which are modified and test only those modified areas using our LTP=
 suite.

The pain point here is, after identifying the changed files from the change=
log/commit details that went into the build, how do we map it to a particul=
ar LTP test case or test suite.

Do you know how to achieve this?

P.S =96 We are aware of the kpet project and wanted to know if there=92s so=
mething similar for LTP testcases.

Thanks,
Mahesh Kumar G

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
