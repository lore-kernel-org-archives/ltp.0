Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BC1C433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 02:18:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 986403C9219
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 03:18:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F05B3C8B9B
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 03:18:27 +0100 (CET)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 819A0600713
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 03:18:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1640053106; x=1671589106;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FIp88LFYcWOyVKW/hKt4aUQifDyhcjdQBH9ullXv/nU=;
 b=WpopfPhkjw6uJmNlc7prKoPJxqQA1zaMIZS2zIRI0BraZqWFxUD/3lAN
 9T/IRMBJvUEo+ZyYP0Qg0nblc4hTrbzygVKPbY0efj1TQHS7yuGbQ5UiL
 lBkFC8FEAsY6ybXaxKeSM3YRymJnGgzteigUaJQyh3TUZMnzgMjFws/yx
 xfUARQBiyKBVgEfVOhznkA4Pya1uECBEVEOf+qEJsyDO/PzhjnNluYIlR
 RZQleVjocffHo9cM+mMrmbmpDKwlxGhRtwn1Dcqv1gjNHOVlwjH4aklTL
 Wk5cFFNljllIzgFudUx3VDTgpKtAaATmoYjyMy/09L8ZTwEOZW43SY3nf A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="46252793"
X-IronPort-AV: E=Sophos;i="5.88,222,1635174000"; d="scan'208";a="46252793"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2021 11:18:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iddw7lmaTdnZzy8OwRuDIBPvzfFwlGNxKaxaodmkamoohcNH9s3iAqLr5Nsb2oQb9scG6tbd928q3eLgHmYZ8QRL6VWoyI2iiecu6JIIcDhKCEhgI2fQQ61GVSyCCBLHZfv/WYq63/MDRdC+il5xbc7FH7fa2BlsDS7gVAWTJ1SmaOXpbAT594U6+Q7TnBde5aZd3T4lhDqXHgXhPO/EB7oQ1ZODct4S6YeErpiey86jMQOclgk+tLvLiaEI38h+IDYZj10xucQogrFvG+xAJq6p5sHF60MREFwfcrs9jruvtpvDVjI5fwb+6CVLchCiZKTe4lgS+yfWDKS4pSBHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIp88LFYcWOyVKW/hKt4aUQifDyhcjdQBH9ullXv/nU=;
 b=evHacYpPQvpYYPnj897WYlZoxHxdepI1hDMdJ8xq5VeDnoDoGzcvmcm4ZQV9hRtLkou3F5Gwip+pvTPt6/ROTxTZOg0xeZF7QSh4bjdCbi2T91/LaFz6535f4h+k6llloH+C0coA6KRfKCqCfWPYh7QQhECXcVIog9tSYKeT1DhbPWPQ/gJ311WVX9VdVkp/HNjqlILdhyz/BJO+OXNGC5+wDu9EAIypOVraNMoIckgsr97CoWlHXtb7MGVq5vhChSkMFpmbf5MLJRjWiYMt7+pm2wqB4bKWg6M+2Y0OpzUN3uv2AWILNl8dMS3y+kBXbw39EIzxX1FSND2adteHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIp88LFYcWOyVKW/hKt4aUQifDyhcjdQBH9ullXv/nU=;
 b=iu3JRHAcGsonGY44EVWlWVoQD4tbRN0fScu7jcQafFftyzkLqlkRSFRPpfk6Bla65RnhzKCzvaUaWfhsNt2W02yVJB04f8L3j5k0o9mn+EodzSFnDXwDFmzWLgBZSkmu1LuNuNukLLrjXPBDodGPpHCa4IKtCoyCsvYVMZt3ObA=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB2010.jpnprd01.prod.outlook.com (2603:1096:404:10::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 02:18:22 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%8]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 02:18:22 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v5 4/4] zram/zram01.sh: replacing data stored in
 this disk with allocated for this disk
Thread-Index: AQHX9W40nQa467DKIkaQve8+nb3fJaw7M6kAgAEDlgA=
Date: Tue, 21 Dec 2021 02:18:21 +0000
Message-ID: <61C1397A.1070904@fujitsu.com>
References: <1639983142-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639983142-2247-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <YcBfuCPg1ENZHvud@pevik>
In-Reply-To: <YcBfuCPg1ENZHvud@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3960168f-7dc5-473f-69cb-08d9c4282951
x-ms-traffictypediagnostic: TY2PR01MB2010:EE_
x-microsoft-antispam-prvs: <TY2PR01MB20100E09A0FF662E52D71733FD7C9@TY2PR01MB2010.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1jMKVG5wr7RuW9y5kNwCTCjmJYQt6LC6IBUrLXxluKq8jiHS1JsqVpeI8RXArrtxFxjhBtNrscYwda79VxTWTuhP0WNy80cn6UAn9zGSSTJ42mdHAuiAASnbHpjRL/cng9jm73dQR6YtmkqpZq13cEIhFyXPa17TMJtjNIAK9JQPtVW8OAnzId1hjt02JcElVBQZVC4IS66eIqeHqqfuYIV4Jf7p2PsQTABdbpwq5/bVhKFBLZLcSs3onYwZ+U2sDEY9ydOGPIcjc7fxwb39f7f5TuOmPBxTi5TyVO2fwqZAjhLRVgWRjg7PMxRCx2fNEKU7g7s3SsMN3LDWFVHs1rkznJyslw/XJQwHhmzgBbfF3dw0297shnrPGY0igJ0FTHdL1GAuUsZdhr3cJw5LVHASEI/n0hfR/qWa24r2YrHUWkX8AEZMt5BiayEDxUdKOj+/4LeCHw+3UG1FbfdABUuj8jdVwGrvWioZ55cvEYAXKS1EMBdaXF4kU//0HQOUQpq22m1mv9XT2oRRQ9gky0uw6iOmMc3L1oWCncbbN+xJf2lbVbKUQ/CCkjvXh5jmNcJE9pOigq+QIyEj9s+JdP0vahOXpY4ZHIrFRQ0+uZP0zDEukOqgTcnQMuDDW0xK0WyvKendcT6dz3zsBOLBQc1qxvyGiVJphA/Xw03HiyzS5Q/4jOKe5J/F37K1lk9kyMXC7pFM+sSvZJb3nzMBTZnWdZ6SGEViMtfloh0ZfLQ6MRU8hm3C3xFcSTdbn/5G6S5SGrRCh88rS5YpDF5c6M+Jms7A3TvHyXX2Gav4hpU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(6916009)(71200400001)(36756003)(2616005)(64756008)(186003)(26005)(87266011)(8676002)(2906002)(5660300002)(85182001)(82960400001)(40140700001)(33656002)(316002)(86362001)(122000001)(83380400001)(8936002)(38100700002)(66476007)(66946007)(966005)(91956017)(76116006)(66446008)(508600001)(38070700005)(6486002)(6512007)(4326008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eDNlQmVZY0EzOGhIemxBMDVpN1ZhdmFyWE8zdzlBTE9IcWlvdUhxZEErQnZB?=
 =?gb2312?B?dEl3Q3BIelVYQ2hzSWZzcEErbXo4ekt0aVhmejc5Yy9ldkJQUCtad1diT1Ny?=
 =?gb2312?B?KzRMZVc2dGhlL2ZWZ2llUCtLWHBsSmtvMzBCY3piS0dEMjJtWDloTlVFVEpB?=
 =?gb2312?B?UHZ2SHA5TVQzL09yZVdyWlYvWEUxM0h3NnJoZk8vd3o0b0tPenJtRDVueGN3?=
 =?gb2312?B?Yy9tYTh4aS9JVjhvNTBWUWxXa3doL25pRXRPdFNIN3pFWVhYZ0dGRVRBVXgr?=
 =?gb2312?B?aVFFOVRRWDdnQ1BaUGtqNEN0UXFsWmhYbGJscnBwcHg0RksyZ3BtNHQzVThn?=
 =?gb2312?B?Z0s0V2FZOU52c1hyOTFiNmRRZG9jbHhEMmp6c0h1cjRTVHBLSEFWNVg5bzBZ?=
 =?gb2312?B?ZnFZa1JUTW9MRFZSbS8yZTZpdW9HS3o5UEl5RnRWS1g4b05BWGIrZnBaYVkv?=
 =?gb2312?B?VXRjZ0VoU1JVSkFpQS8yT2wvYUUyWXFoL2JVbmw4WGozRUl6UVNlOU9aYVNH?=
 =?gb2312?B?YWdpR1dIWTN6QzhXKzExNnVXVHVWTUpPMWVOeVlvc1RXeTBJK1I4YVdnY2R0?=
 =?gb2312?B?c1ZxenJqM2U2Yk9IVTc5QWp5NTJ4TzZmVzQxY1pqSVNHVktPZnhTY2hkcVRN?=
 =?gb2312?B?ZHAwZnJ6bno5MEFIWVVKZVlZT0RQVkpYUTEvMmtBTjhtVG1weU1hU1FrU2Y1?=
 =?gb2312?B?Z0NBQ2pBd0haVjlWb2d2UEhQeDY2b1FjazExS2tvUVlCZ3l5aStSMnlpOTZY?=
 =?gb2312?B?bHJaZzFkRnhPeTc4NnE3LzZRNU9pcmFoNEsvcGMyaTRBa0wwMmt3YlAyMEFu?=
 =?gb2312?B?UFRBMGVEMkYvWUhoMHF0aTNORlIzTGFJRXpvOEk5NG9zc05oNlZMMkFCUm9r?=
 =?gb2312?B?WXVUZmI0TTU1N1R4M3VWWHFOMm9tZGsrT0c2OElNNmxQNE1GaXlVNDN0NklU?=
 =?gb2312?B?ejA1ZmxEY1FaMlpNMkJRbW9wcURqM01vd3VwWjBNbWFNOG1md3dOTXdiTUsw?=
 =?gb2312?B?NkEyMTVNQmZ2Mk15ZHR0QnMrL2lDUk5saTdZY0VBUlRCSlQxck1LZ0RDclJp?=
 =?gb2312?B?MW5kdGs2cjVaaWtZcWg0b2lMdXNNNmYxditQMzJwbmxDcmkwMzQweDhOVU1S?=
 =?gb2312?B?N3dwRU1uMkJSS3FFc1ZSUm1mbW5NMkh4Ky9ZNUV5OWlUbnBXV2Z2T0o2KzU1?=
 =?gb2312?B?K0N6OHdZanVTTVc3TlYzWGZUMWIrazJwU3V2eUk2ckkxV014dXBwSUxNUmNa?=
 =?gb2312?B?THhTcUtrSkxlSG1pVE00cVdqSjZYWFFLZFdKci9kYys4b2VJckpLRG15cEFH?=
 =?gb2312?B?V2lmT3A0WDErelZlbzZEdTZPV1BvZllYV1JQanRQd3EwUFd3K01PcllSQVFs?=
 =?gb2312?B?TVJTRXVOaDNiK1VIVHlPK0RFUjUxSXdHb0cvWlpjejI4MTU0RjNVK3h3OSty?=
 =?gb2312?B?R3Q1cEdiVVc2QTJJL0tkMnlaaE4zTjBCSkNpM1I5MzEvR2xZb3N6bjJod1lv?=
 =?gb2312?B?QytYRFVidGZvWmJmWmlLcGs4cE4yUnlZdXBISVhNbmtSUjAreTQzWjFFM3Jk?=
 =?gb2312?B?WEFvYXVTZW9Kd01HL0xkL2MyMjFxR2pCU0tXdmMzNENGS080Zmx2SnUwVjFM?=
 =?gb2312?B?U1EvV1ZVUm00eFgrQWdRRWJYUzZhU3h5T2FIVDFYcmpOVEl1Q3A3bkNDWE5X?=
 =?gb2312?B?ejhIUklaU3hCUW9ZdlppcGxCYVB0UDFrV1o3RXkzanBkcU5Lb25uV3F3bGhJ?=
 =?gb2312?B?WWRRZ2VqS2g0N3FCOStlQlpSWDhRMjVOU0NNR0xseG52Y2VIemdLOWVla3lq?=
 =?gb2312?B?QTZtdDY0SE9ESXMwd3RGQnFvM3B0TjlpZWFRdkNmd3BNTXJodm5ubjNaeDBw?=
 =?gb2312?B?OEZPRTZ2YlhJK3VWajJpNFkzWWozdkFOdE52UUdqOE5mU1I3NTNFTFUyOEpm?=
 =?gb2312?B?SW9NUTFUNTl0U0YraStXZkUzSzMrdFVLRlJHSmhscnJMbk9FVEx3S2dib215?=
 =?gb2312?B?OHQ3LzdhUisvRE01YmNMNDY3ek5BUUg1dGFzWEU0dHpvZ3g1NjVYVkJXdktj?=
 =?gb2312?B?R2pmNm5zbmowdng0NWdEUTBPTFJJYXloRENjbUFUeE5JNTU1djVpUVR4bE92?=
 =?gb2312?B?Y2VwOWQxblJ4ZFJxWW9YS2IvR1lNZm1RZFhrSW91Y1U4VC9ybXFhRm5qc093?=
 =?gb2312?B?bUxnMW43Z2tHWEdVdllnN2J1Rk5UVVJlOEY0RWQwc2VUVVFRUStKMWh1dGlu?=
 =?gb2312?Q?D1uxyeL4CKkT28NAGw66PMYuTuEVOLYU7F6FXA7ONM=3D?=
Content-ID: <04AA8E4F46936A45A5867DEF42A9BAFB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3960168f-7dc5-473f-69cb-08d9c4282951
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 02:18:22.0214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VtZnBURARG7p5pNRXnftXO0YHW/qXxjJwLm1YMyvpGrFX9JQnndXkjLQgUXo7HkTgsunY5oHmXLsq0yme95ebcI/hwEQT5gMtBxFtXaom3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2010
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/4] zram/zram01.sh: replacing data stored in
 this disk with allocated for this disk
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
>> Before ltp commit 4372f7a2156 ("Fix compression ratio calculation in zram01")[1], we
> nit: we can drop [1]
>> used free -m changes to calculate the compression ratio.
>
>> After the above patch, we used compr_data_size to calculate. kernel documentation[2] has
> nit: I'd add link to the doc also in this commit message.
I don't see the link on your ltp fork:
https://github.com/pevik/ltp/tree/yang_xu/zram-swap.v5.fixes

I have tried this branch and these change seems fine.

I guess I don't need to send a v6 patch and you can merge it directly(by 
removing [1][2] linke and adding fixes tag ). Is it right?

ps: I want to add a fixes tag for pointing to commit 4372f7a2156 ("Fix 
compression ratio calculation in zram01").

Best Regards
Yang Xu
>
> Kind regards,
> Petr
>
>> the following info:
>> orig_data_size: uncompressed size of data stored in this disk.
>> compr_data_size: compressed size of data stored in this disk
>> mem_used_total: the amount of memory allocated for this disk
>
>> We should calculate the compression ratio by used disk size divided into used mem size.
>> It can also avoid the situation that division by 0 as below:
>> zram01 7 TINFO: filling zram4 (it can take long time)
>> zram01 7 TPASS: zram4 was filled with '25568' KB
>> zram01 7 TINFO: compr_size 0
>>   /opt/ltp/testcases/bin/zram01.sh: line 131: 100 * 1024 * 25568 / 0: division by 0 (error token is "0")
>
>> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
