Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919F5C25B74
	for <ltp@archiver.kernel.org>; Fri, 24 May 2024 06:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716533317; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=YJYieyIUHSeFIX14yjLPDNTp908iFbH97F7bC9zyeBs=;
 b=fNNUPi+6AbID9slx+nBlHQznHg9w7kQZHZe4Io29k6FO5wq5TrrFA803BVxGAGDhR13wa
 tQLybVeg6H1XZxGOw7J/m7Je/LuBvKnXyEOkEVmqV+qs7XA2HKfvT592Qs0nhTxrxeDOZYn
 oBaTvtADtS6o2BBS3F0M9hEOrWWjcMw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DF693D01B7
	for <ltp@archiver.kernel.org>; Fri, 24 May 2024 08:48:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 932613D01B6
 for <ltp@lists.linux.it>; Fri, 24 May 2024 08:48:02 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.151.214;
 helo=esa4.fujitsucc.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E876B601903
 for <ltp@lists.linux.it>; Fri, 24 May 2024 08:48:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1716533281; x=1748069281;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=h3HlBFcjlocDIkHbHUiaDUyB64pS+YWc6PNb4k0lBUk=;
 b=eulCdUop/qMjUWG2CB9ifW71zyhKrmUdzEIhrJNJSH/fv6AdXodT52Bu
 3P1JKYhygDimCtjLzd5lDmy0uKjzN1rz1QKzKDCQIYrlM/sE8foTzZWTy
 I69SlSYPjS+WIqMPQR9/r4MpcGMq897asWuV2rZ7Lsbj4yZ7CA7epQrcu
 Q/gq4ggTNaszSb3G4khbJscIm1BGYeLs4npvLgJMo01hCb34u/8eQpZnD
 RbqisXW4dF1jqfpLIf6tQCGKgCX9oM+kEAYEKNQvVT4vLKGyB5owI2zoj
 yTegvtBiZGOG3KUSz8+M1q9k+bMHzZ8wUcDzdfK/bEvA8yHv0yzNhQySf w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="33354259"
X-IronPort-AV: E=Sophos;i="6.08,184,1712588400"; d="scan'208";a="33354259"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 15:47:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsxyErayGKPxJlfJuNPIep/MlVaI5aTgxnVnyOHHMJcWZp2jwXEcMbDOumrtGDfKSwZle+psUZywdzyKN/zSGdjRz0mk2wrPVsWwJCTZlixLekxFAFfgsc1nXbR1gc3vwb9Wsdammkx7Q77K8grlpl9FlghXqbI1JgC3Z7Lf83x/ABeGs9NsVgXt13Ma66J5WNT9SFUTaP10AyZr7nJDHBdUoBZ9d1UBZpz3OLPLT9uT/siB7v1gkWF84BWnkQ5yMEBcBUHOiJ3pKFsKCnPH1Z+uKSo9AuvaRYY375ah396KJmkV2PNVi07+oNxUMi6Km0wOAmOJ5cIA99U7fOXNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3HlBFcjlocDIkHbHUiaDUyB64pS+YWc6PNb4k0lBUk=;
 b=h8T82xDF5oPF/GUaEu4KIyrB0UxXY3xtZ6DJf7+KS8J1L+/moETtUEKdDcKJK5KL4KmU9+IW569NLA7AZB8VKyHn04LBxFSmUR2YbH/0M1uvC/HCiX14KnCeSNbQkwLOaL2lXvOK6aEWwzFnESJY+LO0Jec2j8Aw21K0yLb8oFwXOyzR93Lo8T7t36Xvf0lYmOl3+QYTea6fAnQVIowQurWke3fJTOcuLS+wn0mttLcUdVs1al/tTZseg55sewALvc4EYmKppWTjvzZGLjoQlHq9iQLrVYs58pobP6ZPZxh/cr9HY8pnKokBH/2UvywIXb1RjcR3MPxHbqWg3xg7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB6504.jpnprd01.prod.outlook.com (2603:1096:604:e6::10)
 by OS3PR01MB8842.jpnprd01.prod.outlook.com (2603:1096:604:17f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 06:47:56 +0000
Received: from OS3PR01MB6504.jpnprd01.prod.outlook.com
 ([fe80::573b:9293:619b:1da]) by OS3PR01MB6504.jpnprd01.prod.outlook.com
 ([fe80::573b:9293:619b:1da%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 06:47:56 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] connect: Add negative tests for connect
Thread-Index: AQHajLVE7bIq6FZUBkezlID7L4zLrbGiQzSAgAPv/AA=
Date: Fri, 24 May 2024 06:47:56 +0000
Message-ID: <169f8520-1bc3-457f-835a-02cc79c433a5@fujitsu.com>
References: <20240412080739.18933-1-xuyang2018.jy@fujitsu.com>
 <20240521184011.GA207312@pevik>
In-Reply-To: <20240521184011.GA207312@pevik>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6504:EE_|OS3PR01MB8842:EE_
x-ms-office365-filtering-correlation-id: bcb7b5ef-bbd2-43da-6b39-08dc7bbd71be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|38070700009|1580799018; 
x-microsoft-antispam-message-info: =?utf-8?B?RU9vckpyWDFQVVZHQ0tha0dSVHdJSlgxTk56Um92QUxMUXZtMkRyMDZSNmdQ?=
 =?utf-8?B?T0RBS0toMWVxL2YxQmZLVVJ1YzFTLytKNzEwOG1QeWhRNnhWNGNxcms4b2tB?=
 =?utf-8?B?UDBocitHOUtyTFZsOWtWQVRTZmJ2U2lic0NxUTBGOWFTNzBvZVZKZUJpRnV1?=
 =?utf-8?B?Umt2eVlnbEZZc3pmYXpRNkJNSEYzVVA4ZTBHZ202Zjc3clJrTEpFbzk0bXdN?=
 =?utf-8?B?WWZqR2Y5VlNyK2xrT213WUoxczU5TmcrdXBkSnpDeXAyQXp0TjNGVmxpUC9z?=
 =?utf-8?B?T3pzbTRacFZlOVZ4WkJpWVdVNVdXd3JHb0lGYUM4a1hQem9DbEFodEdYck5Z?=
 =?utf-8?B?OGExTHVScmdiUGhFSjR3TnZoYzdDUUxHQ25VcXlQNUxPSFJRRFFHbGZSN25v?=
 =?utf-8?B?TmJrc1BheWx0TG1iYXc1ZWQ3YnNyeHRNd2h6MlB1WFJkYjFyblRQNG5BZWl2?=
 =?utf-8?B?ZzB4T1hkeUFwZVp3djNIUTBTL3ZLMVlVYkc4VWk2UjdWM3lJZ1M1TGs5SGMr?=
 =?utf-8?B?dVlzUEYxTXVLb2pML3pLWk4wQTQ1cnlFQnFQNUFTc2pCL1BEWFEyRFQzWTRq?=
 =?utf-8?B?VG5FdzBEL3U5QVIyWmpURTk0MkdYRng1U2hwblJNdDZ1NVdocDJ2aXBLSXFI?=
 =?utf-8?B?SjdKWFhMNHFOdXdXMWFIZkEwdjdxNmx5UU1DeEtPNXU2anVEcHBvSGFualdl?=
 =?utf-8?B?Z0pzVVAyRS9tYnNaTnZpK0dPRk1LUktmMnNrMGRaN1d1VDVJRUk4Y1Qxa09R?=
 =?utf-8?B?NEpNSUZraG5XalhLcVBQYVFGR0hCOUo2MkdDUk9JUHJhRjVCZitLMEZnc205?=
 =?utf-8?B?MmhVQmdmRjRPK1NzRmxoVE9nSW9jWEhaNkRlMWI0Lyt1b3ltYzB6QUQyOXlj?=
 =?utf-8?B?K09FTVBXU20yZ3JvdmphUGdaQ3Qxb0lBczJvMFN3bDhiNnFVUzhSSFdCTFI4?=
 =?utf-8?B?V0haNmFnVStZKzBBNWQ3QlZkczJiYkdwVWk0MDZJdVgyQlFmdmNVZ2V0T25S?=
 =?utf-8?B?VENXdWlUVzVsTEpTTXd0Zm1OU3Z6czZWemxYVnBRbU90YjBKRHV3VzlWZS8x?=
 =?utf-8?B?bllZb0IyWS96S1pPVDNxQmc5ZWprWFdBTmJRM0pTUjlQeTJXYmRvcFNQRWF6?=
 =?utf-8?B?c0swR3NKa3lMeENPUTBpRFQ2OEtUMFFBMHhselI0QTk4ZXlRMlNsRWQ5c1di?=
 =?utf-8?B?NFNFVit4aTBDZ2VYMUJqTFZTekNpVXRwbFlER2MvUWdxZnl1eXV2WllzL1Nl?=
 =?utf-8?B?bytlOWpmbkZYQ3BjaEdISjFVSDUzRXpyUmFFQlRRZGEzbkRUMjMxZzlwTnI2?=
 =?utf-8?B?M1d4MWduKzJ0NXBYNUl1MStCRFFkQzR6VnlteUh3cENsTTlTaWxLTlRoU0Ny?=
 =?utf-8?B?WXhDRlhFQjl4R2Rqb0JtdDQ1UEpFekZFUjZmVXNGM0tYUVNXd1VZZTc4QlRx?=
 =?utf-8?B?YXNPa0VCSEYzcHQrbWF6T28xdkQ0NWh0MnJaaHlZcTdaT1k5dGJGaFowN2ZF?=
 =?utf-8?B?ZWpFODJCTDJXZnZpVy9rb3pTbDlCT1JCd0VKWUVqdFhkc2Q0aFZaN0U4Ymoy?=
 =?utf-8?B?clhpckJ6UGxtRHYwNnV1d0xrejNQWTRaQUlHRVZCbldCVmd1Q2RaVUFUZWJa?=
 =?utf-8?B?WlJ5Nk1zcWpHd3A1QWFWaTdUZnNId1lhQ2ZlTkg3S0o0REZDNVlQQzR0M20r?=
 =?utf-8?B?WkgvdWgvMi9mMENEZ09KV2pyVVB6TERxRUhHL3MvMU5OYmp0NTlxVDR6QS82?=
 =?utf-8?B?WitvQy85WUZmMis4NlJaSWhXMVdmN3pRZ1B4cnBseWs3VHEyMUtXaVMrKy9v?=
 =?utf-8?Q?H6Z2NoHaAPQdJUBIhGea5emxBMB9TdFtVMDH0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6504.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009)(1580799018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dG5UZXlsSlh4a2djbjVoNEFESGlXUU1vN3F6OXZKNmxpOE1WdTZtdytLZnp1?=
 =?utf-8?B?TUZab082ZVpHVUtSMHNCS1E0Y29VYnZiR2RYZ3EzQytkRUxkR1RFbXJ0WHpY?=
 =?utf-8?B?UFJyTmExeFJoellENjlLUG9ZMjRwVjVwMXY2dld0TjZyc0tqU09MbEdYVFJF?=
 =?utf-8?B?M1NOSmRxenZVazM3Nll6YU9XNjJTTzgzWkZXc1AyNHlNSmVZYzlRcFd2UE01?=
 =?utf-8?B?VFlQRmZaNFJndjRmZ0lVRUYwZUJNU0FmVHBjNll0UzUrUnZkS0dweDArdzJ6?=
 =?utf-8?B?UWRnallFY0xaWm8vR2h6V0NSOXR4ZXNvbExEeEVZSXludThGN1E3aGRTdUJ1?=
 =?utf-8?B?WjFnazJrUy9MRzRac09lcTQ1Y2JaSUpvWUROaGN4Y256OEE0Q1ZDV054Z05y?=
 =?utf-8?B?YVdDMHMvRzlWdE93UGlXZ3VqTU1HQklaOGJWUWNiamI4S2hMYmtlb1plTE5T?=
 =?utf-8?B?eEdlQ2crOSs0U0pqU0tyY3FQMkxxTG5LaHNqS3dqM3NzZUN5UnZ2Qm5KZXVq?=
 =?utf-8?B?WWxuNzl4eGdhalBRL3FSem1MbGkrOGVzR2RLS3dLZWJVU0xvdlg0c2JFSVAw?=
 =?utf-8?B?OURUUXp2WGVJT3QxR2VPOUpyYjg0STdHSEZNQ3M1aDRTb1IzR2lCMXpOTklU?=
 =?utf-8?B?QVFxYkZJUHNQaGpFWmZjUktMeVBnQ1RJSm53UWZvVlU5Uk1DSjBOWFhHaUk5?=
 =?utf-8?B?aGhKeGpReWJnNUdEbkdVS3FBdGZnRFBjcUpTMjlDZzZBdHova3JNR3ZvOUh0?=
 =?utf-8?B?bTFiS1ZjNFhqSm1wWllJbnBEWkJmMFI2K2hpRWdkZi9jVmtSWEc3MlYxclA4?=
 =?utf-8?B?RVd4aGJxYWhLVGd4bXMxTjdIc3I2dVd3Q2R5YWdpS1E5SGZKYTNIUEQ1akIv?=
 =?utf-8?B?cXpNa0N2S0ZNai95V0FPeXlucEVUL0NsRE5mcHFVdnBEenFKUkk3UXFCYWpr?=
 =?utf-8?B?K3c3UjlHeXBGT3kyUjdpaE5CZ0w4a2xJVUUyUy8zZzdvYkRwa1Q4RWp6OEtW?=
 =?utf-8?B?VG9udW9NMjIrbFE4YUE5eFpuZ0RBbExxNkIrYjE5eDhSM0lIaFVwS0JqUWl2?=
 =?utf-8?B?VXlrT2p5UnhhOWpJRkxuZ285eDRwQmVRWHc0SDBWaDJQaDVRanRucjRBaE05?=
 =?utf-8?B?MXgrUmpnWGF5alhxbDdDZDg0ZEZ5QnBPcmM1NVVQbGpTQk9tRTJ5TWxCNFVS?=
 =?utf-8?B?Q3d2a0kwMVduQmcrbE9GTzNPUnF1RTRmaE1kTDFwNzRKZks1RDN4ZVhOK3oy?=
 =?utf-8?B?cWRmYUdOOC9iT1VXaFpQRkVmVDFVOE1JUmZnTEErRUdrNElGbU0xT2wyZWdD?=
 =?utf-8?B?SUl3UGxTS25pYXhxcHBjNUZBSG9RVm5FaWd2b0NLbTg3TS92d045RUVSejls?=
 =?utf-8?B?LzUyUEdNRk51b1M0VDgwblB2NEhPVTF6SWx0eWdYMTJTNXhYRCs4TThNRVZH?=
 =?utf-8?B?UnJ6b0d0dFAzelk0c1lYYjdHa1d5Z3pGTStjdWZua0tmeDVUdHMwVW52Y2FM?=
 =?utf-8?B?ei80ZUNWU3pKMFE3cVpQeCsvY0pyZGdtakRaZ3htM2czQnNCTW43VVdpaTNH?=
 =?utf-8?B?aGZGd0NYdGtFSzcwNjV6V3kvK3plU0F2bzNOSDEyZWxsY0ZpYjRJNldCdjZW?=
 =?utf-8?B?YXgrSDdiY0thUUQ3OEZVRTV1M25oSHVCUmt1Mi9PQkJwKzFPZ0NrK0VEUW50?=
 =?utf-8?B?U01KK2RJQkhsQ2tLcnpvcEdYdHJPNnVNOHBnRm5tMWlxS0pUOHh1ekRXWmNm?=
 =?utf-8?B?SWVVaEJLTEFvZngxdS9sTUs4R1ViV2xoQ2Y1NndQcTdueFZzY1hJUXA3ckN3?=
 =?utf-8?B?dlQyRTk2b2FiTjBEL3hFQjJwNi9PVFhsOGt4eEV6YytYWldldTdiWHR5MG9x?=
 =?utf-8?B?eU1wNW5wQjMvUXpETGJsV3kxOXQ1VUZiREhzL0h5bTRJQmhGSlVCOXIzbzlV?=
 =?utf-8?B?elIvdFh2amx0V29wOHh3NlhCVFNiWnFoSlkxZDVPUk95V3liTm5rRDRhM1hy?=
 =?utf-8?B?VjJkMnhHR0crdW9xRXFKZlJwUFd3dStWdERrMUtzRGhwUFVQUnJNWk14Wmk5?=
 =?utf-8?B?anNsb2lwZnlXaWE0TXEvbmh0YXpOR25WclhEbHgxMUE5UFcvMmpady9MdUJ0?=
 =?utf-8?B?ZngzRk1RRzZRelh6TE5QQUFiSyt4Ni9NOHhGWW9uMitDQS9WN1FYSGFoaW5t?=
 =?utf-8?B?anc9PQ==?=
Content-ID: <964D57A176DD824AB3E145144138AE82@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gCtGMou2PPWpVGrVs8GejSZRCMb+GFNO7bO33qjIB0CqYpZX8JvStY/9q/wQmeRY2b7kMoWa3t3fxpiBvryCvRrTfghGEyI+5enTyevOPcIifEoo+VLI6sZBE+ywRnwiOOf0TNrdMbct1o82SwPvKHMCKt/8NTsS9TWG3iGB5DhE325gv+B5wf2lrP2VgQOrNM6dbzClUaQY1p8PFGG3otUSlFGh7z6VhiwQFGp/shnybC81aLXa5PXCDZSNo+K2+np0GYx+uR0hKupRdJD8VpzVTECaSul/cVKCXNXLlx9lS1mtT0G7USausA14SgwsW4p+DM8qD0rLwrN6whIBUx/DFhOv88qPV5Km3pHPvb4nyK9slj5FTQKCJ1PgrkxrBTX9JqW9cDBLiIRMsvPhiaC2rcPa/RDe5FFuxpnuAyC9xUEdTohpbYDMg4ZVnQ7Zt3iY6ky9SFOp+Elj4687fzLttobVAy7+vfuuqBahmg3vvRGybjjFz4pw3+4xpVVMgLtSyvb6B82josr1+fAiAo2BzYvIvUMuxcHqpkSeaeo7MWxFSebpACOLKX/kX79ZNW5zlpE7DCbUiuUiFoGf4RstW4cSMY19dXzHWGhMiFjyiIPhCxMefthwx1bMYimw
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6504.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb7b5ef-bbd2-43da-6b39-08dc7bbd71be
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 06:47:56.6735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+ayiVLMYAXjjWNRA53XSPVmCRXzjbHdh65/wGmm7HksFW2TRH7bEykbU35wWToOetKH4ln46xArME9Cg+gLxKzFNPKjDvnfu8cZmN7bcJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8842
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] connect: Add negative tests for connect
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
From: "Yang Xu \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Yang Xu \(Fujitsu\)" <xuyang2018.jy@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Xu,
> 
>> Add negative cases for connect(), when errno is EACCES and EPROTOTYPE
> 
> Similarly to negative test for bind (proposed as bind07 but in the end it was
> added to bind01), wouldn't be better to add this to connect01?
> Unfortunately connect01 requires to be rewritten to the new API first.
> 

Add negative cases when errno is EACCES and EPROTOTYPE.

It would be better to be merged into connect01. However, connect01 is 
written in old API, so I rewrite connect01 in new API first.

Yang Xu(2):
connect01: Convert to new API
connect01: Add negative tests

  testcases/kernel/syscalls/connect/connect01.c | 433 
+++++++++++---------------
  1 file changed, 187 insertions(+), 246 deletions(-)

Best Regards
Yang Xu

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
