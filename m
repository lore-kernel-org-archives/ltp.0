Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE90ECAAD5
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 16:35:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2D273CA56D
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 18:35:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73E8B3CA487
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 18:35:28 +0200 (CEST)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com
 [185.132.183.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E167B680E41
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 18:35:26 +0200 (CEST)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TE6i1Q015188;
 Mon, 29 Aug 2022 16:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=VlXd7tXj4AX/Sn8x0swpkyYbF5nFwaguhr3UWcIoTy4=;
 b=I2uDc96vHzkEjZxWodivwhDaV94oaCHdyp+PIY4+vaOUf77gnzAbp+ew38jTs525NQhR
 XB6l8IovpMxsUwwA5riHtNen/Myx64jx3iV49cU6Y+JVTPe1EFdfiI6ewrGLhFHp1LvJ
 45j+dKgYWEbrNlBCJeXOahAzcinpT/zw3EqE559ieEY0NEjlIqC2yLMFaSu5bP/T4TZv
 7CL0JO8rijEAten4wOv/f1BU51affKjKt/FMggzVkY+HAolMsVx8WTn2Wcq8KxoviSsy
 9bYRNg1Lkzq0rwTPQ9qLkmx4XhSVJPm8jOiG3mbbN8RsmRsclQJPhnzqHamr7umMiz/i Xw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3j78e621bt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Aug 2022 16:35:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVxdDgIKtyajWvi3gqUsmc1ae1wYyV06tdC5Pf34P4i3yPjgjdm0gw1TdLeLgjpypa79Zc0m+g7x0b58sGpZ2Q2F167xxlN/w0k8pNnyru9hGpWfMV6VyYFXxhagKWgpDEg/yeqK5e28mlgYhu4T8z1zN+uBJib4iGAPIO9pMJmE4A0x6B+4Qb1VjHnPQMWT1NKyVoqBdgyz98ylmyheJc7/YNoVe/9+OXnVQYUa+VoodaIdyIACy9FrWbecr76xOiFVHB4Kz9UUJaJTRcDCqNeLDW/2LfMYSYPBH6q2Suw3ySiJ+J7TqVtb6wk7QtLIZvsLpaMJq0/mgusUnKuwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlXd7tXj4AX/Sn8x0swpkyYbF5nFwaguhr3UWcIoTy4=;
 b=cnhgFis6vprANa4rk0zBy7IY1OB5hoBVLrhortvMyWCV+bcbhi2N+K5bAaXF9GAhmpT1vAJV1m6s4U7SFfwma1iOIFa1rdauzE/KNRJmtotPE+wg/I1Nz9EA6FZjie2COkQjwDR4HxRQfE4DxwvoSxoXmigng1ez9F76B5IJeNdB3jnAUQJSc2C+zHZryz7czYGQThy/LSl2fwQZRnVKmRiqO05mr7/PFMYtchJ/YlVLbIAOrgfHfXz4ySFHqKBmEos/Lj42+3iOoQTqltWIWJ9uoHUAYuTb1aUmTeG5F3TNkMY278xJ+swVnuVStyL7iAFATbz71woZfqvujlIOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by CO1PR13MB5046.namprd13.prod.outlook.com (2603:10b6:303:f4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 29 Aug
 2022 16:35:20 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::84ef:e0b7:d15e:8095]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::84ef:e0b7:d15e:8095%5]) with mapi id 15.20.5588.010; Mon, 29 Aug 2022
 16:35:20 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH 1/6] tst_fs_type: Add nsfs, vfat, squashfs to
 tst_fs_type_name()
Thread-Index: AQHYuavtLluMU2mGO0CYvkTjQ0mLnK3GCX0AgAAH84CAAARtMA==
Date: Mon, 29 Aug 2022 16:35:20 +0000
Message-ID: <BYAPR13MB250348CBA4E0B0333C5CF54AFD769@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-2-pvorel@suse.cz>
 <BYAPR13MB2503569ECEDEAC432FBC577BFD769@BYAPR13MB2503.namprd13.prod.outlook.com>
 <Ywzl266wQ89KonEW@pevik>
In-Reply-To: <Ywzl266wQ89KonEW@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3099694a-8ce8-427f-8e88-08da89dc7699
x-ms-traffictypediagnostic: CO1PR13MB5046:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNlHENX94es4eKCvqN6HsANkbrmEZtZ7G/X80Xg6y1gGgMUFboDmQKTzf5GUzpozUjqL5Ev6BhC/qqgN+HqSmQKBPVO3UWWRBCE1Sf60V64z2Psk5NDDWkglgUYpG35pqYdxPzb1Opu7w8uk0K2zH/+dmkxR5Eyp2roSnGCKO8hbfqulj2oWKgxVI7anTEIB5pMMX458gfp8CWCfGQEy896cwSwLpouXcJCpkuF/quYgXVHBWTiaodrMp8qwOJoQGhv4tOgt9ZZor56Laz0NQSZEpDr6WqglrEhuQkwSpQTy1PeKhX9cmDKF+i3q4NXd2LEg8jS8qhCMiMBYZ3MyBMEBVnds1zvTC1QLkdaND43HmCwHygoKUL6SdzC6WdHhX0H4q9vuelvhjRlXo/A6iBgWy2YYafMaZUemAKygtJqM5zeRxH8buTvfyQjjoPjUTMskVsITGCgFpXAQ3bcgs+E3uGh3dDXaQZRHTfM0WdXoxM9voftM5Ak2lOHWEHtDcNWp4U035TaYwkwCZFXqHMtQNyAM705l0uu3CGmgCcRoGFW8OeDwp0QVcTIngy9IIxUYlEOo3+I0FOVDbkU3L+K8A6Azyxih7GiD1yN4BNRzoSNynwGqYtrX/HOXtr2LM1BvPANrHiifkUTlFMf/FtRgR31muvE0YIQ42qfSP02b6C8wWiTExzPVOd3Ey/HKnZJ6cTCeNvviPmKk/V/OnZFFjZYlhhvFIcmrmmD3M6139wH3nzKjRZ9uhEdLU0vh8NFb35wA56jwPd/JciTOEGLq5Gy9CFnhIgOrkBQL4IBFj5Yggm41HXhqQtRg/EPtzkPDSEGvjLYlIRUfsCITJw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR13MB2503.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(186003)(71200400001)(6916009)(316002)(7696005)(26005)(9686003)(83380400001)(6506007)(2906002)(33656002)(86362001)(38070700005)(82960400001)(122000001)(55016003)(478600001)(5660300002)(966005)(8936002)(41300700001)(54906003)(76116006)(38100700002)(52536014)(4326008)(66946007)(66476007)(66446008)(64756008)(8676002)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Qt4k2uQO+W3PiA0zdh8ClDQrA4TacjdMUdn3pb2WpuKApgk5KIsGjlYmqpY?=
 =?us-ascii?Q?yCghke1JSySr8NYGxIZBeqTBMMHS2CdqgUGSKjU0gSBRMyQU/muPOyLQHA9a?=
 =?us-ascii?Q?0SCkNfAVENvTbSM2yaqb/0Z9rXtfzfZoCnE/wti/KnITc3eFEEzRivRjR88F?=
 =?us-ascii?Q?2Jtv8oh+yQoM7WmHHprWAe1/rJQI73f5UZOFyC7wXVV7MWkZ0/4jwAuT0JLG?=
 =?us-ascii?Q?REIj7LhMEErn1eMoeL1RtyABs81Moj0Y3bdYR3E4h7SL8X1Plg02l0Sa73TD?=
 =?us-ascii?Q?Ww9ye8gLYQVR1KNNTobtuKNnhbWunD42grdjgX0+V71SNBo0C2meewROB8gq?=
 =?us-ascii?Q?PB/U5hsSYDLiTgqFJdyQmN04u9TtKLFbz4MaXi89njefzEkdbEg4eYdSjfYB?=
 =?us-ascii?Q?yjMl56otyVrqTxKFhfR5EsM+Rg9esH7TnMv+4OyxOETm07qtbx9GbB9GTChB?=
 =?us-ascii?Q?ZBopkb/wkVWb9C+G1Pd31QlP9p6Ui/l6bhvlzANAv+xf7h2tRML8isIUeH+B?=
 =?us-ascii?Q?vlq9/yQxiPcwZWn2UJlx11oXxf3JrVLLyeKZA4DXnDc2jU604JGsZVc+ikgm?=
 =?us-ascii?Q?58fL6mgkOCLVm8DLNHC9lPbaMnrskqZhtL/to5FqZ7e4G5euD9bm1qIQQ3K8?=
 =?us-ascii?Q?gdtFrn6JDkSq1LguPrWkEeI91kqnYuLtSltKI6Gj5zNd3u22iVQH+O8l90mh?=
 =?us-ascii?Q?DgZb2b5z0QiwgwVvosM/XGyOSV7wvm/I8kBu2NRvekAEj7eLy8qNJdxJ717P?=
 =?us-ascii?Q?HyAjimI0hlpKh91TSjJfcuAg5j2d3PMYvYoQIeaAcXSh2C1r6Fs5JiHDxTCC?=
 =?us-ascii?Q?Wd4agJ0SdpK6obXCEFnAnA/u4GTPHS53liDiA6igfQZMScnh1iG83GGsurlK?=
 =?us-ascii?Q?oQxErnVs/TE5mVr+X4w7f/ZjoN+SPDf7+kay+UhOAkyCxc3c3feYo/oOWaEv?=
 =?us-ascii?Q?LdT0KOEPmlI4+TNifofkiinSEi/o7my30AwvEgcJg1rC2pelU/NqM4sUZnF0?=
 =?us-ascii?Q?kA6BVGGzFKa9ZbP0wVvwmJ184uplLADlsJylw5u1QHBV/vvPSKJIUHDdzJvV?=
 =?us-ascii?Q?8vVqGsRbKWfQa2o67XZTe5C71M7JIa7mOI4tvxs/b986GkJ138G8a2iBn+su?=
 =?us-ascii?Q?zB16mvF/BJFuDrU4aXMTGbt7ij1ONM4YIK4HApCWpQ0OF+GHfcAG2lRdFVFR?=
 =?us-ascii?Q?SNGbaWtx1V5MZCHg6QVbuKvo//T0q58qo15dAXtoemHMUQMevpt/tEmn4L5A?=
 =?us-ascii?Q?U2PNSBCVXVlkJf9l9i7ndeTvWDshlx7K+re3/lvsToeZrwUr3G5oj0lzI2Bb?=
 =?us-ascii?Q?laITyy7V8cPgp/R5fMiOlN5kKus0cHqf3vOG+BCWXw8mdGCbwJvTYYleyY89?=
 =?us-ascii?Q?GOEpJZmi5HmlM+8e/MR9SGWPxttq/EdXyrApQUS0zIJwgv69BHgenCTiPRvr?=
 =?us-ascii?Q?LK8yYCbSQCwedSjuOTHkPIpBUOguOkwHcme6Cmbf16ue8rb2cOLQM7VjWt5Q?=
 =?us-ascii?Q?8HEAxMgUttlPqj/jlpACjvM6O8FjVp2AMRCnWqUw+75VkXUCgVfSCRLGhbpV?=
 =?us-ascii?Q?mIOjVJ3pB/UYIq4UPxPI5NBUINRjn3nQ2EnjRip2?=
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3099694a-8ce8-427f-8e88-08da89dc7699
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 16:35:20.1463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3cjFvPTGzlGW4RC8Ap1m9V4yCJUATy+BiRNlZyNK9iyr/KDEbD0E7jTPWdIay0XpOcNKP2sAVPma1pOwMuEL8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB5046
X-Proofpoint-GUID: etQoHhj641TBBYU9api--N9tiZ-vfJcn
X-Proofpoint-ORIG-GUID: etQoHhj641TBBYU9api--N9tiZ-vfJcn
X-Sony-Outbound-GUID: etQoHhj641TBBYU9api--N9tiZ-vfJcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] tst_fs_type: Add nsfs, vfat,
 squashfs to tst_fs_type_name()
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



> -----Original Message-----
> From: Petr Vorel <pvorel@suse.cz>
> Hi Tim,
> 
> > Minor nit, but the subject line has nsfs when I think it means ntfs.
> >  -- Tim
> Thanks, will be fixed in v2.
> 
> How about XFS using 300 MB vs 16 MB but using different code paths?
> How big deal it'd be if we require 300 MB in case testing on kernel with XFS
> enabled and xfsprogs installed?
> 
> https://lore.kernel.org/ltp/YwyYUzvlxfIGpTwo@yuki/
> https://lore.kernel.org/ltp/YwyljsgYIK3AvUr+@pevik/

I'm not personally aware of any uses of XFS in embedded projects, let alone
ones with a filesystem size of less than 300 MB.  So I think it would be OK.
Such a test might hit some lightly used codepaths, so it might have more likelihood
to reveal a bug in XFS.  But if literally no one is using XFS in this configuration,
I'm not sure how valuable the testing would be.

That said, my knowledge of the embedded ecosystem is not comprehensive.
I just posted a question about this on the celinux-dev and Linux-embedded
mailing lists.  I let you know if I hear of anyone using an XFS filesystem less
than 300 MB in size in their embedded Linux project or device.
 -- Tim


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
