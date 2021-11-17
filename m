Return-Path: <SRS0=ZNpR=QE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6D5C433EF
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 07:54:58 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC3161BD2
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 07:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9AC3161BD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBDCB3C87CE
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 08:54:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 003A53C3329
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 08:54:45 +0100 (CET)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D6A6414011B1
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 08:54:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1637135686; x=1668671686;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xZ8BUUWU62RR5SEN33haWt0PngeCsVyWUxNZ9g+vOuM=;
 b=UMexcTkGPZ6YB+PBnzgPqBmjrSx79+I4ZYZYqcVhHjpJ0U79A957WXdG
 /SwrSILBoczJz2wVCHkJUBDDMzzcfy+u2+QLrdlLxziqPCdNJn+RTVUdu
 73JohiuwKxG74jQi8gdHl+o95hGkPHosvhwafwchzfIYINRcFC+PidFsg
 6Xou89meiLLoxjmkfvsdIOSPkLh8Dt0wcNf+0tFmsc/39nGDDmgpMS6xa
 Kz/ayWHp/2XP4hl8Job0GOsE9wrvgvYHGyut0V8yw0VRfH0Uh5AIhssEL
 zkK1QN8lrCuK9mlD4b/J84eNpfX0eWY5BvB4+bJBfPGpEuBBT8RNvhDqS Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="44594305"
X-IronPort-AV: E=Sophos;i="5.87,241,1631545200"; d="scan'208";a="44594305"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2021 16:54:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6ikGNrNh+W/6byw0P/2SlntKdXbvKkcZrKRWPTOuycfws8aXjq3aknPSlIJRepm1M7qdF4afEe2fszpMgSwxPJ49lcanJHX1Fbh52vswxjAKbaMBrph5M5Hbuz4MdKacYe2DcD4IKAbYtnGRVolVPLxWrqA0bemN+JGYNkUNfwLiRBbjob5PVCpN/aOYtJs2fWAPWva8tdJzjv+t7BpIS3dMjY/mezSVSxkZzgAX9RBK5BDl8C/BJ2ufjQfc/e18lTXKTHoMrsXlwxwDLMfDChouH4qM267Fn8pIidLhhtOG8jxJwBPZg21LVIKI97RN6UpxyFgg+3RcR4en/fzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZ8BUUWU62RR5SEN33haWt0PngeCsVyWUxNZ9g+vOuM=;
 b=Thr8CYsWF0RrkPOqewm6KFrGZN6NuZuaLEvsJtgNIkJ1Byesi0+5MtcbbrKCtNuXWVqIJpzt/YORBSHs2Wf7fkeFDWO3L5IDDAnSeM3autEkyIVBPZALsjMDTALMWrjXRNTmCi5mR3Cga6+4y65r0spACbFudf9rRk4VzpecN/pS9/tCsz6ZDb/nu7g/Nlm9VR7cS8tBD7Y8rIxXGWePiFXUrpEhuyuxaOCRnF09lnuslqysfE3yVOwl5RedKpxc65WVk4ZQ+avha+8Czc9z3ZFD9ScNx1cOZu9xMds2PXoCYbGfDq5+kgrTjANftxnCPsEE0iTv/SjWmlkdktaGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZ8BUUWU62RR5SEN33haWt0PngeCsVyWUxNZ9g+vOuM=;
 b=NZtDOODRc8Ers8DMM2u7i3xqLVm3PRJRbdUI2tLPr8A5DrHuBZKEK08pFlIA/9SJ0yB0HVpxpxWXo0s+RaQGu688Y1Ld5rx+BHtGS+GRG8tlhKIA51Ph5N/EiRZhhjNGuc8awCKNCnWhBNksJYnsnOQlEIB5KPxldVXA9QZdkJ8=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB4622.jpnprd01.prod.outlook.com (2603:1096:404:12e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Wed, 17 Nov
 2021 07:54:40 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%7]) with mapi id 15.20.4713.019; Wed, 17 Nov 2021
 07:54:40 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Jan Stancek <jstancek@redhat.com>
Thread-Topic: [LTP] [PATCH] finit_module02: fix exp. errno for O_WRONLY
 testcase
Thread-Index: AQHXyaPvQYfk9SBELEWpwUTdeDR4/6wHfa2A
Date: Wed, 17 Nov 2021 07:54:39 +0000
Message-ID: <6194B56D.9070100@fujitsu.com>
References: <04692b4000ee415add41128173e395f830ea3e56.1635168255.git.jstancek@redhat.com>
In-Reply-To: <04692b4000ee415add41128173e395f830ea3e56.1635168255.git.jstancek@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45cd67b2-8bc3-4a72-dab8-08d9a99f824f
x-ms-traffictypediagnostic: TYAPR01MB4622:
x-microsoft-antispam-prvs: <TYAPR01MB462291CEFADE4ABCC5C828A1FD9A9@TYAPR01MB4622.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rT8JhIeoAseX7dsEPhPcrwuuVGzsR0+/Qm7/3WlJ8v5MKJkU1gX2sc9gn6eAzmFCRDDEsFtCODBCq0wP5thfXpq60Z6qz9Ol16DMVVopJcraZ29y2kns7p3TVOYDWpkQHOGPVyK9Aq6DVUMsnz329ObSCcnNctTJXJdrOSqJ4aQu+pO7xBXVLYoVZDfGVBmdHX1O7GTc2xkM8iqMBBNAIL0iWbLD+ZVcLPY9iueGjiSt3FVGKDkyhpMExx4wtPV/KXBsKkDMUU6ndhVKz7EGKba1YUdLPO+w6MsGZCWckfTCbTDX/QtMuj8orwP3HtPyy2Ten3SAt7DUa1Vce49VpFQJ+elhMKHHrferEJ7b8CP5erwh4UFGCN2Kp5KZ0Awow+JaPgGA5dZhpq1Ce6JdedUVTv1Uhe2wfsL2mrusb2hZOhil5kpN/uSpA19FrCuJeZ/kYpvXzgLwOIwXPSn4TRgrAe/6l/cskYjgryvkpBruGQjoASQK0nNRUSVNa6htJd8IM/poplCILJdEnpYeneDANg9c/m7HSp+iW2iD7LIUZP+i84PcWcoUIBk8q+OiI61GIsbuFaVdnamKsE6r//Pv2vhh5m9HAG+RNhyy6y7zed2iLQ+FBz30a1qQOzu2MNmNf4TS7VpxtfNelDWx78NWh7y3HhqdEE0EdVm5+gzKOFpRwcXWlFZWKYzOdq28C4Ky1hXkH9q6R65m6NuDGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(8676002)(6916009)(316002)(8936002)(38100700002)(86362001)(85182001)(33656002)(36756003)(82960400001)(38070700005)(6486002)(6506007)(5660300002)(508600001)(71200400001)(186003)(6512007)(66476007)(26005)(83380400001)(4326008)(66946007)(66446008)(2906002)(64756008)(66556008)(91956017)(76116006)(2616005)(87266011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?c3ljbktoWUdtTks4bDhUTGpSOVM4WElFY2ZXeTBOcndiNWpFWE9qNWZjN3Z0?=
 =?gb2312?B?dVFKRGQ3STQ5MEdUSGRFOERxSkFtV3RiTEJHODI3UVJJMTI5RHVEbEkvN25z?=
 =?gb2312?B?T1k4R3pDZ2R0MzJxNTNmSG1Sdi9QWlpaQytwa21aSFg0eGRzdTlsak1jUEEw?=
 =?gb2312?B?V2pVSHhtYnhRWExnR1RTKzhWUktFdjJ3RjJmUEVGNk1lTlFaUy9pQ2Y0bUF0?=
 =?gb2312?B?TW84U3JQa0J6UGN4QjM5RzJUazhqTU5XNHBBblBOdkJmNlY4elhZc0piamtz?=
 =?gb2312?B?bmVKZUdtZG5wZUs1SEw0NmNaTS9mSlArSDRFS2haNTdPZWY5RmRwWUhtVC9i?=
 =?gb2312?B?dUgwR1g4VldhUk1IaW5qYkhtaVBtWmpvc1J6b0htdmF3d1lMM3hiZVF6VWVU?=
 =?gb2312?B?V1JxcHRGSE0zcWwzZzJEcEJkYk5NRmRXdGRTUHJ2YmZDMjhVT3NLalhIVjl2?=
 =?gb2312?B?WXJZSlZvcFNyNXQ2T2Ezdm0weXA0b2lhclp5N0w3bUN2RW14QXp1QlNnUkV1?=
 =?gb2312?B?REVwL2JhWitrQVUrcnpBeHlSUGQzbXM0ZXphbTkrQUVETU5BMVlNWENSdisv?=
 =?gb2312?B?a1dFR1AzVTJ3OERqUDkyZ3Jvb2lMcGNPR3h4QTNTVlhvcHI5MjI4dlhnOFpp?=
 =?gb2312?B?dzZydDlydWdWc2h3VzlJdDhzTVpLMFJNZXU0ZEZQUmdubXNVQWNkeXEyMTVy?=
 =?gb2312?B?TmF4ek5DakxTZjkyWWR2N2kyZkE4M0I0aVY1TWIxSGJnckVQNVNQazNDaG90?=
 =?gb2312?B?bEN6UEozbU1mR0Z5cWNXdU95eklFdTk0d0pQTkdGT0pHMHE5cXZFRmlVV1Z1?=
 =?gb2312?B?c2RTa04rMzZLaUdZcU8wTGVIU1d3Sjc2LzR0MWRMaWFrY3l2RmxEUTRmNUtV?=
 =?gb2312?B?ZEtiWitMVlBVUDdRK2dhcWh2a0d3T2xuYTA2dWVyNnNtS3lqbjBRc0tQbkpO?=
 =?gb2312?B?WmVyU29UcE1jaWlTMm1hMGovZGxERlVxRGFEMFFBVkZkaEFkOHgrenVBdWpB?=
 =?gb2312?B?c2Q3RjhUdlNXRkhyM1hsdXE3K1JERVNNSlRDUFJad2JVZEhnMDhxaWVoRFBM?=
 =?gb2312?B?ZTNRZGNobFVyb3FDVTU4RUlKOHZpRzJPR1Rsb29mdktWbmVwQllCSmZ5MERp?=
 =?gb2312?B?U1E2Y0tRNnJjTktrcmRzbm5ESFN1NzRBMGdUQnNVdGI5Z0ZUZTZ1N3NrTE40?=
 =?gb2312?B?MjNTOGtDaGUwcFk2VEVaRGdlV1U4MWc3N2VPQlQ3eGJ4SVd5Z0VpeGxxRzg0?=
 =?gb2312?B?UGJDcnJZYmFnTERFVVZITlZ1UlMrZUtjT0FDRUw3TFBjNnJnQmwxSS9YdXZQ?=
 =?gb2312?B?T041cW45QlJyb1pvdzNVY1VOYkhaSHhWN2d5QjVJaG4yOHhJdjlFMEF6MVdn?=
 =?gb2312?B?QTlINDQwWVpyVUNJYVZMU3h3SHBxUFVUandZdithcUNqSHlmOE95WTlVOTBH?=
 =?gb2312?B?SUhGZEwweXd1R1NiU0JHbWQ1NCt5VURxbExKUTVKOHc3RTg4b285UTJzcDhV?=
 =?gb2312?B?b3lwd3FtZmZVYk0xdHlocTBrV3lwN2FVTmw2NTBjSi9sVTdKYllZZVJMSUJ6?=
 =?gb2312?B?L3ZaMEhWZUZTMDJjUDFyZUhNSnF6ZVUweS9KbzF2N2p1VzdRaVJIMWJnalFN?=
 =?gb2312?B?b0JKU2RwOC9FK2Q2a1c2Sng5RnNoWG84MFpsdDcxb056U0pYc1NmOVZ0bkJh?=
 =?gb2312?B?eFJwTms1TkdkcGdmbEZNbDl2alNBZzhSSmhlSXJHQjdEcFFnSmlzeVlQWjlV?=
 =?gb2312?B?UXhrL3cxSHFFQ3U1OURlTktBcDFXMk4yaVlXTmtQay9hSWVzTEFSei9DSFhG?=
 =?gb2312?B?MEwvc1ZvdVFlUzBiS0xWdGdGNlNrVkZMR1crL09weE5NempHSmx0aXBwYWhI?=
 =?gb2312?B?SVVqNTFrNVRrc0VBSkpndjRCNGg4ZVNRK1lyY3ErTWx0Y1YyVlpsMURZQU5p?=
 =?gb2312?B?OHBOdEZsRlM1V05WQ1B0bmlTc3NjRHVuVDlRRmNOTjU3eU5MNnB4QmtzZDIw?=
 =?gb2312?B?ZFdmYlRDalU3TTJZZHlsVm1VQm5FQ3ZTYzVtSHBoTDc4N3dCejkzcEpOUXc5?=
 =?gb2312?B?NytBN2EwNEFZNFFMcFBWbnZEalhOUFBwWHBjbjdlTmltU0tRdjE2blpLdzlZ?=
 =?gb2312?B?b3M4bWRxamtndXh3dXlETUIrQkFkVS9rQkxRVFowZ24wWGczU1BMOGxoYjcv?=
 =?gb2312?B?dWpWTDBoaHNid29JSlRwSURDa2hFZUJkaTRXejBCaFhRSkJHWDBsRlpPVEh1?=
 =?gb2312?Q?ZTgXfM20f/L+dZEYoV4U2bEkczBxsgrhH9cEOYCs1U=3D?=
Content-ID: <377A72400E64E7439DF5EE3D463D7EBB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cd67b2-8bc3-4a72-dab8-08d9a99f824f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 07:54:39.9994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faDjfuuZIQUg+xCG2HT4fRaWvCZWVsYIYscA7GeYPGv4lO2E/fKkJ8rEEDH2hGnV5VEdIRCBA5SZUQ85XhrszWI62+aQC5h5oyP0SPXX4So=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4622
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] finit_module02: fix exp. errno for O_WRONLY
 testcase
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan
> commit 032146cda855 ("vfs: check fd has read access in
> kernel_read_file_from_fd()") changed errno back to EBADF,
> which is correct value according to man page, so tweak
> the test to expect it for kernels>= 5.15.
It seems we still can hit ETXTBSY error if we  use RDWR fd on kernels >= 
5.15.

This error existed since the following commit because of 
deny_write_access api
commit 39d637af5aa7577f655c58b9e55587566c63a0af
Author: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Date:   Sun Oct 26 12:42:07 2014 +0200

     vfs: forbid write access when reading a file into memory

I suggest add a RDWR test and send a patch to record a ETXTBSY error( 
Since linux 4.7).

What do you think about this?

Best Regards
Yang Xu
>
> Signed-off-by: Jan Stancek<jstancek@redhat.com>
> ---
>   testcases/kernel/syscalls/finit_module/finit_module02.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
> index 0d2bf917ea64..9b5d3563b74e 100644
> --- a/testcases/kernel/syscalls/finit_module/finit_module02.c
> +++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
> @@ -52,7 +52,7 @@ static void bad_fd_setup(struct tcase *tc)
>
>   static void wo_file_setup(struct tcase *tc)
>   {
> -	if (tst_kvercmp(4, 6, 0)<  0)
> +	if (tst_kvercmp(4, 6, 0)<  0 || tst_kvercmp(5, 15, 0)>= 0)
>   		tc->exp_errno = EBADF;
>   	else
>   		tc->exp_errno = ETXTBSY;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
