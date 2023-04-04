Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37BEC7618D
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 03:15:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAA753CD05C
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 05:15:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55AB83CC8BF
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 05:14:59 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9D3E5600750
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 05:14:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1680578097; x=1712114097;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VOcCvXK8curRXELSkfOu8nan+GErNPTr0B1vtXl0aN8=;
 b=SDnLrUnCjTizF0xeHZKPS42irXu5ZMjpUFD00in6sioEKGrYYUw89pMe
 Dv68b1mhvd1j5rA3iKb99mbDyGuemwJRfejVWroB8l7zFFsyKXREMeVXo
 S+/VKxic2BWE3pbyDkT6ijjKgVIIwhq+To30lgx0yJNpEQaGBYrzHzDB2
 uLrJqmhBzMH4r6kyWkF+fg7xjvYd9WOvgFVNCs/FJPgvz2jCZZ1wfABva
 MXkTHR7qbx4Ar3a/m6/f1gKnTmgg4miDDPDnNpJKuyUzRDU/joigYRXqW
 k2vxJGUwAiUkdQV6KS6rjZYNXfqL76uEysth+oOr5oSnIOY3h0zzFOjAH Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="88792397"
X-IronPort-AV: E=Sophos;i="5.98,274,1673881200"; d="scan'208";a="88792397"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2023 12:14:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StF+3K+OrgaUcS17RW/2hVO5YUicbx4Z5UBCBU8Ich+Z9Xk7vmr/o1QOY3aZ7+guvVegsUKf/EVZd5Y274wWqn959iErfdDtfLSkDWNMmtoOJWPCTXOG5w7Abi0nvPkGS8vYPiEGUEDPvVlsARfAQVrdY7lftTL+cGho9jTJHMBhe3xPbsR/79F6BRkreh+ZdtmW+g35YCS2NzlZrQwCb40dBAA9/KC0tVdNlSHrwMn8G6+0xP8Y4AcVNGsgW5yXcMhQ71Z5DlOQPfYV1u1vuc0tQhqzCpUUxNBjX976FT0lu0gq+Q6ELJoZylkuoYWbuUuPCH4JlzwU2jl22EcW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOcCvXK8curRXELSkfOu8nan+GErNPTr0B1vtXl0aN8=;
 b=N6q6HFpH3Gs3XAIF52hEddAO5lQS0c213BmjQnRK3EmUrU12K7Cam3XXqJ8ITko8BlxU2aHaRs97r43pQPjFXFGYpFAym0YokZnI5soLS2b4EWED0Lngu7b+nLi0HV7KjF6rc2LFq7ZYAxQ1dDqux1mjWRmrz7TprbOr+vVYnpOY0ZEgzYp3qzcSwKDkMsV8lCqpMLOxjabO4NZrn8uzNMWXpBfys2khp84ONDs8OlstAC2eQvfhWZr0htoJO/3/6gbN/iziibV1WupUMfhgCW0QLeR+y6N8+6QsqPoZXQGKoMIMu2Oq08GIOxaFV8QlXuBPAw/JGTBTyk+eaaq41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYCPR01MB10975.jpnprd01.prod.outlook.com (2603:1096:400:3a4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 03:14:53 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 03:14:53 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [PATCH v2 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on blockdev
Thread-Index: AQHZZhloe8rglxD/KkaPeTX+a7XtMq8Z0JAAgACqeoA=
Date: Tue, 4 Apr 2023 03:14:53 +0000
Message-ID: <7305b239-ec4f-acc3-9a85-35c0989cb28c@fujitsu.com>
References: <7f06d661-cb57-cb8b-481b-cafafa92009b@fujitsu.com>
 <1680518676-2863-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680518676-2863-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZCsHKmFrUdBw3xEw@gmail.com>
In-Reply-To: <ZCsHKmFrUdBw3xEw@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYCPR01MB10975:EE_
x-ms-office365-filtering-correlation-id: 7eb7c4e6-e27a-4b84-5b91-08db34bac274
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7FJqysGkT6NkgUn5oI0qPvXmVRxxaiF43CiRL78lX7JrFEg5MwjpJN8SNCt5N3LS9Z/wuHPpHqmvmDN9mMrhf4oeCu2PO1qVbPtnyqiNd+qR9fSlu8EDc163W2M+Aj+qbeXQWaYt/gZYgeD7D/l4GVbPokdIDsdVDvEAfA5S0lXTEfgIihP+Vur0OLEj/7JE/gh7zGa9PQIE1mNKldNPYUUI0vwvrNhe5QhGVTmhSa6eBGse+rwMuIlzRgsC1NTOYX/i0ULEZuX9/xsNjFfyG5unnMChvlBkFF5NAVdjKyKwbUyw6odcuoZZBtyaKJ63OWhOtlqPoW92s4w/tn6LVcspQSg2uecLNwyhy9GiqJWEoyly3ieM+otCMH/3ZHJPw4423P0l2oGqnien0ACH44l0wZfz/sgt2B0XWmVisrILMOzrM5gxtBeG3+p0Pldj1QW/4RwQFoseVP6+bXLwM3QGE4WcfBY9JRevSyRB8MuOZ1isuqLc3zOtM2cGHRVslA9uQZxbbtlkKJcOtau4bP8RycRbpohJQADFd1josimYy4REqifgmvPV+ck9kpb1ZadIxmnScZQ7/PKz7SbibBw/NBm8JtPhH+JE7G9TPqt5fEoiaGAlzaM7MaFHLX0sfUypwZx9hftAiV757X4se5xUnq0UpHf+mivXN28OV1wEy6AOs441E8KOCAJXSYm8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199021)(1590799018)(66946007)(6512007)(26005)(6506007)(6486002)(83380400001)(2616005)(122000001)(66556008)(66476007)(66446008)(38100700002)(41300700001)(71200400001)(31686004)(186003)(316002)(478600001)(1580799015)(2906002)(31696002)(86362001)(4744005)(91956017)(64756008)(76116006)(6916009)(8676002)(4326008)(82960400001)(5660300002)(85182001)(38070700005)(36756003)(8936002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2g5MEVMS0tBd3JGN3pnLy93Mm1rZXlEditYQTE2aEcvTW9wK0tYckx4Nm1H?=
 =?utf-8?B?N0NGSTJtOHkxbVgzb21xclFVaHJ3dkV1ZWtmY01PT1hZbStKMXcwekhBelhJ?=
 =?utf-8?B?eVBIaFBVdlRGNWovNTBrd1h3R1RNS1ZhVFIwNVA5R2tsSzFzU0lVbktDS050?=
 =?utf-8?B?V3FhMzUzZ2dFTm9mTms5dUEwT3RLVjRPUUVtRjQ0MU52aFVBUGZkWm5nZXpC?=
 =?utf-8?B?OFEwVmhTQ0RQS05JSWd1ckVnQi8wMjFoLzJqK091d3AyVDB5bVZ4NDUyRVFl?=
 =?utf-8?B?SXlqQkJ4YW0yek40RGRMTk1yd2VEOTArYXNYMm03dW1JNUw4ZXFmck4ybEps?=
 =?utf-8?B?VkNEaEplSFMwL08rWm94T1JvTk1PdzRCNzhLejdKM09PMzZGVjNITlgwbGlx?=
 =?utf-8?B?Vjd6dldKNlBMNlpmdElPK2k3QzVTelBxdzhDRldoNUhQTmt4TUxOUUFqS0I2?=
 =?utf-8?B?a0R6OGduQnhYQ0JWLzk1L3kzV1liMUNLQnpQOThLOWJ5c1dDcVdkek5UWDZo?=
 =?utf-8?B?Q3JQU3pDR3RKOEdTa090Z1VQWG9YYWR1QVduRzhVK1pjVzMzdmRpVDljeDB3?=
 =?utf-8?B?UkNSUEdMV1RzUHpiM3puZEJSeWZPbzlwSDY0Y2U5LzFzcHQ2UitJMS93SHJq?=
 =?utf-8?B?RXEyODJCeU11VTZJdXFTY0d3cHpIbURlNy9NcjAyNlB6bHlJQTBHM0ovajB6?=
 =?utf-8?B?L1BCTWMrT3NsYnQvUjcvSmY2ejVGcDA4dmpCbU5HcFlKeVVWK0FNOTBQL2Vr?=
 =?utf-8?B?UkVRWnlqaVpDalFJT2pwQ05JZUxOYmFabm9ndW5UM0RQTmJpeHhyYXRnVFV0?=
 =?utf-8?B?V1p1U1IvU1pNTUdMbGxLeHZJVXMwR0ZpOS9oSmpNeUYzWndIMlJQN2xnVWxR?=
 =?utf-8?B?R0NhZktKL0hJb0trblZjc3lqdGZQZ1VIc3JCRFpCcU05U2RiaXYyeDhKblJ4?=
 =?utf-8?B?REpuM0pJandKYWZhZDJaYTdmc1BXQXJjeGwyVk1aZXBuMzFiWlZrN0tJcUtz?=
 =?utf-8?B?WlpQSmxDRUQ2VXh1cU9qRWx1UzdJY2g3akx5N0IwK1RFUjRDSHVUV0JxOFlH?=
 =?utf-8?B?ZjgvU3ZJQXd3dWJ1aEYwOTZnR1I5WStoL3FDYzVhY0dXUS9nZ0Q2YkZaSmFV?=
 =?utf-8?B?NndoVFBwTFRnMnVXRFhjTEdEa3JBOVgyWWRTWDdHSSs0SUR2dDZ6dENHaUJu?=
 =?utf-8?B?TisySmpwOUUwOWxnM25teUo2aG1ORGZ0MGNNcDZxUDZwTENkQlhjSmF0d3Fn?=
 =?utf-8?B?eERUV3NFZVExYXhISkY5MmRNUjRmc1hiUm1KU2hQQU9UUXJ5WlhkWTdsdXky?=
 =?utf-8?B?bU84dGRXOXJ4cEFyUjN3SWRzQlZyNEQ5QlJlSVZVemlaeVRXQ2hNWmZOR1Zy?=
 =?utf-8?B?N0U5MWJJQUlZRWNQZTJ0K1E0bDFiWFNlVlhCcGI1elppT1B3U1RRMkNUZUNQ?=
 =?utf-8?B?czdPbzdFNFVxdmNacTNLOHM3M3N3T2d1dURqd2E3N2M1RXBwL3dKaGdodkZ1?=
 =?utf-8?B?VncxTWt0REg4a2VHdVd4NG90b3VFa0V0ZDhhamNjcTlWeUV0SzNFQXlJMVBi?=
 =?utf-8?B?UVJtYVh2SGtqUGlFVVNhQVFvb1RVbmdGbmZhcnNNNHhrOFFkWW9yS0k4Unpa?=
 =?utf-8?B?Y3BXdEtYYU9OUGdaT3RYSHdlNGFNaFk5Z1VkUVIrS0tLVEwxVzE0LzZ3SGp6?=
 =?utf-8?B?Vkh0MGk2c2ZwTUw2ckdteFhPdE52UEdQU21qNXdDZ2YrSDJxNEQxQjA1eTYv?=
 =?utf-8?B?ZmtMZlJsQVdNTnh5OFRqUzZHS1NQMU9FWlJrajFvdUJ4OXVXSENqR1QyY2Qy?=
 =?utf-8?B?WndRb29HNG02bnNUSVZLZVVvSWtmZFgvdFZGT2xGMGtuVHpYWjBaT0g3eWFL?=
 =?utf-8?B?eFV3UkEwbDROZFhIZG4zMkJqcG45ZS9wb0s0dE1PV1NNVUl2RGpJeHVXaWwy?=
 =?utf-8?B?eU10ZTNHOWZlWlVoQmxqUDdPYTVlVHlaOFRjMDU2U3QydnpsTkVDQ2lJTmcx?=
 =?utf-8?B?LzVzU05vVEIxZmRPeWhIdEJUNnIzRHluamQ5Q2ozOEZaUnBYSjFIOE9kUmlu?=
 =?utf-8?B?RC84TlRRN0w3R1Q5WDNRM3RXbEM2T2NNdUVNZEh6WHFEa0N3b0s2SGNMVC93?=
 =?utf-8?B?OERjRnRGd3o5ejM5eG1vTHBGdmhTb2IyTEpLbEM2YWYyUkIrTkF2d1hkdlpB?=
 =?utf-8?B?YVE9PQ==?=
Content-ID: <2EB7131769E87E48976A31B0B74ACE5D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 37aIl0677lCJ0WIjJ7PYKHV0qZWeo0ziT65SJyODJbpB2qhEXvBK4/cJoQwVfOeuYXKm4sq0H/WwcF8XzlIpRrnLSxsLl2cFqks7unYV93J+N3lfoBvaxSB/OKsD/nKIa/lDJYBg4l6CgmlpCwpsCUb7Npl5cd7wI610kwAUvsGF/uMiQkvEnQpwRkywBkXx/cmTkUYnJ0dx4B+xLDKbxwRWzA6e9bhQGRGNIg+BqZLitSCP6z8+KEtgwXVq/KjkG+HZLEuT8zF+u6hSp48IOxutK6nFOgnPWNYe2MBsEccZzqr1a03ldm22eROsrxN9nwgaIN439DX3+KnQnmlG6WK6uBJKiVw/CCvk7nvDnlsuBC7cXhoVT+Ys5feSPmResOCPJMeuaPL1Onz90+32AZtgKD5WkxcXTfKbXBAUH5V+dJMczM8ffwCokeArF4e1MW8z7/pTn7Qg0r7QOK5B4ggi1A+zNQJjkLB7GvV6IiHNyEFBT+spIncMDCsOFGzDCW4+NsoK1K5myoGszl1ULINnczwBDbg2AS4QLfAVM9SVkdVCj/AvXY0bxoujyWk6Ou9hARvHOYD4xVLLrMzAfKP5SCzXXpEIUprDDc768NmMPYxJ4KJjxq5B0BTN1+J1UI3iDrX1xc9oy7IpoyMKn6Rh3MThk+p+nrJxFF3hwqn7OAblKJfJgNQzcNpcvAgSUX3tuUOUULZ+JhAzj+Ck4jdm7kcQ0XQVKOBYp9qVX5K63nPFfRsFv48rTcXMpEoS1zf5hWuSXvYVoqMSYc82uqLIgAYHipzV3YJQNk/yS/s=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb7c4e6-e27a-4b84-5b91-08db34bac274
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 03:14:53.3959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qkDPZ8eclxvhi6B7LpgvWVNV/KEwK3xflcnwEI8A9fEiD8P0z14P/OWCQ4TgZIfrzFUmhO4V9bB2uuUPv3bfVyGzndISpyHW4HWUIjgaVPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10975
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on blockdev
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



on 2023/04/04 1:04, Eric Biggers wrote:
> This test is tightly coupled to the kernel's current DIO restrictions on block
> devices.  These changed in v6.0, and they are subject to further change in the
> future.
> 
> I guess that is fine for now because STATX_DIOALIGN is only in v6.1 and later
> anyway.  But, please leave a super clear comment that documents the assumptions
> this test is making.

OK. Will add a clear comment in v3.

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
