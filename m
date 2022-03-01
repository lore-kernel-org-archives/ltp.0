Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADD6C433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 08:11:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8497C3CA2ED
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 09:11:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 714953C9DD8
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 09:10:53 +0100 (CET)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3C847600A4A
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 09:10:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646122252; x=1677658252;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ayHyqI3seznP1g18pFeiAHz9HXlBkNtNdBofVvJ5p78=;
 b=xuqXl+fmwdwSKbKAhg9hOoHXCw/t464hRq4J82+s6pAO4X/YW8fz4EGY
 Kii7mp7WIIjpt3kNn8XWJ9pCPmM5aC/JkwQqz2x8ZHPlpUoscWSbI9VLh
 dgs+BBrlSo4HK4fHZUCeuwaiRZl7yR1z5858+hPwasV+e6lT3cArHd8M5
 UTrr6eThgQQU2AAh2MLsG8wSnfE+ZLjNY6Tx07dbwEPVUMVACyWJkkXmL
 +CoiKvUIJ3EWiDmj7QVjtxLasMdAaOwSwieBEvdooeAgnlTMI9hfncOxm
 CJQvu7zG3WYINPEo8FewFpvA4okF6CHCgLypxWXkY2h+zVwhi2Gy/SL06 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="51021793"
X-IronPort-AV: E=Sophos;i="5.90,145,1643641200"; d="scan'208";a="51021793"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2022 17:10:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdvczxmAv1cV3aGK/G/QEmGSWo2AyAirGS8/ZxejAjZm4OS/VRT7CTGG5qy4Pz+eknSn6nD58CrbVNtQQL1rT1ao20Dc/BPSvX1sZT2reLR4J6wm+EuryYuLH3VSPGSRg31cNq4aHBt5YoA6ScQKZ9k890lZRo5IvNH94AKiIFQbbl9ZmR/Yj5p9f0kZqHGuqt+qHjy1sFObLiJsN+lyujfk8koL15R18pc3XFU4TGQLPzKQyT7LLMiZGN/ZJ9sj6kgYTVyzdGCj+98NL70vDUdTKJud5yWkIg698Nnkh/9tJqxL8ft5s9h9r+6Mi7AqSq/C6PU7wRXuBkU8DRoG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayHyqI3seznP1g18pFeiAHz9HXlBkNtNdBofVvJ5p78=;
 b=jXrdgnVfK+FJ9M1BAnvpU4v/u0UYLmK6VqJnKGrlJEtr6PzbYR/2A10UQiqwA28CPnX1wiQHQuetR9y277tLrx2Fv/Nge4UF+Pl8+0tU2Ya7d+uM9i1LZSeWI6BMVLn+5pBv3dR74vmOeevXvlEtqGIC1iHf7usel6ZxNjvN9aoh2gHaVnnolAv6luCnYT0nuwoVv4X2w0MAyB8EfI16MSTT7D1OkSNfjIJzHcJFduDy4zVC1SNXWRV00PbND6oI1WxLMpvmUuEDu17jYfZLyL9isU+UjGJ+abgvgIqd/egUDKhbBh+QH0YwK+rPEioM/9AwhgZlpgLt0gAJIdAHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayHyqI3seznP1g18pFeiAHz9HXlBkNtNdBofVvJ5p78=;
 b=ma59uihiLcwx9E7M1Bl9c3h6FdA63V5d1rR0pMEARAdtTNmZYbrGGErbq/mTxV2FV4rnyDB7Q4AW3TS/E7e2pHYbqQq/9IZJmS99WZkPdO7QLmI6tPYMt570Jx1Kc1oWqh/0u6pqp2U+BJDH3weEGlYmaGVoFdztnXGn5H6W6No=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB2903.jpnprd01.prod.outlook.com (2603:1096:604:17::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 08:10:41 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::38aa:3980:b578:98b2]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::38aa:3980:b578:98b2%5]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 08:10:41 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH 2/3] quotactl08: Use do_mount()
Thread-Index: AQHYKMqkwUNiAx+MtES8Pjk/+VcXKqyh76iAgAc8kACAAJT5gIAAcZqAgAADioA=
Date: Tue, 1 Mar 2022 08:10:41 +0000
Message-ID: <621DD533.50509@fujitsu.com>
References: <20220223153243.317-1-pvorel@suse.cz>
 <20220223153243.317-3-pvorel@suse.cz> <6216E3ED.1050700@fujitsu.com>
 <Yhz1+H3SAlwPaO8H@pevik> <621D72EF.50500@fujitsu.com>
 <Yh3SOwogWwWQdZ4O@pevik>
In-Reply-To: <Yh3SOwogWwWQdZ4O@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2ad89b2-c41d-430c-553c-08d9fb5afa4e
x-ms-traffictypediagnostic: OSBPR01MB2903:EE_
x-microsoft-antispam-prvs: <OSBPR01MB2903524747663DA94B153593FD029@OSBPR01MB2903.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yTXW8spGM+msnC+oZBfVVmjzfYKJKPQOxQ571t7OqAlzu5nckVJaMglBVRg7nPXVV3baeiCiz8f0iw9hHZ5tMZwgH7dGYtQiSDgxZyXDDaOu5reyJASw7TnGywrZUyOjAWKuFAfAYvsfESxD5e9rKAVN+D/W3ip+ZeF8k6ALUNrzjCBYx4wh+g4gGknwJUkW4ptFL9lYVszfCoHlOnvCZT6we95KyH9DIsWqRthQcx4en8iHpVOnaWAEXkIzUbfIdk9SpS5NC2aVay6rFmabXNlbOPq3CyIv03rNCY6X3sbf8+g7ATyaStu51r6ORw8x8oTGHFntO3XkAJ77uxiDPCWAtaEbNPgnDvq9u6CLVfKCoSyhQ/4nk9/P8i9JeqrXQztY1hnOT34M7uXrV4DA8TFin+hIZzKHUT43I0qpIawEDUdsoRX1R46ijFnmRwH4DZVRzzpezV2+gL/1DdSxwiJZT2Pe5Vu0IWQRlNx45DuoiXBqdDP/C8UQVqWwfSf9gj2hWFLoZQ3zA2CSIUWs8LuGsEVy/6Kq7WjBsTtHZ4ylv3uY2H1IFzYsq38sHn4wKL4wqVy9UDM6abrfydECpbObrwpCRN90oXVHU3Fk3wMCdI3dM6bLHUtV30+Bumuvgs1Nf0GO5W8fdeijUjbrQNjgkP5wcvgw7rqOClusQaqNuHG1945PgvmAcFUdxwfa7RdKIlctbYhKtXgTuAactw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(38070700005)(6512007)(6506007)(8936002)(82960400001)(2906002)(54906003)(86362001)(316002)(38100700002)(6486002)(6916009)(508600001)(186003)(2616005)(26005)(66476007)(66946007)(66556008)(85182001)(66446008)(64756008)(71200400001)(4326008)(33656002)(8676002)(122000001)(91956017)(15650500001)(83380400001)(76116006)(36756003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ckdjVml1Qy9vZ2tURDJ5ajI5RmI4QXVNdU9MbER4MzFSUlBpajJPM0NITHly?=
 =?gb2312?B?RjladDJ4TlpwMS9rOGRMakc3eituTk9qZEZnU0cyeGdCUm9RZ3BLc2pYVHBj?=
 =?gb2312?B?ME9PZzdkZ3NBdnRkbG5lR3htTm4xZ1hacDdqSWV6OGxicUdHTEtaQi9nUWhN?=
 =?gb2312?B?ckh2dU1vaVBNNlljZ3J4c3BWU09kVk56K0swbHNlNW1JbTJDaTFYSVB0S0dB?=
 =?gb2312?B?YkVnQnhVY0sxR2NvMHFEdXhLdkJQMUhrUHhKM01KQ2NVWjZLMUFRRU55Yjl2?=
 =?gb2312?B?VkFzVlhWeXJ2Z20xazJiWlVlZVl3VkhsaDF3aFNqdTRJSkVGQU4xOGR5SUVk?=
 =?gb2312?B?VXlqTjZUTzNBYUo3WDJ1RTJxSTNXd09aMDNoSUxoQmhnbEtIOFEzWUlEOWl4?=
 =?gb2312?B?c0RJL1dNLy9vVmRaUlNZV0VXZTFBbStYY1ZLR0hiTVZOamRBL29HMWZ4cUVs?=
 =?gb2312?B?UlJjaU9LYW9OZWJOMG5oY0hON0EyYjRXSUgvTTJDVm5MbzhPSDY3NmhKVi9V?=
 =?gb2312?B?dmszdGZpdkZnTE9GK2QrTXFDdjgvbnc0VmdBeTQ5OHR0Q3hpbVdoSG1FYThj?=
 =?gb2312?B?L1dzV0Uxa3ZkN0dBZVhrWFlFMTAyeDR4UUswYWtUTnNKRmFlaHcwNUVqMmc3?=
 =?gb2312?B?RGxaMHJjc1JDMXpucDRvS2JIT3VDOUNmcFlQbDU5Ry9TdHUvMm9lWTZDVzVS?=
 =?gb2312?B?L3c4cHdYSnZ6dVBoZllmUEt1ekxqZWxVT1BFVXEzT2JaQ3JIUjRCMno1cmlQ?=
 =?gb2312?B?eTB3UndsNG1tdEw2ZjVjcUxpUGJRQ1VJRUVTWFQ1c0Y0QTRPMnFCMHI3WFRG?=
 =?gb2312?B?YW5FUWJLOVI4blFkYS9IRnhiOHVLQ3o5cXFwM2VlTzB1dlNaaUZvYXVyWW5Y?=
 =?gb2312?B?RXRtRGtrNTVTakxERWZGYW9JWE42Kzh3Wnp1Q0lyYVR5cHd1dGgzT2JacTVF?=
 =?gb2312?B?SGw1OU5YYjFwWUYwdmtIcUZTY3hENXRhenpwWXUxSUErN2haa1pQSE9qcDNi?=
 =?gb2312?B?RndUVTZITXhsVDZ2OFhYaXdvSTBLNksvSkNhbnYvM09GYzY4K2o3N3BUc3B1?=
 =?gb2312?B?NmkxUkhMa0VGN1QxaFUwc0l3Mm1KS055UU53UEs5dk5JbGtqRlRrbGJkZkN4?=
 =?gb2312?B?eXdTSXZQdTlhVkRnbGJ2OWw5YWc2QVZQUC9UU212TldSN1RONWlhOTNpSVFr?=
 =?gb2312?B?KzdTNC9DMVhaYXBjdUc4bXB4emJGd2d1NnJJQVNnWFN4ZHZ3djY0SkRjelBu?=
 =?gb2312?B?R2drSXo2MGdmQnFkNzNNZ3JaVmd0MDB1RmtnTDBHOFFoWnRWZ1htZjdnOG5K?=
 =?gb2312?B?MXVtZy9qS3dtb0haMmtvM0I0WXFDM1IvZ3ViSkFlbHFPSnVNT3RlMWtIeTdn?=
 =?gb2312?B?Q09KSzBNUFppTGZsYlNDUTFmZ3V4MFJIK25jRVBiejFLSHBNODV2TzF6RHEx?=
 =?gb2312?B?TG85N3pZZWRjWGM4MGl1WWFpeWhzbkVMcEM1TGxZWm9BWDA0czIzckFJYzU3?=
 =?gb2312?B?ZEZ4cW9pTDg5V1NFQXRsMWhwNEdjV0pkUHJYc1d3K2tscHlaVnoyZUlPUCt6?=
 =?gb2312?B?alFIQ3NLSzIwaStLZnJUZkNEODRGbnBpUExGVEFuVXNUUHV1aTJEek0vdWJJ?=
 =?gb2312?B?VzU0R3hGT3QwMDRMTTRMMlpjWnBVZnRIemk1SVprWVhFN0V5eFphTnQ1NmIz?=
 =?gb2312?B?aFFuM0ZTblJ5cUNZMllQcktadlVZbzNHRXE4WVZ4S2pKV3RhU0VsOHV0YzE2?=
 =?gb2312?B?aDlSYVZ0MWVVSVo3Y0YvNGwzaHRJbytXODRkcm5wNE05Yi90eWxsOTl1azYz?=
 =?gb2312?B?aWxOWm9vaGRZMnV4a1NKYm5mcG15L2xUOHJOQ2RIellxeklleXUrcmRRWGl4?=
 =?gb2312?B?ajRISWt1Ny9VdWpJN3Q2L2dmUGx0VUpaTnU5Y1NBaWhWZjBQWjVvSEJwWlFl?=
 =?gb2312?B?eVV4SXVSZFJjS1ZVcWxMSTM2NnBaZXFJZ051eGdZK2JLU1NPQVBqWnJicEN4?=
 =?gb2312?B?ZWdUM1lWcUdyNGt4NkZkaWd1UHZ0VHM5RlZmeC90Y3pjSStjc0x1VkhOSndT?=
 =?gb2312?B?cTdpczhpWDVVUk12SUNZYlV5cG43bTlpVTByOU1HQnJWNnNsdC9wK0QwZnZG?=
 =?gb2312?B?N0VJMVNRdXBJZUsxYzJLemZhWnVDSVl3NVllbkpTSXo4ajc0NVFvdE9PQkpw?=
 =?gb2312?B?Um9MUzAwRXVzekRkNE94YUZYa2NROFhjVWVXK0hGRmpraWxsRjNCcFdTclFR?=
 =?gb2312?Q?9ZfyCAyf8ut9CgsFa660zKG2wPWBj16v2qaAfJEYyc=3D?=
Content-ID: <C9A7F9A683DC9D4F849C5022D344ADE9@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ad89b2-c41d-430c-553c-08d9fb5afa4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 08:10:41.3608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDW2H46Z2Jekrik3OAREva9IMM2p61EQBfXrO8sybZBMljHiX4chJROeuIC8W8ozg5ByG69EFAHs8No8Bel3ayfB3apg1C4cm8cRsR2jvGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2903
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] quotactl08: Use do_mount()
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr
>> Hi Petr
>>> Hi Xu,
>
>>>> Hi Petr
>>>>> to change
>>>>> quotactl08.c:160: TBROK: mount(/dev/loop0, mntpoint, ext4, 0, (nil)) failed: ESRCH (3)
>>>> I doubt why fs quota is not supported on this case since we have check
>>>> kernel config?
>
>>> There is probably bug on the SUT, thus it might be correct it fails.
>
>>> But how about martin's fix 4aab31e4c7 ("syscalls/quotactl: Skip tests if FS
>>> quota is not supported") - quotactl04.c also checks for CONFIG_QFMT_V2 and uses
>>> do_mount(). I'll check whether it was another bug on the system.
>> Maybe we miss check the following kernel config?
> In my case it's probably a problem with mkfs.
Another possible way about loop driver. So do you use default loop image 
to create ext4 filesystem or export LTP_DEV?

Best Regards
Yang Xu
>
>> CONFIG_QUOTA=y
> Selected by [m]:
>    - OCFS2_FS [=m]&&  BLOCK [=y]&&  INET [=y]&&  SYSFS [=y]&&  CONFIGFS_FS [=m]
> =>  very unlikely not to be selected (but we might want to check also corner case
> configurations; but I guess also CONFIG_QUOTA=m would be ok)
>
>> CONFIG_QUOTA_TREE=y
> Selected by [m]:
>    - OCFS2_FS [=m]&&  BLOCK [=y]&&  INET [=y]&&  SYSFS [=y]&&  CONFIGFS_FS [=m]
> Selected by [n]:
>    - QFMT_V2 [=n]&&  QUOTA [=y]
> ditto
>
>> CONFIG_QUOTACTL=y
> Selected by [y]:
>    - QUOTA [=y]
> Selected by [m]:
>    - XFS_QUOTA [=y]&&  BLOCK [=y]&&  XFS_FS [=m]
>    - GFS2_FS [=m]&&  BLOCK [=y]
> even more likely to be selected.
>
> Kind regards,
> Petr
>
>> Best Regards
>> Yang Xu
>
>>> Kind regards,
>>> Petr
>
>>>> Best Regards
>>>> Yang Xu
>
>>>>> to TCONF if FS quota is not supported (the same fix as 4aab31e4c7).
>
>>>>> Signed-off-by: Petr Vorel<pvorel@suse.cz>
>>>>> ---
>>>>>     testcases/kernel/syscalls/quotactl/quotactl08.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>
>>>>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
>>>>> index 3793867f23..9f54bebcc0 100644
>>>>> --- a/testcases/kernel/syscalls/quotactl/quotactl08.c
>>>>> +++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
>>>>> @@ -157,7 +157,7 @@ static void setup(void)
>>>>>     	quotactl_info();
>
>>>>>     	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
>>>>> -	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
>>>>> +	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
>>>>>     	mount_flag = 1;
>
>>>>>     	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
