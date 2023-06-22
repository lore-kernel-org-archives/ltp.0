Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64F7EB64D8
	for <ltp@archiver.kernel.org>; Thu, 22 Jun 2023 14:51:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53AAF3CDA43
	for <ltp@archiver.kernel.org>; Thu, 22 Jun 2023 16:51:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40A4E3C9AAC
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 16:51:05 +0200 (CEST)
Received: from CO1PR02CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 992BC600043
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 16:51:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVc0pbnWYj8nA+is6W5chojPjTXhpL9zabptAJ9B0FNkvjCMmo2WzT3fqV/Hr+cKUt6ma1lvAGz+/BSgqr39eN95kiK6gJ79FwBqXOXuhGauh5TfUhbD+h5fUpCafGB6okpNIRCJtrHrOdUY17MCgl9jvJmiDE1OKOcHGLFWOJrVmA7/RvleUxaZVaXKjvjGSp9Jv5xKhplDTK3/5JltGrLWTZhcRa7SZ5FW1Qj/qTjGgENaPm4ed8BWMNdY33Pt1TIZqxPQDcH0w16Y26EfUc0nj3KfM7qvgprXlGm1NKU6NXkDrIV0uD6cCEKYr9L+QkCIjKBk16hKzVTsOoUtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOvE2ZGTrWvcxap9W7kBOMpurnYjEJhYRtih99MYiWw=;
 b=igf7pUqLcIbaGoqFhQ4iGtk0EvFOudHDdbvrB8aZ00vcgD0alIwsTXM7HU7AGZpydxYt0mxpQ3Y1XNFWAjWPAz2hAcWCJYguuARxXszG7iV7bIcUBZ/IQtpYmzvyvdjh6eJgtnrgIk2TSVZjS6AMHVPNs7OeNulEMzl00HqDfGsgddk+B3jqSmPNzgnsDY8wGfPZXwn2DUM3dPfz0KuPupAPTUhkY5MK7u0kEVJHBkGCLDxovAH1+h8yB8RFAq41049nP0NrBAlELRxe9ST1UOvNo52b29LVnv8XDWhcn+/pqmC8DDkbtaEbLNCMGaAKHoZEaii4w97MG2dTYMmmng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOvE2ZGTrWvcxap9W7kBOMpurnYjEJhYRtih99MYiWw=;
 b=lKDOfh6Q2VGxlMNKGMq1k88uIPIGwKkpMa2u/TPTWnDG2w2O2Xn6w26RCSY4r8WFJSI+gSKMsQHJF5k5pShFMgZRqJfs+4Rdk0PGg8cLgibeEADlxyGDmNeaSq6GL0X4lJcxY2/mUPN62OdQiX7/abxqL+h4g3GlYF8zkHLnyoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BL0PR05MB5409.namprd05.prod.outlook.com (2603:10b6:208:6e::17)
 by PH0PR05MB7733.namprd05.prod.outlook.com (2603:10b6:510:2e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 14:50:45 +0000
Received: from BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::68a4:3da6:4981:4793]) by BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::68a4:3da6:4981:4793%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 14:50:45 +0000
To: ltp@lists.linux.it, kashwindayan@vmware.com, akaher@vmware.com,
 tkundu@vmware.com, vsirnapalli@vmware.com, pvorel@suse.cz
Date: Thu, 22 Jun 2023 20:20:37 +0530
Message-Id: <1687445437-2453-1-git-send-email-kashwindayan@vmware.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: BYAPR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::43) To BL0PR05MB5409.namprd05.prod.outlook.com
 (2603:10b6:208:6e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR05MB5409:EE_|PH0PR05MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8b0df6-cd19-4901-671c-08db73300f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mn+KQVHVpYfkWmwiR6j82y1bxW9KNLSU5HcEFOGGaCwdkN2NWjgaLGDzh/FZRakyPgrpovHE7QGtdEgR0nPqHIUaPop2ubcn6btMoHssYPlI60+hUh6Uyhksm5+TeQGayls+hVgMCs0ETBiYBJ4NCvLFGmA2tO517McmdViY/PKtaESVxwOz8YqrsuZNhanvuyQ2T3r8ZFfVbMQRRBl/hFLy1HhGpZIvUqqLHksQvUi84wOoRqH+C8v2ea09bZmmn/8SxpRPOql0gbzVTfcItE4nBPzJa1u5+4Ic7SqrJwtsd+pn8nkOLJLG3m2vNOhiicF80N9wBnijl4WBgQlDnYz1XXDkdS6GSAM9gSO4uHWXSn6Le3GBPr92QHahkM48Sihss4NPx9/duLDUEI/uCnL6d7uEgM7+cWG6P17gN69KZAyqY870TQUcra5Uunh7PsmnX4+rwZUFr7TW/3KpWAXohVBYOKl3XvQ/lz9NQYZDR+EGG9gePX4YIUmDD+OsT3d+SYQ08eLVlZ0Aycf4fsTaeVclnzTWKxGgIz6BMEceUqwK/0RD/6YJjLYpnFeJdrZOrFir7ON9uymKAG1G1vAULWrsVduaLAKSGYH5Ikm0dtvSO+kZy1f7hPPFaCScadEXLjLjHPpjeAKymg4S2n6aZeCiKNs+czJjVt2h3QA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR05MB5409.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(41300700001)(2616005)(6512007)(6506007)(66946007)(66476007)(66556008)(83380400001)(6666004)(316002)(86362001)(186003)(6486002)(52116002)(8676002)(8936002)(5660300002)(478600001)(38350700002)(36756003)(26005)(38100700002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rP9/0usnseQRrnvdEqXVhFYC/x71n4zt5xpjtVQGR3iQXHmFJnVPTANsSesu?=
 =?us-ascii?Q?5hapnOAnmCc3UaYjqmpotJ9nkCDTK6zl0FN+MhTgamwdjwt9h2INYGTLVOjD?=
 =?us-ascii?Q?C9coLXRITtxRmCy3xFOu2O42VzRFK5QzMPXeeui/vh/5PLvteVp6z7hNb4l7?=
 =?us-ascii?Q?mhr//a01eSswt+Z18hVH1lHXEeowpfm3/oR5/mbT61ZXUUy4ruPVMQ8ENHXz?=
 =?us-ascii?Q?DGznToukulw1hYUCCNnRJLCInNJ2BFNGxGUOmnEEwskgPJdaMJCEHM/MHlys?=
 =?us-ascii?Q?Ack7IJDKz4T//BHA1ciV7ZDrCQ99LVtUjVN4m2Kc/Yo1azzrhWAdetcBDFpj?=
 =?us-ascii?Q?5XB7DiVqNIJZNnRNJAbv8SjDRjx49XVdyVgVo1xNS6FvuW3nal7baPdWcxbg?=
 =?us-ascii?Q?a2rQNE+PMncATTsIdczgqaAxM0Odf7kn++G+FBUR3SFpazCkqjPxP4jSEcL7?=
 =?us-ascii?Q?W6aKa6qmI/BThSYC4cX3XHenSdAtTgC6yX6PaDVvlw3O0VrbAGo/x4wFV88a?=
 =?us-ascii?Q?++5kYa5iUBMiQlSIY4wrktyDwZ8zqVFQRF/jbm2BvQAHWoyQzXkhxfxt1uGv?=
 =?us-ascii?Q?1QiP9QPAJ6QNmj7sb5LTzxpWS36nRcmFJ/xhZaLWiv5Az834lfFzu/D0MYB9?=
 =?us-ascii?Q?p+ng8E8qCk90kSZRlSpFF6CDJyfSfOtSF1Zb3uZ5MSHPpOM4XQchPISB58UM?=
 =?us-ascii?Q?zgcjphb3ahzcsiEfvmlf69rc955SwbOQ3tDUE2TAz3nhBe+9Kjmd8errmLFK?=
 =?us-ascii?Q?uklCxjZjV1JkVjpAfe5pryJgDDPmJ99DmuMnt1GQU5lBwMDIMl/9SNldz3JF?=
 =?us-ascii?Q?qkOFCjupkbzt9DJ5DnzY1mGulU/Vhipx7frbTkY4am2sten8WBDd/8rfPxHX?=
 =?us-ascii?Q?bVp2M82nT4XeRdN3ooLT6pPWOziPZ14JROEhP6/+lCuYcTtofedx7bpsbl9h?=
 =?us-ascii?Q?zvD/zGJFZPPAa2CSRldJJIW/3CcpqE9p8/gIOgW22Kr30gw4Kqqcxcb0r9lD?=
 =?us-ascii?Q?/nmKITM/j8x8p35eqdYzEtHNDX6G0M5VnNoxVvWk+zxX4YC/mYamYfSrU9t1?=
 =?us-ascii?Q?1LN8FcSu2KxF61ukx+bbtjizu7R9++aNy5HJ7gbs+8jMjw46iz3/F6+WGiMl?=
 =?us-ascii?Q?4Y9Kzbab2agFJkXfkPfiAjb6iVhoiAR2KwHr+UUUNrJ4fDeB2JP/IzTOMNsu?=
 =?us-ascii?Q?oBmrEWH4ivGp7VQ2SIiT5zbi2FNJJ6rv1vQ3gfupf0BJOQx+ahI/cID3nq68?=
 =?us-ascii?Q?NosSUxNEQFhItkmjz/zHapJRE2IzLrrJ6jmPoXaJhrwjlhCdoX9wOqgCItiF?=
 =?us-ascii?Q?7kfPe6vsOsl/CxSOuDOHRdJzpmsfP2sUqI94FuL5Q+Tb8kfTyAQZckOeAcUG?=
 =?us-ascii?Q?SKsgQ9U1VocdDdvHvXIJFT1jNPMXAAuPakhOmLaw1jGXdpuSDx4pqLS5Lajt?=
 =?us-ascii?Q?nHf/93fvleYEs+J+MsEIT2eNrR3oKjIDFsKCLthseLtPcNNcdeyRMFPwqMC7?=
 =?us-ascii?Q?p9dr/+sLkDJ0tFLvjvSk4GARoMN3XJdwXgR3VAgHdc0cC2CqSauDY+GwhWlq?=
 =?us-ascii?Q?c3DM+3PynpRpV0imymAOL1Ox1kaN9lXA/NbQMPGE?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8b0df6-cd19-4901-671c-08db73300f57
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 14:50:45.7334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+xc1L7DFxMPmsMvhSdJoMBDalmZ88xCrxiXRNfXVqfSEWr7oP4IFxbXk2Ytk1rkMs3kZyruW0gZKQOtc8gJLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB7733
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] sctp_big_chunk: Do not use md5 hmac algo if fips
 is enabled
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
From: Ashwin Dayanand Kamat via ltp <ltp@lists.linux.it>
Reply-To: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

MD5 is not FIPS compliant. But still md5 is used as the default algorithm for sctp
even when fips is enabled. Due to this, sctp_big_chunk testcase is failing because listen()
system call in setup_server() is failing in fips environment.

Fix is to not use md5 algorithm while setting up server, instead set it to none

Signed-Off by: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
----
v2:
As per the review comments given by Petr, did below changes in v2,
        * Moved the logic to sctp_server() function
        * Setting none as the default algo
        * make sure cookie_hmac_alg file is present before accessing it
---
 testcases/network/sctp/sctp_big_chunk.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
index a6a326ea2..31786dd39 100644
--- a/testcases/network/sctp/sctp_big_chunk.c
+++ b/testcases/network/sctp/sctp_big_chunk.c
@@ -34,6 +34,24 @@ static int addr_num = 3273;
 
 static void setup_server(void)
 {
+	const char *const cmd_modprobe[] = {"modprobe", "sctp", NULL};
+	const char hmac_algo_path[] = "/proc/sys/net/sctp/cookie_hmac_alg";
+	char hmac_algo[CHAR_MAX];
+	int hmac_algo_changed = 0;
+
+	/* Disable md5 if fips is enabled. Set it to none */
+	if (tst_fips_enabled()) {
+		if (access(hmac_algo_path, F_OK) < 0) {
+			SAFE_CMD(cmd_modprobe, NULL, NULL);
+		}
+
+		if (!access(hmac_algo_path, F_OK)) {
+			SAFE_FILE_SCANF(hmac_algo_path, "%s", hmac_algo);
+			SAFE_FILE_PRINTF(hmac_algo_path, "%s", "none");
+			hmac_algo_changed = 1;
+		}
+	}
+
 	loc.sin6_family = AF_INET6;
 	loc.sin6_addr = in6addr_loopback;
 
@@ -46,6 +64,9 @@ static void setup_server(void)
 	SAFE_LISTEN(sfd, 1);
 
 	srand(port);
+
+	if (hmac_algo_changed)
+		SAFE_FILE_PRINTF(hmac_algo_path, "%s", hmac_algo);
 }
 
 static void update_packet_field(size_t *off, void *buf, size_t buf_len)
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
