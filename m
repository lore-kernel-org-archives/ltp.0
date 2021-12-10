Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C682AC433F5
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 08:27:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA74E3C7FEE
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 09:27:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F4593C0148
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 09:27:10 +0100 (CET)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1BF9E1A014B0
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 09:27:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639124829; x=1670660829;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1UHhBXhOUicqspe3U3NXIGgvfWORavk2rWERM8R6uKk=;
 b=Tcw8o97kk4L1n8zi3kqbO3ZnB5+Mf5NbwuX5jC5VJ1PBe5KCHo228S5k
 XBunNdUQgrOZvmaUIG+5qZxxkyBQv7wpGNKXkFRo/2s41xvdcLCemkwUP
 +ziZzzrDsQvQWDzfzU/7DvRz0MuclrGtLrWZKBbpVm0HHzGFxCWPLFVIh
 1137vN0MjlGIG6HEKEerAhC/anil3yRMEN3KF/3MrfS1lb84l/0NWxVxr
 VoW6htLL0FKFUsa4lQDKhE/VMChzCpAauqW5lyCZPFVMaIEoRh4KZ5q9E
 5k5e3nmkl9h7F3Tf9S8KYkTOT1pxXqMo6qp02itjaa0IGc6zAss62LhhI A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="45586542"
X-IronPort-AV: E=Sophos;i="5.88,194,1635174000"; d="scan'208";a="45586542"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 17:27:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdRbvEWIo0e5DPpuKgGXjoT/PYbPXVlgX2G4V2hI8v5txHKWTsjhTcERVMd5b5VmeXWIWJdcBMsGZrDfQuPCoxNIabOYOFEqH82BRK+jmmCHHyEzlNfPgGiHrlBk2FpaP1PerKc2tZP+irShebXEULDdGWjKoXXs9M1stdbQObxoaJOwdkQLO7Id8AnrudRb4R+HrdkzUX9K1Reih7KeiAhcz7e0g29TmW0zak3JOz7P5SiVzphbut55Zq4eYnY14PdoKx/IHwoKhghvGxHmWhrt6fcAQ0JfFSF6Bb7ywc4WUykulZqLGQQz/E8HU91txsUZo8+G9aO0RBS40ofbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UHhBXhOUicqspe3U3NXIGgvfWORavk2rWERM8R6uKk=;
 b=GXEvTemcqc43MFvtnwZPtsMYY/G3qt24zaICjVzZuAbDhaelrUFqu9xIeSPfkbMahrT8XDUZjXwzizIaVIuV6MUrCEnpD98MkkITpjePuCw8+D2n7TIsgIffSSEq8SfE/tb+BAMFHWi5DlC0scxd4vZfV07U554viEOTnUjWKTDqus49CDL7XnvrBcyAUPJsNSwHLLJkPqkcy16y6MmZVozesFAl5rUWbw9StLfvCrSqF4D6NsI/190gQihK+XMztpVEwf140iwTmbzbsS8lGf8nzcYPsxTJKry1FQgBqn/g3ouDMoZ9/tFgqoT6WC22YMThXJuiPddhNrCz2JQRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UHhBXhOUicqspe3U3NXIGgvfWORavk2rWERM8R6uKk=;
 b=iGB+XgecYsiqeF9ko8//WzVJztl7snSqltv9hZcdHuw1Rx9lg8xwxSoxsQrc9xhMpIIkT5x9yMWAkuU/KJaUxobPsVRL1KdQ6dAdTMG3RiY9/ZMXeweJM6IA7FwHZfhRqrcG0vUjkGyo1km0z6Mse8XM9rit303mFYaJFs38BYk=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB4829.jpnprd01.prod.outlook.com (2603:1096:404:128::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 08:27:03 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.014; Fri, 10 Dec 2021
 08:27:03 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module can
 not be removed
Thread-Index: AQHX7NB/n7TKiBds6Em2B+wWj+FTuKwqRi4AgAEfyYA=
Date: Fri, 10 Dec 2021 08:27:03 +0000
Message-ID: <61B30F7D.1090305@fujitsu.com>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbIeFLfVb36DaVq8@yuki>
In-Reply-To: <YbIeFLfVb36DaVq8@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 299e9311-0751-4739-6be6-08d9bbb6d859
x-ms-traffictypediagnostic: TYAPR01MB4829:EE_
x-microsoft-antispam-prvs: <TYAPR01MB482943ACC2D784379A67E46EFD719@TYAPR01MB4829.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YgSH1cOXD2wrSvoPM4HB8JtiK36F+2ZuNJZcZsfmfZw04h090WF0yJe01R7W1RORiyjM1aw+nI66T0W9YLGzedZsPUZbvuop1NsdYAhz1Xc4pK/F4l6zeMwh0EMKj97V609/AQMZrI9gQzQ0f+7ygese4Suqyl+AG6Gk8i0CIFgV/T98Lmsb0plSjSiQo9c10DLh+4t3Bb1PBBw86cY9+JLZ4+5TbYAAnWHvRQ5mFA49YangJpYJKhdzmzK9kuEgeU1IXhL6JSPuW73HhYulmqaO3XG5zQe8vVJfeLdAm98cdLfRHDgFfHrtzp0oeH35bAiSzj2ELwc9aJzuzGCNNn4r2qwS6qq7fiTz/Eta2tH7L3zunHSbaPEsdVFKdoUF27kcUK2FYsF9NM8o4XghWH/8XpJXndpk12vK5lwtUeChf27WPoo0LgCLtPhnTA4OV1wKpwxY2ZNcsGoNz1kDkrVxV9PZCsPQSr45wEkCVPUqNBPpX9NYSVU54nVfvdbuCE+Pb5nGqHx/F1aD5XpBr6cMUgbB/X2gJnHwnSOGxdI+n9I/b0BUxLkWa3j/YByG42KGU4IgybtprU6Bss36Xkv7OsqObfYs93R5iKDPdwE/eIanC5BgiKmHsAMF+Y9V6dM1cEIauCFxZ7fSbwtq4zv4z3t1BXLqamK8MelkhB7hDCP9PQ9jr8m+XfJRR/P/LLOJGy74f+2V4CriGA64SNZnyfeaAMkQwvZO/f3uCTAOyQOQ+jucn/gL0QEcilxK5zrEXXfDz9fGRSWfzM2XHZ6+bIqGd/mR9uv3Q/+QpSA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(6486002)(6506007)(87266011)(966005)(6916009)(33656002)(5660300002)(38070700005)(36756003)(316002)(8936002)(2616005)(66946007)(2906002)(64756008)(76116006)(4744005)(4326008)(66556008)(8676002)(26005)(186003)(71200400001)(66446008)(508600001)(122000001)(38100700002)(91956017)(6512007)(82960400001)(66476007)(85182001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WjNDR0kxOEFrVTI5MHh3cU9YS01YNE1YeUZoR2NsUHdXR2M0VC8wcEpvRC9G?=
 =?gb2312?B?NUx3ajNrVDkrMlFXajdLOWNMWm9EZVNJMmNiVnhZYVNHbXVtQnp6ei9wTGVt?=
 =?gb2312?B?ZlZQSDJieVdTVm5aVEU0S1VIMkNvSkppcEpPL1VXZVp5ZmlhR1FWeDk1Szlw?=
 =?gb2312?B?SDRvQU5iOVkvcUE3Y3J1NjQvSlN5S0toUUpyQnM2bUNOdDRmVHpER053Qy9U?=
 =?gb2312?B?K252MFZDandHOXRIbzYrWHJHUlBsOXVTZVVlcUFrdG40VEdadkVXelhjWm9G?=
 =?gb2312?B?eVpuNnhGS2MwUnIvZ3ZNenk1V3FZRW94SGpGM3E0RzJQZmNLNzNWbGNjQXBT?=
 =?gb2312?B?Mk1RdHBwaWpzdmJNcmF4MElJRXJZV0xwZU5wMzQ3d0tPeDRROEtUS1Awa2FE?=
 =?gb2312?B?SWNUT1FqeGYxajF5bTBUMW1UWGtEU3Q4SzhoKzBqek5yL2hqNWRKd0FkTFJi?=
 =?gb2312?B?cXorRElsSGVDU0NuSVd6MVRscGx6WWw3MHZ5QytQS3F4VlBvU21ETHE3TlEw?=
 =?gb2312?B?V0R3TnA3Tkt3OFd5c0M0QUNwaWtZenlXUHlaMjJMamdxaStYb0tLWkFITTBW?=
 =?gb2312?B?RlZjTm9QUVhHZmZtcGM1dG5abUh4Mmh4UWt1UzBhV1hLTEpCM25pd0J0c2Ji?=
 =?gb2312?B?QUV3VS9uem9mUFdlWGd4Z3hGdzliTUxhVnNhV2E1M1p2WDhkbzRVNHNrY0Js?=
 =?gb2312?B?M3JYMVNtVU1PNmdJQ3pKZzlqZU5EckJ5SGY5cnZoSWFXQnJWNkNvSlMzSzBS?=
 =?gb2312?B?OFdzUE5Xamh6WDdvZ29XRnZIeUNjajFhM0FXbHhZdDFGbFVwaUdSeVBGK00z?=
 =?gb2312?B?QXF6ZHZ4R3daOXNuZ3dmOFJTclpTQlhVTFJ2NVBiRVBObXczT0FlSkpXVXR6?=
 =?gb2312?B?bitFYzNpNG5VQTA3b0dHb0R1dS8ydDZDdDEvVHdDS0l4SWQ1dlB6aDdNRXN4?=
 =?gb2312?B?NDVGWW9md3FJSndDVjdPeWlnTWNudVJaRDRYOGxpL1pQTkdneXlLcktyWVNn?=
 =?gb2312?B?VnRBUi9zQ0pEZ0k5bWdaRXBUUERONjA1V2FGd1I3NFFCZlF6WnVQUDAwakFm?=
 =?gb2312?B?VThYanVRaThOYmhqTXc1SWRKMWp6RmJXUEVpUEFQVzZVYlJQSGZ4SXF6L3p4?=
 =?gb2312?B?NTlCVDAyaDk4UE45NGZ5MzBMYXo1TmxITktLb21nRHhEcjZjUlluTlB3eFRI?=
 =?gb2312?B?WHFjSXdCRVVWajFlcVlhbjQzaTN6Y09LZDFudFJiejlRSGFaeUZoSkI5RlIx?=
 =?gb2312?B?dE12NWdVM052MjMyNDNzVXh3SkIyTE1nbXZLZVEwS1R3dTJ1M3IvQ3pPNVNJ?=
 =?gb2312?B?Rkh4WDdlNWg3bnV2Y3ZxTlNaak5XVTM3YW1UN3FwME1DbmJYaWRqaVE4c1dL?=
 =?gb2312?B?RDNiN0I4WlppOG1uMWYyYnV4NVUyeW4zWnZyb2RPZFM1SmtpSDJ0V1dxWGwr?=
 =?gb2312?B?WVhvWC9aQzkyV3MxQWUySWdHekM2QWN5d2RrcHNFcGxpM2xyVTRPaHlydjkr?=
 =?gb2312?B?VzluV0JjZ3kyRTJTcXNJckNITUZhOGhwSW1mT2ZhdElDQ2R1QWRjcncrVzBx?=
 =?gb2312?B?WXhkOWpZZkhpY1BmMFdkUUNEVGgxVEt6MmVxRlkrdFBKbmVYYmJRRDAzcDdo?=
 =?gb2312?B?cUFrR2VhNHJBQUlUaDF6RjFqU0tSWEN1alRYeUp0TTNxZndsYmtTL2tYWW5C?=
 =?gb2312?B?WE1qUHFqNTV6QkJoQW16a0hMcTgrVldoaDh5K0VrUHJaRjBNR0NJVzJsK0tM?=
 =?gb2312?B?MGxXam96ejdtbFRrVnVaeHkvMVlaVG5kTEtHbUIwOVFGMUxwc05XbkNkWEIv?=
 =?gb2312?B?ZmtpMSs2NFFqN3lxblIwOUN5a213YUU1b0dxOFRyUWxpWkhhbi9qZW91Qk1o?=
 =?gb2312?B?Q243VExucTZydGNJZ2dCWmYyWnhJRk0vWUpsdElxZVY2QkxydFpOdFZMUEpy?=
 =?gb2312?B?T2RVejMwcVlhZVhaTU5oVG9qcXJ3aVQrSVh2RklUN1FBZ1kxd2RwVjNCdTBE?=
 =?gb2312?B?S205SWw4c2dlemR2cEcxSVc0MDU0VUxxdmd2cEgzNSszMmJ0YUQyV1F3ZnRB?=
 =?gb2312?B?V01BRVBSQjZIalFmYmZBeUFyc3F4cXhrVnVWZWRBTmdjNXdPc0xwbjU4aVFO?=
 =?gb2312?B?L1VLWnBSN0Rwb0dTU1pzSUJ1RzFtU3pMaXZaWTVldFRWVVppWG04elkwbm52?=
 =?gb2312?B?MXNKNEU1N3FOc1huWjFkQ3ExMjJTdFQxZW1sOFcwV1NZcEx1Mnp1dXlXN2tp?=
 =?gb2312?Q?eQ44B/7T/TCuVZL3wOhEy5ENnfoOuDDuTz/BwYHz0I=3D?=
Content-ID: <DCA2EE4ACAA9844DB6C5AD54388BC3A2@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299e9311-0751-4739-6be6-08d9bbb6d859
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 08:27:03.7328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Yt2LKTnUbZll7VgySO5xhyg3BeSPhie8ZkVAeQR3sHdSdVK56VygTtOhAck85bgKe/BqoRV6tKvyQ9migb4pnGKsoqcXpE2G/97oWdKPQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4829
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module
 can not be removed
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

Hi Cyril
> Hi!
>>   	tst_set_timeout $((dev_num*450))
>>
>> +	rmmod zram>  /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
>> +
>>   	tst_res TINFO "create '$dev_num' zram device(s)"
>>
>>   	modprobe zram num_devices=$dev_num || \
>> @@ -57,7 +59,8 @@ zram_load()
>>   	dev_num_created=$(ls /dev/zram* | wc -w)
>>
>>   	if [ "$dev_num_created" -ne "$dev_num" ]; then
>> -		tst_brk TFAIL "unexpected num of devices: $dev_num_created"
>> +		tst_brk FAIL "num of devices expected $dev_num, but created"\
>                          ^
> 			This should have stayed TFAIL right?
Yes, sorry for this typo.

Best Regards
Yang Xu
>> +				"$dev_num_created"
>>   	fi
>>
>>   	tst_res TPASS "all zram devices successfully created"
>> --
>> 2.23.0
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
