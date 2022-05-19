Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDF1C433EF
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 12:19:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0633C3CAAD7
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 14:19:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64BEE3C2157
 for <ltp@lists.linux.it>; Thu, 19 May 2022 14:19:42 +0200 (CEST)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 540DF600667
 for <ltp@lists.linux.it>; Thu, 19 May 2022 14:19:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1652962780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tuQdIeedRpgoq/Wby9zfscYSoBbOUxnN6tOeEtBCm0s=;
 b=ND9vqNZmmhQhgH3+7NyiqQ5D7BM/vW/NfLIUTaVEMtwEid9EiktTdDkDa6wG9bzmJmKzgC
 xXNsFZnr9aJBEjVwAm5TQtbHr61svwPQ344Zoh3C8ZaDS85+5R8H6qJMX4FuaJJN2hqfGr
 PR59uEMAJesR7S7UbHoKnT8VIypt0pI=
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2171.outbound.protection.outlook.com [104.47.51.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-yTiWl4FSNiOn_c2mYH75Dw-1; Thu, 19 May 2022 14:19:39 +0200
X-MC-Unique: yTiWl4FSNiOn_c2mYH75Dw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvZCJejfpFnsqwycOBd+JmizNbMHY9kQOjAg2yMPLvILy7/lJTEmdLDxux7Ou8HLXy7YeS7if/S8T0O1V3fOWKiK0FTfjrAIC8ua6DyuCIRPcFVHLbPgf9EdVtK0ZGSd4UYCJhcRN1TX4afwUgGJTjMAtqaO+8Hs2N0g2e1Bjl6YXE7a7jXs9OunHTZzwf+76GOFtzt+/t6DS03YbmM0Gc+/QZEHIG9Rz/hr+ZIjOVUp8y0h6KaGuYEiAj3Nd+DFQcujXAjhzE+0D2Mggpg56uMCH/C3vAE3QHSr07AU5sISSyGY8/vGAO3VeDrKg7UDFeymcofygf9LwQFcZIDnQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UiX0ak9aIqf0zrRGDBucqpRth1ryzTeqatvC6NXT2g=;
 b=KJW2LdC1zKSPgKcvp+oY316gZKNaf/NfcxCC9o+mbsSmyGtAatv3rVxVFRrkHOpUoSYRoAeDeRf9u3MbzwaRy+eNuRz22wOiDnQ4E0d4Nx0ZvXCeJ1uFDLL5tyFAFNNAJxsBhxASK3koxTa3ssuQDk6paWlrwRda3fvEoPro/nlVRNawOjLWaSQOGtLIPLVYaeySE7T9CueRljWxNEjuDjCeuYMsNrEXMUaJCLVzq5N56UTUsjYMDAu+k/cjidyqrxxHk0GolVT/Hw6q8PRo4b/hN2juCHkPlv86s2g2VvTsU8BRy4VB/ZBXaBIckx3XEtqiGgcbCmAJUZA/8Py0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM0PR0402MB3604.eurprd04.prod.outlook.com (2603:10a6:208:1c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 12:19:37 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::1d3e:8add:7f5b:df25]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::1d3e:8add:7f5b:df25%9]) with mapi id 15.20.5273.015; Thu, 19 May 2022
 12:19:37 +0000
Message-ID: <dc51195f-dc8a-67d3-b84d-e88e7233d276@suse.com>
Date: Thu, 19 May 2022 14:19:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To: ltp@lists.linux.it
Content-Language: en-US
X-ClientProxiedBy: AM6PR08CA0030.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::18) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fa6586d-17fb-4c1c-70be-08da3991d761
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3604:EE_
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3604758A0BC3092CFF102102F8D09@AM0PR0402MB3604.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBaRhVrlmFL42vV6AITG44VLUseUcv9zq3o0HbYP5ETBEWbi2XQYjsmUwFaGaO/hqh4uEXKCqaOapTb1KHau8QCHOCVfuZNABSip2r1ipSXA9zspu0xGF9cppkbVuWl9hHueMcG6YffU/ev0FBfjupKLxqpLvv8PDc4uHHkXv4lZ/D79Y9o2HZxzBKv/pyWMXyT5TI2yYiavpkfa4KH6wvGfbG7y/c9IBCP7zaog6eAiK3EgTJ6tVDJCW/X//QSpoZIfids154qNvdKJ8vj/khAMd8RDUZFv+Nx85SDq4hADbvQGgrgSS10Z45fdRhDPV+G1vWK6hi+CB9kZRkr6ONBzq45RnseWpyOeFinf5Zs52M3ygDuyCuxLFXkNCHNmlCtWHzIv16Y4onblaY8ei5XKPdJwXGSFjyqAlYSyu9suhxxAiEV2Z5JuVudoq3EsR/ftC7w2/foZ3S43L1QauSW9oY7jAdYHW9b/mzxWpdueLjTV70H3oQTjdsCQRV9MBNx+v2f4SbOJmgAwB8HCUDQDQ0iOVUwVuy/wJ/qNSx0cZTconYG6R+DFfPuzpYVJWIMrAkKHJGkAyNiG/5DyNkQOM4+/dB4dMUc/xCIFBLdlGPhxHKEnRn0BmmU/FcujtFq1T2cerB3D3c60wFWJcXp3lXhm2OjEI5X3cnQ5agEj8dJEvG8Ru0iGb8hS1izo+oHr5mdNNP+2EBUPIK6nhYqfFHWuPbcCKzvO+E/5llA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(186003)(66476007)(66946007)(66556008)(2906002)(8676002)(5660300002)(2616005)(508600001)(86362001)(31696002)(6506007)(38100700002)(44832011)(26005)(8936002)(6512007)(316002)(6486002)(6916009)(31686004)(36756003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y6K1DrycGI0/llAN2Ew8X64SrE+H+7JfSnAIvYEHH0z1tl1bnhMy4G5W6OGH?=
 =?us-ascii?Q?nlUIxdGV+nHGuMu4X3vel6Axvv8jY2NkxWjq8y5N/1fvuBoy4LWDqHtJiV+m?=
 =?us-ascii?Q?gbdR81MOwL1nEmt9zB8jptqjgz6fPN+/hdp34Scam/ZzMXmNE+QjVsEr7rQ7?=
 =?us-ascii?Q?kSQsTrrXFIKuaXdJsXFLMqHsTnthn9QakXI5EpriwgqeHJ8PUZxaOSOwmtEV?=
 =?us-ascii?Q?HIuj7nq4vZwdozEopjSQS/QXHpe2EkdMEkBCnl5ZmEiNbxFf2Z0foGkQbRvM?=
 =?us-ascii?Q?hkDJ4o+aYzYnXGBVzevmLtrg3ivZuTH7x3pEye0VIoa5yP15+f5mHI8dpp7y?=
 =?us-ascii?Q?ML/4Ae80tMexp8lL7tEjee6qu/4yBEsaI+oMvFnKD1w50NoVMiKHtiK48huS?=
 =?us-ascii?Q?xDLEv9A05T5EPWe/vQjXt+UHVHD5WiSaNT3BsNcO0uOLUDVKXTntoPrK5O+a?=
 =?us-ascii?Q?KIKPf4nQjMPgZ/gQraJxUJdDZOkKS41ueSuitA9MN+NYV4TyoOCR42nRFyVM?=
 =?us-ascii?Q?wEOw28wQoB/VgmxIf63A3G4coPc+Tf68L3/df0uhffuACPK6e9nMFIBF/se9?=
 =?us-ascii?Q?IcGw9Co/XFKGasVAG2BYysaTE0/SGspEKno/JIM7jVjA4+2mQq/RJ+s9WJw8?=
 =?us-ascii?Q?hUiXTU7I+MkAN6vUrXIAJn7jxQDyL4epXMKY7RvbxM4T6YArO2S+LFLgIDaJ?=
 =?us-ascii?Q?uRJufEpfKYewE/glBYU+hAhtDZaqUG5Q+TsuUOaf7Nlt+IpHAnWgJO/nykzy?=
 =?us-ascii?Q?AiB0FL/D/PimKDmrVf/iWVBdzJWjURGC/0sNFn18IdSui90Gp1s4YkFpg7tk?=
 =?us-ascii?Q?MAqoxmfP8TGIqZV7QZKNAqpoAS+vH3ULpcPsBv5oYv1MiE2MR9/UqQZDFQ0L?=
 =?us-ascii?Q?VdKC5yK6DkihTwkqqPHJSbzkJmuY5vZwqjdqpmwvwnOdUwxjnPStWA4VkPuC?=
 =?us-ascii?Q?0488vbo7jrk5FcSL7Tw0x4Z7hEeQODktttcf8guFba622IWw+rt7xIfvQGCD?=
 =?us-ascii?Q?VFrFBSJA6qyETQ/GRUBgvRIXvpnOHhfOY1DrOiVU+X6dwHTbCAUUJLVolLKA?=
 =?us-ascii?Q?OCxSdkO1Suu834Nm2WE18rx7gUBl33LwUeCVvQ24oQADlEFGxPFfiThW7GRY?=
 =?us-ascii?Q?XqjX5KD/xfInEvss6ZiIy9Bz6d+uXN3yHq6HSP29udGrOqapAlu+f9l+vVWD?=
 =?us-ascii?Q?QlDtwKdYaWtAWiQ5CwzlzsncxwzKCfS6mwC4wwnIk8dTitQFCXdOvdPAlUez?=
 =?us-ascii?Q?batJ40wt0To+Vf+0TmMIYKZwo9/99mvYV/rMjc03Mb2qH/2BswzeM3muEILF?=
 =?us-ascii?Q?/m9KeqfOmRJmGMuu7FtlTw4Sc5uiZvyYtzJnY1uBLVPt0jpvFfaXVGv5jqvm?=
 =?us-ascii?Q?/aAxVvWH4B/fvN3K5s9KDS3mvhOH9L5ukWsOboSjskNdGdtMbMibZgUI3jt6?=
 =?us-ascii?Q?NDQNnjw5P9bmi/4/KjmeXOpv0Uxfx7HHTF3JdsAW3kpi2taZMqnTQljZdeKd?=
 =?us-ascii?Q?eG9iCD2iD5/PUzDoTh44DjRvjQx4DJgCTmvueLZMTNR9ex7ceoyw8bzppyNf?=
 =?us-ascii?Q?uKCfRvPDJd6nwN52PYO5gp+kLExvTqCeIiORnNtB57OzjEQOBKoYOvQ/KoAb?=
 =?us-ascii?Q?kYas0jNCXuUHW53RWHyr3zvdBWMBgUpaYGkMtNFa8Ki1OnpCpufPCis9xps5?=
 =?us-ascii?Q?lzN54Clnb7ag8VwKtpvjn4z9UcY7wD921wy+kubgYWjxDZi/Zu/vZ5A4LiWp?=
 =?us-ascii?Q?47FBv43qIgpa3klkw7Mx4nEe+BcESZw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa6586d-17fb-4c1c-70be-08da3991d761
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 12:19:37.3812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfIAxb0/mH7z+hyZgXLNxDTOuL8euqmduVsX9yC/l0RInQgN/Min/RztVkvuVQVYX0fjhUbZaRVFKqiCmA5gri4GE4eDpFNdT/+UprWEw7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3604
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

cnVuX2NoaWxkIGZsYWcgaXMgY29tbW9ubHkgdXNlZCBieSBhaW9kaW8gdGVzdHMgaW4gb3JkZXIg
dG8gY2hlY2sgaWYKdGVzdHMgYXJlIHBhc3NlZCBvciBub3QgYW5kIGNvbXBpbGVyIHNlZW1zIHRv
IG9wdGltaXplIHJ1bl9jaGlsZCBmbGFnCmJlY2F1c2UgaXQncyBub3QgZGVmaW5lZCBhcyB2b2xh
dGlsZS4gV2l0aCB0aGlzIHBhdGNoIHdlIGVuc3VyZSB0aGF0IHRoZQpmbGFnIGlzIHNldCBhcyB2
b2xhdGlsZSBzbyB0ZXN0cyB3aWxsIHdvcmsgYXMgZXhwZWN0ZWQgb24gczM5MC4KClNpZ25lZC1v
ZmYtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5kZT4KLS0tCiDC
oHRlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9haW9kaW9fYXBwZW5kLmMgfCA0ICsrLS0K
IMKgdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Fpb2Rpb19zcGFyc2UuYyB8IDQgKyst
LQogwqB0ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vZGlvX2FwcGVuZC5jwqDCoMKgIHwg
NyArKysrKy0tCiDCoHRlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9kaW9fc3BhcnNlLmPC
oMKgwqAgfCA0ICsrLS0KIMKgdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Rpb190cnVu
Y2F0ZS5jwqAgfCA0ICsrLS0KIMKgNSBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAx
MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9k
aW8vYWlvZGlvX2FwcGVuZC5jIApiL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9haW9k
aW9fYXBwZW5kLmMKaW5kZXggNDZjYzc0ZWU0Li5lNDJjNTc3Y2QgMTAwNjQ0Ci0tLSBhL3Rlc3Rj
YXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9haW9kaW9fYXBwZW5kLmMKKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9pby9sdHAtYWlvZGlvL2Fpb2Rpb19hcHBlbmQuYwpAQCAtMjQsNyArMjQsNyBAQAog
wqAjaW5jbHVkZSA8bGliYWlvLmg+CiDCoCNpbmNsdWRlICJjb21tb24uaCIKCi1zdGF0aWMgaW50
ICpydW5fY2hpbGQ7CitzdGF0aWMgdm9sYXRpbGUgaW50ICpydW5fY2hpbGQ7CgogwqBzdGF0aWMg
Y2hhciAqc3RyX251bWNoaWxkcmVuOwogwqBzdGF0aWMgY2hhciAqc3RyX3dyaXRlc2l6ZTsKQEAg
LTEzMyw3ICsxMzMsNyBAQCBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCiDCoHsKIMKgwqDCoMKg
IGlmIChydW5fY2hpbGQpIHsKIMKgwqDCoMKgIMKgwqDCoCAqcnVuX2NoaWxkID0gMDsKLcKgwqDC
oCDCoMKgwqAgU0FGRV9NVU5NQVAocnVuX2NoaWxkLCBzaXplb2YoaW50KSk7CivCoMKgwqAgwqDC
oMKgIFNBRkVfTVVOTUFQKCh2b2lkICopcnVuX2NoaWxkLCBzaXplb2YoaW50KSk7CiDCoMKgwqDC
oCB9CiDCoH0KCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vYWlv
ZGlvX3NwYXJzZS5jIApiL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9haW9kaW9fc3Bh
cnNlLmMKaW5kZXggMmFhNTY2MmJiLi45YWE5YjhkNTQgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvaW8vbHRwLWFpb2Rpby9haW9kaW9fc3BhcnNlLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9pby9sdHAtYWlvZGlvL2Fpb2Rpb19zcGFyc2UuYwpAQCAtMjgsNyArMjgsNyBAQAogwqAjaW5j
bHVkZSA8bGliYWlvLmg+CiDCoCNpbmNsdWRlICJjb21tb24uaCIKCi1zdGF0aWMgaW50ICpydW5f
Y2hpbGQ7CitzdGF0aWMgdm9sYXRpbGUgaW50ICpydW5fY2hpbGQ7CgogwqBzdGF0aWMgY2hhciAq
c3RyX251bWNoaWxkcmVuOwogwqBzdGF0aWMgY2hhciAqc3RyX3dyaXRlc2l6ZTsKQEAgLTE4MSw3
ICsxODEsNyBAQCBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCiDCoHsKIMKgwqDCoMKgIGlmIChy
dW5fY2hpbGQpIHsKIMKgwqDCoMKgIMKgwqDCoCAqcnVuX2NoaWxkID0gMDsKLcKgwqDCoCDCoMKg
wqAgU0FGRV9NVU5NQVAocnVuX2NoaWxkLCBzaXplb2YoaW50KSk7CivCoMKgwqAgwqDCoMKgIFNB
RkVfTVVOTUFQKCh2b2lkICopcnVuX2NoaWxkLCBzaXplb2YoaW50KSk7CiDCoMKgwqDCoCB9CiDC
oH0KCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vZGlvX2FwcGVu
ZC5jIApiL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9kaW9fYXBwZW5kLmMKaW5kZXgg
YzA5OTc5M2Y2Li4zYTdlN2M4MzYgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRw
LWFpb2Rpby9kaW9fYXBwZW5kLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlv
L2Rpb19hcHBlbmQuYwpAQCAtMTksNyArMTksNyBAQAogwqAjaW5jbHVkZSAidHN0X3Rlc3QuaCIK
IMKgI2luY2x1ZGUgImNvbW1vbi5oIgoKLXN0YXRpYyBpbnQgKnJ1bl9jaGlsZDsKK3N0YXRpYyB2
b2xhdGlsZSBpbnQgKnJ1bl9jaGlsZDsKCiDCoHN0YXRpYyBjaGFyICpzdHJfbnVtY2hpbGRyZW47
CiDCoHN0YXRpYyBjaGFyICpzdHJfd3JpdGVzaXplOwpAQCAtNDksNyArNDksMTAgQEAgc3RhdGlj
IHZvaWQgc2V0dXAodm9pZCkKCiDCoHN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKIMKgewotwqDC
oMKgIFNBRkVfTVVOTUFQKHJ1bl9jaGlsZCwgc2l6ZW9mKGludCkpOworwqDCoMKgIGlmIChydW5f
Y2hpbGQpIHsKK8KgwqDCoCDCoMKgwqAgKnJ1bl9jaGlsZCA9IDA7CivCoMKgwqAgwqDCoMKgIFNB
RkVfTVVOTUFQKCh2b2lkICopcnVuX2NoaWxkLCBzaXplb2YoaW50KSk7CivCoMKgwqAgfQogwqB9
CgogwqBzdGF0aWMgdm9pZCBydW4odm9pZCkKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
aW8vbHRwLWFpb2Rpby9kaW9fc3BhcnNlLmMgCmIvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlv
ZGlvL2Rpb19zcGFyc2UuYwppbmRleCAwMDM5ZGFhOGQuLjY2MWFmZGU0YyAxMDA2NDQKLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Rpb19zcGFyc2UuYworKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL2lvL2x0cC1haW9kaW8vZGlvX3NwYXJzZS5jCkBAIC0yNiw3ICsyNiw3IEBACiDC
oCNpbmNsdWRlICJ0c3RfdGVzdC5oIgogwqAjaW5jbHVkZSAiY29tbW9uLmgiCgotc3RhdGljIGlu
dCAqcnVuX2NoaWxkOworc3RhdGljIHZvbGF0aWxlIGludCAqcnVuX2NoaWxkOwoKIMKgc3RhdGlj
IGNoYXIgKnN0cl9udW1jaGlsZHJlbjsKIMKgc3RhdGljIGNoYXIgKnN0cl93cml0ZXNpemU7CkBA
IC04NSw3ICs4NSw3IEBAIHN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKIMKgewogwqDCoMKgwqAg
aWYgKHJ1bl9jaGlsZCkgewogwqDCoMKgwqAgwqDCoMKgICpydW5fY2hpbGQgPSAwOwotwqDCoMKg
IMKgwqDCoCBTQUZFX01VTk1BUChydW5fY2hpbGQsIHNpemVvZihpbnQpKTsKK8KgwqDCoCDCoMKg
wqAgU0FGRV9NVU5NQVAoKHZvaWQgKilydW5fY2hpbGQsIHNpemVvZihpbnQpKTsKIMKgwqDCoMKg
IH0KIMKgfQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9kaW9f
dHJ1bmNhdGUuYyAKYi90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vZGlvX3RydW5jYXRl
LmMKaW5kZXggMWZiZjgzZGUwLi4wZmU2Yjg3YWMgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwvaW8vbHRwLWFpb2Rpby9kaW9fdHJ1bmNhdGUuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL2lv
L2x0cC1haW9kaW8vZGlvX3RydW5jYXRlLmMKQEAgLTMzLDcgKzMzLDcgQEAKIMKgI2luY2x1ZGUg
InRzdF90ZXN0LmgiCiDCoCNpbmNsdWRlICJjb21tb24uaCIKCi1zdGF0aWMgaW50ICpydW5fY2hp
bGQ7CitzdGF0aWMgdm9sYXRpbGUgaW50ICpydW5fY2hpbGQ7CgogwqBzdGF0aWMgY2hhciAqc3Ry
X251bWNoaWxkcmVuOwogwqBzdGF0aWMgY2hhciAqc3RyX2ZpbGVzaXplOwpAQCAtMTA5LDcgKzEw
OSw3IEBAIHN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKIMKgewogwqDCoMKgwqAgaWYgKHJ1bl9j
aGlsZCkgewogwqDCoMKgwqAgwqDCoMKgICpydW5fY2hpbGQgPSAwOwotwqDCoMKgIMKgwqDCoCBT
QUZFX01VTk1BUChydW5fY2hpbGQsIHNpemVvZihpbnQpKTsKK8KgwqDCoCDCoMKgwqAgU0FGRV9N
VU5NQVAoKHZvaWQgKilydW5fY2hpbGQsIHNpemVvZihpbnQpKTsKIMKgwqDCoMKgIH0KIMKgfQoK
LS0gCjIuMzYuMQoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
