Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBF2ECAAA1
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 07:31:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59D623CA8B5
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 09:31:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A3E53CA48E
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 09:31:28 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F1AA51000DF6
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 09:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1662103886; x=1693639886;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=472TmOEvEqNN4wSBaygbLMZSgqgMHlPbtYEDbEzqADs=;
 b=dwO+1a5oxTT796MVwwxxkK0Hxcay848AaSzjeAznwpZnB5aSDV643Jlk
 4F/WfnR4f+S1MWVjrzCrQ2UWrxziVPAEgkmh3lzeN1qARheRLSCQSFO7X
 wDXJ3UUAstW7SWs0HITc0nx655AUp6a5s4HKgC6IzICThqTd1FypdVYtf
 g7GSGUe6Vw1uvtNDUxHsHfLcNlzGeLGsFvYwPWkW7PjKpBY4YmgIxiSgo
 VP/stBdKLHsxw+fgjRfJAfuzeZ4fTQUHDswy4Z+5au8wyobFA001zSCO4
 RhlOufydMmPETkZn1/SvJn/8NGjeDQ8P0lr0LZ7E3WQ/07kI4xOR6b7LJ w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="64337721"
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600"; d="scan'208";a="64337721"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2022 16:31:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHjQ7/I/fuoXbdsLpLwkXde0MhfRkEOI3GVj87zRY7et+aLgNZnpWw0p+FC3wju/W8/6sTh0/YQlWOyxvBBCOL5NoWD5PNb0jnDPwA5vQd+thdYePISYBqGGZxymaPrzD3iLBViJ5Fb/MZ3ixQs9B1E2ovFweX8uikwcrETYez3qQ3qVIVyGjBOvpqSxrlsalGB56qsBBp2GfTQh9N2zLuqL5dLs5QyYNikDipDHLpHa0cTpP/0Tm0oKndVW792GmFNRAgikJ12aGMoUn0iWZEa4YFTYL2eGOiwGSmRgV2Ty/QhP6mYKhDNl0OuWZZc5Ac3t5L5PwwvKci+Nmkjqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=472TmOEvEqNN4wSBaygbLMZSgqgMHlPbtYEDbEzqADs=;
 b=PpuzpgttFke65u9X8uwEJnSHKV6bUe+M6ladkW8KHhCVlEzJ+pJrmKYNDasPB0mkt62g7nGzEOvWnY2D7od7s/V9skSle1qRwXSKJqskSKDCj74IfhLw0t/Ndh9qnsngeZmSdHX2tRzHXC/ecHkptTfco86EHKB7tjDlpevsX5IHzuDNxZKwYhcPvQEBST7SlwMGoTyPP0aRWRnrtb0uCkloZDv/PIl/rdlR5ljFQTuRc6OGvyjrq7SK7F7zk1tlCEAsgi4faxZer26O043YypgMXKFSoU+e20C2m5kUvLd0Mpz8FsQT9slUJZeFi5qF75xCkz0k30d7MmdRZ/QvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY3PR01MB9858.jpnprd01.prod.outlook.com (2603:1096:400:229::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 07:31:20 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8%5]) with mapi id 15.20.5588.012; Fri, 2 Sep 2022
 07:31:20 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] README: Add missing configure in openposix step
Thread-Index: AQHYvbbgEnYwAK0pI02c1YlGRwJGsa3KagSAgAFnlAA=
Date: Fri, 2 Sep 2022 07:31:20 +0000
Message-ID: <98263d58-cf08-0c70-c642-2a95a727659f@fujitsu.com>
References: <1662008249-2227-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YxCR7+dkGxPvCQDn@pevik>
In-Reply-To: <YxCR7+dkGxPvCQDn@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 675afd0f-10ea-4b66-d771-08da8cb52143
x-ms-traffictypediagnostic: TY3PR01MB9858:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nzIGGk5jQZmUm9LHc+iU8S73PL+t+hquoAILqAEhYUl/XFc1XpcfOfwl9W2SpnaS1VpcUoEHx5C2BByycHJN1tEMvMsM5fHcUFEu5IDCdDW0JXUcwqcg4qtlahIYX1RqPznUTTVsrn5UVjFz1FFiuVilGtj+d+NmEMKtCRgAcbXhB6ipY5RD76O+hS1vxt1eyfkMHtjkQNQ1YA+E+pBf6qJPyMCom5H1nNkGCfpimNt9+RCTVbdiQ1HdlDHKKo2iwa4k7FXa0LlSiXWiQIenKwXnc7E8R0K/jfBKok2galuhHfNMAqhw+/QR+36C0Vob05ter3SDJmKI0hdQQL0Oej2tKedwxrImDzdsuG/TiEo+09onTlejEhjAHp5uaf4UsJAZG9KfsrB5ATyKkAIM/giWn+Lni9f+WO+nMm8u+M4WB2cRh++Pm3a7pHWu5PzwuPNienVZVQPqoZ1gGaXD29jQfFKeVB6AwUfKWWL/1Rdb0kmRGmOrjBsZDosa3Im0K1Bm16JrNikIZLSjDacg9A/X2t7oInPxlVKDoltseqysM7madrPcuvbEejX25Zvy4nX9Y80sZbAlvDS8ModgE15NGtwcdFZlDxzeiM5OKzwvbTJ7xWOWjtS2u2BJKBN4w6c0WIooobro90CDfdj7Ew0VOZ1uK1hBlbXsuHtQM6EQT9VijiIL+Srsw+uOpGRp3YY+F7PDviZDadXzDcUFKS8g2M2BfpWGQrtHeOwWCnUFiKrajFFkhEqdO4XgI3jtT95C8ZmjCIHA/qix5nC3l5vz+Vqbx7MDeqM8Hb+ro7S6EASvmtteypUeo3AnhYPTxoByuUtZ21vLC4D7P/Hj2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(1590799006)(36756003)(85182001)(83380400001)(6916009)(54906003)(38100700002)(316002)(122000001)(1580799003)(5660300002)(2616005)(186003)(6486002)(86362001)(38070700005)(41300700001)(66946007)(76116006)(6506007)(31686004)(8936002)(31696002)(26005)(6512007)(91956017)(4326008)(8676002)(2906002)(82960400001)(478600001)(71200400001)(64756008)(66446008)(66476007)(66556008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTFRd3JyK0FxRTFqd2l4d3h3bHpLNTJZWHAyY0hvZEI0bXczU28vZkpPSjlL?=
 =?utf-8?B?VDhaeWJxRVN4M1RqN3hpZ251dTZ1QkQzY0V1QTgvTDdFc2dXbE1QNHVTRkxr?=
 =?utf-8?B?RG15TXNXYXhqZ3Znb2pqUkpyT1o4OFlzZjFjczJoSUJYb2l1QzJOOWxtY3Uv?=
 =?utf-8?B?UU5FeEhZa2JHY3pkak9pR0VlSXQxMHI0MWQzRUZyL1lzdGZkM2xsMUp6eWJD?=
 =?utf-8?B?MFRlZWtRcHh5U0VTamxrcGd4ajRlSDY2TlpUZDBZcnJiT0ZLUGpaMFo0TE1V?=
 =?utf-8?B?Y3NhUDdEZm9MbUJoTEw3b3M1eFBjL20zTG1aaEJFK0ZINmZrczQ0Z3RyRkpR?=
 =?utf-8?B?RFFOczR0d2UwRkxoZEZia1NEWHp4TU9OZE03ajE5UUxURGZGMDN5bndVNzRJ?=
 =?utf-8?B?S3h2eHpBa29LaWU1dWRjSnBpYmw4MzZrY29nNkRackUrVVRIcXczSzlkRVQz?=
 =?utf-8?B?WmF0MHFIb1MxaFFnQldRZXBacUxEMVpBSmhLVDRwbGwvazZkZXZ3UHFEOUJO?=
 =?utf-8?B?UHdJdHZpazNPV0VLem03cVRZZjNJRkNoY3BzTU9KOVBmVHlZU3ZnUUJZSk9m?=
 =?utf-8?B?OFI0NHBLMjBUUEswYVloWjZTQlRLaG9kV2NEc3NCUXJGZGVuZVdKNDhJdFNI?=
 =?utf-8?B?TzNIaXJrMXpWa0gweWVGemdTV0pVd1dwWlh0dE9CL3hOUzFSUmtDMGttSk9X?=
 =?utf-8?B?RE4rK09zYkVXcFo3K29LaVJLQUQyVVlhYWxaMU9BcUhFTmxKczRyVk9iUXRK?=
 =?utf-8?B?YnBzckh3T1hQdEQ5UjZLTkEveVZnZ2E2WUJyQkJCSVZ2ZzJPSnF5S0tZNHZG?=
 =?utf-8?B?bjgwc09TdWUwYWplMWZqWUtCOW15WHBxNzFqVnR2SnQrTTVpQitjZFhsS1Ux?=
 =?utf-8?B?YklqR2FiSGxGYVcrZURVVmFiQUVmZWNTUWJ2K2FtZWV5d3dldEM5Y21ZRktT?=
 =?utf-8?B?cm1oMVZmRGg2ODhzSExtRnFyelM2UlFxRnBqUjhjb0tMaERsVHVaZzhRbkx5?=
 =?utf-8?B?NitSb3ZCbmk5V3VRMS9WZk1veWJ0NlVCaWozRDhiRGdyQm5TeDlYbGlsWmpM?=
 =?utf-8?B?REwvWWJURGVBQk95L1pubWdCNDk4V20zVEE4UU15YnQxTDNSWGk4UEFzanE0?=
 =?utf-8?B?MTRwZmhsVzdWSm14eWx3UG1KOTR5NWY5QytsRzZZdmVuWG9sRTY4ZUJLNWhN?=
 =?utf-8?B?dkFPR2FKayt6blorVmxJUkh0ZUE4UDZ4MDkyTHVnL3F2Z0lWRE82T0xTSWJq?=
 =?utf-8?B?SGhOcnU3TzVBOGtCaWhDOHAxa3RBQ0Z2Q1JIQzEwdU9PSzlaZFV4YVIxTndF?=
 =?utf-8?B?ZFBISTlLZ0pONThpSlBCU050TTV4eGVDUFpaS0JENGxadkNpMlZjdXlwUkhi?=
 =?utf-8?B?WTM4N04wRzMwR3U1VFdTTEZyR3Buc0pycVVpcjZwc3BXMkJUdmFRSnhhWG9G?=
 =?utf-8?B?VVFQQk1XSVZzVEhZOUlvS1drNExDL2JOalduQlh3Ujdhd1B5QXNxM090M2g4?=
 =?utf-8?B?ZmtQRUQxZG1Ta0lEbG9GMVM3NnpFY0xxUGg0Q0J2cmViaHZNeGM5OTVsNVBy?=
 =?utf-8?B?OFZiTzdiZCtXVTZsUzdGSGNDaytHZWUvbHFGcGRKREtkRXpDc0VZS213N0xz?=
 =?utf-8?B?Rk1pRllBOFRUUG5SUjRLVVFRN2hXL1d0a0Ewc0pxRXlvV2R6NStLMU1aNmhZ?=
 =?utf-8?B?WW94QkdSbkhqSG1KbXVvU0xxRG93UVVTVkRpbVZYN2cyYnRGanZKMW5xaGxT?=
 =?utf-8?B?Ty9OTElkU1BsZHBBb2xFQUhMVnZLZEdWWVI1d1dFTGVGRTdYUTEyTHpSNTFZ?=
 =?utf-8?B?ek5vWHgzMHl0cjA1dFdBVFhBczJnMnhXWnZITERIaU80QjN1WEJPOEgyUFlZ?=
 =?utf-8?B?TUgxdHVENytkWWoyaldGamFqYzdMb0VKcXBxVzc5L3cyNVZOTmthalgxaTJ4?=
 =?utf-8?B?aVdWQWRtT2xMSEhyRVBDdzBwMWZKSWZFa2U2TGtXYlRTLytpS2xNSXYyZEtw?=
 =?utf-8?B?eWQrNzRaSEx4YjdTY2xEWVpuQzVkNVowQmRWaEhtYTBUbXhncGpFUGhwc3hH?=
 =?utf-8?B?RkRPZnQyZkxWbjhqNTFUUk56RkYrSGYyWWRsanlKMEs3RmRhS2djQWRNdDJL?=
 =?utf-8?B?aXUyY2RMUDNkZVlnZWp4a00wbWZjbHRwYUgrSklGMXdGVE9QUjBoRFU0Uzdx?=
 =?utf-8?B?NEE9PQ==?=
Content-ID: <B6745B795EC4314EB0C758B3A9530DE9@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675afd0f-10ea-4b66-d771-08da8cb52143
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 07:31:20.1253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qVF/A1Cxm7Z5dvSVJNHF8WG4swZcH7uCvamq/F9ezEALyZ/bgewa72hayV6TwNLVT69WJc+HGWX9D+th2+Tqkn1bwV7L4KnxQsATz2mqNac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9858
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] README: Add missing configure in openposix step
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
Cc: Joerg Vehlow <joerg.vehlow@aox.de>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

> Hi Xu,
> 
> [ Cc Joerg ]
> 
>> Since 8071ba7("openposix: Setup autoconf and fix installation layout")
>> , we need to use configure firstly.
> 
> nit: there should be Fixes: below:
> Fixes: 8071ba7 ("openposix: Setup autoconf and fix installation layout")
> 
> Then you can use just 8071ba7 in the text.
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   README.md | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
>> diff --git a/README.md b/README.md
>> index d45d1ee44..d0ca5f4d4 100644
>> --- a/README.md
>> +++ b/README.md
>> @@ -79,11 +79,13 @@ $ cd ../commands/foo
>>   $ PATH=$PATH:$PWD:$PWD/../../lib/ ./foo01.sh
>>   ```
> 
>> -Open Posix Testsuite has it's own build system which needs Makefiles to be
>> -generated first, then compilation should work in subdirectories as well.
>> +Open Posix Testsuite has it's own configure and build system which needs
>> +Makefiles to be generated first, then compilation should work in subdirectories
>> +as well.
> 
>>   ```
>>   $ cd testcases/open_posix_testsuite/
> 
> You miss:
> $ make autotools
> as this creates configure
> 
>> +$ ./configure
> But if you run make autotools && ./configure in the top level, none of these two
> is needed to be run in open posix directory.

I have called them on top directory, but configure still be needed in 
open posix directory.

Best Regards
Yang Xu

  Maybe document it (not sure about
> the comments)?
> 
> $ [ -f ./configure ] || make autotools # not needed if run in the top level
> $ [ -f include/mk/config.mk ] || ./configure # not needed if the top level configure is run
> 
> Kind regards,
> Petr
> 
>>   $ make generate-makefiles
>>   $ cd conformance/interfaces/foo
>>   $ make

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
