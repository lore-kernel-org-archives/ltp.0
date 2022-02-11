Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBB7C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 06:59:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90E3C3C5446
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 07:59:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 676223C5446
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 07:58:52 +0100 (CET)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2DE3C1A0112A
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 07:58:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1644562732; x=1676098732;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FEW25YD7zsfBbfyZaK5GMwXg2UyW1aJsf5gAWz5sYPc=;
 b=bj5+9zL3liuGpwF2451DePm8rcyR4WuJaJXoG207HLi5m9mtRiti4SjJ
 EkQLDSnJTyAMn7OO8yby4A45TLXeR+Fuv1ODgZFzzgtpoNR4KWMNsIYXf
 RCZqtSknGNzir3VEyAS/HVB2s1i2mEzMurXcOUccTw21tS3hKXczQL/wA
 ttWjtkt7flfE6Kh49q4uZu56yaAJRIbmbARR7WUf41fzJTMe5pbA3kVH9
 +TpLHQr4wax/QlZg/s411vzz9BWkhFSdr6u0B5/3rNtddlodtsJh9SbMQ
 SaCiegUiUZibpbyc4jzShyjzsqVcvfZyLFoRb3sGWD9JB5vh8lRdJOhd1 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="49705679"
X-IronPort-AV: E=Sophos;i="5.88,359,1635174000"; d="scan'208";a="49705679"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2022 15:58:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXZMmZvM5sc1MLgtCStzlkbzUgB4WAyKknsin/HzhYXVeSsgSIHrRo4m3ZFxUZgStktgG8yAxqc7KpqUEnrDcS96ScUTxsY1F2hbsqTyfzPzHs4EM79TxyhGeQ6Iaju1+7Vhzud0cyDW/NNhvthUht+uOz3uuL5If13YjeirwmPl6uDPtJQZXd5nJ/YYJzOcfQa4XFmuH8n++J40WzzTIheob32RrLl0px1OVIztkz0LWhKde8c40YwuUr2ximzcO9XP2BgcVVzUAT4qSx5EHyZFORqA8+XimF1kEOalP0hlBHjd4lMLwNnOScqPUPmYJyXAZKObIZfdy1xrpe5zFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEW25YD7zsfBbfyZaK5GMwXg2UyW1aJsf5gAWz5sYPc=;
 b=kkr1k+PJRMRKFK8CC7KPa69r8ObUhaws+Ig8NmvcaR0FR1IJicnPT0OZOejcYAJNFtQ3CQBpkZVyqGHCXw0B+2mAoBARCxnzhiLim1PxkxNwBP11zXEU5VEpGLlZoWt4V/VYRn/jtJ/bz0J8KxotDcCaDU9nrChM6Fqn1y76FV75/DQa2SqOU5QXJpmIWfq0sLo0R4/fNIasEeh41/FbVWbfI8jO2kAzefSsgXXq6QMRHQO5RD7PScQ1VAjMivNyfBnjaOLmcOJByykSkCBJwFd2C7eB5e/6w4Whyvc4R9G2Oc5uKxrSRzexp4La86TdW0Iz16eac01ATXG5Z8gEAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEW25YD7zsfBbfyZaK5GMwXg2UyW1aJsf5gAWz5sYPc=;
 b=Y8d3NtBP58NvIWQhSx9JsSDcvY83wEN5hT8U3PXfRFMKJwYDa3l9vk+NkXltwG4V2EMXaFlEYH2SlVc0T6RmwpSmCydDEdFbkvuTI5Ru8aseLSJKyzJyhx4FzgSj0mj9FDaTn3bgu6mFwEJcw3+oAnSpTaMG8h0sCUy5ldIWtNw=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB3836.jpnprd01.prod.outlook.com (2603:1096:404:d4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 11 Feb
 2022 06:58:47 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 06:58:47 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v2 3/6] tst_test.sh: Add $TST_FORMAT_DEVICE and related
 vars
Thread-Index: AQHYHpsleScu2COTOkikYaEs07y/N6yN7J4A
Date: Fri, 11 Feb 2022 06:58:47 +0000
Message-ID: <62060952.5040909@fujitsu.com>
References: <20220210162739.30159-1-pvorel@suse.cz>
 <20220210162739.30159-4-pvorel@suse.cz>
In-Reply-To: <20220210162739.30159-4-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fc48f6f-3c4c-4c63-ba99-08d9ed2bf34f
x-ms-traffictypediagnostic: TY2PR01MB3836:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3836BB854AB47E4DA67788ACFD309@TY2PR01MB3836.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h1rZhqf1WnmiG+d7v+Ran4X2oAZoCNOxlbGt4qbN2BRhA0TMgaLQo5BL3T1GN4PqUqkc1r4Sj0HQ/WbwSRUMiSqebhFA2E6nvXZThfZkxpos1esGUtYLX2uY2vMTwMWAj9ZLNVonOYviGNqdVICm6fWLSn1B9mJXr7kMCKK9n2SzqAdZdztL4Ly0lmKJ1d5XfpYh9jPF9q9QkKFaTphCAKfXBSzLfyNaqQve3Udr3o+TyQ6hU+UNT5EtgoyobFj1WGiGg3PzvkzD8rIU8yzZCPicYvOf4aJq1fzvsoJpLBiGplaW1VzQsAxDhVjb3EC0ioc6QDc1rJx+Meqjv4pZ2b6eugdrngyVIjVuQ1+FuK7mpD0WLru6fxtYT+5Cqi3kh/8PrhhFIJ8CtsX1kq4HvnOkkL+DPP2Y5nNB267kiQbMBmX1Cpu1cLQnqaQ6FqowdQhTSyKsBcUDE/JaHzBNn0SRj3zNGOLRfg37gpGGmypKcKcvhN4Wzx/JLJZyvhK5fkwa3u2yoPmCyOuRn+QWQLnpvnk0pvSPWIPf97nahtwEkc8BBuWdDeFpz/1calRtpsRIx67KhJCkyWy0Zqn9ab8cu9NhLRh5SycJQgtVOxAeIwZq+EWeFh6sArZhzbnO+1z/6ixnLQFbhteZntcju9JXXbbPuwQ9TVoxSvFZAUeYKC0+OQtp3rqFuA0ekH4LnKX3EJxzwwQBtoe67Vsv36gRNzLSFF64ze2z2D8kfz8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(6512007)(66476007)(4326008)(66446008)(83380400001)(64756008)(8676002)(8936002)(36756003)(85182001)(508600001)(316002)(6506007)(66556008)(66946007)(54906003)(71200400001)(87266011)(91956017)(2906002)(122000001)(38070700005)(76116006)(26005)(6486002)(82960400001)(2616005)(4744005)(38100700002)(186003)(86362001)(6916009)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VVBXcWJIME1waXV4VElRbS80R05ScVFwVktGaWVObnhBa1NLNE5Welp5T1lV?=
 =?gb2312?B?NlNWM3F0eW1peTRPbFIwK3B5SEJHTW5tWmUwYWluM2hKZUtYaEN3N2l1RTRn?=
 =?gb2312?B?b3dMMG4wVDREOUpxZTNicDBGVEJhS0FOUld6QmFEb2VjV3lmdlhaUllvNmVE?=
 =?gb2312?B?N2QwcytUek9KVUhhNkk2UGtwdkZES0txNHlGVUx4SzJSZUUrZTRDOFI1QytX?=
 =?gb2312?B?alZMNmhzU1BHRVJkcWYrVWZLNCtHVW1JSDZSdHlIYkYwUEN5cUdVeU5NTWZQ?=
 =?gb2312?B?Tm1YZDN0akI5dUhWdVdHeG9XVnhhSlA2SzM2cmgwS1pHSnE0WStvanhMN2Uz?=
 =?gb2312?B?dnBRWTQ1Zm1vamtXRmZSekUxM092d1pQK3doV1FaWmw3NTJtVzA2bzVWQjB5?=
 =?gb2312?B?bjh3R1BGb2xKbkw3QlZ2eENNTkNNR2hveld4Yk9ISjdqdjlRWk5hL1RUbCtV?=
 =?gb2312?B?NUFGRTRUMndzTTkwYlJSZjNFMjFpQVJkbDlQWUx4Mnd5alZQTFZBUk9vdHpE?=
 =?gb2312?B?UkFHWmR3KytZK1RpUzd6SlorZCsxNzVUK1ZaaG5ybVlHSjhaclA4S2toT1Bp?=
 =?gb2312?B?RC9EMGIyRDBOZGpDbUZkWUVrWlZZNGVMNjlveVI3Yk1Ld0hCNmhVeG80aDNa?=
 =?gb2312?B?RWZsSWRHNlVzbmpFRXduc2FnakhKZnJ0dk1NN3M0QUZSQnZwUkR0UHA2b25C?=
 =?gb2312?B?THp4K0FnMzlNVzdjRFRmLzdmYW5Lc2NxMktzTVpYcWx1dWhtdmRLMmVHN2Yw?=
 =?gb2312?B?TUR3RStnczMyMHljV2MrRTNieGVEMVppMDVVZ2FFK0oyaTdhbjZCZG83Vkx0?=
 =?gb2312?B?eTVhbWIyQ05pQXMwN0pXRTFKNE5Uc0g0eDJhK0YvQS9VRkZubDlrUldjUnVM?=
 =?gb2312?B?QTBKMFdWMk9EV0MyclYyZ01tMFkzMW8xU2FtVTdlSzExNGpDSC9uY2RrdWhW?=
 =?gb2312?B?dXd5RmNuSnJtcnBTRVpjTTVoNWowMzloSkErSHFyeWhHWkFKTllUanN4aGRw?=
 =?gb2312?B?dnVuVUl4djRKNTlQLzRsZVBjQ085MU9YaUJ1Vm1xczZjbFE0a2RHQU9XbFBp?=
 =?gb2312?B?T3VHNjVYTlF3VkoraGlYTktkMDA4SGova2tmYTFnMFVXSElUek9kTU95a2xI?=
 =?gb2312?B?UGliM3BiVXFKSURodDFmZE9qQmpYRWZMQ3YxWDlNdG9razhSVUgvUEdQazhS?=
 =?gb2312?B?cVUwaGhWY1poNkxSbkxqRG9jZW0veDltdmdMU20xYXNHVGtIamczUHBySGZ5?=
 =?gb2312?B?VEZPM3pqZHI1c1ZoaVhHZzRDbjRZWGJTNkNtMWg4YTQxRy9Lck9uZkxUWHlY?=
 =?gb2312?B?bXRzbUFhbzloNFg1VFpLVUtuNzlsejVEd0JCQWlSa3EyQmxDa05LNm1SRVJX?=
 =?gb2312?B?TlAvWVhQVWZMS1Bya1lLQk1GbTNDbGh1QSsyRVdmZk5FM0xkV0g3OU1PdFdO?=
 =?gb2312?B?aHBNWWw2T2dBY3VpME1Ja0o3cFBnWC8wSnBlRnBaQWxvbVN5Rm50SDZPZVZS?=
 =?gb2312?B?c1hVMDdBZXI0UXpzTjhreFl6bEdDbCtpRE9pRXU1YnYrenlXTjBxa2xzZjNq?=
 =?gb2312?B?MndUZEMxQzVkRURJSHhtdllrR2hnZzdvOGI3TWY1TlcvbFFTai9XTkk4eWhT?=
 =?gb2312?B?RGd2b1NDOVJOdENGOGJBNWxrdEl1RVY4cEpsMUdGRzJHSXEzUFk3ZUFFcGcw?=
 =?gb2312?B?bC9DbkVVVWlLY3BVU1lVdVlMaDJJNis3YzFTR3l2VnY3eUlyUWV0TkY5TWsz?=
 =?gb2312?B?M28wZm9nMWdsVTZDZlMrT3I0R1h5eW5uR0lIYmpIQ1U1MjFPci90Um00emNl?=
 =?gb2312?B?Y2d3T0x5ZW5KcUFGZ3NxWkZzelpSVDhIazVZTnR2d0V6YWRwNGpxNW1DK2Q0?=
 =?gb2312?B?eDA0L21QeXorcCt3OUlMQ0R3QnM2eFBLYTBzZWpJcGpzMXBvdnNrL3F2dEpj?=
 =?gb2312?B?Z1pCM3BTK0lPVHNuQWE1RTlYQm1nTXhKOThDTGp5Nmp2eUphWXgwRDhpV01j?=
 =?gb2312?B?aitmd0JUbXRPNmdVMFlDTERMWE1nTlVoQnU1M0daOG9xa0Y1elYxY05JcGVG?=
 =?gb2312?B?dzNmNUphMlMvNCtTbkFTb1pza2lRQU1ZUkVWVnUxdENTTU42MmlKT3lGMWhv?=
 =?gb2312?B?Y2dGNmdURk92MmtlSEloWGJDcGtlQzlDNVJKWHFCRFU1WmN3VEJHZG4wZnhR?=
 =?gb2312?B?LzBtK0prUVhNSW5rUmN0STdtQXdqRlhpeUhCdzJBRGdtdHhoRUJmMGZGRGNr?=
 =?gb2312?Q?GQdiB4CtA0kJxHmEPndxTmpTTs948uOfzmGX2ht8Dg=3D?=
Content-ID: <ED69ECF5887ADA4294AA24B89326D3DE@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc48f6f-3c4c-4c63-ba99-08d9ed2bf34f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 06:58:47.0163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmdH9l1IQAxTWftH8jxttlvwEHU09g6dXFzdNqdKDjh/2mKh4Yoh7mlQCXdzrFC+bW8L7Ho7jEDIDoUgJ8iVJgvTKbMKaB6FiZdPOE6zMUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3836
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/6] tst_test.sh: Add $TST_FORMAT_DEVICE and
 related vars
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

Hi Petr
> +
> +[source,sh]
> +-------------------------------------------------------------------------------
> +TST_FORMAT_DEVICE=1
> +TST_DEV_FS_OPTS="-b 1024 -O quota"
> +TST_DEV_EXTRA_OPTS="5m"
> +TST_TESTFUNC=test
> +
> +test1()
A small nit, I prefer to use test name directly if we don't have several
sub test cases.

Best Regards
Yang Xu
> +{
> +	tst_res TPASS "device formatted"
> +}

> +-------------------------------------------------------------------------------

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
