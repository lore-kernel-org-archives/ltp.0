Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E699C79F9F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 13:28:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B3123E72DD
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 15:28:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6259C3E30A3
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 15:27:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9BAFA1A0092B
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 15:27:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C38AD1FDBE;
 Thu, 10 Sep 2026 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789046840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRZY+8EQhMC1M2xp3A87jDNEECEPCHNB7/XfYZVXbDw=;
 b=0lf9EKIkz3fn/BkRwZa0y2626jxsbspiB5H2rGxq7sjBI4piqG3fDbJiaZ2gtb1N+yAgij
 xdAgxll5tGsOxbF2OVBMfOBxEKVKRck+840DR3oJvxn0ayG+ngKdcVcsRq4JoW7NagcbIE
 ReskwuzgSv5mcsi5WRG5T6uTC2X2Ir8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789046840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRZY+8EQhMC1M2xp3A87jDNEECEPCHNB7/XfYZVXbDw=;
 b=xX33v3XU+Shb9WNdit1I9duCqPAM9IyMIiRqzjX8KYZqGG2qAe7MNq3/LUtFe6cbO2wZbj
 +7zARAquoehtJsAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789046835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRZY+8EQhMC1M2xp3A87jDNEECEPCHNB7/XfYZVXbDw=;
 b=WHnmU5Gra5LFSXiVHuvxSS0NdhXUTt6EpaOJv6lhR5BeGyoX7IUke/P1ivAbLUneRCaId3
 aD0iV8WciKhgOmf3JoE/14rmkOnDh7dSdoUnmYAhM3a3ba2cKKE3FEVH3yOXTXANnXdle9
 /mBHvh4Om3XmlkwHRGCPGmjobEiKuwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789046835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRZY+8EQhMC1M2xp3A87jDNEECEPCHNB7/XfYZVXbDw=;
 b=dZMN7Pu4IviXGUiYAirN4CqdrVyVFppUQTZ3aYZrAuA9OejefXMZlTyIpAF8PbC9WeBLtH
 J94hE0gQ8nbKgoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86496137FD;
 Thu, 10 Sep 2026 13:27:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GL2IHzOwompBDwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Sep 2026 13:27:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Sep 2026 15:27:11 +0200
MIME-Version: 1.0
Message-Id: <20260910-coredump-v11-1-e87e2100dbe3@suse.com>
References: <20260910-coredump-v11-0-e87e2100dbe3@suse.com>
In-Reply-To: <20260910-coredump-v11-0-e87e2100dbe3@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789046835; l=2771;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=el9JPPLUkwp4JKWvuHBjyHiJazScx41EI94KVwZXOOo=;
 b=qUnbJGVGW9giMm6A9SA04wMVetjT6bzhFOJrCCjyFSejPfGRBuXW/ISOqIPZXiSrLYp9WWUoj
 Yct+gQJkU2QBxE4wdKH0BPk1ytPGaJMsefzvEKrjsX2SCPN9zW36pfk
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:email, suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 1/3] lib: Add SAFE_FILE_VPRINTF()
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

Expose safe_file_vprintf() as SAFE_FILE_VPRINTF() macro to allow
formatting directly into files with a va_list without requiring
an intermediate buffer.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/safe_file_ops_fn.h  |  6 ++++++
 include/tst_safe_file_ops.h | 14 ++++++++++++++
 lib/safe_file_ops.c         |  2 +-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/safe_file_ops_fn.h b/include/safe_file_ops_fn.h
index 223fb0d68..1edaac794 100644
--- a/include/safe_file_ops_fn.h
+++ b/include/safe_file_ops_fn.h
@@ -20,6 +20,7 @@
 
 #include <sys/stat.h>
 #include <time.h>
+#include <stdarg.h>
 
 #include "lapi/utime.h"
 
@@ -62,6 +63,11 @@ void safe_file_printf(const char *file, const int lineno,
                       const char *path, const char *fmt, ...)
                       __attribute__ ((format (printf, 5, 6)));
 
+void safe_file_vprintf(const char *file, const int lineno,
+		       void (*cleanup_fn)(void),
+		       const char *path, const char *fmt, va_list va)
+	__attribute__ ((format (printf, 5, 0)));
+
 void safe_try_file_printf(const char *file, const int lineno,
 	void (*cleanup_fn)(void), const char *path, const char *fmt, ...)
 	__attribute__ ((format (printf, 5, 6)));
diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 73ebd2ab8..0fc1a160c 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -65,6 +65,20 @@ void safe_file_read_str(const char *file, const int lineno,
 	safe_file_printf(__FILE__, __LINE__, NULL, \
 	                 (path), (fmt), ## __VA_ARGS__)
 
+/**
+ * SAFE_FILE_VPRINTF() - Formats and writes a va_list argument into a file.
+ *
+ * Writes formatted output to the file at @path using the format string @fmt
+ * and variable arguments @va. Aborts the test with TBROK on failure.
+ *
+ * @path: A path to a file.
+ * @fmt: A printf format string.
+ * @va: A variable argument list.
+ */
+#define SAFE_FILE_VPRINTF(path, fmt, va) \
+	safe_file_vprintf(__FILE__, __LINE__, NULL, \
+			  (path), (fmt), (va))
+
 /* Same as SAFE_FILE_PRINTF() but returns quietly if the path doesn't exist */
 #define SAFE_TRY_FILE_PRINTF(path, fmt, ...) \
 	safe_try_file_printf(__FILE__, __LINE__, NULL, \
diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index 19da1fd97..1069a017f 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -280,7 +280,7 @@ err:
 	return 1;
 }
 
-static void safe_file_vprintf(const char *file, const int lineno,
+void safe_file_vprintf(const char *file, const int lineno,
 	void (*cleanup_fn)(void), const char *path, const char *fmt,
 	va_list va)
 {

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
