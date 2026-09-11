Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1661C88E45
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 07:07:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DFF93E538F
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:07:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A35253E72B5
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A39186006EE
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 572CD1FCC4;
 Fri, 11 Sep 2026 07:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VatBtR8wcc6xJTxA4PcscRvj36OdIbbwYHydwjOPSU=;
 b=cDprt2Qv5RDyrvUzxIsk2KqQG3jzuidrUkofke6cf1HwvIQcZoIdincUIAGIaCxue4F4Ma
 pAM3AEPnd3F9aEKeXijbJ9CN+NV2vfGBw0MGpTEiRN109WhYnadhqqgz6L8tXR1MvEls7E
 cJtt3j+yff4+1e11Eee/45pFbqP9xfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VatBtR8wcc6xJTxA4PcscRvj36OdIbbwYHydwjOPSU=;
 b=9biEZ7+VGNkbGXgAmPONRlWqYNgoU7YfZn4CbiEycomRVFnvHepapu9cIsuQbbA/N5IE/m
 +cjKs/XnUoB7yMBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=O+Ivd8Qr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nzbHLhUJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VatBtR8wcc6xJTxA4PcscRvj36OdIbbwYHydwjOPSU=;
 b=O+Ivd8Qr9VUrtUuYvOWT2hRHJuScInX4nTVDrExpOg35YwNCOh6af29MOQ6bNl5UgyVqVw
 NZmxgHTcM+7/sH77akbTfQjYAPi6tJHOGfEayyI/JGLmd48RO5kZfKxV1+YWuFB8abcK8l
 j7jRhAoKoCvy1dtZQxl3ynK3jwobWlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VatBtR8wcc6xJTxA4PcscRvj36OdIbbwYHydwjOPSU=;
 b=nzbHLhUJeNrBk9JoUHPPg4nlPPPujR0zP6uAzO20bsibZyWgz6+cQXCAIfFelsKUJA5g7I
 VGFsgag7O/QB6lBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90CB3137EC;
 Fri, 11 Sep 2026 07:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MKWpIfWno2qwLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 07:04:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 09:04:22 +0200
MIME-Version: 1.0
Message-Id: <20260911-fix_documentation-v2-6-716b2613c477@suse.com>
References: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
In-Reply-To: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789110260; l=4530;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=7cKa88eHufD5zmV1IR6MIcAOBzINaF3M+aocXbziqBg=;
 b=ihK8OOP/fqXgF6UH2DZ1cXGaxJ80qYoLRF8wvO/g6dHesBSdUSBNJ+jgd9WfEiEb6kF16+4cY
 lDHyWIyLi6eDgYuuj02qYQ6h98CdYkKzQktMi6D+K6gTUI8ZSlaPlgW
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 572CD1FCC4
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.cz:email,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/9] include: Document memory test utilities
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
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
