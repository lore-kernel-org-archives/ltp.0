Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B80C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 17:53:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29A473C8D0C
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 18:53:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4AF83C8B34
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 18:53:32 +0100 (CET)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com
 [185.132.183.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DCAE96012D3
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 18:53:30 +0100 (CET)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEHE0gI006679; 
 Tue, 14 Dec 2021 17:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=A9utKM6UnAa+0brPs+joonvQZKgi3UJhsgCFnTgqVos=;
 b=imW+COJPGOIebhqYlpOEnrVQQtdFmN5Jcu+7AatikyGcJ9Ucvc9h8Cdv/n6wCQ2sNiws
 nxGCm/ssXf8wTl/NBT8H6fUhiNMo+aCkxl0vFT9u+9Mlzp7dSV6ZlJhkWrrJixksSiXN
 bwg187m7pyjIgYJw+/5AGi0cugAmb2rXQ10YmIpLuXBxB+XJcDVih1BPCnKEVO4NkwkM
 JsZi9mRQyI3qeC7A9ShhlbguciEdUVcnmKyngPD/tdHRAn8j/m+1Li9InlzaskuTtYAE
 3Bl7ElrK04YTuwejCTer8hdnRQYqY2I5ui1kmjOykxKM8QF0Rmdv5hqge4qV+6iNGmno 7w== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx08-001d1705.pphosted.com with ESMTP id 3cvh56tesd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Dec 2021 17:53:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkyJVYci2ZRpdh+JCK8JdNAatK1s4BvQHLJ+/cCXpzJCuVOV9f9qSPujkSoWK8rIvKC7p/W6FL1YP67q7hOyYJx3evTEzDL1P+CDUtybfK7HGAX3U2hpjkY36WuyG0g+J6JUjlFhsnr/wzqdSYeqJA6Ex78Z3VVBWrw0DKf6H8e6LQsPLu/Od0ly/3ruQJiG5d3vTJqDVPlAGvYGgfEDVDeVBMBFOukBytISxeH/uTfW/zZyaUl//j29V20GqburwvNwW1SZaoWEXEScQ7mSkRtktkjLJ/mm25lM6QGonBVLXDlL+VPIyuy6FUfbUi0UuZGFY4VbMKSNUa/ykhbJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9utKM6UnAa+0brPs+joonvQZKgi3UJhsgCFnTgqVos=;
 b=Vtvn3nCrcYtMmSKiZX9uMsEshTjKmzJDoruV4LckjzIx+aSu8sd9k/sb4fR+cKfsDNgIWpWxxVk50jqzmVunsYS2qPZz9CAeMXfKvGVEIqfapXtN/oTeOTuYsa1VtG4CxoqB3r9GS5a2bYjGEY+2+tt6jdGib5NfzyussNBUNCeSnZAT70nPmFVICTwvIUWPsKvIYvH3ewG6bhNrGoYathwY+z4RQGwLwehxfy9qW2EWvIMAwPYY8lE730V5IDFRtQwsxC+HH87DJmHovcaa8hYfgq7o/WLFYQyjT4HgUWbYfwnogpP3kbN5MPolLZdGf04jLDfBfgVjJrdFMG1bxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by BYAPR13MB2407.namprd13.prod.outlook.com (2603:10b6:a02:c6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.10; Tue, 14 Dec
 2021 17:53:26 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::611e:6e22:a5ff:1a50]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::611e:6e22:a5ff:1a50%5]) with mapi id 15.20.4801.013; Tue, 14 Dec 2021
 17:53:26 +0000
From: <Tim.Bird@sony.com>
To: <pvorel@suse.cz>, <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v2 2/3] tst_test: Print environment variables on -h
Thread-Index: AQHX8PkHcVdxahZ08EOaAgJkqo7HhqwyL5iAgAAC8wCAAAL9gIAADGDA
Date: Tue, 14 Dec 2021 17:53:26 +0000
Message-ID: <BYAPR13MB250371A7DC839014B8219104FD759@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20211214144309.6704-1-pvorel@suse.cz>
 <20211214144309.6704-3-pvorel@suse.cz>
 <BYAPR13MB25037C7B8DE0850EFB25DDE5FD759@BYAPR13MB2503.namprd13.prod.outlook.com>
 <YbjKkic5F0j4c3bD@pevik> <YbjNExvj1vjnjb93@pevik>
In-Reply-To: <YbjNExvj1vjnjb93@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53c90709-c4d8-489c-bfba-08d9bf2aa186
x-ms-traffictypediagnostic: BYAPR13MB2407:EE_
x-microsoft-antispam-prvs: <BYAPR13MB2407D95EE89A405CDE68F6CFFD759@BYAPR13MB2407.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/w8hTpCS6sk0zwDXlzaaa0YqwLexrSKvmWRSbMlEkOOKAr9lcgGpO+DVJaOOqnnG6gtIKtSrhcSkFEFc4s+1Hu2GuqKfwjUSGTLFaub5ltpGZC3KU3Bm+DWJ4xE3VkyebMdOnKeCMreY6lkUuDr2qMgcK2XHyLNJ1cRCT0NVp7FDTNn6bKmwWUUu29s8m181q20AQS8IhTfbHShA6r2sgPc5XdXSfQlnZ2Jrsm7my6Ms+XwW+KEqU52vAuxjyfwTI26TatjrAd0nKkBQOOr4ebVfY+lYzVJSAJ4ZMFFSIjc9jOlCBDK1y/PXE+Ygowf0FCJubI0Z5HhGvRNuwRjMiF8rj4uznaTviYSaAgPql+myicKPM/wJC7t0jK6NTv9pyCoVtcOK1lpHODCe5IJj22X6qq/zgYyWZlMPRrO4D5YYO61McipbtTl3vetx4EYcocNRcvS3cIU8SMSv9XMkbBculGxYr2Sa2RFo/oFaeHFMr4f1z7qukujkBK0RtWEVc569bDsiBIDVNO2Q29Y5oDVITNpKhxCsRpEA+R8AP8b5nBVdR1GC5LesDQqMphYxk3KTw8hBQNpR0ROU6FK3+IHg6EihYlNSKPackvm/RFkbTdtOSYu/Gpa/9y64wqTIB84vkvTuKB9lNKVhp6E5cPmzJDxlpMl0QoSbwHlT+ivaGA6L/iHpDM22aZkwBgxCyseoaugqOP6tg8qU0eWRtpUfoCmMGTeG/W30aggKt8t1RgzbFwlzmS4LBaZyjET
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR13MB2503.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(33656002)(508600001)(8676002)(83380400001)(82960400001)(8936002)(66446008)(64756008)(2906002)(66556008)(66476007)(52536014)(5660300002)(186003)(71200400001)(7696005)(76116006)(26005)(55016003)(110136005)(9686003)(316002)(122000001)(38100700002)(6506007)(66946007)(86362001)(20210929001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yb7IG9rvrv3jrJAlvsEG8uPUasltHWKwj+xMLnnFYswkGpHAYC97tpIQBbIM?=
 =?us-ascii?Q?vU6DdFHuk5GoRW+MXWBKmSMaSR7nMo0vWPllcieTxUEFCDaehzNOuNRYqL2U?=
 =?us-ascii?Q?lfLzQ4aGftNZly1Ca0xnarD8w74ok3ncZQk6kHU8s2e7ci15e7CAp3nZ+ZpB?=
 =?us-ascii?Q?E9s8bgwP8znVznNba2iFDeuHFeXhCyFutxow+3hFjRy2JQZ467t6DktRNRqB?=
 =?us-ascii?Q?KYTgsjF+fKtC3o1dlJYqVEn4tp5zyxTY4yUzZbTiiA9dyjZZxPwyCD/qQruT?=
 =?us-ascii?Q?k5JdmqvS/E1w0Cu+qHDyjV/PGMDr44gKEwZq4vdsdQWhhnxaWqj0ZF2MAOZg?=
 =?us-ascii?Q?NIoGU9yX520J+ytQsXe0stVjgTdmhAArN0SilS6jlyN6KQVvf1/Ju+Qvh/kQ?=
 =?us-ascii?Q?LVk5j+KDSLMMo+J1CN4GG8eFriRncKpyx8BMz7A2C94S3QqFcIqsGdDrrHwF?=
 =?us-ascii?Q?ZxWroerDruyZy/fcDa9MDxKHpPODJeQo1KRMLULc1CvYOpJI/LL/C6YdQLPc?=
 =?us-ascii?Q?2JFTBSLkbgvf0ry3KKwEbCBbFZRod0Yn5UIE945Txvct1Op8sr25i+H/ERGj?=
 =?us-ascii?Q?cdGjXEA0DjMl92JVGVa+aJQAqrB16fGO0VkbShscY0WG/0/KcJjVrSA/ugmU?=
 =?us-ascii?Q?bjOPT5H3RU24Vion6k+Vwv/A/sCTl/iXuUy1otRVP+NSmCIFrE2OHCgvSPHy?=
 =?us-ascii?Q?MeK67rvoUkh9Mqw+1vS7X8vuxCsFQSs7WuTgkcFHbEONl++6lOh3kvlhHN8z?=
 =?us-ascii?Q?Qv2abwQzJdSTDtbsOP0CnAIqf680HlqTWTI0ikLvnMpVSDmp6rrxxOF4rRn/?=
 =?us-ascii?Q?gvsBEFA8TkJaGS97ncdcFYtN095fUrjL9lOoXC4Xvr/0DUWIMsmzO0jOqHx9?=
 =?us-ascii?Q?nsybNbwcV5Of3Zzm9obSsHfFw+YNO2S+Ct+48YXwzN8MyUTL/vEDDY237VET?=
 =?us-ascii?Q?0F5hozjB5hM0vSp7ca2OxQZeWgrc369xOvZrPc+eYC5bYPF1iCQC3qa1Ri99?=
 =?us-ascii?Q?nsR6mZ3rJ7Z6WTRuefF2FrEGbJw6S5dgnOR7BWOZPmMH0PwVAvdesXwSjY66?=
 =?us-ascii?Q?EMO7RM0PU4Cp5cW/2R7wy20XJRbHPve7qsGnIt7fnK7OhQ+m3NAfBukxLexV?=
 =?us-ascii?Q?eoxdU+h4cBDfpOoQSt0nbIb8VhMKDy5O6WImN3hUGIqxHL6+ExF4YEB51EG+?=
 =?us-ascii?Q?siSLeTR2+0CWM06CQLuwiY3bfyPPEQJhdFg15MeSOVw3OzWjFXl7yvM4g6jD?=
 =?us-ascii?Q?AB9FrEsgNGGJFXijUAvowYAr6nIYtxm8Rr7anG7vNjVem3mLN8r28jnXaXc/?=
 =?us-ascii?Q?JjjA+I3fv9bmcYB8MWWHHnofndE1TBDF4DQulOWB3ZNdiu9v1BH0w+p455oc?=
 =?us-ascii?Q?b3H8k3SZw8PPGirGgfCj4raJ+Sr7OW1kd5a9NQFuQfsG2gplRswuGGjnzrJp?=
 =?us-ascii?Q?LIhCFOUYvWn2eI4ZpK+xrrBCbGepspcDJhNhxNI4y6E1y3LOGGVZrGozKRbr?=
 =?us-ascii?Q?lg3MLhwRnoO9vezy8e5zUi9Z3tt3Q7SJ5v5+QoLSAT7WGKy4ZsUOyLOx/M4E?=
 =?us-ascii?Q?+Oma+tJPctY497xrJsDfjpsZfQ2SXTXme09+g24z8OZw7qTX/daUkgY3KuRV?=
 =?us-ascii?Q?WAvla0LCQ0vpnHwNVLRl8LE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c90709-c4d8-489c-bfba-08d9bf2aa186
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 17:53:26.8192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVGtxunrMG00whXt4y4XvaXBirpQdgvVnaILZA5u8RrFxUWqo31n2hVwmqIaYR6xAdPFyJqrjO+sHlscnDoTVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2407
X-Proofpoint-GUID: GXWuXs3B-UsAJbhWSBIQnFdZ0OTsro2z
X-Proofpoint-ORIG-GUID: GXWuXs3B-UsAJbhWSBIQnFdZ0OTsro2z
X-Sony-Outbound-GUID: GXWuXs3B-UsAJbhWSBIQnFdZ0OTsro2z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140096
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] tst_test: Print environment variables on -h
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> -----Original Message-----
> From: Petr Vorel <pvorel@suse.cz>
> 
> > Hi Tim,
> 
> > > > +	fprintf(stderr, "LTP_TIMEOUT_MUL      Multiply timeout (must be number >= 1)\n");
> 
> > > I think this should this be: "Timeout multiplier (must be a number >=1, should be an integer)
> 
> > Also makes sense, thanks!
> Although it does not have to be integer.
> => "Timeout multiplier (must be a number >=1"
> 
> For C API it's used any value:
> ./open01
> tst_test.c:1409: TINFO: Timeout per run is 0h 05m 00s
> 
> LTP_TIMEOUT_MUL=1.15 ./open01
> tst_test.c:1409: TINFO: Timeout per run is 0h 05m 45s
>
When I grepped the source code I saw the usage in testcases/lib/tst_test.sh,
but somehow missed the usage in lib/tst_test.c (sloppy on my part!)

Thanks for pointing this out.
 
> For shell API:
> ./zram02.sh
> zram02 1 TINFO: timeout per run is 0h 5m 0s
> zram02 1 TINFO: timeout per run is 0h 7m 30s
> 
> LTP_TIMEOUT_MUL=1.15 ./zram02.sh
> zram02 1 TINFO: ceiling LTP_TIMEOUT_MUL to 2
> zram02 1 TINFO: timeout per run is 0h 10m 0s
> zram02 1 TINFO: timeout per run is 0h 15m 0s
> 
> Doc [1] explain it: Variable is also used in shell tests, but ceiled to int.
> 
Would it be useful to add a bit of code to tst_test.sh to handle
floating point?  The shell construct of '$((timeout * LTP_TIMEOUT_MUL))'
can't handle floating point, but floating point could be done pretty easily
with a callout to awk or bc.

I'm willing to look at this and submit a patch.  But does the shell
test system try to avoid dependencies on other utility programs (like awk or bc)?

Maybe rounding timeouts up is preferred behavior anyway, so
this is not needed.  What do you think?

In any event, I retract my "should be an integer" suggestion. :-)

 -- Tim


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
