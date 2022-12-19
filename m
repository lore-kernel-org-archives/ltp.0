Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A56FC4332F
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 03:01:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A0693CBB64
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 04:01:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8708F3C8C27
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 04:01:31 +0100 (CET)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2CC6F648442
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 04:01:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1671418891; x=1702954891;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RC7TPIdRUCAtNjKsdb+ZgCwmFoALf4vw7aOK4a//0tM=;
 b=u2KdfqBbfWzhAC0OnAWw0Fu5It9zpaMFK3EB5kw9hMpknJZw0C1kH5YN
 c/f6IRdTTilTLp52XjQRlV58ufQBWt+RsnGA9uekn3shMrqn3ndZ6GoDF
 U+rzaTxe8IyTtGGyyfwHUsG8LBAiUwPLbWcCOmEwlihchtQ45oEe/jhMf
 g8wkkLugTKYZDNdL2A3/Rh3rmLwwoqq2fLccEK/1Vy8VygUtMet5qCR3y
 H44qdXvXS2f+fKBPB2Z5OHicEovWSiHnuZ1PTngcLXG6Warcj4PtGZjQf
 B475LRxNSHgyES3FWGJ4ESiJ2O+iHeqhFRj/kWsES/bsBYWIOmmw9ztyE A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="80992285"
X-IronPort-AV: E=Sophos;i="5.96,254,1665414000"; d="scan'208";a="80992285"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2022 12:01:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z22Ibw+F0vnrNkhMK9Ie4zzIRyoWLA00xMv2Uf7ZLYle2cquWwlV6V7UvwBHMRMTeB4Rq7SPtM+ccgysYdSS1G68WI1cPRHNDkUqHngSXSWwmlL2XquWyaWpmimhyTwoBGYSznZm78hb+cFlBzi5k/Wx6azCfoaVoGU1hcVb+lFvuvaYvd9VA3Ul7Ee57Ls/4pU9TEUdWuaS0NztpYP75RH4vCoyWl/l/UxTxHUbVGd2QjXaTX0DvguM1Pgqqr0LEjdvBAdW8A8BrPYZhHikHT/hqHtbp/wV1rMMvLeJU3g465jwb8PfNaFn+G6jLtpW9pI6uVmgCyjKiSrREqsKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC7TPIdRUCAtNjKsdb+ZgCwmFoALf4vw7aOK4a//0tM=;
 b=BujXbYQAfha+quqW1DxkkZI6wbljxaqeYwbFhZFlPQ+PpJR9XG/5imhSrLKE6Dnzr5CMo7RaCTBBv+gNLrQs0yiR4nMPg2Qy+IkbbtEefD6sktvpHmNHZT4RRMbHr1X6im6s2GNrxDFwp1CUYbQAVco92CeguugmGuq4kR49BEammlOVH64tB9K/1IytnKND3jWAR2PSxZeqN1ujvmr4lu8ugtGwPwfuKnrX+crV27RiioRJdGTWwSwEEJO+535rsjCRtVxHPljQvwZVJ77NA+gm2NrEV3CjGAj9mb3eSkpPZPa6y1hwdvzA48DyZ2ESuID7s3oomhClHEvOv3jxmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYWPR01MB9743.jpnprd01.prod.outlook.com (2603:1096:400:235::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 03:01:24 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%8]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 03:01:24 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v3 7/7] doc/c-test-api.txt
Thread-Index: AQHZEQMex7GrrWcXVk+YmvbGz1cBB65wS94AgARPoIA=
Date: Mon, 19 Dec 2022 03:01:24 +0000
Message-ID: <0ec8a1bd-1fa3-0114-3b90-2527ad2a0492@fujitsu.com>
References: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1671166923-2173-7-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y5xEoHhXDn5EN0gA@pevik>
In-Reply-To: <Y5xEoHhXDn5EN0gA@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYWPR01MB9743:EE_
x-ms-office365-filtering-correlation-id: 056c583f-bb5f-4307-bb86-08dae16d509b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L7xaUzwZFM+d3P9x5YylQfaPhegixJWK6it5DrmhMiFiMxbzmSF6fVaOpZ3SwOoqRHH8xaFdod86An/MftjE+2TYg6Mq8SAxQYocSHeOyb8tHwcXrFCq2zfN0irdpaxmb9rqbNLbAXt4/Sv+Y5lLVH24XArezylSTxCWi8v9162OEgIvikYhNUAftDjfi2DJcjQspf2bwSG5IS5wEB3GSchsUimizSOrn0FQ5T0wJC9mzqC0YxH/xxG6v3kdE9d215yD30HZkEZ5rhwv0ktqotQpfojN9pcN3xHxQQwmt4S5iPmywBdYKMk4G3+7SP3RXSbyQRPYyuUCUMEPuc1KYV3/s3sucVLOnT6J+v7bm++p9KMQVPZU2oGmZr+6foSittACiD1t06OsTYF6iZq/NdtShvrnrEbzaY2WHn/jLEAGgN+rIZGdjEv6zPa0JeYus1lPLsagg4JB68RqV2kcHitd5xJFaD7i8RktWBNgozezvzxY8c+H83ZNAmASpjTP+18UME3gPHCd6cZmPfUk0jiZMKH2ffw39AF3uKersmEOYxHRA/7BuA5PDOByx1z2nJ2SC1OLYmwAf/0ai8M8quh8083WppPNjxIiD3lTHKLz3k12210fTQ+o7V32IP2+z2XK/9A6LwnaupkU7/w845krru4cFt1UmGXfJaxgxoNUb9P6nsNILpjd6o5B4cx6QaTMhhDfj4NAoJu2zsRnM6YAYSS7qaUXpo9HP/dxccVz/UrcsTc1/J3I8vmCKfyfUjmiLx/+zErP2WpK09vMdIu+hlb8iH/OkZejuVJ/QkE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(1590799012)(8936002)(41300700001)(186003)(6512007)(6916009)(316002)(2616005)(91956017)(76116006)(85182001)(36756003)(66946007)(8676002)(4326008)(64756008)(66446008)(86362001)(31696002)(38070700005)(38100700002)(82960400001)(122000001)(83380400001)(66476007)(5660300002)(66556008)(2906002)(6486002)(478600001)(71200400001)(6506007)(31686004)(1580799009)(26005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2U5MENGMjJYWWM2WVBDZ0NOZ1VLZWZUWGo1R25Gc0p5UHhxWlJxcWFBOXNk?=
 =?utf-8?B?ZDA5d1BkMWE1NW9XeEQ0Lytuck1HdmRqdWd0cnhsU0UrdHo2NUxaKytlK2JC?=
 =?utf-8?B?ME5ydUJOdm5QWlpRRWViaHRUZUE2K0dNQXhpYnZDSHMzcy9DRkdBbUo5QWZL?=
 =?utf-8?B?YjMxeCt2Z2trSVdKL2NmVVZnbmFlZGpCeUI2RzRETjRVb2lKRU5Sbjd2WVBp?=
 =?utf-8?B?MFd5QTJOR2hTZXJKcjEyTDRyK2psRmx0RFVrVVExQXZhdW5sN2VTM3o1ekhX?=
 =?utf-8?B?MWpFWmF5V0dWTTU4djNFWVV6MHhDQnY2UEF5Q1M0MkN0QVYrWjdsR0dPL0Zm?=
 =?utf-8?B?eUpGbW1zNm5jNzJEUjZva1dKOFlYcHFiSm5RRk0wbkxBQTRIWEtuRDBsS0xP?=
 =?utf-8?B?MWtwOU1aUVpMTXRCQjYrL01yNTY3bFhzRm9EbDQ0NnlnRFZ5Z01Md0R5dDhR?=
 =?utf-8?B?OVM5dDZadWRHRG8xYkpHS0FkeHRQaU02cHMzVFpDbHRjTGFmL1NoVDRyT1pQ?=
 =?utf-8?B?MHRWWHFVR3kzL0kvNm1odmx5aE5jeHVYbWhHODFVYzJnMEtrdUp5QjYvYWdm?=
 =?utf-8?B?eG85K00vVlJ6MkpaWjMyYW4rQWlmYjdZL29Jem5hUGZNcnRzS0V2YjdnYzhM?=
 =?utf-8?B?VW1ncXJ2MjVtZ1FOL290S042c2hvdXFqMytJMWlEd3M2M2FqVG5ZNWx1dG91?=
 =?utf-8?B?WW5PTXJ4RFI1aVc0SDIxYnhZMUZRclRNaGhQZjNCYmNtUi95TnJLUVNqOW52?=
 =?utf-8?B?SUMyZ3VEeUdJS3ZrVWc0cG13Z3FTMEdjblZZcnhLdUM2M3cvaTJaVDdIMkVv?=
 =?utf-8?B?bDRLV3MxVStONGlkeWZ2SkdKL0cwSElCTGZPTE5LczUzekFHVzhqQTFpaVZn?=
 =?utf-8?B?eUhTY3dkcThVNXFMM1M2b2k4Tk8vYWxwK0VWeGFvcjZzQzZFMXJTc0J6T1ZY?=
 =?utf-8?B?bkdTT1YxV3hMWkkvcGNodTExWHpkZzNDcW0zSzluRVVnY29GeWdaWTNiaFZU?=
 =?utf-8?B?OENHb0N1Uk5mVE52QU5jMjkwalcvY09MS2FKeUxTTHhTNjAyMVptNWY5cjN6?=
 =?utf-8?B?Y0xBMHVacm0zTTk4RFVEWlBIOFZ0R0JuVDhlOXVFaEQvVURXYURUU2xBM3hT?=
 =?utf-8?B?NTBscmR3TlFWNk5PblhzdXpFdTR4UGd4eVBRbkM5a3hTT0ZzZVRIdDdoc3Nm?=
 =?utf-8?B?UjdpQUVjaXRGcUVOMEZXNnVSSWg0bzNYaTVQbTNjVmhHbEUralh6enkrVDNS?=
 =?utf-8?B?R0d5MHVFUGN3SVhFbldSdDB0TlRaQ284Z1orbHA4QVdGMWlxdzN2dEJCRjA1?=
 =?utf-8?B?dlVGK202Q3BsanJ3elpZcUNBazl1R3pDWVB6THRRakpudWt1NWRVbnJSZktm?=
 =?utf-8?B?emxBbG9RWEQ4QTFvRm9pV0pzZ3BpNklUMHNSUGp4SzBsTFhrL0VPNy83VUlR?=
 =?utf-8?B?RFNzWXFJQU5xOU9XQWo4OEk0Uzh1NUM3ZmZGVTVHeTNGVW1IUW9zQUdvcDhS?=
 =?utf-8?B?Q0pGSHlGdW5UUS9VbWVrUTg5dDI3Y1hHOFhEQUMwMFdVNWs0QlFBK0tJR2Vs?=
 =?utf-8?B?azFHZGE1MERUVXBjeDVVR2hnZDNydFJ4b01SVWpKdGFtejlEVnhzRmJDeit4?=
 =?utf-8?B?ejRsMGNQK1pUWlRuN0lrWDRjZ1BDdmJtd2tQSGZ5N3RiWFoyVm14WG9PVUhZ?=
 =?utf-8?B?NzlJSm9VRnZ2c0l4VW5EM3IrK1UwcjNCU205V2pxWmVGRzVzUUNlZThCS05Q?=
 =?utf-8?B?UlVaNmNwZmM0VWh4QTZ4azJMekwwUU1uUnJXbE90TTNCQ29KaEFkY0RjamVr?=
 =?utf-8?B?QVJBYy94dTVWUTY5a2haYzFtS002R0k5dXpqL05rWWJvQUxCNW44WWI4aXNV?=
 =?utf-8?B?bGZsTGYraXR4UDBZT0VwU3BUQ1dJaFUzOHZyVS93aFUyWnU5ZzJGaWRUWE0z?=
 =?utf-8?B?cmZaUEhBcDhhVHJrTENYZ0hBUHJxWWROdFRvQkd0SmlBZ3RSZkVXUnRvbms0?=
 =?utf-8?B?eG5nZHgvdFRwZ3hiWFBVL2tFKzBTR1JNZUdxc2UydzFDM0taSmFDdnNUL01U?=
 =?utf-8?B?QTc1akU2aVVwYWVaU3hvNGQxSVpSM25ZSTluV3dyNWpLSk0xcjVtTUs1Nkgy?=
 =?utf-8?B?MUllY3FtR3MxRndKTDNHMHhSbzcxMkJHNFFWMElTRHBIMm5XUTlaY2xQekd4?=
 =?utf-8?B?bWc9PQ==?=
Content-ID: <F859409A4EC7A54897379B224EB24376@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056c583f-bb5f-4307-bb86-08dae16d509b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 03:01:24.5946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /QEAd2ntLa/arCtgqosJc+v7YmaEDPfgknqQ44+BNibEbTsdIbX1I03ntirvwKtYxfv1S4SApcWGzeoQBd8reIGEi5xIWWQaVsicqf4bKYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9743
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 7/7] doc/c-test-api.txt
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

> Hi Xu,
> 
>> Update min_kver usage. Also inotify04 has removed tst_kvercmp2,
>> so remove it.
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   doc/c-test-api.txt | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
>> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
>> index e6d121dce..f4da9ff41 100644
>> --- a/doc/c-test-api.txt
>> +++ b/doc/c-test-api.txt
>> @@ -559,7 +559,8 @@ static struct tst_test test = {
>>   Testcases for newly added kernel functionality require kernel newer than a
>>   certain version to run. All you need to skip a test on older kernels is to
>>   set the '.min_kver' string in the 'struct tst_test' to a minimal required
>> -kernel version, e.g. '.min_kver = "2.6.30"'.
>> +kernel version, e.g. '.min_kver = "3.10.0"'. For ltp, the oldest supported
>> +kernel version is 3.0, so we don't add this check for old kernel ie 2.6.32.
> Again, not sure if this should be added.
> 
>>   For more complicated operations such as skipping a test for a certain range
>>   of kernel versions, following functions could be used:
>> @@ -585,8 +586,7 @@ positive means that it's newer.
> 
>>   The second function 'tst_kvercmp2()' allows for specifying per-vendor table of
>>   kernel versions as vendors typically backport fixes to their kernels and the
>> -test may be relevant even if the kernel version does not suggests so. See
>> -'testcases/kernel/syscalls/inotify/inotify04.c' for example usage.
>> +test may be relevant even if the kernel version does not suggests so.
> +1 for this.
> 

I merged this patchset except this patch. Also I will update 
tst_kvercmp2 usage but in shell script. I will send a patchset for add 
RHEL9 fallback for this change[1]

> Also, I'd wait with this patchset to what brings the discussion of minimal
> level.

I guess we can mention that old test kernel version raise to 3.10 in 
next release if nobody has objection or no reponse during this period.

[1]https://github.com/linux-test-project/ltp/commit/2aaff45db7960ce8e46e39fad8ae95a3f5db6cba

Best Regards
Yang Xu
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
