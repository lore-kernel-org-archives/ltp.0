Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDECC606A33B
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=SFQU9ylQ;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NNvnBsl0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795428662; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/inhUL80OMDm2n6kjFZxd5qExfsLqgEqp2zKhjdtVfc=;
 b=SFQU9ylQ0yLL8vrogvylxVprZv5pkMUWa4TkNyLV0ZSzuvJ7GFc57F2zBx6xJkdcDOYNC
 xVNltqSgsvknMIEw8+JhnCLW0SCONuKnuSRKNGoieu7I2RJ/ma500AdDRobrC+OFxZ/LYcI
 t/Kq/MZid0hrzocqY5ORpP2s9drYMAA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 845483E919A
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 11:11:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BAB53EB1E9
 for <ltp@lists.linux.it>; Sat, 21 Nov 2026 01:37:12 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AD444600D3B
 for <ltp@lists.linux.it>; Sat, 21 Nov 2026 01:37:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPma4p0SrzvsoVDU9VUzk4EqTgRbmeNcs7QH54L8eBUHDkRIGZZGCFH48evESRF40S8d7tmAnmxm7jsm1PIEv8W/tqPPcLzHmItn+zVZlUDwSgmSeNMarz//TOXl+C3yzJheitHwQ1DtUJ14GR7+EqeqbBaW6Tc3n2EdF+qCdBBwyEL8Yb+/P8bx8ZRTe3Ik+w360QGr4DQw2b2cglFGl6YfgDQ6XjrhWv23cc/h0PhPDoH0AQo1T7wqofm7oEvMsKbLXvn8xLCtIbJ3z594RwRfi9jdnqdHwP3yaEAhGmFrpUvk92HbGqCyO8FZxIMXZ4HFFvOxqHX/7d157piYWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQCEH9qhs7ZCV51Lb66ToaAreXDVbekfCOZEH+E9094=;
 b=CcvibTs230aPCpxQwmuLKmy/5/5wkc2n/ie+t63vlQmFy3OPF0OKWcSitMBluvYQK4xu1N/PvHv5PG5mdokZg8gzRFtL/prnrPaxYa2/+ifsBx10d5UiZkeL+7lxknibZXk4AacUIXO5pk65xq44/HV6aTKUNQ0LuND14QYV7LbZGbO7O8g0IWmk+DK8PjXNmOZFgY/gWvNrT7jmVCTPYxLjn6Rs3TYozHtUMrIwHANRXQsShJzkjKrqKPLc0nPAuvOvcY6dOEz9lNtA2NUoMUjTuSoWMdzAzwALEttPBSZXVFYfqF71rS2Q1fmaejm0P75GtvrFNmQMHK2es0Gk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQCEH9qhs7ZCV51Lb66ToaAreXDVbekfCOZEH+E9094=;
 b=NNvnBsl0InYulfzcWwMmWayYW7BP3idynWS4R8eUHp0gMP+vNl03OS+ISFnvip8Haosgvu5gfWCcO2suEysHUg5I6djUl+WYusuluorNh/5v59ip3XV+rC0C1FDRfEHOtkusUCEgdI+J/MTUiEG7IQ13N+ix/mgTxPifMziiZilSCy9ARqDG/WlVNmKMPIAZJICeydeUz9a9Mm+CBu6jmTQxfnpS1rTGaa4iskQClvkR/cSyvfmLUGuz9JSVPH+Lr2TwLrgh7cCrEfVnjnUGU7G8yXg+3SNxmW3Pj54dUhTLUfGEeY6xQz3/dSOOeKhkbudchpxgGJPLXLr34ljJJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:b7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.10; Sat, 21 Nov 2026 00:37:06 +0000
Received: from MN0PR12MB5786.namprd12.prod.outlook.com
 ([fe80::ae61:c9b4:847b:4854]) by MN0PR12MB5786.namprd12.prod.outlook.com
 ([fe80::ae61:c9b4:847b:4854%5]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 00:37:06 +0000
To: ltp@lists.linux.it
Date: Fri, 20 Nov 2026 16:36:52 -0800
Message-ID: <20261121003653.179935-2-bmak@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121003653.179935-1-bmak@nvidia.com>
References: <20261121003653.179935-1-bmak@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0297.namprd04.prod.outlook.com
 (2603:10b6:303:89::32) To MN0PR12MB5786.namprd12.prod.outlook.com
 (2603:10b6:208:375::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5786:EE_|DM4PR12MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd587a8-d081-43e5-c703-08df476791c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|261009223027099003|11063799006|261026121527099003|261026140227099003|56012099006|261022105027099003|261021121427099003|261028144727099003|261022115727099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: tyhK4r9LTAFPdOn0fbRLZwD3rGX5pi9K854LpDx70lewNuStU2/uOrEw4+XZfwSDdomT9Go0jJoEFT2AW0lNbtbhDuHFHqtw7t7wEc7neoBApTW/DhtC4+sPGUuRs2+1iPrQaLkUcUxEXaNo1ZHXxDBVoCYhfl1UpbpB/RF39dU9aT6xhP2tc1g2r02EaZQnYxnDPHlA+amIarznEGzqxhlDj24xqLeQ/vNt55JfKhj7ezZ1jFd3tvcAjNkwY33c8kgBg8zArWxnFuwI1xSds70wOVRwN8PA8a1ZUxR23Ma+4vDvsHIa1BEXqirIKfNkSZ+RHUzA7umaBSnL3fvXFMMrIUmMRCNtOA/bXlWHg0KAUwcNQLfdH39QAjIL/AYvVBToVKoiYz2vsirCZMC01P6cDceQ5fMML1MNxvOmcNmx8a2Z1DFxqUpT1Jrs1QAni5Oozna7S053kf2s4Jz8FPvWXcwOh5KwHzMxLi4F6qfi2i4rxVYFWMyrUQeWJbxHJcgVrUsd/WPRegowRB74yIoQgOHi1CurXNJE3UVXycOyVJ4TV3QO7pMa65wCpm4eMLlZGYY/sbvH2+1NeWz2jplNTeH1IqE/Rm38yfe+HtWWK9r8FOQEAUufpUdOSR2pjR6bPHSsefPC7hJ5vWAVGj5Ha5FNDE/mOJwSsLohm58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5786.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(261009223027099003)(11063799006)(261026121527099003)(261026140227099003)(56012099006)(261022105027099003)(261021121427099003)(261028144727099003)(261022115727099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V9qJgsiQr9R+JmGiOrdF92il4DOATrESSHNJxMh0Hq8BpnP7M9+I/YVatOQE?=
 =?us-ascii?Q?fuOl/fycnBU4WTvS6eNb235BstfVPLJXcbNTAbx0prtls2+6R6lr2GNoi+s6?=
 =?us-ascii?Q?3NS+H6Ydj80iZuMlh+Ux+2bxty/S1N9Q5p1HN99aqL8bDS1EEwifMb1nsLCJ?=
 =?us-ascii?Q?HFitquz3RvwbzR4euAwQQv5+tWz3Q6kxo1nF7QdG7/GF5U/flwbZ+YvP9+w7?=
 =?us-ascii?Q?3Ud4Di0QSSYfi/1f1xaIFpH7Xh2UpU2VxEGnnwAebc7mam76wTeNkyF+fxGK?=
 =?us-ascii?Q?J5OUql6sXDO5J6y2Sxv5M6xCV99EflhkFIeqkSDBeAYzZ25i3/g2J7nYd3Kv?=
 =?us-ascii?Q?kkO+hrCBV2OK1RYDoK4C/zHmKpqfa/BOec6PRJeHa6uaaFQe9nHCbD28eNt7?=
 =?us-ascii?Q?ZbfEsPJQ6NxQfxwE3e5wvacqkPHjFzoGVkd6wjiEIDSLQrqti4TKOAH1Pw8J?=
 =?us-ascii?Q?R8nQxwcZNXKKTb1a4BJLt6K+FhLEsCjf0tBw1ZuZ/gJ8AG+fDpGV3onfGNiW?=
 =?us-ascii?Q?4PoHaVRKbdPJz6IIj5Wz/nYK66gBX3jab1R44axs19z3TbPOqbMzWaOWhPs2?=
 =?us-ascii?Q?pEBZ1y4CP8HWP7MEY+ACipLh8SrEn5DzXovSmiTCPxzzZqaRwahy70nH8c8N?=
 =?us-ascii?Q?b7+3sRN4tgDMKOAl2QmZsqW6vaT30v8PqiTW8gbDL9oR1udSm7qlFkCOZYqI?=
 =?us-ascii?Q?5vmjCsj7R46iZc6mtLl3HUHwcAitVG+78MJQ7NEbiVNXpwvAvb9gAUfMKraD?=
 =?us-ascii?Q?4nvU7NA/Bh13V+rq/yzvx+b3T9K9m11acVy8R20JRYVS/Ae++aXrd4E79Blz?=
 =?us-ascii?Q?M6ZqJqsDS0SeoR8Aishzy88656dzZ8DV++mIodRneYi2KSZHzOnkfSi7Nvup?=
 =?us-ascii?Q?CjndIbk0cLqXWsKHWRDXRAQs0iZh7fiFuB3jVT0lXpHhdVjTvZhNFlO1e2+d?=
 =?us-ascii?Q?V6gF9Lrp0JQaKZoal+lEQOV99kHdVYSySvQz9dmLpZrI6ZBUC2uOvD66yT4R?=
 =?us-ascii?Q?q0dYWVPR6EVwy1PzZjal86PzregSvd6G/KRHFnZholmmVYBdsWiclLS0o8+9?=
 =?us-ascii?Q?2sIBNJAArxImw2oZwh07YtzdC0EVKO3KYyumtBJXbtfibJ8X4dRD2PkpBccx?=
 =?us-ascii?Q?qQ/LHCiUGqmwbo1I7pmpxIDSXl3HuRawdG4UuVwGzDFIJnyodbEx0ToeHmNF?=
 =?us-ascii?Q?MAb68zZtZOhTFVVpAMqpDL+qW4MMO1KEdxM/kG2h1r+v1iR1yxsSa7hL+83S?=
 =?us-ascii?Q?AMlX/79xsWWwt/yNkpSOpRS5Uf6rfP6wWF6jrJabHI/1nz2/oldEJyETlwYB?=
 =?us-ascii?Q?yelXlsIZPsWGSk+trbUFkZbTxAfXTeoHVJRlgnGGkzxmDgO7JqYJc9TGkJu+?=
 =?us-ascii?Q?gRFB6vsGyf+ZKt9jy3zEs7Q2X/Yv105IDdajxTKnIwyr0PIIQZXss5HAlECn?=
 =?us-ascii?Q?Bk0Z5NWmrzE0ihfMJw9e1wmjnCVLJyCcLtlKK50f8LTR2BG+CbPTvcarAe7y?=
 =?us-ascii?Q?lDqXLjCiQiGP8t/xCmog+CO67m80cq2qu6tY2fxxkqIbXOYgzhbUupGEv4W7?=
 =?us-ascii?Q?IERF43HKXtzg/eq5Zhqvs5thVYmBwT2Lb61kf0UAKJfKGycQNA75D22E85dj?=
 =?us-ascii?Q?NJqHG+PVDh6LFQwM9l7A7v3plB16he58Q7qWkXTEnX7cqCH2wOdCvsrzbqhd?=
 =?us-ascii?Q?9XCZ6kWTkNR8uDoWRMh1CeIXvfhOjzFQdNbySjWkCkqLF1Ai8mVIBHEd+slU?=
 =?us-ascii?Q?GKoWD2CA0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd587a8-d081-43e5-c703-08df476791c4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5786.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 00:37:06.3700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLQGlZQjRc34fRcyJzBawsS2C028ZKyBwwyHumlTygj4bTwH7ClCq/fP03aHACPg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 23 Nov 2026 11:10:24 +0100
Subject: [LTP] [PATCH 1/2] lib: Add ntfs3 magic
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Brian Mak via ltp <ltp@lists.linux.it>
Reply-To: Brian Mak <bmak@nvidia.com>
Cc: Brian Mak <bmak@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Tests currently running on ntfs3 print "unknown" as the filesystem name:
  tse_swap.c:228: TFAIL: swapon() on unknown failed: EINVAL (22)

Add TST_NTFS3_MAGIC and map it to "ntfs3".

Signed-off-by: Brian Mak <bmak@nvidia.com>
---
 include/tst_fs.h  | 1 +
 lib/tst_fs_type.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 80eb1292e..0a6c863cb 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -34,6 +34,7 @@
 #define TST_FUSE_MAGIC     0x65735546
 #define TST_VFAT_MAGIC     0x4d44 /* AKA MSDOS */
 #define TST_EXFAT_MAGIC    0x2011BAB0UL
+#define TST_NTFS3_MAGIC    0x7366746e
 
 /* fs/bcachefs/bcachefs_format.h */
 #define TST_BCACHE_MAGIC		0xca451a4e
diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
index e9efb89dc..703225c09 100644
--- a/lib/tst_fs_type.c
+++ b/lib/tst_fs_type.c
@@ -74,6 +74,8 @@ const char *tst_fs_type_name(long f_type)
 		return "vfat";
 	case TST_EXFAT_MAGIC:
 		return "exfat";
+	case TST_NTFS3_MAGIC:
+		return "ntfs3";
 	default:
 		return "unknown";
 	}
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
