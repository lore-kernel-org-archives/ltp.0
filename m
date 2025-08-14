Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A10CCA0EDC
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755185254; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=+BIDlguWhtRcjkVg6YlSWDHNa9vuM5gtXpU4G0qm59c=;
 b=m2C1VQJY/WOANaQn9mxNHh7zFjRLTdirdgYCpAvq0Yzrowok5HTYcVWzC63H8UGSpLyWZ
 d1bqokNFRRfHYPyvtc7WqZuqIvUE4pc9DJag9NTXaAmwuE0oevn6VxNgzB+c/PkKQaKwAZ5
 RM1R3wnEXBEYhRjqQqIj1QrgIf2TJVc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B77933C6994
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 17:27:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B7C53CBF17
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 17:27:04 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::702])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E9C4220012F
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 17:27:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lda0vcuLGKBwgOxZMmaUXSVuDu8L/BilBvdkn1ig3S2WjAsIFQ0ok6OmNgac15P6l8qtrlY/14nASIAb5DGUFNV0wMkmo2u1+i3KODdU0bUoxpatIJ9tRPOJ46Js2AA326TcBOnPT1BC351d9E0e5Gxy4m98wwMDtfJns89wN6dnP7aXCewhy02rSz+nwBXgSG8M23nvN/3B9lK+Z66HiniZ07yAix/NJiXjey8h420nKz5EFCoBhODb5fAAbvTF/io0WfHekuPSB1cQSTdywXZaj7bbSI8mS5dqsKcAOBNvYB6oA+prohFXjGI7tFGXFdNnQftsaFQHtHiWRrP0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gdn1fjkVUnqua0MusfYkWZabEMp7Kjzs28fkBEcfny4=;
 b=dc33CzIZ91cVs6sAAJ/uxITHuwmEK+5rxdJ/3Rdp5wQ2w0aJMmT2xoFIHZL8B8c/5kvZfSLY/63UoNosccZ7HAhClszQ9rrtQYGBDFmYa8sAM1NP6FurFO8Is5BrO+Dh0VmyT7knYB7yXi2aK/skUZkETWSxA0VpKxWX/jcu/R3ZswbX4hN1OPIl6v6KHVQUMqoqNPTR5Mr6iXDsQ5nU6FywrYrkUzTmdIDM17OicbGidpQGriq+UPXVIre+tJGX4r6Y8ZF+6Q5XdgzBQXe4ERPzGEpU8PJPyKXedkzBN23sUiJSiJ8NebhCYSXPzQlyW28Z24QLm8H17iSXnk7XSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdn1fjkVUnqua0MusfYkWZabEMp7Kjzs28fkBEcfny4=;
 b=UlH0c2O5f+IyU3SANePL3wK2AFON4Nsx0ohNHaNH4CqDM9nbsgJkS7VPzV19JlnlkHmNq42JBUd9W053F6oZOI9rjo8aHGVUcbLqFqR/8wznloQByfJDVTTCl5NNvcxwu9F80fgERkG+q2qmM59J9tTrGHNfMkqoBDJbg82lyLFzoYeqsWpF8BoybsN3FNbQ9+xfG64DlXiSCfB6Z5lCGBrkRvSaFNt5UZ/ooXRauNne4wd1NEhgOmMFukh3fllklEstg+vZtUcmp4xAj2hCik2U/6i/AA9sZ80Ax2j08eg5tWia7ebBvB9lV0WvLEoJuueDICBtnR1YOoQzpJjuDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by PAXP192MB1462.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 15:27:02 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 15:27:02 +0000
To: ltp@lists.linux.it
Date: Thu, 14 Aug 2025 17:26:59 +0200
Message-ID: <20250814152659.1368713-1-florian.schmaus@codasip.com>
X-Mailer: git-send-email 2.49.1
X-ClientProxiedBy: FR5P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::17) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|PAXP192MB1462:EE_
X-MS-Office365-Filtering-Correlation-Id: 137c0d8c-d053-4e29-9463-08dddb4704c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?llKXrs0aLQMPGGr94liVsJInGvXohKAdPYgCdNn92IyFjv/kPFqutW/VA4Cm?=
 =?us-ascii?Q?L/ZmoOr38/XCMLlsamwAwqd+cS9Xcp0QndFACNKgq4bRvlYVi3Xde6XpdDei?=
 =?us-ascii?Q?qkjVOt2yFDut+Loczhl5yP359YAnyTdGJa7VLBbANZDy79YdwLzyRRCe+Uu4?=
 =?us-ascii?Q?eSSIvb3yZ7nl0dl8yKFCJ/yek/n21mLmNtUBUIY5IJnHGo7AZwSs/lPIIMWV?=
 =?us-ascii?Q?7wnsyD0GPn2+tEaZWG4bI/DXbDKblOf4xM0rnsMUufhygZBnTCZynOYM7AKQ?=
 =?us-ascii?Q?P69vmQRjguq5LSSSO0zTQvkO6bb2GACCT+fwulhI5ovrXvgIMW8zL5OpIwyI?=
 =?us-ascii?Q?sNm4hqx45vKhZDvroQYtayUoKeX53Hk3jsKSQkQBKEPqOo8EpMUo530qK50P?=
 =?us-ascii?Q?8cIYUGDpCA/Pz6WtPqiQ5c/BmO7fbHwUN4ebsJc0jWZGXJKX1A8bmKG4ekQu?=
 =?us-ascii?Q?Rk//xIFxd+I4HBxyIT0fJ1wVEn2LUiJLh5Ihax32NVmXAWWDuXD4ADzVVkoB?=
 =?us-ascii?Q?WoHu/WTWp2DSswiT6mfO5kmm67jUJO+lR2kzLNdJVOLRKhwoflN651g/leu8?=
 =?us-ascii?Q?hCervNbEas/pZdWFJ/fiZcWBbbOWjk7gkbblwQ49pjKlbz3bRwY2IoYGfXna?=
 =?us-ascii?Q?aM5agzkiKzyMR65Qkq8o4KPRV61/sn10QoRlhq5Ir2UW6N6gVSVvADyIrXEp?=
 =?us-ascii?Q?S/wEqdroFbZ1SehX+vlLXi5I4/8bX/JPJx6a7QsmbrMiW6yf/7J27pS4Xjgj?=
 =?us-ascii?Q?dS6ZLena6X1b1ce7BcGF9Pr4NeFSgkXNi0ducle/So0uNHdZuiGQE2z+kQDf?=
 =?us-ascii?Q?mF9PDxwMDcNkfbvM2O95SEkYMjmX5FJBTFt2b0cZ8RWC4wxhpLaGKwu6ujYy?=
 =?us-ascii?Q?/xeG3mHHq+fVcqnG39e6HZr0Nvzf3fyBS4nc/Z4BCVizU8oRs8rUjw3UsAf6?=
 =?us-ascii?Q?eg6HRraNjLuO+KGgG+xhO6Ar+oXDnCk34WzX5/2/y4jr7sdMQp7OHc718r40?=
 =?us-ascii?Q?F6REJr9aBag9O3MNzRrinW3HeiNU/9qA24oikF/BmhVVGobrjdIXSwEZd2zG?=
 =?us-ascii?Q?OF96wrxQzf+BW7G/of4yAdRp4BX5OolHvzLTNqSG+E8FlYi1sSYPO9gslgb+?=
 =?us-ascii?Q?n5/FBzBqQ9S1SRabSY5URN26kxyba4acu2agxUNiVE7D1FtfCjQIr+yfAYzd?=
 =?us-ascii?Q?NI+tfHJYZCCvMCgbD7w8jWOXTMGhaRp5fjcZs/rNhEPomlYIGwezQUuy0Bfw?=
 =?us-ascii?Q?z+V4YEaxOW5CUMce2lx76fud1XrqSOVKKM4up/EuJz6p4r4dtiIQBgDLbc2U?=
 =?us-ascii?Q?+eBHJp9m7g5ftfWictrIkU5SxsruLxhzaAJROqESC62cG+/81T54etdP5Kvb?=
 =?us-ascii?Q?MBwgoNgtxoHVGkH56F6kjhqy5289hwsoaB37YtVeYiCYviSRymj691VE6LiB?=
 =?us-ascii?Q?MPSC2GCVp4A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YtGZqKEzwsa9TsPVHganeFwyGaXWL7bS9fX0OXsbZKD0IGzNUurAAwRMXtnV?=
 =?us-ascii?Q?VC3YWAJVqBoiXHdYhep4msMsXdLijkZjcuWEhwPVfqzeyHPtf+ZRmNvheWF+?=
 =?us-ascii?Q?n3ly5UKrkyye3e7IMnew8vyJjhADo3KBl4kJRbFEzf3VuSaKnd9d+XmxxYVS?=
 =?us-ascii?Q?u62vvSDnrkVvVNnC5GiNkMtPI2Ik7X19TyEyvIn89iuHnk1ZHaemIrX0a+4v?=
 =?us-ascii?Q?e/lg326RkfTMMemeczy6BD8jpTFx1L9RLWVAFrrptay9dff4vsJEubiA5YLZ?=
 =?us-ascii?Q?YqpB4TBffaG91NEdPsPZYPrVRTwBGkTWNV84uMlP4sCt3kSdZ4wm6eLTSvHs?=
 =?us-ascii?Q?k8suYfQ0ms4JMs92mTFfQkC8qyoLLbmYAg/WLYb+Fq5yW/gFGje3bWdAGG5t?=
 =?us-ascii?Q?ujpau2TNfhQqsKGmMXsoIZihUjfL+tCaeLcOxmuVdAFy4K79zcnQYAibHJFn?=
 =?us-ascii?Q?w8FZM16rso9nAd1ERC/9YJmkD6q+1cs/P2vUDmMuj7BL0HzrEJEzda9NKHI6?=
 =?us-ascii?Q?7ErbQaR92KsFqCeE4J+k4r1l6YMiF/nGAqW9BJJtGzgrEsNMkIoTjzqiFotx?=
 =?us-ascii?Q?bR5+lrGM0U52IQiEqjQ1xvTJcUfxj3KQvCiLD0APxfs5fSNGeT9IjfLJofx/?=
 =?us-ascii?Q?5UzjkCTU5FGwT0eRZ7VwyhhtqouJrhnNk3lffeyDhUUhkqi6newWQ9vwqYLr?=
 =?us-ascii?Q?3Ps2xCx1zMQ7zgGNYxD5JsR7kYW0/n2h1O3ygu1NAFCqw+5lBONPHEzIKvaU?=
 =?us-ascii?Q?IBVza/VEh7evihADUuf2Sl6GNUb8VK5/2qchobEzKDfGw+yJBWNcJI0Z5DEy?=
 =?us-ascii?Q?I9glJFcKQM1q4LtasA3p/rb8TXdv2fMvOagpTKbN4EY4h62+9lBofjp7999+?=
 =?us-ascii?Q?6WklXxdizy4/hu6ejW1MjZHiy58xkhE/I40o9o917ioLWAwzx1D95C8IkLey?=
 =?us-ascii?Q?qNMZsQD1liCj9axk6ItrtZ2rrhXxPKl3x+rtzJh6MSbQt/wHqJJAaqthsf2x?=
 =?us-ascii?Q?rv/PEgP4rfSfp5sy9OSpzr9QtioK1JFyt+f4Nhqh+nQT0nWrdTYz63fPO+ES?=
 =?us-ascii?Q?JyW6RfyQ9TCtt4H1qffoU3PPd3mAmlVNgm8zKEgdMGsyWhU6dEX+ESDL4oCe?=
 =?us-ascii?Q?Xta4ZXUOb6eBbD2NT1IUR3+HN3G3bSXQIe06HhPQDiWSf/kD0Lcz0kY7+Uv8?=
 =?us-ascii?Q?xEdsVDYjO7FbGUWOzrfDXU0DDnv84iEo8d7/iqxS6NBwrPJzcueOZma0qKkA?=
 =?us-ascii?Q?G+gv98kPMUltn+smU8J3cPDuwjdFB2aHoChzKqesFwkEjd6wnKaWlDdlwNOe?=
 =?us-ascii?Q?w5G3YX7Ibi9Cebv+Rullxb+fB3m25i3syVoNoM42p7jQoB+KSPi2/Qptivdo?=
 =?us-ascii?Q?IXcMxvOr5Rd6FryAA55j8nYdRc36EiOP2WTxYr39K4gPU/Av3GVtdQA8u935?=
 =?us-ascii?Q?wMQCszufCGwb2FpkNRqCNFuizUMz+i57rbkEXDVxs+O6jOsAiKxKcZ8a6lR9?=
 =?us-ascii?Q?Rs7DnuNG2LeziCeSAtMfxHResyz8xH+BFMqfdw0ZGBmWyMT7XP42W6IBGvc0?=
 =?us-ascii?Q?tu1WhcFKOglBHIt5H6tsBffwzy9LB0iqHu0epbUeqACzBJxSCmB+DyRhOdw1?=
 =?us-ascii?Q?2/Yjuo3lIOpQu8teyZ2orpGxNZce+j43x/NG9GEvnv9Bbf0fqoaVkmO2SCGc?=
 =?us-ascii?Q?Z/uA2Q=3D=3D?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137c0d8c-d053-4e29-9463-08dddb4704c6
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:27:02.6460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxl2Jf3F4NX9skAKRbqsYJJyWiGzHsd53zFUm5MMt0pOAsahoh64XM7oa7NjH5r3/1BoahpIR8A6VMWjPHlv82z4yi2JsTdDtkeI3nf4QYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP192MB1462
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] sigrelse01: Select signals based on
 SIGRTMIN/SIGRTMAX for musl compat
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
From: Florian Schmaus via ltp <ltp@lists.linux.it>
Reply-To: Florian Schmaus <florian.schmaus@codasip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This avoids selecting signal 34 when the test is run using
musl. Signal 34 is used internally by musl as SIGSYNCCALL.
Consequently, musl's signal() will return with an error status and
errno set to EINVAL when trying to setup a signal handler for signal
34, causing the sigrelse01 test to fail.

Thanks to Pedro Falcato for suggesting using SIGRTMIN and SIGRTMAX for
this check.

Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
---

Changes in v3:
    - base check on SIGRTMIN / SIGRTMAX, as suggested by Pedro Falcato

 testcases/kernel/syscalls/sigrelse/sigrelse01.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index d1ed9d53a4dc..23c6758262bb 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -739,8 +739,10 @@ int choose_sig(int sig)
 
 	}
 
-	return 1;
+	if (sig < 32)
+		return 1;
 
+	return sig >= SIGRTMIN && sig <= SIGRTMAX;
 }
 
 void setup(void)
-- 
2.49.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
