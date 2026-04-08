Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B479E10F9961
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775670277; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=OTKfOTdgso1feSOG9kpLxOMxCSsrzY2Z2XCem0CnK0w=;
 b=AZZ30R6uy3mz9VdLqoMMqm13clOi/U350GeTAW99yIfPQIesbzC32KoyIOtQyNbk+dIfw
 07+5QsI185PWCqXrosxGdc8C0gZisCxB7OiUBPuygugL9L/MZiUbLFyVfPg/pFAFE5WMQQU
 AOZ4fqNCSBDInmGMBgNSQzLoFIeX/8M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9D553E4D47
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 19:44:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 456D73E2A04
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 19:44:13 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 876732009D5
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 19:44:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mk7yEhMJK5UZhEE1iGO/MjwVrPGFsknWogNN+Gn+xleYVKfCNQvbipk4nkgeNgZcD4u0pdFIBJKwWelxBa0tyLKY0QdWD/72PvQ/38if6I4ylSrHmKxN+diVZWvaLMbstrq63M2hzErrsMLO0+iQpB2Hya3SKdFCCMuU3q822UBbtYjiog3T+8JspykQ5Ct5xXrCpvgwxeMKnDEamBPAMoqUuj7kekNhwsTHC0X2/a+DBH7+M5WB93BNrVVsWkdQ+UjRhBUdeKeZmnqxGTZMwQI2TZsFFIivEXqcMz2AfE/fjLGAa/2MWW8IFk2xcaJa9S3N/CdS1oVQo28/OvX4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5MmVcSMrJWSRnPSSzBjLiihnfOca4OX9Z6Dqe8ih9Q=;
 b=ID+bUWQ8RjVOxzFHqHjViziCkwhQvflUKvZkFn1QrPMpcruWEUWK0k4oLjtzJI0EKYRb5zJKZBkMuU+BFXkzBoL8aOjXT1g2gxo8sQ5Ey4YPAyKDXlAyhWfZtScb04g7z3zVecyftEpLcmRADbu73gqw3pXfEI10andnAu/ZRxAai3q7kqVarlYqwGum/RdLeXNF6kVW52C//EwiBg81qxUXW4VfqfJWKkvLEsiQrY6EDLSfwlwexGv7/660RcCc3ZLpQhqet7bE6/EFnFepTBbcJ0m5kgw2/oyTV+SVk4w1kXbjtbKQn3Ki0V+W0atTSJNNKYti8WrMFEGhXO5Fgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5MmVcSMrJWSRnPSSzBjLiihnfOca4OX9Z6Dqe8ih9Q=;
 b=HiYBdp8jIW6NSyq7aKT74yH7YmIj+tzs8nEGFT+yeiQcja3OzCviXhyh8XAKxlJ+io4jDo9PY5VVhtfYRqV3seFvkZto40p5xN3wHqkROPVjM/zCkBmRxVvR12qJl9htCc2+ITkI7/PWP7RB/Ln+n+V6mQkZ2Gg9MrVj/cLIy3LR9Vi2FNfy/SnC5/nlCRXxJMQ7B2t92bYytUo46SCltLuo06lohELz8MmvJ+9gjjZlngfkvs3SNJVbDgqwJVaaYlpdH6ToXlIYBAWpPIf9vjf6cpSk28l0mkXmXma/1j82DQlSMuNrRKN8/ATnuPmHaJNo3VUFAZxD4AFr3AwWUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 17:44:07 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%6]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 17:44:07 +0000
To: ltp@lists.linux.it
Date: Wed,  8 Apr 2026 10:44:06 -0700
Message-ID: <20260408174406.1572520-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
X-ClientProxiedBy: BY3PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:217::31) To DS0PR12MB8442.namprd12.prod.outlook.com
 (2603:10b6:8:125::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8442:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a12afe-5c23-4999-fd3c-08de95966f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: ZGGWHUpAYMmQ0iIMEYfHfTbComJjCofZU7E2qE+RQqXMsgeGi60ig9UqTm7c4MbEgE3S5uAHwZQGgu3p7kqevt0ucW17QZp+2fYPKDT6awsxXM6TBu7cIlzyJ8YQpEHA7VdxKLJQ63jTDs421xD+E/+Z7RVlX3lKJn5Mfi3LxEVgt7bSuUoni+S89zfc6dIZrVfvcoV2+gefj/BBViFxPS54MNNYXuq6X03OlW1i8wy675EuNSf+KoH6+mYJK/wt0OpLu58957wsHsMghoBx0NCdBu3nZtKXbuRz9OKll7IIQn+6tJyFj5ZuXpZn6sTVbxofY+axLyRzqi3Sk3zcAh4kMHQOvJ2jIQvgHYQ13l2p8tGZ07OCjy/3rDgp9PD0PLp1L40gEr2mEpefVntufCTZFpCEa6x5bH1ZtIf0dtT71RqVxfEhi8dia9bL2J80wHy8uRz95PPIIgeeLneOIB2hEkgKXny5A+CPfdEn0A501719h9uPwMVvRCB4poLQdo9iYVAswmY0N3tVmKbKSC5n1yxLuLdGXN/hpapdAhJjZVvAPGDFG5t4YK1u5yXSuObBIcuzjcEyJp6bHNGP1nCc/uK0JxU1GKTxybbYH51D3NJPsJzPe9fSNRZrf4EEBDo9mTtU+RLixjtkoNloul0N8agaw1xsYkbAXFpEpxAOky6059hUlkAcFO3fsusUiDhC4+HpiggsHQJ2OpAj7bCTeXjZM4OUUUDaZsZNCnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tb8ef2yBUCJReZv9/PFJwjdbz9B8tSbsSAKGofrbNtSSh2coPQM3HGFqga41?=
 =?us-ascii?Q?vaypsd9Pgo9EQu97mToof/HCyu/Q/DRnRhOvnFfh8EnUJ7JWd2/uoQL+QOa6?=
 =?us-ascii?Q?brc0CzlBXr+a3qaAeU3h9hZw3hLADRpzNwFRqHrdlPd7nPATj9MNf/Z01Fqw?=
 =?us-ascii?Q?Bsge9fzvdsQYlWy71S0JqHoaP49Fm8XSuO46y22oUKryqW3jxpvdUfJ56TsB?=
 =?us-ascii?Q?e29b4+/BFrXDAmx8hKDnAYrZNjJCHN67JlRyLtCy0H2PTgm89DXiZX5yp/HD?=
 =?us-ascii?Q?cBUyHFuo8xV/QZwlKEOPoIr7JWxlqfzOCQqnBWNKg0b6g4sGvJ+J4mVXvGV1?=
 =?us-ascii?Q?ShTyXJXOUhv+jOYjcETfqJB3/LX6p0wQjPW0AcElN6F+GOdbywcQMguLV1II?=
 =?us-ascii?Q?VcVcVhtvSFJWBoVi2QM/El/X6Z/dRl5At8037oWJYfSfxUS5+Zv9FNkH0+mE?=
 =?us-ascii?Q?jnqKurHniOfJ+6IKp0gOFzSceiseim+Faut7R+vtsIb7yR9XC9jewwQHJxkR?=
 =?us-ascii?Q?KeiK44IQ/X8G0S2Sm/jQQZRAJThp9voEdtKSbpccUU1pdPN/p8FdbpAW97He?=
 =?us-ascii?Q?xSALP8hzpJAkGwnW/XV2K1Us4YCuWmEQ+cvGb14MZXvcr8G6x5OFKWgGyo74?=
 =?us-ascii?Q?5/gaz8bBDzdGQhlm7Y6iFMa0fYKygBfiDsvLPmIc/SfVVPQsd6qgqgXMXmPG?=
 =?us-ascii?Q?I0JfAHLeRvCAm2SSyubXalpdnSGdd5ZoUVkPQg1/Z9PDyKfGiugjBKN4AE9i?=
 =?us-ascii?Q?NVDGbtsFJKt4HNOklGT4u/HcqiJbveiiVwH768dyj19D+7sJLbvMz+3viJso?=
 =?us-ascii?Q?4SD5KLzw5lCLku28eyWGCUuk5DeePpFEvOptvnhGgdQSb7QgBovIwLrmDIEt?=
 =?us-ascii?Q?16StL/+kdE9SYkTxHq3IfMXqLphbERYdoe1lieMAtKfQj4wXoG1aQWssOxR1?=
 =?us-ascii?Q?ofB3hMmoqBpEjbRdgbQQHHR2xr+EJxkpWtVAoLmyopxgYRiYyXmvh/+3aIPy?=
 =?us-ascii?Q?cQqBc/c/FZ6TbObcq6tLTHmWBkgqEQpwdx9jqTYZSGTVm/AvP9QaqkibzNcg?=
 =?us-ascii?Q?/P7tQHAqM31MNyxb5mluyZHGwQgwjaKYHMq8Wo9fWqSxLE0O91u40U1AfHb2?=
 =?us-ascii?Q?1JfRkZfHz5tmviwIOd8TQpsvbC8dVo6CofTmsVD3fia05yBZinb4fMNhRd3W?=
 =?us-ascii?Q?jVHfFiStHiVROF9Ri5J6iTprJ7qKSRms5PoMDYhX7fnAefQ3cdaiy56hWHHZ?=
 =?us-ascii?Q?K6xMlAlwmnRgWdTU7rCNPbcesPVHL0cEc8HlzcY4Hbra9AisMvRTkkTEDXkI?=
 =?us-ascii?Q?WNtl9X89nmyYSbHwno86N0jvLCSc9cNiEKL9LSI7cCoSQTgFVidA1mXmPGRB?=
 =?us-ascii?Q?RdW24FmICucjMwh7GH5YlVQjXasKdHEx/K9FTuGYVPPXoS2CG2kCcgan2KIG?=
 =?us-ascii?Q?yAKiQdw7+f/3WUodYfotofgNWL5EUqLNSPv9NDw5nzUgMbD619NIydr28Izt?=
 =?us-ascii?Q?WcBvm9pQA+yTwT+YRDmiLmIO/Hh9iQ2mSkxeN2TyET76D+Zpwckl2ZlqLxHi?=
 =?us-ascii?Q?IBsWN5z6m3Wq7smOf6BBq3yqD4+/J6jZ72DtHOnVGUnt8nKRzq7Z1mqF6xtx?=
 =?us-ascii?Q?w9YZjHJtU2faApJtdPBphEahjeaq/42vBPGFP5Ti1OCIYGWHodzkOppQlg3G?=
 =?us-ascii?Q?ITuiVZoP6C2q22wewBhqTJFY+Hp9kLbBMxMT4H2IzviTKYpCR3KG7MJlNopF?=
 =?us-ascii?Q?pNuMnhBPTA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a12afe-5c23-4999-fd3c-08de95966f1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 17:44:07.6059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMNtZ+pUFJ0p10m0KlO1gfG1OwcURQwYHnVZJHIsNl32kDfrwUwgccgkDrBXvf5i+UE0LYSJ2Yje1jkthXRAlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls: file_attr05: skip ntfs filesystem
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
From: "Matthew R. Ochs via ltp" <ltp@lists.linux.it>
Reply-To: "Matthew R. Ochs" <mochs@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP mounts ntfs via ntfs-3g (FUSE) rather than the kernel ntfs3
driver. ntfs-3g's ntfs_ioctl() returns EINVAL for any unhandled
ioctl, including FS_IOC_FSSETXATTR, so file_setattr() returns
EINVAL instead of the expected EOPNOTSUPP.

Add "ntfs" to skip_filesystems for the same reason "fuse" is
already skipped.

Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
---
 testcases/kernel/syscalls/file_attr/file_attr05.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/file_attr/file_attr05.c b/testcases/kernel/syscalls/file_attr/file_attr05.c
index 6c1471da33e7..85b6cafc5f17 100644
--- a/testcases/kernel/syscalls/file_attr/file_attr05.c
+++ b/testcases/kernel/syscalls/file_attr/file_attr05.c
@@ -49,6 +49,7 @@ static struct tst_test test = {
 	.skip_filesystems = (const char *const []) {
 		"xfs",
 		"fuse", /* EINVAL is raised before EOPNOTSUPP */
+		"ntfs", /* mounted via ntfs-3g (FUSE), returns EINVAL */
 		"vfat", /* vfat is not implementing file_[set|get]attr */
 		NULL,
 	},
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
