Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10064D609D2
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 17:31:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C1863D0362
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 18:31:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEE6B3CECFD
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 18:30:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A5875140098E
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 18:30:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C25E833814
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765906256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=51yeKS6O3p6OHeCKN4Oc92M5sko9iew//q56eg9a/1s=;
 b=gp7dwmDR1z5XQJjqd/xW0uDnNQjfl14DEt1Mk8k3QIz55pbjGvh4cGI+dIaBbxo8rhx2UQ
 BpHEiDbpWPmELFm46P3X9ShhTava8IrybNRrx0/VZZ8feAMnHwIEq7kcQe3gVnuctar3HD
 nNxXqASfQhT9Vc2wMhNSEWarZ2WKGJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765906256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=51yeKS6O3p6OHeCKN4Oc92M5sko9iew//q56eg9a/1s=;
 b=Z1CqiYVZ8yQuR6dH+hhkx47lEObzxFSBzDa/TLgoB30a8nOQzxGT2QAafpyuJo/al1T8B1
 1uKXrH5YywIR/1CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765906256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=51yeKS6O3p6OHeCKN4Oc92M5sko9iew//q56eg9a/1s=;
 b=gp7dwmDR1z5XQJjqd/xW0uDnNQjfl14DEt1Mk8k3QIz55pbjGvh4cGI+dIaBbxo8rhx2UQ
 BpHEiDbpWPmELFm46P3X9ShhTava8IrybNRrx0/VZZ8feAMnHwIEq7kcQe3gVnuctar3HD
 nNxXqASfQhT9Vc2wMhNSEWarZ2WKGJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765906256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=51yeKS6O3p6OHeCKN4Oc92M5sko9iew//q56eg9a/1s=;
 b=Z1CqiYVZ8yQuR6dH+hhkx47lEObzxFSBzDa/TLgoB30a8nOQzxGT2QAafpyuJo/al1T8B1
 1uKXrH5YywIR/1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B82713EA63
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 17:30:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id igi9LFCXQWnDcgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 17:30:56 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 16 Dec 2025 18:30:49 +0100
Message-ID: <20251216173053.29112-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.68 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_SHORT(-0.08)[-0.389]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_NONE(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] cpuset_memory: Print basic subtest descriptions
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

The cpuset_memory tests has multiple subtests. Print short description
before each subtest to simplify debugging. The last three subtests
have the same description because they differ only in the specific
pattern of signals sent to the parent and child allocator threads.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../cpuset_memory_test/cpuset_memory_testset.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index e81d22293..1f68d7444 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -63,6 +63,7 @@ simple_getresult()
 
 test1()
 {
+	tst_resm TINFO "Testing anonymous memory allocation on node 0."
 	cpuset_set "$CPUSET/0" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -80,6 +81,7 @@ test1()
 
 test2()
 {
+	tst_resm TINFO "Testing file memory allocation on node 0."
 	cpuset_set "$CPUSET/0" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -97,6 +99,7 @@ test2()
 
 test3()
 {
+	tst_resm TINFO "Testing SHM memory allocation on node 0."
 	cpuset_set "$CPUSET/0" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -114,6 +117,7 @@ test3()
 
 test4()
 {
+	tst_resm TINFO "Testing pre-mlocked anonymous memory allocation on node 0."
 	cpuset_set "$CPUSET/0" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -131,6 +135,7 @@ test4()
 
 test5()
 {
+	tst_resm TINFO "Testing mlocked anonymous memory allocation on node 0."
 	cpuset_set "$CPUSET/0" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -162,6 +167,7 @@ check_hugetlbfs()
 
 test6()
 {
+	tst_resm TINFO "Testing hugepage SHM memory allocation on node 0."
 	cpuset_set "$CPUSET/0" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -201,6 +207,7 @@ test6()
 
 test7()
 {
+	tst_resm TINFO "Testing anonymous memory allocation on node 0."
 	cpuset_set "$CPUSET/0" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -218,6 +225,7 @@ test7()
 
 test8()
 {
+	tst_resm TINFO "Testing anonymous memory allocation on node 1."
 	cpuset_set "$CPUSET/0" "$cpu_of_node0" "1" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -254,6 +262,7 @@ talk2memory_test_for_case_10_11()
 
 test9()
 {
+	tst_resm TINFO "Testing anonymous memory allocation in multiple cpusets."
 	cpuset_set "$CPUSET/1" "$cpus_all" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -292,6 +301,7 @@ test9()
 
 test10()
 {
+	tst_resm TINFO "Testing anonymous memory allocation in multiple cpusets with migration."
 	cpuset_set "$CPUSET/1" "$cpus_all" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -358,6 +368,7 @@ talk2memory_test_for_case_12_13()
 
 test11()
 {
+	tst_resm TINFO "Testing anonymous memory allocation on multiple nodes without migration."
 	cpuset_set "$CPUSET/0" "$cpu_of_node0" "1" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -386,6 +397,7 @@ test11()
 
 test12()
 {
+	tst_resm TINFO "Testing anonymous memory allocation on multiple nodes with migration."
 	cpuset_set "$CPUSET/0" "$cpu_of_node0" "1" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -442,6 +454,7 @@ get_the_second()
 
 test13()
 {
+	tst_resm TINFO "Testing anonymous memory allocation in multiple cpusets with threads."
 	cpuset_set "$CPUSET/1" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -490,6 +503,7 @@ test13()
 
 test14()
 {
+	tst_resm TINFO "Testing anonymous memory allocation in multiple cpusets with threads and migration."
 	cpuset_set "$CPUSET/1" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -546,6 +560,7 @@ test14()
 
 test15()
 {
+	tst_resm TINFO "Testing anonymous memory reallocation in multiple cpusets with threads and migration."
 	cpuset_set "$CPUSET/1" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -613,6 +628,7 @@ test15()
 
 test16()
 {
+	tst_resm TINFO "Testing anonymous memory reallocation in multiple cpusets with threads and migration."
 	cpuset_set "$CPUSET/1" "$cpu_of_node0" "1" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -688,6 +704,7 @@ test16()
 
 test17()
 {
+	tst_resm TINFO "Testing anonymous memory reallocation in multiple cpusets with threads and migration."
 	cpuset_set "$CPUSET/1" "$cpu_of_node0" "1" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
