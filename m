Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62C4C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 16:16:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FDC60F9F
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 16:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0FDC60F9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vpitech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF9373C8A0E
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 18:16:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E4ED3C2308
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 18:16:00 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2062.outbound.protection.outlook.com [40.107.100.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6519E1A0123D
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 18:15:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTfmtyna3kqPHUNg8TVt7llUYPNXtZtKquQRugRfAVNn2kSqHIxGOSSk5T9D1JTU5GqvovT/fwec5RVqsmUHOBDwfyC2+Y+F8P47aDiOpXw7ZyhZ1ONcR5Xt2g3IiiZF+xVwl5JNZ9lei5A6KdIt+nCkkb3hADXuLhv6xlZRQnYKb8yA6NhAsEx5VtYER/Ut5f0s+8vBF9ANJ2ALnrkiAnwCp/jS7vYFfrZnC2dR8if5uFkwUGDyOOB2RDJyTgj4K3OQbmEffSywwW1PTHqSwnBhkXzFlT92PKeDHtmgHAGS5K/9k0AkXO3W4ENJX8Mmw0lrRZM00P/psAzlonwHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=zMxu75s0OhBb/Yj7WUME2AQQ2gmO12Nyk27SSpLlHuk=;
 b=Vrj3fxgOsebhItGPgQho5ZN/J9spqrNa3TR3RFF2rSa7kclpHTCjy/QJo9uZEiZYzjRXsvEd14JizW25muDjNMAoYymvLtKcG9kyC7yXriljW7mc2hTkpbbq5GPRwlePTxG12Dh8jyVtzumEWMcKQn+vyUnFiheoLX6KE0dEOi9d85khOOeaLjCjq/ekUnUAofHsLM0fsxdA2Qs+xvgg8pakOdAbH+u5ApEg4S9kT36Hryn18Ff2c6GTFbMrnwfiXGKHJSje54ddtvsiExJOu9a6nzj8gFqLs6mRvMSfLcQZRkzWYKoci4fS30hiq2Q+UHE8/Om8IX+SnqV/LgEuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMxu75s0OhBb/Yj7WUME2AQQ2gmO12Nyk27SSpLlHuk=;
 b=c4m+6juiVrsoK/1Bd8kIwsJVqt8uWX/cOKgTxqF7Y7rkQNi4qwB25m1zd2Kc/4FJ3eBSctpwDsPoH+QYv0nJRMlhz5+2zOqrb/3lOSjKPCiFNQ0JTsykTL/Jlav9Ev56MssI+e3kh68tulRdNuAAOryxdKaIoRkSWMiAYWO6bt0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MW2PR07MB4009.namprd07.prod.outlook.com (2603:10b6:907:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Tue, 14 Sep
 2021 16:15:55 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4500.018; Tue, 14 Sep 2021
 16:15:54 +0000
From: Alex Henrie <alexh@vpitech.com>
To: linux-integrity@vger.kernel.org, ltp@lists.linux.it, zohar@linux.ibm.com,
 pvorel@suse.cz, alexhenrie24@gmail.com
Date: Tue, 14 Sep 2021 10:15:02 -0600
Message-ID: <20210914161503.97495-1-alexh@vpitech.com>
X-Mailer: git-send-email 2.33.0
X-ClientProxiedBy: MWHPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:300:115::23) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter.ad.vpitech.com (66.60.105.30) by
 MWHPR11CA0037.namprd11.prod.outlook.com (2603:10b6:300:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 14 Sep 2021 16:15:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 340b01a4-f32c-4223-019a-08d9779aed91
X-MS-TrafficTypeDiagnostic: MW2PR07MB4009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR07MB4009BECF80BF0C0995532A11B8DA9@MW2PR07MB4009.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEeFyePev5Jf4XgWbjJkQd0ThMrzxOhRJc8fpxCx+OZ6ukhTWLlUi8veWFthnEhPLdJz8azEliVHfLsloshmb5WwVK042mg3gNUMelRwkIn+/am4FZ5bzjXX775k9/NH1lreucacn6WwuTdKT3l3WJ64v93EmFECXsPARpOwPr41F+DM/9QIE/dnkI4rbyilfm1p0ImdXwd2D3p8vQ+G6pVr2ifn9o351hBTayDpxESnDhcas+qeE+worFQY4J9RjHqHPhyFs5Gd1kfnE7zT/pJMG/LxTwXUXiFvitOW1SYZWKfGHa1RVSSHoN2zzyE/mKvIAI9Ehe+bF03cOs/tEDI1sAozXp7wzCXzx8K/nbsvRdQG3+QLyINI3jy071xbKpu+Th6NFJy5U40nkyMYMUagyN/Yet+31PY5jfbpQQCXEfWwI9g2P45rxpcWJ4aiS1SP8S+/ayXcOYmPWiW2V8W1JxgNq/3AMWt9YFQlcNAZkzhtVxw6BRCP0L5spCcqR1P2Eo6Bc8akHNFB0+vdKoDr4UCbOCURW1OeTI38BCLbsEes0+yKLExMGekhQpsux/fUCF1f49SJMGCQKLA/PdYWKqHSqq9tkDwqGaEwMTE6I063M3KXwqnSdVl07aquxl5uZjSbTvlk+C+JfhgvLjdJvlUzbIrmtjMgJyep4Z+Ty7ymV+8OhbjmxuSQsdve
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR07MB3980.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39830400003)(396003)(376002)(366004)(136003)(66946007)(66556008)(66476007)(186003)(6486002)(1076003)(36756003)(316002)(7696005)(107886003)(83380400001)(26005)(52116002)(478600001)(8676002)(6666004)(8936002)(4326008)(38100700002)(38350700002)(956004)(2616005)(2906002)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cwg2gOfoolyMY4oimLb0g8jpHIA3F1lq8/Ts4fyEbIqF6/PgqjVQd1W6sytS?=
 =?us-ascii?Q?YyKZYh3na2rVz0XSB6qakSAMcu2A706QwmAoiws/qALxYMaBn54WN3QgpuIB?=
 =?us-ascii?Q?IqYtdgD2HTTZdfBXmMcQT60ej5Uq7Qb4EVR6emGyDFhbTtptDdYjIuy+7Vuz?=
 =?us-ascii?Q?j52guRtAQeh13bAKj3vce0BnLVvwTFei/9QhRALkSBjwH80Qm0OWzR8V6gNQ?=
 =?us-ascii?Q?Ejiy/ME2Rz4M4rpSh1BatrLDx5dnDtsUgnQOY082jWfViNMmerG8XdlH4eGI?=
 =?us-ascii?Q?9ma0qexdsqlZc6OAaLAHIk1exrKupEfGi2Q+z8X+IlbM4biNWcXMVyuCadAv?=
 =?us-ascii?Q?wh+ruR5kZ9EssuaeY3smQUns5lhUVmznf4pg5u4LIaA61MqkLArpnHxccLt0?=
 =?us-ascii?Q?D13xPkjgHD59cnBcqk5F9ctBSDFDQtc6vXWw2fxn0ECwWMQsEW5wJrke/WzL?=
 =?us-ascii?Q?29L/idiAEHF+O5LAnK6j8BiarlI9WbWV8bwUpau+szLhiuC648uWLvTSeFXN?=
 =?us-ascii?Q?jcfnn27meUXEb+ijWIMa+tIRt6j0d8ZfuvOcUa6uDJXv76xCniTq5UejFaQs?=
 =?us-ascii?Q?g1VU5VGZF+euL5q8a7Nx3ziXAULgaoJ7/XcR3Pdj4NektwRxvq4JFTYaMkCe?=
 =?us-ascii?Q?xwafYQvhe8t4ViTgIeQyTZzuR332Z7JEM2mxphSjsJUS+SYuH9ScFs7qT+Ma?=
 =?us-ascii?Q?S4nv1iNhJ6OH1MofuCR76cMKyO5A+dd9A/4bzQpmfh9GpMP6qAE06AKY6JNH?=
 =?us-ascii?Q?ThX2AvZlyPLuMYiHMDfFx99cOg6E5m6RWDs0p5rwXz8Y5bBoPjoysiTbLw8m?=
 =?us-ascii?Q?U/7HS2cWBDoUs2ccdKLpN6W0C2/VK+eVEBitQ+D8M/abJCjICyO4VPbQZOa4?=
 =?us-ascii?Q?CFoJ1OiMTeicdaJ9BdMKtH7O3U6FnpwYjdXnMKSAYMOAG8pUe+CFauTRN3ZF?=
 =?us-ascii?Q?QWbNcVdUI3A3tHVTSLErASX758olUWV830ja6aYBQNIuv8xtvZBh9Cs3OfcO?=
 =?us-ascii?Q?NZmVB61SV9uQ/Ta+9x/RF2snYXxiiqf9PhwJmJBOlgdcgCXd0A4/GgHkezPp?=
 =?us-ascii?Q?MZiRQ+CxD/HbjH74AUAwuEGr3vBVqeLPDsa+e16eciuBxx1m/eEZJLh5c0r6?=
 =?us-ascii?Q?dxRj2xBwQBAJXdUQDERjNG10Ys5HnE/MzailhCfUTLePL517FOf/OJexcG6y?=
 =?us-ascii?Q?gIc/FTFKD/7jCIU1Q1vHgl6ypFx79TIR99Fev6c5Bn5KjbhE8es1XEkOYJcw?=
 =?us-ascii?Q?MfVF5Bt/I8AEf0kHWZdsD7HK2AmolGxqLqmO/Q+JakdRRvdAs44fn94qb+Ow?=
 =?us-ascii?Q?xWBX7xJVY7+PtYFtkDKUfsJB?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340b01a4-f32c-4223-019a-08d9779aed91
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 16:15:54.5737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IK7Wloix5PtXgTnS5BwFDZHCfLTCvAgxor7uzzQyb7LBYtsOFFMF2Kk++L923TspBf3OmnFGmWV1QQw+Cu/PRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB4009
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH ltp v3 1/2] IMA: Move check_policy_writable to
 ima_setup.sh and rename it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210914161502.UcIpD8eci6qI6BGGwytnppKYEPHqjezrx90yQ1usHr4@z>

Signed-off-by: Alex Henrie <alexh@vpitech.com>
---
 .../security/integrity/ima/tests/ima_policy.sh   | 16 +++-------------
 .../security/integrity/ima/tests/ima_setup.sh    | 10 ++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index 244cf081d..8924549df 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -11,19 +11,9 @@ TST_CNT=2
 
 . ima_setup.sh
 
-check_policy_writable()
-{
-	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
-
-	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
-	# CONFIG_IMA_READ_POLICY
-	echo "" 2> log > $IMA_POLICY
-	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
-}
-
 setup()
 {
-	check_policy_writable
+	require_policy_writable
 
 	VALID_POLICY="$TST_DATAROOT/measure.policy"
 	[ -f $VALID_POLICY ] || tst_brk TCONF "missing $VALID_POLICY"
@@ -55,7 +45,7 @@ test1()
 
 	local p1
 
-	check_policy_writable
+	require_policy_writable
 	load_policy $INVALID_POLICY & p1=$!
 	wait "$p1"
 	if [ $? -ne 0 ]; then
@@ -71,7 +61,7 @@ test2()
 
 	local p1 p2 rc1 rc2
 
-	check_policy_writable
+	require_policy_writable
 	load_policy $VALID_POLICY & p1=$!
 	load_policy $VALID_POLICY & p2=$!
 	wait "$p1"; rc1=$?
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 565f0bc3e..9c25d634d 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -73,6 +73,16 @@ require_policy_readable()
 	fi
 }
 
+require_policy_writable()
+{
+	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
+
+	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
+	# CONFIG_IMA_READ_POLICY
+	echo "" 2> log > $IMA_POLICY
+	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
+}
+
 check_ima_policy_content()
 {
 	local pattern="$1"
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
