Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381CEC433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 02:26:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 639403C926B
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 03:26:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 800C33C84C1
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 03:25:54 +0100 (CET)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6691B1A0081B
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 03:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1640139953; x=1671675953;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1lOVl7M3vWJlz+yF35iaWCbpvrfQf2zRRfHE4Sdfd8A=;
 b=hO8OzAQG10t8PVjCWf7uL09xgVyvhddXrbZcvskbAxP2ojUlva+fYYLm
 ET1FRyrFr92+kr/ppqRW/cS6fPtt7OYyRvHog0lKg3jed3kf5d5l323r9
 kovZCTCbn8NAqnB+Ae9P+WsWsmFUiS8LYNVcuA+1JJMe5mQOYeFHwCSum
 aB0wTiY8hkFuNWAu4bKkLVHZgLkjljNUV0HDo4g4CYbqJRUHjzo9t9SUp
 zX/15zJOugbo5pEmk8BuNHw0pAsM0/0Bd+xPC0xzYzNIvQZbPcI45U50P
 28+OlkQuR0cUSeC1nmfEFAMU3qibBHQEaxMnT5c/8lNTt8oTKIBjqshBG w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="46345407"
X-IronPort-AV: E=Sophos;i="5.88,224,1635174000"; d="scan'208";a="46345407"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2021 11:25:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LF//gyaKYOayjQrm5Nmddd+zW8CUcQ7NjyPtl8uG/a67BNluIQDMdv9wXAfP0VSYwsnLL3RhtsYHruwSu+QPt2LcTt9hgzQS8+4IGb/UyjK3jO7POYErRX2vZt51pON4PO610RDaj+sXjs+knryAzfu60161ZTQBReOv6/4UC8jdrTtNwFMUKhwNmYFYqOBNP5k51L01T79qMeIEo77MTazw89s4rUUs7EeB1AupZsGbIikzlJTYh4znWoLvyIFR/k3LDLLZW4tpNiwp9eBkzEr8V5w8t0N43sitHOPs+eVlWhxhGf5+0+xN4SfT97RZ941UJWGJYWJI9tNbEfQ4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lOVl7M3vWJlz+yF35iaWCbpvrfQf2zRRfHE4Sdfd8A=;
 b=ajuxMAWKf7uLYMajWYGE07p6xUnHmAOxlXtnmtTngM8vSvNNMZH6gMisAan9AMbuU+sprW700YB+HDH7UtZ5PAqN/PFbR32QIYSwrqg/FGds75kxh8LmheXnK6opWHhSPJSohKR4U/mD23dgHgQkRFQJ/v1wyhFZ0nONj/ENSTureEDRmiFxkhwrtQYMJie0VoPBXh3VsTqgYkiUqz1EvgMBmhKdV5Dd9IhxMZ4S/Txar2jewR3o28PDeYFy7TMeA5mtdTJ7yYhU17QnjhSISnxBh9hw9V0bjghIJXaqZXgY5okFCRDw/zDY0BZpmmsbtWJjYhbJ+RHlCiw/8XlL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lOVl7M3vWJlz+yF35iaWCbpvrfQf2zRRfHE4Sdfd8A=;
 b=l7+tGG4aTA0gqjjG+4BJZo5gtOwz+iGHbiz4QGlgBTUM4/oPBL0dHYTKGRsV88/znqQb2zUbSdsagZ4PBPUZFG6QIyEMj1fwZRP0V2zTlu8+2PP8CDMgx5YEjTqZTf6tAtiOg/7utWGsjG51qheAH80BLPNmIYOGe7qApGo5OYg=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3658.jpnprd01.prod.outlook.com (2603:1096:404:d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 02:25:46 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%8]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 02:25:46 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 1/1] lib: Skip tst_{disable,
 enable}_oom_protection() for non-root
Thread-Index: AQHX9qHoonjI6Y3fe064dMYL0OKUWqw9yUAA
Date: Wed, 22 Dec 2021 02:25:46 +0000
Message-ID: <61C28CB8.3050209@fujitsu.com>
References: <20211221193500.31950-1-pvorel@suse.cz>
In-Reply-To: <20211221193500.31950-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 629fda83-1bef-4655-238d-08d9c4f25cc0
x-ms-traffictypediagnostic: TY2PR01MB3658:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3658C2AD42B25B489BA11896FD7D9@TY2PR01MB3658.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nU7Ea4zpQR4GpiKRiE6weOMz9MqphTKui3zqEGAaoPspMwZocxo22mjvyMkvUCvjs4c2178l+Hqmxd+3iG63T1Bb9SM0f85xQLkaJEWoVkpLEVt7luGjiBZTIsvaDHIw3UNqa9Py+4ZqEhtwg3cIAnduV2zQisFllA781T62irGMl45YVqfd7t0uKYMCV9hGJAkxjUkP7JOK/fi4hi8SyGjpwP40MaA/JbN7y7UthfTw5TToJJIqxWpC2uxfjSLyijoFJT0v/j85TH58cf41z+WjkR6CvXvLP5TlD5DwjQovq9u4MW2ql/JZhpgAP4G7tPrQ/I/qlzOM4J3zhE4pm330CkfYAEtDMkiKh4R01S4dufyW8DunI4OBQVupWvFehNWqhmYnBI/bJyi66pSqlEWy6OJ3mDGWSCIKbqzG5H4+doWk+7joY8EmCLHt4rwXcFaLGIkTgOXMvKgjAsAHYCMcldpv6eEgEOXp9utUbprIWpg3hR4IQWwfqFiJ7jBud/XelJkaDh6dk3HxGESkDRmID5KbIqn/T4K7scdPvl0imHKZXx/Am/AnNFTrVdL2nOyuUxRpPLjbk9BobberTxak22EaqrB+Od1+JCcagVayMy4//Eai5MfrXNTf0HeOCT8WVNK4dsjXud8YlQ+RfYc1OWHbkW75ylEatNJakUMsirwzXM4B2gXq/UPmFUY+6rd+2gpn49Jdv2xLWOrOVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(38100700002)(6916009)(2616005)(8936002)(83380400001)(2906002)(71200400001)(33656002)(86362001)(38070700005)(186003)(26005)(85182001)(6486002)(6506007)(508600001)(91956017)(4326008)(82960400001)(66446008)(6512007)(66946007)(76116006)(316002)(122000001)(5660300002)(36756003)(66556008)(87266011)(66476007)(54906003)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MTlSMyt5ZnkvbmhVQVV4WWNyM2NRNjNKOUg0djZWQ3BaclVwZzBzN1FUNlJ2?=
 =?gb2312?B?WVd6TjlVWU54ZjJ5QjNHU29VZjhZa0NJcEg1YWlBQzRuci9nVE1YeDdpTmlq?=
 =?gb2312?B?d1RrRUlVTE51NzN5QVhaOVpHblc1T3hUZFRIdVBvQ3dvUjdlVUEzRm5DbmpV?=
 =?gb2312?B?bzFub1FlSnBjSDFFZjlyOUYvWXVHVDEvVE9xVmluYno4YU9leWFJc0pYemcw?=
 =?gb2312?B?Z2x1UUtkdStoQXpNZ1hOdE1sRWlVa09oRzM4Y05HUnBHM0Qyc0o2VmdHYUZv?=
 =?gb2312?B?dlNpUVlLamNNZlAwWGxJR1FzakJ5RUlxSnFxMW40L29PMUd1WEZMRGplSUUr?=
 =?gb2312?B?clZCZDlWVVFic2x6emFCQzhXNUlmL1ZwVXZjNitMMmpuS1ArNUtLWVBsd0hM?=
 =?gb2312?B?SGVDQ21lOHNqN1ExYW9EYjRuU3RwRDBYQVF2NVVSL2plejRtODgwRGJuZzRi?=
 =?gb2312?B?QWJNU05ETnlkMHlPbnJHTjZncTIrUi81dnkwbGFSNTlyNjRsSnAzZ01WZnBE?=
 =?gb2312?B?b0wwcnZnUm9yWW1TVXlFZGhYemJMejgzK1lLbWZ3bjBoZ3VkcEFrbjV3M3V0?=
 =?gb2312?B?RHNDNjZUUHg2WVllTC9qMUduVHdvREx3ZzRHL211UGJTRDZTL1BLRWdCWXd5?=
 =?gb2312?B?cXFKYkZRSG5Vck5SNHc3UFhwMFV1MVkyQVpHVGUwN0U4eVV5ajVvTVNKSHcy?=
 =?gb2312?B?R0xNTjhIYWpYWUFhamIwL28wVEl3OU14SVhzcURleXVYeU5kU05LMFdOOXQ3?=
 =?gb2312?B?TURwYVV1UGxwVnQ3TDRVMXpWUE81K2tSQklwUWo1cHFHVDd3eU5XclZqMlBw?=
 =?gb2312?B?akRrbnp5Yi93c3FxT3VETFlZbHg4Njh5NEEyUitKakFYREM3a3BuWW9QaUR2?=
 =?gb2312?B?dUcvU3VvWElWR3FhRFVKVWUxbFRLUXNOeW9lQTFzbXRSc1JZWmNDNTYvS0h5?=
 =?gb2312?B?R2RGVXFVa0ZDL0tFd3UvNThOWXFkTXJnRnFYSC8zSjhXK1JBb0pKVWNkaFNr?=
 =?gb2312?B?S3RoS3JnOEhuN04ybmk1a0R2K1JpQnJ3WFR3dVptWlByQTFvZ0d6ZDRZQ25I?=
 =?gb2312?B?NGI0TXJkZjFjRkh1M29McDJUNk1yMGFLS1dHV0tWVHRIOGJHbVF5OGFXeHVJ?=
 =?gb2312?B?Qy90M0pXZXFINE1xVmQ1RnoxRjlpdFpaM0pweWVYQ2lYVHAxeHUzZ2V5engx?=
 =?gb2312?B?SFlFcHg0ZTBId2RHUFl0U3cvYm02M05aSldkdE90L3NtcHZKTXY3c1lxdnNQ?=
 =?gb2312?B?RzdqSjJRMmtnRy9KRk5RMll2TUNONFRHM0FJWU1BbktDcDE3VjBHU2ZYcFEx?=
 =?gb2312?B?eVVHaWtiME1wK09BQUJlR25QbkJrYVVoeDA2M0p1WW44bUl5UnpFREFnaVl1?=
 =?gb2312?B?OEovWUFPUHJZMHg4Nlo4a3VFNDZSZUVkeC83OEdBcnJiM1d1a2ZsOGtvZnVy?=
 =?gb2312?B?c3doaVF0Y2JHUUx4RUM5ZTROaXprbkNocitZazFxeFZpakIrVGRETUNROWN3?=
 =?gb2312?B?ZVlJTTRobWJuakU0TDZpRGFJcnZNMWI1eUFOTEF1MzZ1cTFCelN5VWppd2lU?=
 =?gb2312?B?bWRNTTkrTWZWWFplSitJM1pNMlVoZkc4STV2NDRYOVJOSXkwS3RoMU8wT3pi?=
 =?gb2312?B?VTVmaXhZUXNxeTJSY1N2L2kvYnVhYU9lbjJsMTZISitEVkdpU2JuRWtsQVlE?=
 =?gb2312?B?S0l6c2tSbHhwRlp5YzMydXJ3YXBBR2pDb1JRcXNveEp0SVlHZ0EyZHQ5SjQw?=
 =?gb2312?B?Tm1tVFNtbFJSSzk5aFNoUlJ4dEJEb25IdjBhSmo1eTJGY05zNlNCME02NTVL?=
 =?gb2312?B?UEovMmRDNThSYkRmTGM3RkJHV2V3RzloZk9RV2tGOGtwSnNrTm5OOW9TQ0tB?=
 =?gb2312?B?cTNFWVhlblY4L2h0MGlJalBGNDV4aE12b3FpS2NNMkp1bHA3ZGxMU05FZDlV?=
 =?gb2312?B?Yk5pWW4xN2d5TExKV1FGQWROdm5ON2pxTEVpUXQ1SHlqOWU5eDJMZlhEbzJW?=
 =?gb2312?B?SnhqekhWYnBoc0RhR0xxbFlFODk5aExZaWQvd3ZrSkRQMHFGUXJaSnJORjBP?=
 =?gb2312?B?a3d6bVo3TXIyOUhSQVQ4Qnl5WVBTV0pYRndBRGJiVC9TVVlrUC9HYjVFOUNi?=
 =?gb2312?B?YTdYSmlvZUpoQS9vb1BtVy8wd3JPVFZ6alE2eVBwWGNIUjNwZmdRdC84U09j?=
 =?gb2312?B?dmlTdHU4VitQOUc1cWtKWm1PTkp2WTlCeERwV283ZmkzYzJTTzJDaVJhaktj?=
 =?gb2312?Q?RR+UlfPNF5+bW8kYJPS5MtZJHP0t4AUs/zbm4l5p7g=3D?=
Content-ID: <2D861E668B479E4890BD561499E88A3E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629fda83-1bef-4655-238d-08d9c4f25cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 02:25:46.6054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxoqIeJuzjQKV/G3Re+9cnVfXaIVH0c6LR22C0D9dWCFBmY+vKB/B3fwiPLsJUMGKx881QBdAkC3C1Tfes+TatOO3M9zPqESGksZ8uCKQEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3658
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Skip tst_{disable,
 enable}_oom_protection() for non-root
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr
> If needed to set value also for non-root, use set_oom_score_adj().
If so, why not rename set_oom_score_adj to tst_set_oom_score_adj and add 
declartion to tst_memutils.h?

ps: also have a word typo in set_oom_score_adj, adjustement => adjustment.

Best Regards
Yang Xu
>
> Fixes: 8a0827766d ("lib: add functions to adjust oom score")
>
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   include/tst_memutils.h | 11 ++++++++++-
>   lib/tst_memutils.c     |  6 ++++++
>   2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/include/tst_memutils.h b/include/tst_memutils.h
> index 68a6e37714..e6f946ac0c 100644
> --- a/include/tst_memutils.h
> +++ b/include/tst_memutils.h
> @@ -30,11 +30,15 @@ long long tst_available_mem(void);
>    *   echo -1000>/proc/$PID/oom_score_adj
>    * If the pid is 0 which means it will set on current(self) process.
>    *
> + * WARNING:
> + *  Do nothing for non-root, because setting value<  0 requires root.
> +    If you want to set value also for non-root, use set_oom_score_adj().
> + *
>    * Note:
>    *  This exported tst_enable_oom_protection function can be used at anywhere
>    *  you want to protect, but please remember that if you do enable protection
>    *  on a process($PID) that all the children will inherit its score and be
> - *  ignored by OOM Killer as well. So that's why tst_disable_oom_protection
> + *  ignored by OOM Killer as well. So that's why tst_disable_oom_protection()
>    *  to be used in combination.
>    */
>   void tst_enable_oom_protection(pid_t pid);
> @@ -42,6 +46,11 @@ void tst_enable_oom_protection(pid_t pid);
>   /*
>    * Disable the OOM protection for the process($PID).
>    *   echo 0>/proc/$PID/oom_score_adj
> + *
> + * WARNING:
> + *  Do nothing for non-root, because it's expected to be cleanup after
> + *  tst_enable_oom_protection(). Use set_oom_score_adj(), if you want to set
> + *  value also for non-root.
>    */
>   void tst_disable_oom_protection(pid_t pid);
>
> diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
> index 4346508d9a..f0695e026a 100644
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -126,10 +126,16 @@ static void set_oom_score_adj(pid_t pid, int value)
>
>   void tst_enable_oom_protection(pid_t pid)
>   {
> +	if (geteuid() != 0)
> +		return;
> +
>   	set_oom_score_adj(pid, -1000);
>   }
>
>   void tst_disable_oom_protection(pid_t pid)
>   {
> +	if (geteuid() != 0)
> +		return;
> +
>   	set_oom_score_adj(pid, 0);
>   }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
