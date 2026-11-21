Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC7606A33D
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=MsZJiX5u;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LQlwMX/O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795428680; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=3jMNOhfEfHoaYmaJRHEsI0taKMpnQm4WArmHjoMSaMU=;
 b=MsZJiX5uI2QuAZ9PycL1GR7FaI6nuFqyg7jZjv/EcuHo0fQWJVIAAljWZHkgtzMZY2a0j
 v1MUh04nD77xZUIv9ZYxu01Zz4GJUnZt4cyXcCk3s3LD+NMIQMi5TotcXYQDQOMAephjV3W
 aY6sPLne3rguru7OcI8W17QK+JDMs28=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E035E3E917B
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 11:11:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED5DD3E9FAE
 for <ltp@lists.linux.it>; Sat, 21 Nov 2026 01:37:12 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5D5CA600D3F
 for <ltp@lists.linux.it>; Sat, 21 Nov 2026 01:37:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2EEIlWlOrYeGUb7R3CWk0mS3QGe/FpMknqooc9WyM30muWxATIuPP+k1jMlIuUkuTN7LWw9pPWmoIrjKZo7Omacsd6pV6IF08dPoCk7W6t56wDJkuxSv1j0VEMQ+yGSIz4uiqHdSSNxag4xaEZbkSFTQ/FJtgDuB+8RSzLclk6xjpiR2OISGSqRbdsUguojalP3Y8y33D/NkIgTNsYC8EsAzVXdL4lBOhSA+Z4JLYjXoNjWsHXK4n3cAcgCP5WDYJhpngpH7/WEP05WRp9pwZyWdOcDJaPFroCJfOFLljSBQqumN6zvAJvrcRHwWJLVAdqLP8E92uuM4aTfHoD1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paGNkqs6uxm6+LPQj8M5Yc/P7kGSpnP7egJuW6QO/d0=;
 b=hcnuCaa2tfEh1/cRYHnHnDmiA6kfIsH+UxfXvmv5+pWUDtp+8OZ4C0B/pYy+9E1/PxnVfWDdinBHGBBFlwbPotRJIhvGBeO8iAYUcT+N9dNM6/khNf38/3l7MPkYTKM6rYlKOh6uGaFjnig3IsDmJVM1xcPPMz/nTrpwU2N9h9G7dkaWyaqkuf6eFftaXbm8dy82x2XWRl6kA6KxUoq+vtOZ2P3WeBNu/KcxuKieQ6o59HiPABJBqwI1qUoFLt67HWR6WCPPCqCm1bF26AAAHEBXX5owsyhNORRs6NjksxNBfXs8aIO73Pxt2RbxjH4EwSWnAViqfBf8KZ5dV5wVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paGNkqs6uxm6+LPQj8M5Yc/P7kGSpnP7egJuW6QO/d0=;
 b=LQlwMX/O5WiiKuNuznf4G/0HSdUb+GKwI4wg9XzjBndhtxg9CBTH607OVUrUNrBv6St194kcVsoi5REoISpK8j5GmJ3fEOrS3dW7XPXv+NxT3Y8yFioNHNG6JcoSwYVsR0oiTYqfnN/H+AGVBt2D76BEuMylugOn9FGJPZBbNVdBDpzfLGcm2Nb1wenaJqdkpwIGy9X+1XBO+UAotWZKBfd4QCc1kwlYcxDaC6JsUfeqMUjb/61F9R6bUC9AcNaKzUP0ecb4KrMaS/qQxhAH0NjRTMttmzVboV14rYN3IK5yJ91CGn0Rs+vNI0jwMQdzYP0sepA678fBa4qPoFJ3fw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:b7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.10; Sat, 21 Nov 2026 00:37:07 +0000
Received: from MN0PR12MB5786.namprd12.prod.outlook.com
 ([fe80::ae61:c9b4:847b:4854]) by MN0PR12MB5786.namprd12.prod.outlook.com
 ([fe80::ae61:c9b4:847b:4854%5]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 00:37:07 +0000
To: ltp@lists.linux.it
Date: Fri, 20 Nov 2026 16:36:53 -0800
Message-ID: <20261121003653.179935-3-bmak@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: fb38ef7e-6ef2-4906-82c3-08df4767924c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|261009223027099003|11063799006|261026121527099003|261026140227099003|56012099006|261022105027099003|261021123027099003|261021121427099003|261028144727099003|261022115727099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: lXsqI8qv7pezVe2m1JrV6/JiGfdORN7xhHkhQ/9fxO3sryQ4rRN32iusvvliBNK3gggzoVkXpTKaDEv1FXYPC+Tt9Vh5+QsQG9GubdVmQqxCh6Qzk090O3s5+L1TzyReNJ5vfdp4ix2p53+0+8FTGF+GK2hUWlvmsS8qd4lP58HTWEStySFbrpPPyPWk6FctWQspYEdeK+cg3+ck6miTNqMhuA16yH7LTfL2yvpqhDpiia/gYvsFxhpj6oV0t0Vt0aXpvEvnk2MMnuFYIvqO6CxDx+WfPCNRPre6OnZyiEYIIC6Rn/nFrbxPKZEIV5WyA3wT6LvE8gOjCYajEBxTRzXTTnXbAM10j+XH2OFh2AHWvU13idA1zZk+iThD4UiKx+rquzTzHAp/gsbw7wVVCFoqnpFP3D5HoUmRBflppWYhFW22FR90KZeP/VZWj47qlfSxf7rQgvsq9XpeDJiJuSfcKYZ3cGh3RLPtFd1LC7mc4F/uD3UUinjPr6JNLwZemgUEX7bkvf0FZpY0dU6f6jdmfBNTXUy+btLGmWeWQSE+uQhh1+JwLcbRTdr47WRwja627L2epWS4GRCeEtxE4ppTy2qlz4lrphxZentYlg+2EJ7h/ww/lsSdXCh3lZpKtqj5yrJDqowL4vKRgYY0EtMiCBLrY/leJs+A73TWUYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5786.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(261009223027099003)(11063799006)(261026121527099003)(261026140227099003)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261028144727099003)(261022115727099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NvbBtO8EsAK9xpe0AIdDmCLd9gHfad7EEOG3KWgVYAK72Zxuhdvv4EsEL01K?=
 =?us-ascii?Q?FkRCJoLC7ROkhdo7EjJYwlw0e/FA5StUkCVBCCAqdUteqSDtuQCZbotB+MUU?=
 =?us-ascii?Q?e2UXmTKzH0/E0HL0TiK0XdixwAspBnHh3BKJX6w4zusfRhOijx9hTze2VqN6?=
 =?us-ascii?Q?vbi3KhF/ENaCk2xnjbuFBrwyAevXTG0dmuShuw486HpMqgoUVjC3FbgS4tNT?=
 =?us-ascii?Q?og1fKeYC9ynaJpFd6Cz7iGQ7ZlGgfOdvZOV+6YDEkKPHbO9mQRJHrIWWbcC/?=
 =?us-ascii?Q?Br/pp42WwfB3YVrJ0tmym+iveH9vSvLTnUpUOJWAfMSOtgFx3MOB07eeMLaU?=
 =?us-ascii?Q?GUmkFQ+7QYzYEBAMg05wEwZuy8P370GM2yboT5QgkEoIp71r9O/O+Qo1WAc1?=
 =?us-ascii?Q?v9Yy8LxMZ4X+ZxrSmaGB5k0AwLCeXYVFMJ/Uz8KsSL4YWiue1Jy7YrTVtSxw?=
 =?us-ascii?Q?igYZikwEsTD96XYOu7g0UlTvZjMJpYBnfa/735b0RCJqLeD5dqvZa7KL1ism?=
 =?us-ascii?Q?HMY9swGZarQdYHuSWd3lErRlgOS+K2jL7+0DtgFB0nn1vI7cQnuEbZ+cHemD?=
 =?us-ascii?Q?kElnR0dM3APqpeGSx/ey2GqDM+EUbCmEzt5ZkjwO/uScKbSxK1bi3IvesDtH?=
 =?us-ascii?Q?EUNJ/Sg/NnvCx2rEDyhAzdlGq6vnPFguKG0zKUa+5nYFIH6FnkcS+tcojiV9?=
 =?us-ascii?Q?JhIHOXR1K/LRcy1atGP4tZNdQivxlG2E9PnxKymLLnVzyL8C8nSGtcDPBVBE?=
 =?us-ascii?Q?NnJcnshONdfx7cMc5CvbqXtHug3X/cmjAWMnupk2ue9AVwn4bTERDrZHDXwD?=
 =?us-ascii?Q?ejh+otHaAduU+Ztpdqg7rmi+gYjjz43A+pefdtQ9iMqenJjz0kwHIcV6AAZc?=
 =?us-ascii?Q?1lJqEBtUqBbi6veTN0x/HQIailZkzdfMlgY9ay/1/GWEKbqWWLpjci9z/C1k?=
 =?us-ascii?Q?OcDLRZey0lZJYquZp51pXD1d95J/lKJ9K714GNjFkczJjKMs6Sd6y1jmJI8f?=
 =?us-ascii?Q?wB3lmeOX1kNTlOYfeoilLB/mOQZ1ZeN4BWWCEs5O5LPvdKrAXIzTdSKFDc49?=
 =?us-ascii?Q?dC5JKpNQD0gHC4stjk2lPohSzODfRa2n05VpyW3FLIQyiOPllq+CGwbQrMYr?=
 =?us-ascii?Q?ER8CDcKpAqB2eKJvgwk6M2L3OKythGSZmVdji8UHkRIcCYsPF7B8t0TYc/h9?=
 =?us-ascii?Q?JY2R0i9xmEz9f2aBMWKnfN45Fu+0Fyud0TCROZ5CMPnC2Y3Ak53sBo5QCg1U?=
 =?us-ascii?Q?xm5Yo43U/uqIQirPwEtK4BGhWdwi2kIqFQr1pfc0hrygB/tqV6B8NVI/xi6Z?=
 =?us-ascii?Q?X2wQEeH95EHnFQb1viZorzi6SEfYRI+h8c3/f3yZBuR4DtpVunXKUTejQjP5?=
 =?us-ascii?Q?HWvu5/Sxce1slSIvLJGQtYWFqGUSeQnOCU3mjherb1LqfzF+y6Ssv0oK7qCQ?=
 =?us-ascii?Q?Ndw9e2oKQzkR175jBJWprYfVRkd7VvbR4ycSscBLTaXuFpNiNtHuIKOCaJVQ?=
 =?us-ascii?Q?jilO+IdoUjsxP2JSIUovzFD5mNRH5wHqqcgVHB3GyWexOtaFFhCYSn2EQJq2?=
 =?us-ascii?Q?cBNL4I8S2DWhG/YKD2SAFXXeyg+jJFaA1oQQnVDKR7LnIyiUcwhvme/o43jR?=
 =?us-ascii?Q?uuKMSGGJ5wdQoSZOgDH4Bbg237mzGsSwFOBPFrmBFe5NRDpRC+E1E93stYvz?=
 =?us-ascii?Q?acxc7MaRgDDT0djP49qi6e5n5wL/eG4VJOD9jFqS8PqXfzcA3QTjbiRQGd9q?=
 =?us-ascii?Q?z+dRCLN8Lw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb38ef7e-6ef2-4906-82c3-08df4767924c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5786.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 00:37:07.3420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EvL8vvPmN6odmreMpRNKekJTLPJNaoKD2647MeKR5iiZu+2SpwQrb16kKo4EVw+
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
Subject: [LTP] [PATCH 2/2] tse_swap: Fill swapfile with zeroes on ntfs3
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

On ntfs3, fallocate() allocates clusters but does not change the valid
data length.

ntfs3 has no ->swap_activate(), so swapon() maps the file with
generic_swapfile_activate() and ->bmap(). Since ntfs3 was converted to
iomap in v7.0, ntfs_bmap() calls iomap_bmap(), which only returns a
block number for IOMAP_MAPPED extents, while ntfs3 reports the range
beyond the valid data length as IOMAP_UNWRITTEN. swapon() therefore
rejects the file, and swapon01-03 and swapoff01-02 fail on ntfs3 with:

  swapon: swapfile has holes
  tse_swap.c:228: TFAIL: swapon() on unknown failed: EINVAL (22)

Fill the swapfile with zeroes on ntfs3, as is already done for old XFS,
so that the whole file is written before mkswap and swapon().

Signed-off-by: Brian Mak <bmak@nvidia.com>
---
 libs/swap/tse_swap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libs/swap/tse_swap.c b/libs/swap/tse_swap.c
index ae3c19313..a19e97556 100644
--- a/libs/swap/tse_swap.c
+++ b/libs/swap/tse_swap.c
@@ -145,6 +145,7 @@ int make_swapfile(const char *file, const int lineno,
 	unsigned int blocks = 0;
 	size_t pg_size = sysconf(_SC_PAGESIZE);
 	char mnt_path[PATH_MAX];
+	long fs_type;
 
 	safe_statvfs(file, lineno, ".", &fs_info);
 
@@ -177,8 +178,11 @@ int make_swapfile(const char *file, const int lineno,
 	if (prealloc_contiguous_file(swapfile, blk_size, blocks) != 0)
 		tst_brk_(file, lineno, TBROK, "Failed to create swapfile");
 
-	/* Fill the file if needed (specific to old xfs filesystems) */
-	if (tst_fs_type(swapfile) == TST_XFS_MAGIC) {
+	/*
+	 * Fill the file if needed (specific to old XFS and ntfs3)
+	 */
+	fs_type = tst_fs_type(swapfile);
+	if (fs_type == TST_XFS_MAGIC || fs_type == TST_NTFS3_MAGIC) {
 		if (tst_fill_file(swapfile, 0, blk_size, blocks) != 0)
 			tst_brk_(file, lineno, TBROK, "Failed to fill swapfile");
 	}
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
