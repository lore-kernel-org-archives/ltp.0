Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF5FC433F5
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 13:13:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6125A3CAADC
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 15:13:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 983813C1DFB
 for <ltp@lists.linux.it>; Thu, 19 May 2022 15:13:07 +0200 (CEST)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BD103601595
 for <ltp@lists.linux.it>; Thu, 19 May 2022 15:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1652965985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pxD1sDq3tqkLD3JVqt2zXeZ3yPFcrbGKGfqXPIXi2EA=;
 b=MTFbuPJEpDoJon3dJPwaCYx5nCwM1DS1QJyb9kGgNCKrJQ8cMFOUc+57reBRTnvM1ULqWL
 zfWiwfIt/LYyfcXynX4qCc7ErqDxzD5wVfNuieIZCeu+1VGIXCq2LohzOhaAowbJqK49Jd
 jBrH2Bat4/qdnj4ZqysFe727Esq9TrM=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-7mPAwTOYNuqVx-9wQni4PA-1; Thu, 19 May 2022 15:13:04 +0200
X-MC-Unique: 7mPAwTOYNuqVx-9wQni4PA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQcA+zAgaBdwRSeFUF4sory3JmxnzJA8x6/kPe+h99lFgSpQHigcVT2O7zHu1qBwcbDeSxm3PtPy+nLJnJw0Bsne5R+OesSneHxjF7r9pyTUMeJ1IVjDsSHzjyHrLRnXhWPK/PLJE+4yhA7WE/VZ3rCtn2bq7V/fvfoSBUTEQzLxUwUjP2UH8isCnN3fVwdJQRYAIeVye2nFEhyKGwWfy2fxdQTqd9RRUqOojt98b9gVsNg/bxBDo7M5VzrbKOcL2bexgjw1SCIMjBTO7wxAsFoG73NO5vc3LWSweNolPorqbm1whuDnDWXZySuEkw2u14I8AaTX8vOWwnoQ86OSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0vjJKe87UmcvtWcVoDvx9GokvBuaPU8SepLXl33zeo=;
 b=OKCAemYRI0fP73nHPJoIWVzRlg4+6YCP2W76hfKHgd18axf09IWigdAKIfuLiMFbaFScp+Sun163rI8/56FQigatkkY6pzILBnCBWfRoTz7XdgzxJuCMoJFIlkKzcljPG69Smczr8nuQlwyz5qySEGYqHxq+r15z9t1dqmmzvs+hdsWgwC+OBllXz1F0ys6iBOpzUorepkqH2avAyTBhn6MuXdONlivy1V9wf8zTkGUA7SJydQsSBASBFuAxBqc213TTbt+FbDRVhcBPTx3UTg4yb5KqmAbD4cwTX3CDz3PoGkNKIiYwxnIl5kfxy+0f7r6+/suQWFVoDhvu7yMq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by VI1PR04MB3262.eurprd04.prod.outlook.com (2603:10a6:802:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 13:13:02 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::1d3e:8add:7f5b:df25]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::1d3e:8add:7f5b:df25%9]) with mapi id 15.20.5273.015; Thu, 19 May 2022
 13:13:02 +0000
Message-ID: <a3ae8c0b-9ffe-0596-72d2-ce1e5fa10825@suse.com>
Date: Thu, 19 May 2022 15:12:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: LTP List <ltp@lists.linux.it>
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f26967bb-0da9-4aa8-5321-08da39994dce
X-MS-TrafficTypeDiagnostic: VI1PR04MB3262:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB32624038FD03E9EDAE1620C5F8D09@VI1PR04MB3262.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8k4lJIq0CWOFSxphJNBAzh7ujDISDu/OvlW+zDqvTUs1CTJ03hruomAgaK6YPdw7LUHb4nFEW39hZgmKB1MddLNaNzo0L0h+PxjRVGVDa8Q3ynajJJFgF9MmmOakLT9kmMEMGyds7qK+Z+s3kKw4OTGTMnui7EU5VRlb2eWvBxC1CkVoqilHiuUI0462Hvm4gBFBegQmWArAYlZKb0XtLpLrwYz3IQ037sZFfA6p12qcBozrjSU0yyb30lsL2/MVWFXNWsIZnh4wdI6joMPRbXy/sJ6Z7IS1dkGHK266ZoM6h0xCCynDhwxtMh6y35GLq7lddf02j1og/n8FiWIWjgsSIQ39/4d68W9pJomDSNCtFzut0e/1ePW+xil1sPzv6Jt4ptU5UWh4fqYdhnMrAbU+V8YOV75VNbYmw15JmNmMT7srxAPCLUjy4d89RnJupoe2y7i7XXS2yPaxILa3DP3sjZ9NrdzJbkXDz3zcOM0FpiBNbZKiWcJiwk8Il3u3pzhg0+cpAOEfmp/McuKXfHYpFZWZfD6FWOpHKmy3+av3qXXsrL/YLe2RfGol+K0+erJcss39xjewvibha7F54fjZZSqcC/Ua7yOUbgFSINfWgcNVDr0qRo3dO7e4Ea9bPGR3w5eYGg6MnQAEo3AHPWl0NkJAsHfQge0AyvrVoDiqId6N6RZ8T9KVSl67TIe3v8NagGRJEr3c7DqfcR9hAiXXL3XCvdpktBckMVVVS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(6666004)(6486002)(508600001)(26005)(31696002)(83380400001)(86362001)(38100700002)(6512007)(6916009)(5660300002)(44832011)(2616005)(31686004)(36756003)(66556008)(66476007)(66946007)(2906002)(8676002)(186003)(8936002)(316002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aksTkLBuKbqciVSkVlKjSLFNwd8Fxo6LUxV68Lg+TpJspa9UTsnaAMs4Zdkh?=
 =?us-ascii?Q?jr5j66lzvBMxfgujnbllDrGSjzJsmt67UqeUw7lX1etJEa6kDAWiUM/PvmF2?=
 =?us-ascii?Q?Wd0xnKDfKs+KW8hKxTu4IKY/FsNSOl/DA3kOaC79piaHmWRyz7UHZmsDDvHF?=
 =?us-ascii?Q?RSJRkp6QpW4jINuWMrmCqqLC5BHWdk4eEGpeM6ZagEJXuW2MNp9zMyoyIqbJ?=
 =?us-ascii?Q?kItuDMbM6nUdmlj3S9eyQ4r7Mfi1a2gnKiwz++9D3Mse1hdlgpkZABDo4iYT?=
 =?us-ascii?Q?GKQySpEnlMmADQpt0ouuEQwheQAj5UAYK45FBTJm4JwiKRscs0+pHpTLYCYY?=
 =?us-ascii?Q?sly8yz+Jf84uJlk++VKNRhJO4BRZ6V1MyNH6bAC8c+yErlulbwlMy4j4I539?=
 =?us-ascii?Q?WtqdmUBAY3s7hFUOsl65Y6sWcJy0ZYUlxvIKtOyDAU1+dz2HzotqPOlyUH+z?=
 =?us-ascii?Q?0zv573t6CP0/AntgtG+fBwok1ICn9lyxdE3Z1nXEu9gsW1d5XyHQ9jWWqUiP?=
 =?us-ascii?Q?8tWHIskQWu+ZviORiYrPLR2sQXOWltBmdrrCD2O5vuvtcYRQLyxz5a5a2r8c?=
 =?us-ascii?Q?EumCRbFGBBosQ7cXQ31ex4NzVInakztD7w6CY1TczZKC9UjPQhZVmgYbKATT?=
 =?us-ascii?Q?pAtVhqyFBO33m0q26NoTL8gIlm5UBFFa2KZT06PWiUKnsxfsdNc8CpVA3hto?=
 =?us-ascii?Q?URLNSimKJkSl4Vx7X3tqsOBGFqTmopdadmNJWqllbTsi0ZbWD0h3U9vwceie?=
 =?us-ascii?Q?cadhH4R8cHJn2UIRIttifnV2w3oDfGkZanQTGGxGYUZRxaILheKdgCOn/LQZ?=
 =?us-ascii?Q?58zmPdZmz02yKVylHTtQTj8zdjYbger4YenaakpidsAwJfLsQ/saXbgcMEcr?=
 =?us-ascii?Q?aCc9BwbQ6nYPawe8lrnJpX8wkH9OTiAqi9IUHr6s+yTCsWiawWf36rqYUUGv?=
 =?us-ascii?Q?wQKL6mcEhJRtEgTtWK4aoTL6w6dDjhnanAmqfVFd6ylnk6NCYwN35eL+3SMB?=
 =?us-ascii?Q?FWi5cozkWbYoidW7z/gnU1KqHIHGvQmpQCE0EQ2X1WQTQGvtzW9YpjD23x9X?=
 =?us-ascii?Q?qCi3IlxM7g4ys13ad1RbsDdt4yeJ1q+Fl4wJlcrVERioijfLY8KmQdvd53JE?=
 =?us-ascii?Q?WBgd2iDyif6NjBr/otB/mPQnRKEdTbUYfTRZypczMeq0JCRTtivJ2xiGURNx?=
 =?us-ascii?Q?pXYh+0794czIeqXPqjp8eUB9dN1wuM5uYoyK4iXRnx5CgNUVfIy9Rpfk78Xk?=
 =?us-ascii?Q?rgVx8ArTgukkHtHUcDcufJEY29K/M3JNf23DR4cY4Gh/WSbzrzMHFzJ97JFU?=
 =?us-ascii?Q?CDYsV7WQIdPDxELGSK/Xm8NdTgM0dbQpYY6p3jelxSzybgN4AYxd9eMA8Ffp?=
 =?us-ascii?Q?SjXf93Y/eUo3JPR0xAQVKQSY921lRy8sbmQHQiy7l9tvPq34I808JWG/WGt2?=
 =?us-ascii?Q?4Kk+L+O/dCGK4FHHz1igIASRx31D0vnzwu4BteknI8tqV4aOtfHbA2/v8Rmp?=
 =?us-ascii?Q?lEAPD3+bhILh1gkBpjVG60N4SKS7sjKxTz2acG13u5mGEExujHtyqNtGd8GU?=
 =?us-ascii?Q?QsVvp3N5bGNJAVys2+K/s74NmSpifwNUc8TmiQHSqFP9XVpXarzf9mQGju9f?=
 =?us-ascii?Q?wiLQ1A7iRYdMg1doLgLO3Zes28ggpnJ5gu6UmF0/EHxXm6CvxfvffUvdgw4c?=
 =?us-ascii?Q?OxoSNEPsWwSjitNf53ZCIzSONQB7e3xpspjYrr7Xwzdg6Uh/4lNg8omk6bJl?=
 =?us-ascii?Q?GT6gCxOXnU/JffB09moT10GZKoOheSw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f26967bb-0da9-4aa8-5321-08da39994dce
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 13:13:02.5274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIohfAHC94qX2phg5OTZchL2ZN0Zx4iuvrD906uCwgxooFJZXkXdz28iB3pXV0geoc3huKXBgjVRgH3/Jd/9Q7QR3++BOL9sASF0CvkMT8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3262
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Fix ltp-aiodio tests failing on s390
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

cnVuX2NoaWxkIGZsYWcgaXMgY29tbW9ubHkgdXNlZCBieSBhaW9kaW8gdGVzdHMgaW4gb3JkZXIg
dG8gY2hlY2sgaWYKdGVzdHMgYXJlIHBhc3NlZCBvciBub3QgYW5kIGNvbXBpbGVyIHNlZW1zIHRv
IG9wdGltaXplIHJ1bl9jaGlsZCBmbGFnCmJlY2F1c2UgaXQncyBub3QgZGVmaW5lZCBhcyB2b2xh
dGlsZS4gV2l0aCB0aGlzIHBhdGNoIHdlIGVuc3VyZSB0aGF0IHRoZQpmbGFnIGlzIHNldCBhcyB2
b2xhdGlsZSBzbyB0ZXN0cyB3aWxsIHdvcmsgYXMgZXhwZWN0ZWQgb24gczM5MC4KClNpZ25lZC1v
ZmYtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5kZT4KLS0tCsKg
dGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Fpb2Rpb19hcHBlbmQuYyB8IDQgKystLQrC
oHRlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9haW9kaW9fc3BhcnNlLmMgfCA0ICsrLS0K
wqB0ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vZGlvX2FwcGVuZC5jwqDCoMKgIHwgNyAr
KysrKy0tCsKgdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Rpb19zcGFyc2UuY8KgwqDC
oCB8IDQgKystLQrCoHRlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9kaW9fdHJ1bmNhdGUu
Y8KgIHwgNCArKy0tCsKgNSBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vYWlv
ZGlvX2FwcGVuZC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Fpb2Rpb19hcHBl
bmQuYwppbmRleCA0NmNjNzRlZTQuLmU0MmM1NzdjZCAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tl
cm5lbC9pby9sdHAtYWlvZGlvL2Fpb2Rpb19hcHBlbmQuYworKysgYi90ZXN0Y2FzZXMva2VybmVs
L2lvL2x0cC1haW9kaW8vYWlvZGlvX2FwcGVuZC5jCkBAIC0yNCw3ICsyNCw3IEBACsKgI2luY2x1
ZGUgPGxpYmFpby5oPgrCoCNpbmNsdWRlICJjb21tb24uaCIKwqAKLXN0YXRpYyBpbnQgKnJ1bl9j
aGlsZDsKK3N0YXRpYyB2b2xhdGlsZSBpbnQgKnJ1bl9jaGlsZDsKwqAKwqBzdGF0aWMgY2hhciAq
c3RyX251bWNoaWxkcmVuOwrCoHN0YXRpYyBjaGFyICpzdHJfd3JpdGVzaXplOwpAQCAtMTMzLDcg
KzEzMyw3IEBAIHN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKwqB7CsKgwqDCoMKgIGlmIChydW5f
Y2hpbGQpIHsKwqDCoMKgwqAgwqDCoMKgICpydW5fY2hpbGQgPSAwOwotwqDCoMKgIMKgwqDCoCBT
QUZFX01VTk1BUChydW5fY2hpbGQsIHNpemVvZihpbnQpKTsKK8KgwqDCoCDCoMKgwqAgU0FGRV9N
VU5NQVAoKHZvaWQgKilydW5fY2hpbGQsIHNpemVvZihpbnQpKTsKwqDCoMKgwqAgfQrCoH0KwqAK
ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9haW9kaW9fc3BhcnNl
LmMgYi90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vYWlvZGlvX3NwYXJzZS5jCmluZGV4
IDJhYTU2NjJiYi4uOWFhOWI4ZDU0IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL2lvL2x0
cC1haW9kaW8vYWlvZGlvX3NwYXJzZS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFp
b2Rpby9haW9kaW9fc3BhcnNlLmMKQEAgLTI4LDcgKzI4LDcgQEAKwqAjaW5jbHVkZSA8bGliYWlv
Lmg+CsKgI2luY2x1ZGUgImNvbW1vbi5oIgrCoAotc3RhdGljIGludCAqcnVuX2NoaWxkOworc3Rh
dGljIHZvbGF0aWxlIGludCAqcnVuX2NoaWxkOwrCoArCoHN0YXRpYyBjaGFyICpzdHJfbnVtY2hp
bGRyZW47CsKgc3RhdGljIGNoYXIgKnN0cl93cml0ZXNpemU7CkBAIC0xODEsNyArMTgxLDcgQEAg
c3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQrCoHsKwqDCoMKgwqAgaWYgKHJ1bl9jaGlsZCkgewrC
oMKgwqDCoCDCoMKgwqAgKnJ1bl9jaGlsZCA9IDA7Ci3CoMKgwqAgwqDCoMKgIFNBRkVfTVVOTUFQ
KHJ1bl9jaGlsZCwgc2l6ZW9mKGludCkpOworwqDCoMKgIMKgwqDCoCBTQUZFX01VTk1BUCgodm9p
ZCAqKXJ1bl9jaGlsZCwgc2l6ZW9mKGludCkpOwrCoMKgwqDCoCB9CsKgfQrCoApkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Rpb19hcHBlbmQuYyBiL3Rlc3RjYXNl
cy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9kaW9fYXBwZW5kLmMKaW5kZXggYzA5OTc5M2Y2Li4zYTdl
N2M4MzYgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9kaW9fYXBw
ZW5kLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Rpb19hcHBlbmQuYwpA
QCAtMTksNyArMTksNyBAQArCoCNpbmNsdWRlICJ0c3RfdGVzdC5oIgrCoCNpbmNsdWRlICJjb21t
b24uaCIKwqAKLXN0YXRpYyBpbnQgKnJ1bl9jaGlsZDsKK3N0YXRpYyB2b2xhdGlsZSBpbnQgKnJ1
bl9jaGlsZDsKwqAKwqBzdGF0aWMgY2hhciAqc3RyX251bWNoaWxkcmVuOwrCoHN0YXRpYyBjaGFy
ICpzdHJfd3JpdGVzaXplOwpAQCAtNDksNyArNDksMTAgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9p
ZCkKwqAKwqBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCsKgewotwqDCoMKgIFNBRkVfTVVOTUFQ
KHJ1bl9jaGlsZCwgc2l6ZW9mKGludCkpOworwqDCoMKgIGlmIChydW5fY2hpbGQpIHsKK8KgwqDC
oCDCoMKgwqAgKnJ1bl9jaGlsZCA9IDA7CivCoMKgwqAgwqDCoMKgIFNBRkVfTVVOTUFQKCh2b2lk
ICopcnVuX2NoaWxkLCBzaXplb2YoaW50KSk7CivCoMKgwqAgfQrCoH0KwqAKwqBzdGF0aWMgdm9p
ZCBydW4odm9pZCkKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9k
aW9fc3BhcnNlLmMgYi90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vZGlvX3NwYXJzZS5j
CmluZGV4IDAwMzlkYWE4ZC4uNjYxYWZkZTRjIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVs
L2lvL2x0cC1haW9kaW8vZGlvX3NwYXJzZS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRw
LWFpb2Rpby9kaW9fc3BhcnNlLmMKQEAgLTI2LDcgKzI2LDcgQEAKwqAjaW5jbHVkZSAidHN0X3Rl
c3QuaCIKwqAjaW5jbHVkZSAiY29tbW9uLmgiCsKgCi1zdGF0aWMgaW50ICpydW5fY2hpbGQ7Citz
dGF0aWMgdm9sYXRpbGUgaW50ICpydW5fY2hpbGQ7CsKgCsKgc3RhdGljIGNoYXIgKnN0cl9udW1j
aGlsZHJlbjsKwqBzdGF0aWMgY2hhciAqc3RyX3dyaXRlc2l6ZTsKQEAgLTg1LDcgKzg1LDcgQEAg
c3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQrCoHsKwqDCoMKgwqAgaWYgKHJ1bl9jaGlsZCkgewrC
oMKgwqDCoCDCoMKgwqAgKnJ1bl9jaGlsZCA9IDA7Ci3CoMKgwqAgwqDCoMKgIFNBRkVfTVVOTUFQ
KHJ1bl9jaGlsZCwgc2l6ZW9mKGludCkpOworwqDCoMKgIMKgwqDCoCBTQUZFX01VTk1BUCgodm9p
ZCAqKXJ1bl9jaGlsZCwgc2l6ZW9mKGludCkpOwrCoMKgwqDCoCB9CsKgfQrCoApkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Rpb190cnVuY2F0ZS5jIGIvdGVzdGNh
c2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Rpb190cnVuY2F0ZS5jCmluZGV4IDFmYmY4M2RlMC4u
MGZlNmI4N2FjIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vZGlv
X3RydW5jYXRlLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Rpb190cnVu
Y2F0ZS5jCkBAIC0zMyw3ICszMyw3IEBACsKgI2luY2x1ZGUgInRzdF90ZXN0LmgiCsKgI2luY2x1
ZGUgImNvbW1vbi5oIgrCoAotc3RhdGljIGludCAqcnVuX2NoaWxkOworc3RhdGljIHZvbGF0aWxl
IGludCAqcnVuX2NoaWxkOwrCoArCoHN0YXRpYyBjaGFyICpzdHJfbnVtY2hpbGRyZW47CsKgc3Rh
dGljIGNoYXIgKnN0cl9maWxlc2l6ZTsKQEAgLTEwOSw3ICsxMDksNyBAQCBzdGF0aWMgdm9pZCBj
bGVhbnVwKHZvaWQpCsKgewrCoMKgwqDCoCBpZiAocnVuX2NoaWxkKSB7CsKgwqDCoMKgIMKgwqDC
oCAqcnVuX2NoaWxkID0gMDsKLcKgwqDCoCDCoMKgwqAgU0FGRV9NVU5NQVAocnVuX2NoaWxkLCBz
aXplb2YoaW50KSk7CivCoMKgwqAgwqDCoMKgIFNBRkVfTVVOTUFQKCh2b2lkICopcnVuX2NoaWxk
LCBzaXplb2YoaW50KSk7CsKgwqDCoMKgIH0KwqB9CsKgCi0tIAoyLjM2LjEKCgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
