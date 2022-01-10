Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEB8C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 10:09:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B0B73C937F
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 11:09:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 755163C90B7
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 11:09:30 +0100 (CET)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD680200E0B
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 11:09:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641809370; x=1673345370;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=WD67AA88ajXfA7mTgdwl9sVQpHJiuy+1vmWnNmB5Ckk=;
 b=zM5TGHEuG6j338zNDxZ5IKbldja0sCCsu+dtExXFmJe94Qdgpyi0KHGD
 B94hSot/I1GtQ4RN6CuX0i9LDimtNmTeDJ6kmSggJYefQDGVr/H4sOfWG
 dg2E9ewcZhpFid9dutHgcW2f9klFuFPIUAD6RV34RQ8TaxVJtAuvmkTsn
 Q51+6NxH+KKQ4RIxkWAwxZ6SNhUtX35v4/NqYnewXU54J+8TiJ19qs1Wu
 /DaKNsMdfdHELbWLk4Q8b4N+im8je5pW2vI9G2rybfcOcHB5pVUJzDzqY
 w6PPEAGwoMDoGJ6L+GvJhDbblIw61uGr2efKf8lm6jg03kkzucqIKSRVk Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="46973080"
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000"; d="scan'208";a="46973080"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2022 19:09:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRveLYbqBP44Lahgp/dpy4+PXCc/FOFDPfA36g9ETzEx6+Qj3X7loTBFT1e4Munvh1in9jtMZ4ZRpeKiwH4U63lNLXsaIebhHcL1e4LPEp1RsL6QT3Tfr8SqmFHbVtMsgrk7Q0atNqcKVNL8SDP2wHKM09rZTb6Cw4K5J60zXtHkfxIg9LODbFhK29wovK2Nz5gmoe5WhSDpJ36pLC3MkNUWpRygN69dMTO4wiW5dRo7TYrxiDgFpd+KgYTyOPWH5Nf2ESRImPbfVSNmih19dSF6FwWuIyXVqu37oPy4abZDQgAoNJL6wOq4VyOVQCNMXFMXqJbxKnd0pJMeF/cCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WD67AA88ajXfA7mTgdwl9sVQpHJiuy+1vmWnNmB5Ckk=;
 b=AkERZq7Ov5T/PiQ0k7vxuRIJQY5dIcNkwk42mDVzxFKC4eVd6U0o/Go78ywqACgq+nCofaxAahG2vKhl2E70m9HhYi1PRFzKIZnCKYrIkqgP2XTEviu3MnTrc3E1IH1BoQOwRYvMmz96/4az3GLRaPkmF1x+AB/r4sbL6X8uqX64EsGa+zuqes7yaPYQjxps1JBNs88uErAJeDXwMRdtdoW+qROQFnd4CXMVkrO991Qr4xWtuAf99PIQ4O07PYkVTqkPAj9bHDfMoOrYpc4dT3Uu5+jjysoGYmQOyNzQuQQvIN1iujxdmVPYOU23F0gSMbTwiaVGxtYmRqA7GOzlSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WD67AA88ajXfA7mTgdwl9sVQpHJiuy+1vmWnNmB5Ckk=;
 b=hQlw03K17lMcSFuWI9B1Czqw0pwQMw7OKVidhrBk+aV9RGNhOsOe9kCx5wO4UI7y8f5xw8lPzOjcKDCa2Cc0zw0DP0lXWCZDlUEQzyJoCQVS9QVZqG1YYbpwMzS+VLDNuFb4/lUghTaAQXB8UytgvLEtYGZOIZG7oUFzSgVZn8g=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3115.jpnprd01.prod.outlook.com (2603:1096:404:6f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 10:09:20 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 10:09:20 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v4 4/6] syscalls/quotactl04: Add quotactl_fd test
 variant
Thread-Index: AQHX7/LUOGeBchDySkKhRFHMNari8qxX2IYAgARcEIA=
Date: Mon, 10 Jan 2022 10:09:20 +0000
Message-ID: <61DC05FF.6090800@fujitsu.com>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639380414-24390-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ydhdxhc+/tsHXH9M@yuki>
In-Reply-To: <Ydhdxhc+/tsHXH9M@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5fdcbdf-8c22-42c0-f869-08d9d42144ea
x-ms-traffictypediagnostic: TY2PR01MB3115:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3115915424A9955BBE5683F8FD509@TY2PR01MB3115.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BJy53WJW8oAlWUG1rfkfOz9BBs+qufiToPjxqZJvNlwUwqd9TkvRBv/7xtnvlrq39yTWuKgdvYNWIlvBseMsbpsc5oJZ5m1hNagCDPvRQUcaeKWKLOFqn30A0Wgf81s+qy5f4st3kEdoaQVaf/kIOVKRe+ZONmwkswJTxMVHMUZ5lOUCdHuhacTGQ/7Iq0vpZdtJx81P4vqhH/KrDgaqJc+LcSSf7Gj8LOfaQtJxUoVV7R0BfXW5vrexkzNXa7pJTma4F1hEnFft/puI7PQeLYcP4bdHi839mxgfTD5rcxQgO9w7oAr86uhS6c6v2G7LXhRJcMx5Rbr++/i3k2BezdLwGe8XmjmMNs3u9u+ILpLJwNO8JNrZTLns2/HLxodxhYXVVsW2GA2FxtvlvOKaFudR3SwVMXd7K86iQoZ5pNs9k/tdmTSVA1ztTv17eP0XOjN0nUsBI5xsrbrlKDpN5jNdRXRewP9y1avDPnPhqeV+bBcxAhU7SKAMB/cHPZQGq+O2cCq7qeSlFmT2tfQjauVNvCM0q1K1TTAGwB+2cmLx62um8t6oDYEYA5zO6ETm4TIZd487byJ7qVQLl6qQnO9yCaqbv2Lzxavc9mZvT8j/w90aOfh7qpWlg48rOXYOul/LuVTwsOfDjN3R+IIgQpDw9M+/5spIbBeU0YWMoGiEer3780aWKAFAV6+LI2ZlRu6eBAYnu8bSKWpxXV0y5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(82960400001)(186003)(26005)(5660300002)(508600001)(6916009)(36756003)(558084003)(2616005)(86362001)(38070700005)(91956017)(76116006)(66946007)(66446008)(66476007)(64756008)(66556008)(71200400001)(8676002)(316002)(38100700002)(6512007)(6486002)(33656002)(87266011)(2906002)(4326008)(85182001)(8936002)(122000001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MDRLM1o0WU5JOWcxT2FGT1YwL2NLL1k0M25uOEd5eHB2QkxSeC9YaWo2ay9w?=
 =?gb2312?B?czJRdzBQWnorNTdjT2trRDIrN3AyWXc2Zk9xclpSdVNjZVlZM2VteWZIVFBm?=
 =?gb2312?B?VXFSbnhTcytWNldOWERaN3Rsa0VLWXg4R0h0VkxGMDRTemJPZ2lFa1lCbnNN?=
 =?gb2312?B?OEFSMUhmZFkwa0FSb0ZvQUFLRFZpNHYxNHZOaG5RdFNhbEFWMldQWUlURlI1?=
 =?gb2312?B?OThEdGhiOE1BRU1IQk1mc3oxOUZkYm00Qmkrb3VkRGwyZ2I0aHovQUw5YXRp?=
 =?gb2312?B?ZnV1VEMzL0VYV01oNFZOSkhLMWpzcnNibUpvWWpIVUF3UU1hWVVXejFLQTcy?=
 =?gb2312?B?RmNNSXhVYXJobWwwS3BKOVh2S1lPQXJzajViWHVUQWF5bVZqY1lPd3VXMm9K?=
 =?gb2312?B?VkxJeHVVdFpUaVM5VzJFMDdNa0NrM3VGb25PcDNjbnlyTVdzRUxkSE1FN3ZF?=
 =?gb2312?B?Y3RhbDlLcmRRN20zU1JqOU9SRzBBRnErSnlwTnFOaFBaTy8wb05sekN1MERa?=
 =?gb2312?B?V2wyL0xtWVN6dnBiWHc5MFlkY0xFeEpjeTRrQ0hZc2tWLzhOMVJOaWFhK2lD?=
 =?gb2312?B?V2sxZVphc05aVHp5NTBJdmp5WUJVTEdXeWZTZjZ4NHA0Szl6eUNnMFIxd0ps?=
 =?gb2312?B?RW9oRlNxVlJqME1RSHVwSE5iY2xHeFVRMWI4YmlvQWEySmZJZnNmcVpjb2wz?=
 =?gb2312?B?Q2xiSHpSU29aa0Y1ckEzK3piK3hvZXV0NFJOcmd1N204YkZCbDZyZHJQWWtv?=
 =?gb2312?B?SGExRlVveFRrZUJYcU1EZnBjMnp3NlhVbU5BUXFyeEpCVkRMZS9mR2pRdUoz?=
 =?gb2312?B?LzRieCt3d0Z0RGdiaXBPYTNsM1hUVHlzQ1hicjY0a1AwRGRWTXZVMVZMMFZV?=
 =?gb2312?B?b05wVitQYk92WlR2V1JhQ2daUEdBWTZBUjhlcWNjd1ovOGRBVE9IeHB5OWFV?=
 =?gb2312?B?aVJ1UWZVa3BnZVVNVk1FTGpING5KMTFzQjRCK2VPampaaGRvV0ZCN056RHkv?=
 =?gb2312?B?Z3psVnAvZ0loMTBJTis3YURvdjFHejNJckdJbVV1ejN3YitZREM1ZEVneHd4?=
 =?gb2312?B?ZWx4Sjc3Z3l5aHdQajhocC84VFA0WmtGTlo4Q2lrVCtPUlQ2RGt5MVVHQWdU?=
 =?gb2312?B?SHUvN1c1dUJRVDBQTThJS2ozdjdaNTZBTmJUVG1UeC81R2s4M1dzbnp5YXoy?=
 =?gb2312?B?eTVNakFuOVRoNE0xQWZCMVhQNHRBSVNGSUw4UU1ZWUd4OGRqMWtKTUp4ZEFj?=
 =?gb2312?B?SWpNWGI1RHRPSmtUbTVMc0s5L3RWQzZtblJCNEJTZFV5Y0kzSHB6UFB3VDFC?=
 =?gb2312?B?VTlsNkNOWlNCK0Y5YUFuSW9yTEhiWmZGSGF3NDNacjY3NWJpTUF1MFhZUjU2?=
 =?gb2312?B?UVFLdU5ucFFmUDd6OWFITHkwQlp6WnVrTDY2Vm5RRjgzZ09GZWdheFNRbHBa?=
 =?gb2312?B?OVJ4RTFWd054TmNLYUNuVkF3OVc2ejV1QXUwOFlXSVMxaGt6WjBXcVUrT2ZO?=
 =?gb2312?B?TjQrNlkxa0QrTEpORThaaHRObW9hVC9zbVZrMXZaQmd3YXVPMTE2am1QbFEv?=
 =?gb2312?B?QzZSSm5qV0JmdTdSMU4vKzhBRHJrcEhXazN5bzV0RjM1eGJjM2N6QmRjeU5z?=
 =?gb2312?B?UEFoRzhucFdOd1p5SmJmd2RoRGE2V05zR1luOVdxZGZ3dUsyVUh5bjloWE5q?=
 =?gb2312?B?a2l2RVFKbWl5d24rQkdEbjFCOFFVWTljY1FCWkRCVFNlSDIrZzNPR056ekFI?=
 =?gb2312?B?bG5td0FsU0pVaEd5YzNBK2FFR0w4VkFzRjUrSU9rT3BDV3ZFNkxRdGtpRCtl?=
 =?gb2312?B?a2VCUzJQbW5lek11aWRXa3hWSW1xaG10U01ULzVqdUVnUnM2dDlpbHBnN2ky?=
 =?gb2312?B?QWp2Wm1sc2g5UHRqTnNKMkpxT1pSRHd4cnVCWCtZSTJGWWpOZW5NUDhBMmpT?=
 =?gb2312?B?YXl3YUZZSkI5OUNWSktpT3BHMFg5SThJYkZPY3l3RVRSYm9BU1J5UnlOR2px?=
 =?gb2312?B?WmtRenBITDhUdTB1NlU4a3l4aGY1WmFLQ0RSSjZ4U1NwT0pkeCtEdWhmRFJZ?=
 =?gb2312?B?aWsrTmFnUjFndmdXZ3ZubUFSNEY4dGtrZjM0UXBSSGw3c1RqSXRoUWE0bVFE?=
 =?gb2312?B?KzVvK2NXbDdBODlqT3VkcDJHUGxXb1BPdTV5czJiZWFSY1ZaeDVySVlKcDE4?=
 =?gb2312?B?dCswWmY4QXBIY3NRUzJnQUQ1OXpWQ3ltcFpZTzBKa1V4dFBRZ3FraEM0Skdu?=
 =?gb2312?Q?lh+8Cb3rwFnjB9E0ekcGtbhgpFU62LOs7rfH0Bj/sQ=3D?=
Content-ID: <F1DDAB78C956FB4C84F9AB9D4785E362@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fdcbdf-8c22-42c0-f869-08d9d42144ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 10:09:20.4113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsujS4tbJ2ajB8ZDUWi508vIu9yd0fy0/+6qC74UZF2eGIFspSvyjwcQ2TP4oeGwLU0Fose8Dbe4dR5bM3aNhrpmEJ92vkShJvkMM9M0h0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3115
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/6] syscalls/quotactl04: Add quotactl_fd test
 variant
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
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
Thanks for your review, I have merged the first four patches.

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
