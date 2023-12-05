Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF28C4167B
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 01:46:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 412D13CFB5E
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 02:46:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D0743CBDAF
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 02:46:15 +0100 (CET)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 43C841400452
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 02:46:12 +0100 (CET)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3B51XN3l026699; Tue, 5 Dec 2023 01:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 PPS06212021; bh=LkuwYulG3B5UvSfte6LvsxcO2k1EXh2oVb4TyuWmmJ4=; b=
 NLPRCfmtpq4MK2TEQym7z7UocTxCy7L7D1H+IVH5FzW2dClS4OI7OHXkuM/HSMTq
 hOcK0c0s0Rwtr/uvutBZKB4GH2Po7wl49pOfrGfw4QSVva7EgluM2PgBsbg2c38C
 vVZe+zSwO5EV/TFv1W/COf7yRoi12oocn4Wqx3DYQ4FDmlSqeHbywtKIC+b7Of1+
 HgKa3LG/9bJveiF2B7+MI9gJyBndNzL1PKvT9jU+eE3YIDyWwt+jXvCD7JtJSsyP
 qzPVpS2MpYaFyOOonToMr9m84ot2bZVLEDCyhALh/TFL/m27UIi4aGQqmYNA3llg
 eIRlONQYJoJKl0SHGGq8YQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3us4d5h4u6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Dec 2023 01:46:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEIZvDFaDSUL1vbXhzktZO3x8PQTp6LqaztyeKQ9Y8XOWI7F4PC37B/WrLd2jfVHvR1709s8JE3cVdFKg2U4bHQthRu+sAGD4wmJl1xflkEijNH6IVLoOR34X7+/j9E+EwSFIQZcT3MWheaSGTkHFYDEVKmL2wolptlws+FYBm9WC9bwHKYhOAyMzr4mHAz2inJlp7RKa3VH6mGjd1JwLF6sontkhkrcz+xojSXxHX9uL6FlUCsFNo+iykSHjR6Sx+L594bVXiHjrRlpLlYEz3CNnPBMHgKCmbKfNP5L8Wj+pHXD1t26vBQP6qCqI5Kcb1A+8pmrqmdRevcXqyL6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkuwYulG3B5UvSfte6LvsxcO2k1EXh2oVb4TyuWmmJ4=;
 b=hOU0918D9U2JDV95QAMXCZik6LDlNE48O9E9bzVKhOT5PIL8IWrZ+r0VqHRZXqMCECzIpQSulFROZVeb8h0WiBq4hg7RVdO8l33mj6OKk25Ldye/GvdfYwHR6OGMJGCsyTuCtdPJcT9Z8KgDFlYFUozSbAGa0SAPn/fKWYHfiWf7LxAZkQ8uFm5gUCp1E1jJTKD3OQk/PUoF5m5+O3nVf5CAGfOMtmcMHmZ9nhczwcI4aBTgpnFOWFxoi+0oDpA0kto6X8wg+BQmMogjKcRGFLPqN+J3fhipiBQME3/r4NVj0FxoB6/Xmdx2V8xF6z494txalY3+9ACBVkGSSj7REg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA2PR11MB4987.namprd11.prod.outlook.com (2603:10b6:806:113::24)
 by SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 01:46:06 +0000
Received: from SA2PR11MB4987.namprd11.prod.outlook.com
 ([fe80::a877:9814:de75:c9da]) by SA2PR11MB4987.namprd11.prod.outlook.com
 ([fe80::a877:9814:de75:c9da%6]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 01:46:06 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2 1/1] enable fsx-linux.c running on VxWorks user
 space and add measurement of execution time
Thread-Index: AQHaJH5SZdwWqru02UyznAVeLNmu+LCZ7Y9w
Date: Tue, 5 Dec 2023 01:46:06 +0000
Message-ID: <SA2PR11MB498773F71659200414106E649585A@SA2PR11MB4987.namprd11.prod.outlook.com>
References: <20231018014915.1632280-1-Xin.Wang@windriver.com>
 <CO1PR11MB4979520F15EBFB02E28BD64C95DDA@CO1PR11MB4979.namprd11.prod.outlook.com>
 <20231201174623.GD2829815@pevik>
In-Reply-To: <20231201174623.GD2829815@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4987:EE_|SJ0PR11MB4893:EE_
x-ms-office365-filtering-correlation-id: 4a7a9fca-489f-452f-933b-08dbf533f26e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Oei42zKZeUgYntF5F2Bj4k3rN5HCYIJxX2MOJ9zCisVC3wGdQF5BBnVN/Bv2S3eudwiWcm+T7wBcKjCkNRv+e7W8MslBo1unY3uNO9qHo4rE7Jdo7iQeNQcqSIXFL4jdLa4NkNM0hP3PmPBz8wNyi8fLZ3G4JwERUG8qwtil8MCGMSiH781fbKmewwHlSx9iBHp7Fjg9ujjWrM8fXdGmjGtBFgXl0ioQlftbOed5SiUFeuh/V0M3htTWrqKmTxRMyhPVckSbFi92qpn60HMDuQhhJyjkwyxaX2ObNxLCVVt65HMyeaJ4WqIWMZfQsqs0wiRXtCtbHzPVWA0TSSl9vi/k3FiUBIFEyCnTi86U+rti9PXDatsMiF2xJ1l2vIRAvoIu/jgcuaelgzFodahBLRF8L0snXW7AbaCkRRd7nrJ/4I2PXtiWI+qEQHtIq/7vFiVmPFF1CP3a85z6aZVaBhlPWATiEgAqbsAsy3DtYnSocGH07NnE5MYu5WKqTIi4oW44ZB6VMkc5hCH4Sb1hBEC938LGZz1R+p00WTluziVmnpdmAUW7c4ge/5mBGqKCuzjfmCxLmZAaTRNnZgzTqrV+THy0+Fu9vji6AuC0QxAAejXoe/ifhjUihVk2XXo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR11MB4987.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(86362001)(478600001)(6506007)(7696005)(9686003)(71200400001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(6916009)(8936002)(4326008)(8676002)(52536014)(55016003)(122000001)(38070700009)(83380400001)(2906002)(33656002)(5660300002)(41300700001)(4744005)(38100700002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nH1ZnT2jfPxudflvN2gDiCeNgdYVzMyEB8AhJBtrcu6/KfN1pg+cIMpLWZpB?=
 =?us-ascii?Q?UDpI4pBLwd8B0ifYqTSG1gwFM7p62F2ybDCzn7jIJ8CQTh1ggHssq51QbGE4?=
 =?us-ascii?Q?lFJt4mkfljUxHsdT5y+31ryMTHwwvxhZ7cMxgfsctyO2HpbQo0P/Gb8n/53T?=
 =?us-ascii?Q?1whX5hdYr06iOsvfqpLrj/75SePhjBdijavInw9avCLtUMxxec2MEB/nPwT5?=
 =?us-ascii?Q?dKRuHOUedSBghxk7aWB7rdA84kc060n+d2iwzu8X6ZbM3lqGHbr7EujsEEyD?=
 =?us-ascii?Q?WQwtLUR1w2Hh+NuABm8hdEYoLqNrTRvXwx9B1rYBT9aNAtngoEqRVHjVW/NY?=
 =?us-ascii?Q?w7WnhHDQ/7nRKVxNNsU7jGYtU1V/c3XhRMO0V+yq1xZFIZJAesiZHkowkKFj?=
 =?us-ascii?Q?mUjK5NvyaF+fG70K8j0tKmhTQfUCm2vxG/+WKyTdxvfjXrU6iDi5544tTGw2?=
 =?us-ascii?Q?S/qS7Jb4cSayIR0AkGthi+pgtiNxZTcLTQ/bZSHMbSanmOmh4Lf0alCvLCVg?=
 =?us-ascii?Q?JV/jgDGfwaIe8mAGZFUQi8tWXIr9WtZ2PYoScjT6u8rl69ZS2gFhLNWGTs+v?=
 =?us-ascii?Q?yjO/sZXiGnlXPV8UPF+SM3KlKQ1Oh1lyyDpLSkssreXS/oEEsJSw+uTKuDUb?=
 =?us-ascii?Q?HeVRMQFuXwKplR1mwrBdy/ZyGDnOkKvxQbs4l3DtBGPggsC4O+t+oDPMxVbe?=
 =?us-ascii?Q?/39c/4nb3gNNbqlkhnc+dWG3tzVPzZ2Tk0Zsl0n/0DyCPg3Fv6eqVIm/no8G?=
 =?us-ascii?Q?7pD6oMTkxXf6Un5YCPtBdiOfMXuVqF2xtm6bT7h8svZ3OsUQqSQQUNVr+ndr?=
 =?us-ascii?Q?aHxQSKHB7GAmgp7XKmNgLYrG70FPuuuY6AFb1LnE82UBjZOyt4nkwYV4SvT2?=
 =?us-ascii?Q?klsGsrfAUpuoa0XZnzjCruEtpqj8eENcD+GzYO80v2SiEzp4nEwYQSTtFqF3?=
 =?us-ascii?Q?c7a/6yLR27Hn/dEtG4D4er4RrTtlun6i276MuaOUItTiQS4jyQzYwyUk9W2S?=
 =?us-ascii?Q?KdfqWQK8TuAUn1VV23JpnbQe90OPR6UMyS10SIeZwUm+PhRAnpLqLpLXNolP?=
 =?us-ascii?Q?nOSLnGoxNej+2iyyDoFan7DoVijlyhMPehegPNBlDtUSjHErZXAGvAAV044S?=
 =?us-ascii?Q?TwoF2uMQTF25Ulz9CqDFaMmNCNUv2tyJPsGYh7kc8TADRxwjJXc5tetuhAl1?=
 =?us-ascii?Q?Om+W1L6O+SR0L8Xjm+Rg/f+2dhS8F9Pw6ZzkbsOfMGs//yj5XdV+BWpaL2Hr?=
 =?us-ascii?Q?L0c1QRfBixDAnuJfK9hHo+ft9ZatyDSvBEQ1VW8yr24NIVreYKXMCsf+v7Sh?=
 =?us-ascii?Q?Z9d7Sd3cpvQnT4bx+p3D9eu3mNRjgkv33hZNb5MAHv/oBnP+JD/0jReX6lTd?=
 =?us-ascii?Q?d/HHyFCScqQbHNUaHNiCYmSwLkGMiMK/nJxSBeQhpwkTM69Wnxh++Ovdm712?=
 =?us-ascii?Q?jtpPo6J2VZumMSzagKe2G7iOv6pCfPeGcuBA0LBVXAHGxy+OoxoAEekC+4el?=
 =?us-ascii?Q?IdguWABwNBGOXlgYqzj4QlTlr2Y0cf3I7CTYAVk+LFBMwccs4H9jmcDfi/Hh?=
 =?us-ascii?Q?VEmgIDtCsPMBXdsA7kjbOiEDHhtNhZRcO8uj7viT?=
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7a9fca-489f-452f-933b-08dbf533f26e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 01:46:06.2343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdOpshIKgvNeCju+UDdQohrfNjp3PC1aT0bq6qgG7vpEj0Lr08Mz+MeY+AfL0khsfTDjm+gI5Z+J396yNSUgHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4893
X-Proofpoint-ORIG-GUID: yQF13d88T68k8tNmdFcsM7XrD4fEnz_O
X-Proofpoint-GUID: yQF13d88T68k8tNmdFcsM7XrD4fEnz_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=866 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2312050013
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] enable fsx-linux.c running on VxWorks user
 space and add measurement of execution time
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
From: "Wang, Xin via ltp" <ltp@lists.linux.it>
Reply-To: "Wang, Xin" <Xin.Wang@windriver.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Petr,
> Hi Xin,
> 
> > Hello,
> > > Subject: [LTP][PATCH v2 1/1] enable fsx-linux.c running on VxWorks
> > > user space and add measurement of execution time
> 
> Also, the subject suggests (and the code changes how I understand it), that
> you're changing two things:
> 1) fixes for VxWorks 2) add measurement of execution time
> 
> If I'm correct, it would make sense to split changes into two commits.
> 
> Kind regards,
> Petr

Since fsx-linux.c had been updated to support new LTP API, this commit hasn't been fit to current version.
I will try to find a new way to support VxWorks.

Regards,
Xin

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
