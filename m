Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FCCC79FB9
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 08:35:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65E633D00A3
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 10:35:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA1013E72D1
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:34:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 26EC220075C
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:34:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B87F1FDFB;
 Thu, 10 Sep 2026 08:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJX0A4zrfObP1u0uj5Ls5bUmmabNzPutVkr8zMP+ats=;
 b=KxF3KVfIXWVnMFz3G3MJlOgFfq6wdQG0fJOptAvaOxLrhD6Xy/4F3jo+aETbjX8o8k7kjF
 mIf1dZ9dqalAFF7M2/TQZgQd21SbH6PetANpRpmufqqZ4t6XqyHL90Znja9eVJRMhkhzZZ
 vh4rzTA61QFafCNH32U8shSEgYwsqPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJX0A4zrfObP1u0uj5Ls5bUmmabNzPutVkr8zMP+ats=;
 b=ZEdIdoIVy76K6NMFh06TuChWibJjats38uNbvqEPbvcLVmolOf8ULPsVZVkTfF5+WUtEgk
 fczOS6YlIhGzwxBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="iZTZVp/h";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rHL7GmVq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJX0A4zrfObP1u0uj5Ls5bUmmabNzPutVkr8zMP+ats=;
 b=iZTZVp/hvZjyf0i4BGc45f94l2V59xAPfRanREzebxfyepz8pOK4trasF2K6NJgY0UBupc
 Ig8MVXxPDxYShQhTwg89wTj0UfS7v8JM8+vufxUJKL9Btb4+KHlvENAwQh0UTWWxfcRjla
 z/lD2n09175EOyxRDV5tWqWI/87w/ZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029232;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJX0A4zrfObP1u0uj5Ls5bUmmabNzPutVkr8zMP+ats=;
 b=rHL7GmVqDhgYpTQE+JxcflnZ9MxXScluHIWWOUvPn/CaChjABHU4pKWfarQeknFWmfYsIp
 sC6HU0QuvYXcOJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 688F613A5E;
 Thu, 10 Sep 2026 08:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6EzMF2hromqoWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Sep 2026 08:33:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Sep 2026 10:33:46 +0200
MIME-Version: 1.0
Message-Id: <20260910-fix_documentation-v1-6-44313069bbe8@suse.com>
References: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
In-Reply-To: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789029223; l=4488;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=URs7GDqkPZkIxU1xlpINbEcy0XxE8Xa6Wb0XQk/cQ0U=;
 b=6uSCCGpX12wRSbmeDH6n9i/k6fr4RUAZ6ZADAJzBaG1h4Dhj5tSba5wlR7X+g/Bs190x1FuaW
 xjQga1v+9qPCSCC03TNMkQURCn4foLMYIfMX9GUsibqBcrUtwA+4TeU
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 4B87F1FDFB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/9] include: Document memory test utilities
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add kernel-doc comments for memory pollution, available memory/swap
queries, and OOM protection helpers in include/tst_memutils.h.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_memutils.h | 70 ++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/include/tst_memutils.h b/include/tst_memutils.h
index 57c90c4a9..e3f18c45e 100644
--- a/include/tst_memutils.h
+++ b/include/tst_memutils.h
@@ -6,55 +6,51 @@
 #ifndef TST_MEMUTILS_H__
 #define TST_MEMUTILS_H__
 
-/*
- * Fill up to maxsize physical memory with fillchar, then free it for reuse.
- * If maxsize is zero, fill as much memory as possible. This function is
- * intended for data disclosure vulnerability tests to reduce the probability
- * that a vulnerable kernel will leak a block of memory that was full of
- * zeroes by chance.
+/**
+ * tst_pollute_memory() - Fills physical memory with a byte pattern.
+ *
+ * @maxsize: Maximum memory size in bytes to fill (0 for maximum possible).
+ * @fillchar: Byte value to write into allocated memory.
  *
- * The function keeps a safety margin to avoid invoking OOM killer and
- * respects the limitations of available address space. (Less than 3GB can be
- * polluted on a 32bit system regardless of available physical RAM.)
+ * Fills up to maxsize physical memory with fillchar, then frees it for reuse.
+ * Keeps a safety margin to avoid invoking the OOM killer and respects address
+ * space limits.
  */
 void tst_pollute_memory(size_t maxsize, int fillchar);
 
-/*
- * Read the value of MemAvailable from /proc/meminfo, if no support on
- * older kernels, return 'MemFree + Cached' for instead.
+/**
+ * tst_available_mem() - Reads available memory from /proc/meminfo.
+ *
+ * Reads MemAvailable from /proc/meminfo. On older kernels without MemAvailable,
+ * falls back to MemFree + Cached.
+ *
+ * Return: Available memory in KiB.
  */
 long long tst_available_mem(void);
 
-/*
- * Read the value of SwapFree from /proc/meminfo.
+/**
+ * tst_available_swap() - Reads free swap from /proc/meminfo.
+ *
+ * Return: Available swap space in KiB.
  */
 long long tst_available_swap(void);
 
-/*
- * Enable OOM protection to prevent process($PID) being killed by OOM Killer.
- *   echo -1000 >/proc/$PID/oom_score_adj
- *
- * If the pid is 0 which means it will set on current(self) process.
- *
- * Unless the process has CAP_SYS_RESOURCE this call will be no-op because
- * setting adj value < 0 requires it.
+/**
+ * tst_enable_oom_protection() - Protects process from OOM killer.
  *
- * CAP_SYS_RESOURCE:
- *   set /proc/[pid]/oom_score_adj to a value lower than the value last set
- *   by a process with CAP_SYS_RESOURCE.
+ * @pid: Process PID to protect, or 0 for the calling process.
  *
- * Note:
- *  This exported tst_enable_oom_protection function can be used at anywhere
- *  you want to protect, but please remember that if you do enable protection
- *  on a process($PID) that all the children will inherit its score and be
- *  ignored by OOM Killer as well. So that's why tst_disable_oom_protection()
- *  to be used in combination.
+ * Sets /proc/[pid]/oom_score_adj to -1000. Requires CAP_SYS_RESOURCE; no-op
+ * without this capability. Child processes inherit the OOM score.
  */
 void tst_enable_oom_protection(pid_t pid);
 
-/*
- * Disable the OOM protection for the process($PID).
- *   echo 0 >/proc/$PID/oom_score_adj
+/**
+ * tst_disable_oom_protection() - Disables OOM protection for process.
+ *
+ * @pid: Process PID, or 0 for the calling process.
+ *
+ * Sets /proc/[pid]/oom_score_adj to 0.
  */
 void tst_disable_oom_protection(pid_t pid);
 
@@ -63,10 +59,10 @@ void tst_disable_oom_protection(pid_t pid);
 /**
  * tst_mapping_in_range() - Returns true if there is a mapping provided range.
  *
- * @low: A lower address inside of the processe address space.
- * @high: A higher address inside of the processe address space.
+ * @low: A lower address inside of the process address space.
+ * @high: A higher address inside of the process address space.
  *
- * return: Returns true if there is a mapping between low and high addresses in
+ * Return: Returns true if there is a mapping between low and high addresses in
  *         the process address space.
  */
 int tst_mapping_in_range(unsigned long low, unsigned long high);

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
