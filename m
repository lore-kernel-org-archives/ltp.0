Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF4DC6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 07:46:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B41903CAAF5
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 09:46:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2EDF3CA9FE
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 09:46:21 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 196161000D37
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 09:46:17 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 28D7k7Aa040624;
 Tue, 13 Sep 2022 15:46:07 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from ATCPCS31.andestech.com (10.0.1.89) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 13 Sep 2022
 15:46:08 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (104.47.26.44) by
 mail.andestech.com (10.0.1.89) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Tue, 13 Sep 2022 15:46:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBOI9unr2mMU5qHwJg+8VIR7gs5EIMD+zgQ9Va7T3k3u/49x80+4ac420Rohkwpk/rsjjOavmpeoBhTm5xcJu2FOTa+SezSecgiP8qfcMDTEliRgFdf4SCR+ocMU79wQul5IOVFkQP/UnJ1rChGiqDo0+0g5JriqcgLMqZlZVuP3AK20bHQmkR18p7Lx9ZHHXZ5L30mvkN69GPo+mrar1EBj1MHKPfc5jIHJ8wbD3Zk+QxkyIJu9CQnNLUoTABHNiFSn4XAtMsXxaI4VAZnKzA7UkRnhCkX1tL/c3BaDW2LrNh9A2Is348XTB7d5wOWpxcrLHXQa2V8AqZ1tIq3vUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctpnsB5J7+Ge1P73jXfhGySHVnGH2w/YVo2tn/8kFqs=;
 b=EophvANhtybxryiY3E9n2SOFk9fg8Pg9M6irnzh84rgo0KbubiFaZpirGkF9din3I4zVR9GYnoi2Mpz9FZW8mw7Ck8COHfFD4xJoGj7eGxajV4xSNbAeNUa9KKgda2LsXDyj4VVrNNdMfxcPnEu5cO7uwIZCyCGhQtOvxACK5QyPZmG4vZuJt40MiEonoaESt7+d9tphN+ieB45igpNLM2bCFDIajULnzJ6J5Zbodku2qJRVM4jyj77oXxVkv/KXPqqNLSYZpvwbJ1H3N6nevIkDs/+WR0jsGEt9a+29yf/wsnr59xuTp/B+IObB2towjkatW6jfp+7ecI4mIezG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
Received: from SG2PR03MB4120.apcprd03.prod.outlook.com (2603:1096:4:3c::16) by
 HK0PR03MB5122.apcprd03.prod.outlook.com (2603:1096:203:be::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12; Tue, 13 Sep 2022 07:46:02 +0000
Received: from SG2PR03MB4120.apcprd03.prod.outlook.com
 ([fe80::259b:f8eb:cc43:6e06]) by SG2PR03MB4120.apcprd03.prod.outlook.com
 ([fe80::259b:f8eb:cc43:6e06%6]) with mapi id 15.20.5632.012; Tue, 13 Sep 2022
 07:46:01 +0000
From: =?utf-8?B?UmFuZG9scGggU2hlbmctS2FpIExpbijmnpfogZblh7Ep?=
 <randolph@andestech.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls: Fix tst_res() format string for 64-bit
 offset
Thread-Index: AQHYwnwgtS336JxmN0aqzT7gZ35zpq3bldkAgAEjp7A=
Date: Tue, 13 Sep 2022 07:46:01 +0000
Message-ID: <SG2PR03MB412066513D7DA6F4D3332DE9D0479@SG2PR03MB4120.apcprd03.prod.outlook.com>
References: <20220907053841.7923-1-randolph@andestech.com>
 <Yx8Bbu2Zaosb6y7f@yuki>
In-Reply-To: <Yx8Bbu2Zaosb6y7f@yuki>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB4120:EE_|HK0PR03MB5122:EE_
x-ms-office365-filtering-correlation-id: 49d87871-b16e-4b09-5c70-08da955c0137
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TiGx35zDmGz+70lVzIt4iV3g5FYBwXU8vnYmso0KsjRxBjE0VohUv/TZzhR+ThyVxm0KtoN32aEwULc6YfGm/aGnkJTfyu42yer4ArL+ZdHKUxV1OwqB7EG8bctv9N/OBQJXVhI0QG2k22MHo7m+Pb3h4PoI4jX+gPzfYjUY4aROv+MZlctsyZKb3KiSir4r9rwog9NzCnfb8IkYZ76Qw+E7yLNFE9f0vQwhGuLa7GqMWHqinZYHM/Lckc7j02FsbUnp9rb+ztrtjxPaW1kjvJUOo3APB8ky4GbX34gakk5KR8uucTPsJD4eQ5vhfLTk4QkGHy9pMqkAxVhzuP5jNahpdLRPJsTuFdICLJiB/xazcpE92sROz27q4hiszwY56NXbStdiq8rrxh+kRzUOyA5S2XxAoh1QHl0o6qacDcFpKEhR/p1nr81gj7hESkbS7RsgI5eDntsJlTK7FiMsbCVnktqfM4NEb0hbuWFgyF1WgaefkqouR8U70muR5pfByGQuSXuGntY/SUKwQgRTQGpOanKohlGeXzXnlL3TKDuTZpjGLN7OIfuZWJRvJFLnipJuq+66vI/CGUrUbx+pUa81HPhO76ha2AAgMmylN/5vObiR6RhRl1XIMR7ES+nLINJ44RMr4FKfjaWQCu2E4kbFYExpE3Tc+StjBDuEjRkBDITNVxJYBnkaAZ6bMyHN70M13Mde+N4UQ2t98sMEW4hp16UedtCmB4pZI8fzDs6PR9fvie4ozjM4mcDtbGomqz4jHgezG3wQ1pvQ3P4TZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR03MB4120.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39840400004)(396003)(366004)(346002)(451199015)(478600001)(33656002)(8936002)(186003)(41300700001)(71200400001)(6506007)(2906002)(26005)(7696005)(107886003)(54906003)(9686003)(316002)(38100700002)(6916009)(122000001)(38070700005)(5660300002)(52536014)(83380400001)(66946007)(4326008)(76116006)(55016003)(66556008)(86362001)(64756008)(66476007)(66446008)(8676002)(85182001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emVva3BFTCtLV1JneklVQ2NLV3p6MDRHa0RTSml0Q3BIeFVtTXBybThMQ1Mz?=
 =?utf-8?B?aFNjY09lQ3d3bVlkVVdNSy9yZzl1R2l4MWRQQ3lBd1c2Q1BFTXpBTzFkbFZL?=
 =?utf-8?B?SUZrWVhQTnlNcnhaeXdlNk9nRzduVC9vQ2VrL1VJeUJpRVVpaWVDQTU4bElr?=
 =?utf-8?B?NTkrMnZsbHJCeW5TcEpBckpjMXlHZEIveENVM1ZRY1hvMUJ4amhFMk4va045?=
 =?utf-8?B?amhoNVowT3RmTVpJdHpmMG9oc29raUd2ZE04WkYrZmNQUU9VVWQzWXBZVkU3?=
 =?utf-8?B?UFRJVmtUd1pldlhUd3lVdHNRbzdhaVBRcGxxV1Y5MmhDVWpHQTMxckpmcEdh?=
 =?utf-8?B?Q1N5Sk4yK1lFUWxLSjlieC9SVW10N3d3UXczVEwyNkZWelBRZTVRRlpUcDB1?=
 =?utf-8?B?OE41bU9LT29tMmQra24vTS9mT203bFg1aXRWeFBhL1dIa2xla1lKMkRGZDJo?=
 =?utf-8?B?a2RvOGVhb3JtKy9ockpreUdhU01waW9WMU05MitNWjd1MExlcFNsbE9MampJ?=
 =?utf-8?B?SWhod0VVanVQYlFDWmxuWnBPYVBid3VtenByWWp6MGNhZXlBak1HZkhVRmtR?=
 =?utf-8?B?dlZkZ2hnaWM2ekNkazNOaG42TXI1UEZtVUpzTG13VjY0TCtzbWwrZk16ZlVM?=
 =?utf-8?B?bFcwYjNLYlRVMVFUTkwxc21OanVMMUJhK2xFYUEwZGJhWW04dGhWcGg3VEVj?=
 =?utf-8?B?RFJveHFob0xkWHBucjMwQXdnNzhDUXJnZkI5Y2p0NkUzcjBHaGRiRkFJTnNH?=
 =?utf-8?B?WWhRSzhIS0c2VjZacTFxT3VQTHZKWmFETjBhd2lHMlMrZk9uQVBheURFb2VO?=
 =?utf-8?B?RHJWNW5rbHZnNjV0ajF4ZlovZndmSGNROEdIS0wrZVQ1OC9obVpzYlZiZ1Ew?=
 =?utf-8?B?bFJEY202dTlIKzQ0TllxdmRTTENHVTRqdTBBejB2YkRXMmQ0V25BRHRidUp6?=
 =?utf-8?B?OTZaSUJUNUlETHA4dW4wbEVRL2loQm1zazZvUTBaZTJMMzlNNGhRejBqV04w?=
 =?utf-8?B?TTVhbFlFNm1TRmdyMGFpUkdpNTZ2RGw1UzJveUxDTzROeitwb3piM1IzSUVj?=
 =?utf-8?B?Sis4WkFHYzJFM0RzdlYwNUlCcjArTkVIV1RXS0w5eU5oUnJuRmRSS3JTRlMw?=
 =?utf-8?B?Y3pUcEdOQUlqQXpFMVN3YVR1YXFvVjRnRGpxL3NIK1ZRb0RzdmZaZ1hWUjhz?=
 =?utf-8?B?SjFMK2NJaHluaTFzTXR1cjVaeDBaQ3BGb1FlYUxzVGVoWTA2b3hSeFphRTB0?=
 =?utf-8?B?cEZiM2hxNmdYNXg1NFRVSE14ZWF6YXJ0cVZnaFhQZW5oSmlZWTdBcVcrYUN4?=
 =?utf-8?B?QU1rYUtXZjVmUm04aEdxeElTei9CSGhZNXZlTVNOYjNSQlJUOXZtTktsdSto?=
 =?utf-8?B?VENwbldjSE1oM20zM3hycGNXS0N0bW4zWHd3QXd4bjN4L081cXBlVGI0a2JY?=
 =?utf-8?B?MEhJQ3R3Q3dQa21xYTVEd1lucEpNSkNkdjRZSHlENmZOM0hMdlVhcHJ1dWRT?=
 =?utf-8?B?NXpyQlNEKzBLaUREaE9TcWs5NUZoYzhuVktzWGMvdmY4TllnSUlUSjM3d21M?=
 =?utf-8?B?TmppVjBnSWNMdUR5U2RWVW5CaDJwUUs2UWE4Q0VyOFl5K2MrdGo4ZkxFSlBk?=
 =?utf-8?B?MEVjTVFBSERKZytmL0JwSHBBcHU3dFBqOEpIR2VmM3VVM2hSZDBhSG9tQ2l0?=
 =?utf-8?B?MTY3cDgxOFR4N2VIcXB0VUdWSGdyMCs0UnprSDBBdHBYNEZTUVVxYTZla1Rk?=
 =?utf-8?B?SWNBNFBCbFBGTWM0YTZTWG05SVlqSnZVdEprTXhRTDVtczRRcjY4MXhLU3RL?=
 =?utf-8?B?eDl3eHJsNWFTeWRFdE0vUTJzOGZGTm05YWNqNTRmeE8vb084RWdnQldBRmQ5?=
 =?utf-8?B?MVFsTHRNTUJkUEVPSVFXaVFDaXFSdGYxb0dLN2tZWCtnSDlrTGRKTDJOeHRF?=
 =?utf-8?B?cnBQeVlSbUxiK0wvc1E5SXNzaVNYZk85ZHVhQ09zdC9TSkdiR29pUC9OUjJy?=
 =?utf-8?B?UStrdkRSZ01JaXdmK0dZZ2VOV0ZsdmNQN0xYMTZFZXRrWmc3R01rL3hSVmdp?=
 =?utf-8?B?WXVTYUozSzc2R3VDdWV5Z0ZuSlpCRWErWFVrR215YURUc2t5b3FiTU9STm54?=
 =?utf-8?Q?qW90f0tLEY4yN2eMTUUoHPQce?=
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB5122
X-OriginatorOrg: andestech.com
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 28D7k7Aa040624
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: Fix tst_res() format string for 64-bit
 offset
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
Cc: =?utf-8?B?TWluYSBIdWktTWluIENob3Uo5ZGo5oWn5pWPKQ==?=
 <minachou@andestech.com>,
 =?utf-8?B?QWxhbiBRdWV5LUxpYW5nIEthbyjpq5jprYHoia8p?= <alankao@andestech.com>,
 "kester.tw@gmail.com" <kester.tw@gmail.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril Hrubis,
  Thanks for your suggestion.
We will follow your comment to do the cast for off_t, and test on 64/32bit system.
After test pass, we will send patch v2.

Randolph
Sincerely

> Hi!
> > When compiling as 32-bit with _FILE_OFFSET_BITS=64, the format string
> > needs to be specified as 64-bit long (%lld).
> > Fix format string for type block_size.
>
> This change introduces warnings on 64bit platform instead.
> Unfortunatelly unlike the size_t and ssize_t which can be printed with
> %zu and %zi there is no such thing for off_t. So the only way how to
> actually print off_t correctly is to cast it to (long long int) in
> addintion to changing the format string to %lli or %lld.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
CONFIDENTIALITY NOTICE:

This e-mail (and its attachments) may contain confidential and legally privileged information or information protected from disclosure. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the information contained herein is strictly prohibited. In this case, please immediately notify the sender by return e-mail, delete the message (and any accompanying documents) and destroy all printed hard copies. Thank you for your cooperation.

Copyright ANDES TECHNOLOGY CORPORATION - All Rights Reserved.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
