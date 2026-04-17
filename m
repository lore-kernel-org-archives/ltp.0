Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF6CF8DFF9
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 08:48:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB0613E2DDD
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 10:48:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88B193E2627
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 10:48:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 02052600B2B
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 10:48:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 12FE26A869;
 Fri, 17 Apr 2026 08:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776415690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnn54T+JcoPAUZcr9+j97ooam/LQDn34ym6lS4lS4PM=;
 b=wbJLdSISidImbocpwLOr9V6CzbfE8DwTK7Mwe1C/U9WABhr6FEjiyCOqO+Ax8yKPL3jSFC
 W9QruBHXuQPGeoQS97XQpp3gYeSCTAe94fYjEYK4uCDriaaimn2WwXjpeFl+Dpoe1jCDzZ
 oOuKL+2zmT7GM5ZC43Qo8A+QT34ld7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776415690;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnn54T+JcoPAUZcr9+j97ooam/LQDn34ym6lS4lS4PM=;
 b=z4w+RFkgCw+kLzpBn/YVwUnaX0CLnXxf490KthbM1vHnG0804PhiKD8f19/85jXGKPZoia
 9qW2xuzxdT6o4KCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776415686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnn54T+JcoPAUZcr9+j97ooam/LQDn34ym6lS4lS4PM=;
 b=v20GVU3vNd6EDw7opH6VKZD7Iiiy7TInmnI9AK8t5f/k0YgBhR1yL/mFj4nFq4z7Ca41Ne
 14WqJwBkN1OQeUGQUilIExP317fP19gbf+whDLu3nJUjP4Tnko1FZlbjkNB874SWguSRuy
 f98ueOdLDUqINksFEcFlkq/QuN3RD6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776415686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnn54T+JcoPAUZcr9+j97ooam/LQDn34ym6lS4lS4PM=;
 b=G0TIF4p0vh1SV9TxjMvfG6ud09cps2iOgm/9ydqq8WBpcEKHaO0HVRLFhyq4FeICWrYiaz
 ZcGYKkL3jdMVEJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB060593AF;
 Fri, 17 Apr 2026 08:48:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oMRxOMXz4WmUUAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Apr 2026 08:48:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 17 Apr 2026 10:47:58 +0200
Message-ID: <20260417084758.329107-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417084758.329107-1-pvorel@suse.cz>
References: <20260417084758.329107-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] lib: Be pedantic on invalid comparison check
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

Invalid return values are when "ret < -1". While "ret < 0" mostly works
due previous check "ret == -1" it can have misleading message when after
code refactoring.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/safe_file_ops.c     |  2 +-
 lib/safe_macros.c       | 16 ++++++++--------
 lib/safe_net.c          | 14 +++++++-------
 lib/safe_stdio.c        |  4 ++--
 lib/tst_safe_io_uring.c |  4 ++--
 lib/tst_safe_macros.c   | 16 ++++++++--------
 lib/tst_safe_sysv_ipc.c | 10 +++++-----
 lib/tst_safe_timerfd.c  |  2 +-
 lib/tst_security.c      |  2 +-
 9 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index 8314c4b1bb..0982274120 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -361,7 +361,7 @@ int safe_touch(const char *file, const int lineno,
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Failed to open file '%s'", pathname);
 		return ret;
-	} else if (ret < 0) {
+	} else if (ret < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid open(%s) return value %d", pathname, ret);
 		return ret;
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 68b8747b4d..22b321fc45 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -89,7 +89,7 @@ safe_creat(const char *file, const int lineno, void (*cleanup_fn) (void),
 	if (rval == -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"creat(%s,%04o) failed", pathname, mode);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid creat(%s,%04o) return value %d", pathname,
 			mode, rval);
@@ -258,7 +258,7 @@ int safe_open(const char *file, const int lineno, void (*cleanup_fn) (void),
 	if (rval == -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"open(%s,%d,%04o) failed", pathname, oflags, mode);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid open(%s,%d,%04o) return value %d", pathname,
 			oflags, mode, rval);
@@ -297,7 +297,7 @@ ssize_t safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"read(%d,%p,%zu) failed, returned %zd", fildes, buf,
 			nbyte, rval);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid read(%d,%p,%zu) return value %zd", fildes,
 			buf, nbyte, rval);
@@ -495,7 +495,7 @@ ssize_t safe_readlink(const char *file, const int lineno,
 	if (rval == -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"readlink(%s,%p,%zu) failed", path, buf, bufsize);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid readlink(%s,%p,%zu) return value %zd", path,
 			buf, bufsize, rval);
@@ -554,7 +554,7 @@ ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
 			return rval;
 		}
 
-		if (rval < 0) {
+		if (rval < -1) {
 			tst_brkm_(file, lineno, TBROK, cleanup_fn,
 			          "invalid write() return value %zi",
 				  rval);
@@ -804,7 +804,7 @@ pid_t safe_wait(const char *file, const int lineno, void (cleanup_fn)(void),
 	if (rval == -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"wait(%p) failed", status);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid wait(%p) return value %d", status, rval);
 	}
@@ -822,7 +822,7 @@ pid_t safe_waitpid(const char *file, const int lineno, void (cleanup_fn)(void),
 	if (rval == -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"waitpid(%d,%p,%d) failed", pid, status, opts);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid waitpid(%d,%p,%d) return value %d", pid,
 			status, opts, rval);
@@ -1116,7 +1116,7 @@ ssize_t safe_getxattr(const char *file, const int lineno, const char *path,
 		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
 			"getxattr(%s, %s, %p, %zu) failed",
 			path, name, value, size);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
 			"Invalid getxattr(%s, %s, %p, %zu) return value %zd",
 			path, name, value, size, rval);
diff --git a/lib/safe_net.c b/lib/safe_net.c
index 5dec0de113..37a980fae9 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -127,7 +127,7 @@ int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
 
 		tst_brkm_(file, lineno, ttype | TERRNO, cleanup_fn,
 			"socket(%d, %d, %d) failed", domain, type, protocol);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid socket(%d, %d, %d) return value %d", domain,
 			type, protocol, rval);
@@ -215,7 +215,7 @@ ssize_t safe_send(const char *file, const int lineno, char len_strict,
 		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
 			"send(%d, %p, %zu, %d) failed", sockfd, buf, len,
 			flags);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
 			"Invalid send(%d, %p, %zu, %d) return value %zd",
 			sockfd, buf, len, flags, rval);
@@ -239,7 +239,7 @@ ssize_t safe_sendto(const char *file, const int lineno, char len_strict,
 			sockfd, buf, len, flags,
 			tst_sock_addr(dest_addr, addrlen, res, sizeof(res)),
 			addrlen);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
 			"Invalid sendto(%d, %p, %zu, %d, %s, %d) return value %zd",
 			sockfd, buf, len, flags,
@@ -260,7 +260,7 @@ ssize_t safe_sendmsg(const char *file, const int lineno, size_t len,
 	if (rval == -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
 			"sendmsg(%d, %p, %d) failed", sockfd, msg, flags);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
 			"Invalid sendmsg(%d, %p, %d) return value %zd",
 			sockfd, msg, flags, rval);
@@ -284,7 +284,7 @@ ssize_t safe_recv(const char *file, const int lineno, size_t len,
 		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
 			"recv(%d, %p, %zu, %d) failed", sockfd, buf, size,
 			flags);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
 			"Invalid recv(%d, %p, %zu, %d) return value %zd",
 			sockfd, buf, size, flags, rval);
@@ -308,7 +308,7 @@ ssize_t safe_recvmsg(const char *file, const int lineno, size_t len,
 	if (rval == -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
 			"recvmsg(%d, %p, %d) failed", sockfd, msg, flags);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
 			"Invalid recvmsg(%d, %p, %d) return value %zd",
 			sockfd, msg, flags, rval);
@@ -396,7 +396,7 @@ int safe_accept(const char *file, const int lineno, void (cleanup_fn)(void),
 	if (rval == -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"accept(%d, %p, %d) failed", sockfd, addr, *addrlen);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid accept(%d, %p, %d) return value %d", sockfd,
 			addr, *addrlen, rval);
diff --git a/lib/safe_stdio.c b/lib/safe_stdio.c
index ed5bca0072..27b38aadcc 100644
--- a/lib/safe_stdio.c
+++ b/lib/safe_stdio.c
@@ -67,7 +67,7 @@ int safe_asprintf(const char *file, const int lineno, void (cleanup_fn)(void),
 	if (ret == -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"asprintf(%s,...) failed", fmt);
-	} else if (ret < 0) {
+	} else if (ret < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid asprintf(%s,...) return value %d", fmt, ret);
 	}
@@ -154,7 +154,7 @@ int safe_fseek(const char *file, const int lineno,
 	if (ret == -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
 			"fseek(%p, %ld, %d) failed", f, offset, whence);
-	} else if (ret < 0) {
+	} else if (ret < -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
 			"Invalid fseek(%p, %ld, %d) return value %d",
 			f, offset, whence, ret);
diff --git a/lib/tst_safe_io_uring.c b/lib/tst_safe_io_uring.c
index de6869f501..627cedfe02 100644
--- a/lib/tst_safe_io_uring.c
+++ b/lib/tst_safe_io_uring.c
@@ -21,7 +21,7 @@ int safe_io_uring_init(const char *file, const int lineno,
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"io_uring_setup() failed");
 		return uring->fd;
-	} else if (uring->fd < 0) {
+	} else if (uring->fd < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"io_uring_setup() returned invalid value %d",
 			uring->fd);
@@ -98,7 +98,7 @@ int safe_io_uring_enter(const char *file, const int lineno, int strict,
 	if (ret == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"io_uring_enter() failed");
-	} else if (ret < 0) {
+	} else if (ret < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid io_uring_enter() return value %d", ret);
 	} else if (strict && to_submit != (unsigned int)ret) {
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index cdc8c7dd33..a893f73231 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -68,7 +68,7 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid)
 	if (pgid == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO, "getpgid(%i) failed",
 			pid);
-	} else if (pgid < 0) {
+	} else if (pgid < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid getpgid(%i) return value %d", pid, pgid);
 	}
@@ -103,7 +103,7 @@ int safe_getgroups(const char *file, const int lineno, int size, gid_t list[])
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"getgroups(%i, %p)", size, list);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid getgroups(%i, %p) return value %d", size,
 			list, rval);
@@ -120,7 +120,7 @@ int safe_personality(const char *filename, unsigned int lineno,
 	if (prev_persona == -1) {
 		tst_brk_(filename, lineno, TBROK | TERRNO,
 			 "persona(%ld) failed", persona);
-	} else if (prev_persona < 0) {
+	} else if (prev_persona < -1) {
 		tst_brk_(filename, lineno, TBROK | TERRNO,
 			 "Invalid persona(%ld) return value %d", persona,
 			 prev_persona);
@@ -139,7 +139,7 @@ int safe_pidfd_open(const char *file, const int lineno, pid_t pid,
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			 "pidfd_open(%i, %i) failed", pid, flags);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			 "Invalid pidfd_open(%i, %i) return value %d",
 			 pid, flags, rval);
@@ -521,7 +521,7 @@ int safe_dup(const char *file, const int lineno, int oldfd)
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"dup(%i) failed", oldfd);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid dup(%i) return value %d", oldfd, rval);
 	}
@@ -723,7 +723,7 @@ int safe_prctl(const char *file, const int lineno,
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"prctl(%d, %lu, %lu, %lu, %lu)",
 			option, arg2, arg3, arg4, arg5);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid prctl(%d, %lu, %lu, %lu, %lu) return value %d",
 			option, arg2, arg3, arg4, arg5, rval);
@@ -746,7 +746,7 @@ ssize_t safe_readv(const char *file, const int lineno, char len_strict,
 	if (rval == -1 || (len_strict && rval != nbyte)) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"readv(%d,%p,%d) failed", fildes, iov, iovcnt);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid readv(%d,%p,%d) return value %zd",
 			fildes, iov, iovcnt, rval);
@@ -788,7 +788,7 @@ ssize_t safe_writev(const char *file, const int lineno, char len_strict,
 	if (rval == -1 || (len_strict && rval != nbyte)) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"writev(%d,%p,%d) failed", fildes, iov, iovcnt);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid writev(%d,%p,%d) return value %zd",
 			fildes, iov, iovcnt, rval);
diff --git a/lib/tst_safe_sysv_ipc.c b/lib/tst_safe_sysv_ipc.c
index a196fc9ce4..4a16a86e12 100644
--- a/lib/tst_safe_sysv_ipc.c
+++ b/lib/tst_safe_sysv_ipc.c
@@ -70,7 +70,7 @@ int safe_msgget(const char *file, const int lineno, key_t key, int msgflg)
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO, "msgget(%i, %x) failed",
 			(int)key, msgflg);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid msgget(%i, %x) return value %d", (int)key,
 			msgflg, rval);
@@ -110,7 +110,7 @@ ssize_t safe_msgrcv(const char *file, const int lineno, int msqid, void *msgp,
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"msgrcv(%i, %p, %zu, %li, %x) failed",
 			msqid, msgp, msgsz, msgtyp, msgflg);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid msgrcv(%i, %p, %zu, %li, %x) return value %ld",
 			msqid, msgp, msgsz, msgtyp, msgflg, rval);
@@ -148,7 +148,7 @@ int safe_shmget(const char *file, const int lineno, key_t key, size_t size,
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"shmget(%i, %zu, %x) failed", (int)key, size, shmflg);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid shmget(%i, %zu, %x) return value %d",
 			(int)key, size, shmflg, rval);
@@ -218,7 +218,7 @@ int safe_semget(const char *file, const int lineno, key_t key, int nsems,
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"semget(%i, %i, %x) failed", (int)key, nsems, semflg);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid semget(%i, %i, %x) return value %d",
 			(int)key, nsems, semflg, rval);
@@ -272,7 +272,7 @@ int safe_semop(const char *file, const int lineno, int semid, struct sembuf *sop
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"semop(%d, %p, %zu) failed", semid, sops, nsops);
-	} else if (rval < 0) {
+	} else if (rval < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid semop(%d, %p, %zu) return value %d",
 			semid, sops, nsops, rval);
diff --git a/lib/tst_safe_timerfd.c b/lib/tst_safe_timerfd.c
index d31f6e35e5..c08b468fce 100644
--- a/lib/tst_safe_timerfd.c
+++ b/lib/tst_safe_timerfd.c
@@ -21,7 +21,7 @@ int safe_timerfd_create(const char *file, const int lineno,
 	if (fd == -1) {
 		tst_brk_(file, lineno, TTYPE | TERRNO,
 			"timerfd_create(%s) failed", tst_clock_name(clockid));
-	} else if (fd < 0) {
+	} else if (fd < -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid timerfd_create(%s) return value %d",
 			tst_clock_name(clockid), fd);
diff --git a/lib/tst_security.c b/lib/tst_security.c
index 00be4d72e2..b25605377c 100644
--- a/lib/tst_security.c
+++ b/lib/tst_security.c
@@ -122,7 +122,7 @@ int tst_secureboot_enabled(void)
 		tst_res(TINFO | TERRNO,
 			"Cannot open SecureBoot file");
 		return -1;
-	} else if (fd < 0) {
+	} else if (fd < -1) {
 		tst_brk(TBROK | TERRNO, "Invalid open() return value %d", fd);
 		return -1;
 	}
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
