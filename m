Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE93C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 10:55:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB4763C8131
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 11:55:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 474C43C1D2E
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 11:55:45 +0100 (CET)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 13264140124D
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 11:55:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639133744; x=1670669744;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=b7wDc6r2MD6i3F2I3uNViGh5YS6xn+tdZab/1WoQWv8=;
 b=mO2NsZQqIJD5ajkBOZu4MKwatMI7ApdQr9rjFafpCWD2bEgP9ovg5K56
 bsELOQL3TcPyUD8aw5/3URRcVEFf+UNw/tQODvk80PQKD9vu1CpSc9tQ8
 0uTg7vUT5qk4cbhLL8xfHcV5utPX+j2nlz592ht/RDQLegGTiQx88xpDi
 IzH/FYq7VfD8PMzZkFjzmbz605DtqEw0EsPajTj3glnUfUC5wxRZIlJHp
 XMx7ImgHA9gK/mvsKHdUewwxWDnv2GBYWvTk657T/JmMzomZhtsA7lWic
 mNCTNLWDIXSaLfkpYrBMJHpVQlbPPO60d+jwefVtyMh/s1H0ka/J50RSF A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="53523404"
X-IronPort-AV: E=Sophos;i="5.88,195,1635174000"; d="scan'208";a="53523404"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 19:55:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frAwqGZaPkuaCTsL0/CF8ZWNTlude6k6CvVnp09lxqqSI9DQTIseAu9zeJjxVRPJNha8dI2bq6QbT19MKAAlvC6LuqzWkudnaK0DjnGqw/6off9axZvkU3Y7atBDF/Ss+rvxHrzRUOYfGik5mCs59oi+A1IeUnYhfhYUA7KxBSogMhHcKQNfYYQNhDPx62LXMvI75UpqrTCtV519UEtsZnLPqzQvve9KBn0kCPXmFX5D+yMyTnahUK+s8k1QFUceYa79fTN/1YNfh33wpuE4eEB5RRx10L/cQ2Y1YuzXP16ukqw/XuoSKccYteuRW5+K/Aj6b6cwnEvj7FgT42qFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7wDc6r2MD6i3F2I3uNViGh5YS6xn+tdZab/1WoQWv8=;
 b=i+ssGubxoo6I5uDO3ZgfIz1l7SxLdv3ABqYcDgbmB0iTE6wMr/5ZfMdogGQ4a4TTSJrOFmUzyaAuEqfK8MKFJ3qlWOko0HwzflsjphoWUq+2UMri2sF5Nf7DkLSU/K5foToBNknXsQDmST4Mse3hItZUjPlL0jQsfM75o9MKws+ah73kkhpjtGEIzoL1cNNcL/n6rGlRSZjhGXLvOPCkJ4U4E10qL/BVSiVKO/2MYrVa4gCf495GOw5YAjbqbWV6iqk4qSikNJhDp0Zh3PDWEwvrfUqSIuXIBF9yBwxgqrCVUUxHKOfCjdV234MqSlrr+fcg8sSfjNJlYC0k9icl7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7wDc6r2MD6i3F2I3uNViGh5YS6xn+tdZab/1WoQWv8=;
 b=WgJ6eR9QosrHu1hBjKCRWnMIvkzq7L0xZUmEJcNSQ/kPuWt6BGYoJ9XyAWfA6NxFPKqDyFrvjdWAptfpBYxC/qOad4lRgbqiPjVZ0NwBe+ZsXVH93mIGLSiHDm1IOXwccIDibOJniOMhvDypcMwOrBvb/102pmzGQRZStNbedkI=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3115.jpnprd01.prod.outlook.com (2603:1096:404:6f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.24; Fri, 10 Dec
 2021 10:55:39 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.014; Fri, 10 Dec 2021
 10:55:39 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 3/3] zram/zram03: Convert into new api
Thread-Index: AQHX7NB6xUX/vyeW2UaQi8HnxvTG56wqsIUAgADe+YA=
Date: Fri, 10 Dec 2021 10:55:38 +0000
Message-ID: <61B33253.2070105@fujitsu.com>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbJ3SKsLu7iNoqZc@pevik>
In-Reply-To: <YbJ3SKsLu7iNoqZc@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a44398b-943e-4b64-e198-08d9bbcb9a3b
x-ms-traffictypediagnostic: TY2PR01MB3115:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3115752ADECCB642C715669EFD719@TY2PR01MB3115.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+stMLKJy1XjLe9pa+/j3pp2nyrfcHPJMDEF67cHFYKvYiRGmbz+p9bvPPZZqPMTViNJ6BGMnqB2KyjY6Tkj4WsyLGtPNizgnXzTH1bbX5i2/J4XFwQ1lm3hI2x2egQHfbdseFNiZFjlcwV8KkfULk6VGqHl66nIgXNtFrJJa5IZZNO1Xedxji+ylQMW8WRfskNYowUVW/vwl90mCjQGp2XYB1rLpelBbyp0qmFE0rG+/Dclkrse6dJZZ48hzdSHQ1REckum+eoOSeyZ2fqXeUSb72tWIzGseC/nWgR9p+vCsufsj/tXbm3OjD0D1N6GoJxQGY1eDEm8LtMVSepEJOuiz1YPwJXVESqN7MIE4fALl6CZqmVom+phHyEe0IOStVCri0Pi/lkIpiINJU2dad50iBK4ZKod/LtlcwpE6ai+AnrxQWH6r/6SSHd8gW0iaF6CLVEONL93Hq1Biz08MNlqE/bvaFdvUuVtQXSaOpa9WxzUc/0y/4lzEEE4Yfvp3ggM0OTTVBs0r4JdXhmwlmdkb97GdACnz0zJntiGfpceZzrmk46eGRUZ0tRJfvqZXqxEbnu6jjQvbK+U5jRVPDYQxfY9UqKYs1uphIzOHtR2g8GSG45RWXbu1R3iC27K994t9RQNz8nf7RKHOCGb8PndYVMkaN3VoxVClxSG0OEmppU9ShAg3L6Yi6pnutecM2iBaob+mUUI9FBzHSMiMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(6486002)(26005)(71200400001)(8936002)(2616005)(76116006)(82960400001)(6916009)(36756003)(66476007)(66446008)(8676002)(91956017)(66556008)(64756008)(66946007)(38070700005)(33656002)(4326008)(122000001)(508600001)(316002)(38100700002)(6512007)(5660300002)(186003)(85182001)(83380400001)(86362001)(6506007)(87266011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?M2p5dFk0ejh3L3FFLzJXaFNDaUJTSk9jRS9NMk9iRnkrRXRuRzhYMndzNFMy?=
 =?gb2312?B?VmY3WmhkUW41dE1leENSckI4QTE1MDVPR3krVWN4R0FQZDFLaFF6emd1SHVG?=
 =?gb2312?B?OEZQbldZVXI5dFNJeTl3K2tvRXdrZTVTRTBmZGlHWkJwbFp0NlhVb3dDeDhS?=
 =?gb2312?B?S3ZtVGw1Q05oaFc5NlphT2ExR0lXREZmY3FoWTFZV0xOcmVnR3JPRGVJTktK?=
 =?gb2312?B?M2NnbGM1aEdMREY3WjlTNEs5UVZ3ZFJXQm13U1lzK0tySHFtM3o1S1NmSXN4?=
 =?gb2312?B?UWd0bUF1SHFqNG1JVS9Fblg4OTFBOTFzSTNSMWprTlE3VWxvS0I5dHFBUWk5?=
 =?gb2312?B?aW5WeE9yYVZIb0pTY1FnU28vYzRvRzkyc25pbC9TaEVmTzRVcDlhd250dlNB?=
 =?gb2312?B?UFVxWWtQVE1BM1dhNHFybCtZb0M2cjc4MmpmdTVMb2NKWktHdS9XMXZYTHVt?=
 =?gb2312?B?RjA2eSsrL1Q4UkRRYWtvWWpVYWliKzZTUEZGTjRxRHBXdFJ3Ly9oV1JVb0s0?=
 =?gb2312?B?S0NFWTlVQ3pveUFxVFNYYi8xeTVaZXV4YUZ4Lys1SnlSaC9rUlJDTlF2RXJv?=
 =?gb2312?B?eFFIWCtCcXZXenFwUlA3VEJqejVDTmIrRHBNRjN2VXVVL3RVa0NEVnVuaHcv?=
 =?gb2312?B?dG8zRnBHcHZRT2xqRDhIcSthOGw0QUFiQ0VTbDdXUHFkWThrMy9JVFVwRFFq?=
 =?gb2312?B?Y1FURnVmc09VNTNjUkU3enpPSmVrREpaSHV4WWhJUUhaZUNIdlg1VG0zQnhG?=
 =?gb2312?B?Z0NUczBNc0ZQdjgzbExKZzZzTmUrWHVzR25vU2VlZ3dOTlJYUmlFZktrSHJX?=
 =?gb2312?B?Yzl1ek5CQWhpR1NKWjZZNmcrTGVibkN6SkpGOXZuNVB3MEJqZ2tlb2cvUVRJ?=
 =?gb2312?B?Z3QxWkFBTllFRkFIY2d4RUtKbDFvdkZHM3hkenVlZDl5cUZFeWErY1Vyc01C?=
 =?gb2312?B?ejlkNWovQjdUd25lLzltek9NUmowUTFEdE5icGdERVFJdWcyVG1ZTXZnU21D?=
 =?gb2312?B?WVZtZVh4TGhBclZyUElUZDBaNFgySWh3RnVxek1wWE5VQVBhN2FuZjFHU0N2?=
 =?gb2312?B?b1hJZDNsaStySmdIZ1Eza1hadzBnb2R0Z3VYL3VGQWt6MFN5Z3BhOFlaeFl1?=
 =?gb2312?B?QnQ2UXhmUFRJdERHWS80VnBuWUo4L1JTdWVpZVBwSWg5KzF4QlhoQzJjVzJM?=
 =?gb2312?B?bXlLNFRvc2pZT0EyZjlXekdNUFAzUW92ZEVHcldGcDlnYk84RE9MN2kwaU04?=
 =?gb2312?B?S3ZyQkpKL3NPNVV0U011a0xwWDAxcFBiQUlOWjFBUFZSVEpqTlZ1Z2hJbHYz?=
 =?gb2312?B?NTlSTTgxSjkvMVNOLzhaTW5TVWJVTWRodWhKenhHUjd6ZklWanJDOWwxRkxE?=
 =?gb2312?B?YmdDUGtOdXA0andVQU5SRmFZMmloQUxrZ01pSmJHYWVEMm80TlZNWlQ4VWxZ?=
 =?gb2312?B?NmRCWVFzTk5DTlBmL25BcDAvd2c3Q2pCMW9XQXFMZDJVbC93SmJDdUJOR2pt?=
 =?gb2312?B?NktLd29MWlV4UnE4OXdnS0lJeEtLd3ozNmdjYzM1cjZQTi9vVzc5UTFYdjY2?=
 =?gb2312?B?a24xUG9vYm5NdDBveTZrbTVObisveEEwTzA2eU94andtTkc2TWszN0FraEg2?=
 =?gb2312?B?T3Z1c0hjVHVFRkdzSlR1ZTZyWDlPVXV4aUpCRW9CV3Z0VDlEUktZZVpyTnVy?=
 =?gb2312?B?RmxqY2VCVEhtbnRRUGtlYmxsakdyelJ1ZHhIYUh5aXlVdjJ5aVJmb0tmZDB2?=
 =?gb2312?B?MEZ6OHU4TWEwSHpCejBaaC9YWmNUQmFhQkJmb1pwSHpwQjZGWnNsekRGaElx?=
 =?gb2312?B?cmt2VHVlWDNNSllPRmpCQTNRMTN0TVg2c09HZXhoNUs1Q2pZTXNESHg1QXFV?=
 =?gb2312?B?MXRDZ0pyZVdzTXpYNVN2dzN4cTZudXg2c01iaS9XMEs3MHAvSnBQVHZsUDdn?=
 =?gb2312?B?K2g1a3k1SjZ1dm80NzExTXFKTU9YOFBnTmFyTEwxTEd6MFRJNDV0L2Z0VGFS?=
 =?gb2312?B?T094WCs2bFQwM2F5V1FYR21kTEZNK2dKT0RReEhSbFhtdm0remt3SnYyVXlY?=
 =?gb2312?B?SVR4Z1pleHM4N052L0Z5bit2VlZKQXFBL1RjTWR0cjIzc2lvMnVXbW1JUlJl?=
 =?gb2312?B?NTM0UjVOYyt0Y3luV09IMWZ1K1k4aTJGbWhiYUt3WWVuTzE3b3dXVlZjSVF0?=
 =?gb2312?B?L2xWbnpZbFJOa2IrV3VJWUFNVlhYYWN5Z21oR3NPNENpZVo1ZFR3Vm5lTk5H?=
 =?gb2312?Q?MaADz2+jWzjHJWjdvioEhGXBzBnaqQQs6yR+6ONEm4=3D?=
Content-ID: <6C24F2DB70E5154E87E96A2EC5136283@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a44398b-943e-4b64-e198-08d9bbcb9a3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 10:55:38.8841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrxRmZV/gsDZUWar7TadzVWUL+gGRYc1SunDGh7A4fT/nI0AjhaR7RK9gmK4DFlEmil/eDMDQdBIrm/87JVQsFcj2soBxk53WqMbWH2dmNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3115
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] zram/zram03: Convert into new api
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
>> Also add removing zram module step in setup, so we can avoid the situation that
>> zram module is being used by zram-generator.
>
> ...
>> +++ b/testcases/kernel/device-drivers/zram/zram03.c
> ...
>> +static const char *const cmd_rmmod[] = {"rmmod", "zram", NULL};
>
> Again, here should be lsmod used.
I prefer to detect it in /proc/modules.
What do you think about it?
>
> Except this LGTM.
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
>
>>   static void set_disksize(void)
>>   {
>> -	tst_resm(TINFO, "create a zram device with %ld bytes in size.", SIZE);
>> -	SAFE_FILE_PRINTF(cleanup, PATH_ZRAM "/disksize", "%ld", SIZE);
>> +	tst_res(TINFO, "create a zram device with %ld bytes in size.", SIZE);
>> +	SAFE_FILE_PRINTF(PATH_ZRAM "/disksize", "%ld", SIZE);
>>   }
>
>>   static void write_device(void)
>> @@ -92,17 +45,16 @@ static void write_device(void)
>>   	int fd;
>>   	char *s;
>
>> -	tst_resm(TINFO, "map this zram device into memory.");
>> -	fd = SAFE_OPEN(cleanup, DEVICE, O_RDWR);
>> -	s = SAFE_MMAP(cleanup, NULL, SIZE, PROT_READ | PROT_WRITE,
>> -		      MAP_SHARED, fd, 0);
>> +	tst_res(TINFO, "map this zram device into memory.");
>> +	fd = SAFE_OPEN(DEVICE, O_RDWR);
>> +	s = SAFE_MMAP(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>
>> -	tst_resm(TINFO, "write all the memory.");
>> +	tst_res(TINFO, "write all the memory.");
> very nit: while at it, could you please remove unnecessary dot at the end?
OK.
>
> ...
>
>>   static void reset(void)
>>   {
>> -	tst_resm(TINFO, "reset it.");
>> -	SAFE_FILE_PRINTF(cleanup, PATH_ZRAM "/reset", "1");
>> -}
> ...
>> +	tst_res(TINFO, "%s...", __func__);
>> +	SAFE_FILE_PRINTF(PATH_ZRAM "/reset", "1");
>>   }
>
> checkpatch.pl complains:
>
> $ make check-zram03
> zram03.c:93: WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> =>  nit, but checkpatch.pl is correct, previous info was better than tracing
> function name. How about keep info instead of function name, e.g.:
> tst_res(TINFO, "reset zram");
of course.
>
> zram03.c:94: WARNING: Prefer using '"%s...", __func__' to using 'reset', this function's name, in a string
> false positive (not sure if we should bother with renaming function to keep it quiet).
I prefer to ignore it.
>
> ...
>> +static void setup(void)
>> +{
>> +	const char *const cmd_modprobe[] = {"modprobe", "zram", NULL};
>> +
>> +	if (tst_cmd(cmd_rmmod, NULL, NULL, TST_CMD_PASS_RETVAL)) {
>> +		if (errno == EBUSY)
>> +			tst_brk(TCONF, "zram module may being used!");
>> +	}
> nit: I'd add space here for a readability (it's on more places).
OK.
>> +	if (errno == ENOENT)
>> +		SAFE_CMD(cmd_modprobe, NULL, NULL);
>> +
>> +	modprobe = 1;
>> +}
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
