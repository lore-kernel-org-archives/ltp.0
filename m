Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F016EB64DA
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 05:53:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A2B73CC308
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 07:53:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE7423C99A4
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 07:53:05 +0200 (CEST)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazon11012011.outbound.protection.outlook.com
 [40.93.200.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A9371200069
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 07:53:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2m1qLk2SOoy2vMdYI4jX0u+nizb64d+bMDojv3tqVVjLG7it7z4S8weos6NWqbHq+mE4MsbKh0Ru6GxVM309RrLa/ThPqGUFH8j+r41qLlqNkTB0BM4H6eaEm/4Bwx+dzTzuxoBByiEeKOZIC4ZKWgM/0iDA7yHSzAKLaEEQa2SNwMjen+j+NHM6XlXyOy4zK7m0v6OQtgDxr1ljFoTVjMQ4YBdyQshtiGSOdWo0oNPMNepcUEHrgP+tBmVIS2+KZI7h36E6+YBqAITb8Cv1duSYBH0bsV2CGLny0J2DJIwkuF9I8+ZA8ZHULGJx7vJr+fQYj4/Z/86wHlGJrFY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OHDNYFRMGReZ/T0QVv9WXv83eijV4m1r2d03T9qEgM=;
 b=JGtliAMtiYydpjidOkNbaS9Yx7DzUSO0XXnQj7AjBxO6icSBltJWi5Dex5O64CR8WU8u5OTGZ4NLAXU9QGLQCqkwSMs/BxH9m9NcKS6H+o2XyBJtW5bNNZoUGsL52amhXrDxpXKRYIQek/gS613lyK+cS0rUb9ProqIak27AYXnTEIpFK6chD6+JsyGsoxsGME9C+o/hDjCbbhEVBLC3Q1KDNu76egeS9z4DYFN2d/EAWjGVQ5nSZthbsC2Jw6JiRNYgBcGzRSJyT8tPt6w+OehedQvTJX6KiZwMjV+b2StfKe7KzRRmzc/GVgObVqoen8HRpjxcFi5TBag+BS6rfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OHDNYFRMGReZ/T0QVv9WXv83eijV4m1r2d03T9qEgM=;
 b=r6YRvKWqPeNa9DeQVxwVKxRF1GtVNVt+7omPiJbNvo5ptxgvZTA8+uNt2yNTGCCMslL3uteFYlRM5cbyhBC/ZzsBZSFngcXxDaYcOe96y1C0rXWLJNe5Adl37HniLxXhRwJOSaKjPj1OS5u4rz/E3Wy3KPi3oqTXxLEgpYxMRKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BL0PR05MB5409.namprd05.prod.outlook.com (2603:10b6:208:6e::17)
 by SJ0PR05MB7817.namprd05.prod.outlook.com (2603:10b6:a03:2e0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 05:52:46 +0000
Received: from BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::68a4:3da6:4981:4793]) by BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::68a4:3da6:4981:4793%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 05:52:46 +0000
To: ltp@lists.linux.it, kashwindayan@vmware.com, akaher@vmware.com,
 tkundu@vmware.com, vsirnapalli@vmware.com, pvorel@suse.cz
Date: Wed, 28 Jun 2023 11:22:37 +0530
Message-Id: <1687931557-10354-1-git-send-email-kashwindayan@vmware.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: BY3PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::16) To BL0PR05MB5409.namprd05.prod.outlook.com
 (2603:10b6:208:6e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR05MB5409:EE_|SJ0PR05MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae2dc89-88c0-43b9-19f4-08db779be5bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNwq2WjspZQincYuiPLER/X7EkFUykAR97tIp9TGp+MGvowIEgKw96+8UCETKlLU+mklLTxVDvng/Ar4WmhAAaGL7x0JtyNJbzuDmuUrp68v8fzdIQ8oaKq2Nuke+WYJCRFrgpWTOgU9Jb8S2tCMr4NsgAu5g//hO/Z9zq6iG3jiraqLabtlFobPmsXGwWgbYhxeM6qjnLRoD9nzQVKRj5yHCcNnPA9zYY0/eLIkx3X2DaTgFWPRtqihWMgSDmURYyYjxSgqnUwmmfR8pidzThUGP944/SYuNcRLv9L41v7UYBuu1BWc9H1QGU1z1HXatn0aTcbf0Izdwva8GzGvhacgVPiVWAi8c9Cm+OwPkTa6YY0+LElYUwN6Ox+0xL917JOfSPLjS28ppkCev9gUI5q3iTwsmVzHsOKwFR8wVj4LXu3tx5savd+pfp05tzczlXqPfL4mltA3RVp3P982F6VIJhO1Me9ybDYWEHIANgsmVFJfQ34NQlFuxDKjplxyZHbEF2eTHPGDMpYftM8bmUQOAn4d6NqI8VBcd/Do+HAhg/m7wAG+5s9iyFzv/ydD5tTjq1zsBEjEYqmINVysE8U7AZ7fnUiBf7ZCQ9uhljngNdL7j2tHvh+VMcleTmS/VSQzDoc4XuwR4fIEDLjeYS/hW4jOAhjDg+uW7MKsdbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR05MB5409.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(6512007)(26005)(66556008)(66476007)(5660300002)(86362001)(8936002)(41300700001)(316002)(38350700002)(8676002)(36756003)(66946007)(38100700002)(6506007)(6486002)(186003)(2906002)(83380400001)(6666004)(52116002)(2616005)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?emfXYeJBKJmBPwXFzBz1kARZWiMoifFSaDuhReNyQ/weQRuGgoXxPKr6MCns?=
 =?us-ascii?Q?kexpWcDjl7mfSt4j2bV1e69yyD8ZyLbuq8Gb8oNAszf8VHSdspHi08mhdp+u?=
 =?us-ascii?Q?u55ftHv46bW+VA8GVSftpBEh+mD8iUFVEpb/KudaWkJkQ54lNPP+mCmlE9ZX?=
 =?us-ascii?Q?JbiF//MtqTLA2R/+2qCA7GRU1aOY+eA9AfphHmBHfu/MP297v5solekqgwn6?=
 =?us-ascii?Q?J0hliuGCaGBUouAS4ZIu3pFiUg+CMe8wmAvphMNuR+yqUvWaA/4A2bVvnITV?=
 =?us-ascii?Q?iLaAgTkrX9yyDUEkQ3/mgJYk0trQq3xq4g30uLdpmCNqSAMNWiwkLTi/4yrL?=
 =?us-ascii?Q?wbQZaGxh+IX0eU5pSjHxQj9mIhe/60utqwSh2BVR2yqjW2OKN2sJ2lwKomLg?=
 =?us-ascii?Q?IIMlYOTZ2WJZQ8hodYFkOgInR+84h153H+GEgus9/HPhLoHVIIHBL4igeeTT?=
 =?us-ascii?Q?dIQfRS+FdJNGyOugkVfsf6fzvhEX7h2RwKp+Grtzbffc0Re/gz0H/ghiQA7B?=
 =?us-ascii?Q?7mfzUptiN2cUAlphNiFiAICEWeZZxchSMDnX9a9ZtmZ3a+odFwB/yz5ygxRB?=
 =?us-ascii?Q?945N8XfVWRPX4DMX5eiylPJo6UzcjI6d/8kDNSY8QAoWoWUUEftFyZgGt5rU?=
 =?us-ascii?Q?h0J7WLRWTs7Y98ZbS+e/AYxuMboJAzFlZO9QocQgkPhB/QPhQSzqjJ1GMs5u?=
 =?us-ascii?Q?RY4cdc4A9ERkEw1SkLCFV+nOQK4AoxbrWrPqcnmj7QweWYcRavcigQi9iukC?=
 =?us-ascii?Q?rUXMISxb4tUuZpKci5bTQYhAgU1nDRJjvn245N/xXockf/BKYlrwdxtHkm2p?=
 =?us-ascii?Q?3gnP9wdmjQJ4dQtWM1RIwqKTc5brlBMmoo66yPNZTcgOoZtBSlTMv0C1WHHi?=
 =?us-ascii?Q?d11ARxGArOtix5X3k+HxN9nDDbaktbhjV6c0C3TKSG5VbH4pvucgRgAip1uz?=
 =?us-ascii?Q?6OLrcSJ9PmMDIPuQvIodpYYIY1Il52Q+JPD3T/A6Qu721JT/9fulauQfR5Tr?=
 =?us-ascii?Q?D9Gpnafb0q0//L4h5oU3lK6XM+uvdThLJKSmX8DUggxcrR9FO3qMRF8s28sN?=
 =?us-ascii?Q?RZ5FMZF6EuuFq2mVHiixiM/U/98qwvAoFGUoAyN0ydOsNX7xMBzZhOn2dmDe?=
 =?us-ascii?Q?MKmifRipitjOsBjYZwo2nnUbC4ucYmSgESFqlBAqH3mbaxbqh63vosfHc1P2?=
 =?us-ascii?Q?ydMs06O/ZNScABlMfdNZ+g21uQLfqKiXedveojybC3bXa5TXIwHfh2gQcATP?=
 =?us-ascii?Q?bK7v6VRyTvoa1K54syYqsFW9KS1zC34IrGFIq0LRLaH7bUlyouguvRVM6jMl?=
 =?us-ascii?Q?2dMmqi9BJP9i2a61xtBiJ5CxCJ4KKEp0TYFSPQC274ls/IVfDoMgk3PsyJdz?=
 =?us-ascii?Q?KVnrfhf0isnyTnlDNQdAa9A2fyvDahh/HGD4AQMeGCCBULAfAbZc0ksxthvQ?=
 =?us-ascii?Q?ff78mDmSq9cjz0Mg/m+kr+FhOlDOaTd+4jGhQXN23WzBthPG/9uGh+Jykchf?=
 =?us-ascii?Q?m2AcJKed0cHkl67keBVbVOHFiTDw8O7MBJ/7yo8yI5WElZnXsfIVPcs8fDCJ?=
 =?us-ascii?Q?XcfKIuXEhPPFDpuI+Jig5qdai1zbOp8qIt1pgSE/?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae2dc89-88c0-43b9-19f4-08db779be5bc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 05:52:46.2169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NO5UfZ4mXVrajifRknGGek+SdZ/OI/DAUL/8Cj6cm5mOLWLd1lveq61fKRG2Yb8iqqY1TA6WUWsccsIQsQ4qZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7817
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] sctp_big_chunk: Do not use md5 hmac algo if fips
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
---
v2:
As per the review comments given by Petr, did below changes in v2,
        * Moved the logic to sctp_server() function
        * Setting none as the default algo
        * make sure cookie_hmac_alg file is present before accessing it
v3:
As per the review comments given by Petr, did below changes in v3,
	* Instead of calling modprobe directly, creating SCTP socket
---
 testcases/network/sctp/sctp_big_chunk.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
index a6a326ea2..fa0e556ee 100644
--- a/testcases/network/sctp/sctp_big_chunk.c
+++ b/testcases/network/sctp/sctp_big_chunk.c
@@ -34,6 +34,25 @@ static int addr_num = 3273;
 
 static void setup_server(void)
 {
+	const char hmac_algo_path[] = "/proc/sys/net/sctp/cookie_hmac_alg";
+	char hmac_algo[CHAR_MAX];
+	int hmac_algo_changed = 0;
+	int fd;
+
+	/* Disable md5 if fips is enabled. Set it to none */
+	if (tst_fips_enabled()) {
+		if (access(hmac_algo_path, F_OK) < 0) {
+			fd = SAFE_SOCKET(PF_INET, SOCK_STREAM, IPPROTO_SCTP);
+			SAFE_CLOSE(fd);
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
 
@@ -46,6 +65,9 @@ static void setup_server(void)
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
