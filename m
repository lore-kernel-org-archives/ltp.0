Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3824C36010
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 11:44:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 322A53CA48E
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 12:44:12 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3F683CA305
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 12:43:24 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CC9A6600750
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 12:43:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE7F3211BA;
 Fri, 28 Mar 2025 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743162200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tY2+2StgQ6j3Wu1cbuZc4EW9ykeg/4F6cO9Jiq9Z9VM=;
 b=NpBow5Z6QzCXgUdn049u+qMFurg1c88r5kKCEby4sOhc/ybXQIndaDJ4zrYsw1Nu/cBpiB
 k9/o7Bmj/JrWcsFiCjPMd0vygONmn1ReSPKoA61ZzTXZ7CZ9ql+M7ifU1HbaszJTsG2fLg
 3wkLafniS2XXEtUNlkog88fylelwUak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743162200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tY2+2StgQ6j3Wu1cbuZc4EW9ykeg/4F6cO9Jiq9Z9VM=;
 b=ZeCjRl3hNM1JHuBNGjyhxzZzgwyy/YCnLBzplVSU7Qc61eJ7CISj8JWyow7qeC034iIWV+
 ONiDhoAzw4uVRWBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=K+i3RLvP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4eaBZQUg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743162199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tY2+2StgQ6j3Wu1cbuZc4EW9ykeg/4F6cO9Jiq9Z9VM=;
 b=K+i3RLvPGBIAVU/YCOQIEXizbD3F1kAAn4b4tvEFGAeyVCL9jUhdu8eBVsfAowu+JjbEzj
 iSkz9VgMwdaMUbWtdy0lUSMakVWlk6JbhAj9X6bRKCE8EqoPTv+IhLHhmtTdfvf1qGlkHd
 DOg5J8JdvQGdXN+G18NhK0xz7phTc8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743162199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tY2+2StgQ6j3Wu1cbuZc4EW9ykeg/4F6cO9Jiq9Z9VM=;
 b=4eaBZQUgypL4aXkRzHpEWn3pgVAnqpv2YQ7an+fyFOfYVpZDX7NluW+ToBBygnbfnTqPuY
 wqY1o825gqr5lfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88B6F13A5B;
 Fri, 28 Mar 2025 11:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6CqEHVeL5mdqQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Mar 2025 11:43:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Mar 2025 12:43:11 +0100
Message-ID: <20250328114311.187541-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328114311.187541-1-pvorel@suse.cz>
References: <20250328114311.187541-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: EE7F3211BA
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 2/2] Use safe_get_nodemap()
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/mem/ksm/ksm06.c                          | 4 +---
 testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c | 4 +---
 testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c | 4 +---
 testcases/kernel/syscalls/mbind/mbind02.c                 | 4 +---
 testcases/kernel/syscalls/mbind/mbind03.c                 | 4 +---
 testcases/kernel/syscalls/mbind/mbind04.c                 | 4 +---
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c | 4 +---
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c | 4 +---
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c | 4 +---
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c | 4 +---
 10 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index a8e73275dd..936980dee6 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -124,9 +124,7 @@ static void setup(void)
 
 	page_size = getpagesize();
 
-	nodes = tst_get_nodemap(TST_NUMA_MEM, nr_pages * page_size / 1024);
-	if (nodes->cnt <= 1)
-		tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
+	nodes = safe_get_nodemap(TST_NUMA_MEM, nr_pages * page_size / 1024, 2);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index 3c854d1096..031c35f40e 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -142,9 +142,7 @@ static void setup(void)
 {
 	unsigned int i;
 
-	node = tst_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED * getpagesize() / 1024);
-	if (node->cnt < 1)
-		tst_brk(TCONF, "test requires at least one NUMA memory node");
+	node = safe_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED * getpagesize() / 1024, 1);
 
 	nodemask = numa_allocate_nodemask();
 	empty_nodemask = numa_allocate_nodemask();
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
index 79ff5d94f8..9344cdbb12 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
@@ -55,9 +55,7 @@ static struct test_case tcase[] = {
 
 static void setup(void)
 {
-	node = tst_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED * getpagesize() / 1024);
-	if (node->cnt < 1)
-		tst_brk(TCONF, "test requires at least one NUMA memory node");
+	node = safe_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED * getpagesize() / 1024, 1);
 
 	nodemask = numa_allocate_nodemask();
 }
diff --git a/testcases/kernel/syscalls/mbind/mbind02.c b/testcases/kernel/syscalls/mbind/mbind02.c
index cd6a032269..c690ac858e 100644
--- a/testcases/kernel/syscalls/mbind/mbind02.c
+++ b/testcases/kernel/syscalls/mbind/mbind02.c
@@ -32,9 +32,7 @@ static void setup(void)
 {
 	page_size = getpagesize();
 
-	nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * page_size / 1024);
-	if (nodes->cnt <= 1)
-		tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
+	nodes = safe_get_nodemap(TST_NUMA_MEM, 2 * page_size / 1024, 2);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/mbind/mbind03.c b/testcases/kernel/syscalls/mbind/mbind03.c
index 3d477c9cbb..58967cc06a 100644
--- a/testcases/kernel/syscalls/mbind/mbind03.c
+++ b/testcases/kernel/syscalls/mbind/mbind03.c
@@ -29,9 +29,7 @@ static void setup(void)
 {
 	page_size = getpagesize();
 
-	nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * page_size / 1024);
-	if (nodes->cnt <= 1)
-		tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
+	nodes = safe_get_nodemap(TST_NUMA_MEM, 2 * page_size / 1024, 2);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/mbind/mbind04.c b/testcases/kernel/syscalls/mbind/mbind04.c
index 50028835f9..795905cc14 100644
--- a/testcases/kernel/syscalls/mbind/mbind04.c
+++ b/testcases/kernel/syscalls/mbind/mbind04.c
@@ -31,9 +31,7 @@ static void setup(void)
 {
 	page_size = getpagesize();
 
-	nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * PAGES_ALLOCATED * page_size / 1024);
-	if (nodes->cnt <= 1)
-		tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
+	nodes = safe_get_nodemap(TST_NUMA_MEM, 2 * PAGES_ALLOCATED * page_size / 1024, 2);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
index 39e7156d06..92ef165d79 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
@@ -32,9 +32,7 @@ static void setup(void)
 {
 	page_size = getpagesize();
 
-	nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * PAGES_ALLOCATED * page_size / 1024);
-	if (nodes->cnt <= 1)
-		tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
+	nodes = safe_get_nodemap(TST_NUMA_MEM, 2 * PAGES_ALLOCATED * page_size / 1024, 2);
 
 	/*
 	 * In most cases, set_mempolicy01 finish quickly, but when the platform
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
index 3db9c20090..57fef862da 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
@@ -33,9 +33,7 @@ static void setup(void)
 {
 	page_size = getpagesize();
 
-	nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * ALLOC_ON_NODE * page_size / 1024);
-	if (nodes->cnt <= 1)
-		tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
+	nodes = safe_get_nodemap(TST_NUMA_MEM, 2 * ALLOC_ON_NODE * page_size / 1024, 2);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
index 5cfcda6d8c..ac464e5bc1 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
@@ -31,9 +31,7 @@ static void setup(void)
 {
 	page_size = getpagesize();
 
-	nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * PAGES_ALLOCATED * page_size / 1024);
-	if (nodes->cnt <= 1)
-		tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
+	nodes = safe_get_nodemap(TST_NUMA_MEM, 2 * PAGES_ALLOCATED * page_size / 1024, 2);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
index 2a1d2e1b9a..8e0ed2dc2a 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
@@ -44,9 +44,7 @@ static void setup(void)
 
 	page_size = getpagesize();
 
-	nodes = tst_get_nodemap(TST_NUMA_MEM, node_min_pages * page_size / 1024);
-	if (nodes->cnt <= 1)
-		tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
+	nodes = safe_get_nodemap(TST_NUMA_MEM, node_min_pages * page_size / 1024, 2);
 }
 
 static void cleanup(void)
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
