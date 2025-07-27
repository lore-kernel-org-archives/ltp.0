Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BC3C87FCC
	for <ltp@archiver.kernel.org>; Sun, 27 Jul 2025 20:55:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 257F23C75F5
	for <ltp@archiver.kernel.org>; Sun, 27 Jul 2025 22:55:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FBDB3C68DA
 for <ltp@lists.linux.it>; Sun, 27 Jul 2025 22:55:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C20521A002F3
 for <ltp@lists.linux.it>; Sun, 27 Jul 2025 22:55:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 88BBE211C7;
 Sun, 27 Jul 2025 20:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753649702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7RLb6zH2sTDsMHDEjX9JOSPu+ITRu+BwpCfY8bLpc3c=;
 b=cOLCqC8CVUJKDMTlhF6NxXyc+vfyepTFci+GvmCmrJT01wSR6S1mbiFWCdzapWsU1Aj97Z
 y7hMgo48S+UaZJw3D/sHyN/QGKauuUNjQkqz/WZLE/RKIZCMk/VBIbBugbnh9QBd++DIhE
 50bb54KY8k/PlcYNX+dMZwSCn/zMkFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753649702;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7RLb6zH2sTDsMHDEjX9JOSPu+ITRu+BwpCfY8bLpc3c=;
 b=iFX864tf2ooyqG7/PVaVaXgk849ZM67xeh4XI0sSw5Eqc9L6ERlA1I6epnJm8+TurZgInO
 sX5Ti2wR5y1OCTAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753649702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7RLb6zH2sTDsMHDEjX9JOSPu+ITRu+BwpCfY8bLpc3c=;
 b=cOLCqC8CVUJKDMTlhF6NxXyc+vfyepTFci+GvmCmrJT01wSR6S1mbiFWCdzapWsU1Aj97Z
 y7hMgo48S+UaZJw3D/sHyN/QGKauuUNjQkqz/WZLE/RKIZCMk/VBIbBugbnh9QBd++DIhE
 50bb54KY8k/PlcYNX+dMZwSCn/zMkFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753649702;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7RLb6zH2sTDsMHDEjX9JOSPu+ITRu+BwpCfY8bLpc3c=;
 b=iFX864tf2ooyqG7/PVaVaXgk849ZM67xeh4XI0sSw5Eqc9L6ERlA1I6epnJm8+TurZgInO
 sX5Ti2wR5y1OCTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C50413A43;
 Sun, 27 Jul 2025 20:55:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id psxRFSaShmhZVQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sun, 27 Jul 2025 20:55:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Sun, 27 Jul 2025 22:54:54 +0200
Message-ID: <20250727205455.728650-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo,ozlabs.org:url];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.com,redhat.com,suse.cz];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] tlibio: Detect <aio.h> support
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

From: Petr Vorel <petr.vorel@gmail.com>

Some libc (i.e. uclibc-ng or uclibc) does not implement <aio.h>.
Requiring it for the core LTP library breaks build of these libc.
Restore unintentional removal in fed3e3ee63.

Changes:
* Fix for all libc without <aio.h> support: previous check
  'defined(__linux__) && !defined(__UCLIBC__)' was uclibc-ng specific
  (and check for __linux__ was not needed anyway). All of these used
  prior fed3e3ee63 is replaced just by HAVE_AIO_H.
* Comment out also if block first and last 'line if (...) {' and '}' if
  the block would be empty anyway.
* Further join preprocessor checks as code prior fed3e3ee63 contained
  code compiled for old unixes (e.g. sgi), which fed3e3ee63 removed.
* Remove nested preprocessors checks in code which is already checked
  (i.e. lio_wait4asyncio()).
* Fix wrong #endif comments.
* Add further cleanup of old unixes.

I also wonder if #else part of struct lio_info_type Lio_info1[]
should be really defined for code without <aio.h>.

Fixes: fed3e3ee63 ("lib/tlibio: Get rid of support for old UNIXes")
Fixes: https://autobuild.buildroot.org/results/f3e/f3e03b9a1a69988d6497f36c9d64a37a66e9ad20/
Fixes: https://autobuild.buildroot.org/results/856/856365f467efc449faee1951250e63d8d4442bbc/
Fixes: https://autobuild.buildroot.org/results/2ac/2ac08cecd6a505f1bac1a673efc280b3a8dcb23a/
Fixes: https://autobuild.buildroot.org/results/59b/59b3ad33667b7e87c81e49dd434d5f494e189e0d/
Fixes: https://autobuild.buildroot.org/results/b1a/b1a36f9971c97300670d8d772ace11e5fedceaaa/
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Changes v1->v2:
* instead of hardcoding UCLIBC add a proper configure check for <aio.h> (Cyril)
* join 2 commits into single

v1:
https://lore.kernel.org/ltp/20250724190946.338828-1-petr.vorel@gmail.com/
https://patchwork.ozlabs.org/project/ltp/list/?series=466584&state=*

Kind regards,
Petr

 configure.ac |  1 +
 lib/tlibio.c | 52 +++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8ec37639c1..12025be51c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -48,6 +48,7 @@ AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
 AC_CHECK_DECLS([SEM_STAT_ANY],,,[#include <sys/sem.h>])
 
 AC_CHECK_HEADERS_ONCE([ \
+    aio.h \
     asm/ldt.h \
     asm/prctl.h \
     cpuid.h \
diff --git a/lib/tlibio.c b/lib/tlibio.c
index b877393df2..70e0c6f7d2 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -88,7 +88,9 @@
 #include <stdint.h>
 #include <sys/uio.h>		/* readv(2)/writev(2) */
 #include <string.h>
-#include <aio.h>
+#ifdef HAVE_AIO_H
+# include <aio.h>
+#endif
 #include <stdlib.h>		/* atoi, abs */
 
 #include "tlibio.h"		/* defines LIO* macros */
@@ -108,7 +110,7 @@ struct lio_info_type Lio_info1[] = {
 	{"b", LIO_IO_ASYNC | LIO_WAIT_SIGPAUSE, "async i/o using pause"},
 	{"a", LIO_IO_ASYNC | LIO_WAIT_RECALL,
 	 "async i/o using recall/aio_suspend"},
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
+#ifdef HAVE_AIO_H
 	{"r",
 	 LIO_RANDOM | LIO_IO_TYPES | LIO_WAIT_TYPES,
 	 "random sync i/o types and wait methods"},
@@ -159,7 +161,7 @@ char Lio_SysCall[PATH_MAX];	/* string containing last i/o system call */
 
 static volatile int Received_signal = 0;	/* number of signals received */
 static volatile int Rec_signal;
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
+#ifdef HAVE_AIO_H
 static volatile int Received_callback = 0;	/* number of callbacks received */
 static volatile int Rec_callback;
 #endif
@@ -399,7 +401,7 @@ static void lio_async_signal_handler(int sig)
 	return;
 }
 
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
+#ifdef HAVE_AIO_H
 /***********************************************************************
  * This is an internal callback handler.
  * If the handler is called, it will increment the Received_callback
@@ -417,7 +419,7 @@ static void lio_async_callback_handler(union sigval sigval)
 
 	return;
 }
-#endif /* sgi */
+#endif
 
 /***********************************************************************
  * lio_random_methods
@@ -515,9 +517,11 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 	int omethod = method;
 	int listio_cmd;		/* Holds the listio/lio_listio cmd */
 	struct iovec iov;	/* iovec for writev(2) */
+#ifdef HAVE_AIO_H
 	struct aiocb aiocbp;	/* POSIX aio control block */
 	struct aiocb *aiolist[1];	/* list of aio control blocks for lio_listio */
 	off64_t poffset;	/* pwrite(2) offset */
+#endif
 
 	/*
 	 * If LIO_RANDOM bit specified, get new method randomly.
@@ -536,12 +540,15 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 		*errmsg = Errormsg;
 
 	Rec_signal = Received_signal;	/* get the current number of signals received */
+#ifdef HAVE_AIO_H
 	Rec_callback = Received_callback;	/* get the current number of callbacks received */
+#endif
 
 	memset(&iov, 0x00, sizeof(struct iovec));
 	iov.iov_base = buffer;
 	iov.iov_len = size;
 
+#ifdef HAVE_AIO_H
 	memset(&aiocbp, 0x00, sizeof(struct aiocb));
 
 	aiocbp.aio_fildes = fd;
@@ -589,6 +596,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 
 	poffset = (off64_t) ret;
 	aiocbp.aio_offset = ret;
+#endif
 
 	/*
 	 * If the LIO_USE_SIGNAL bit is not set, only use the signal
@@ -597,9 +605,9 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 	 * the signal.
 	 */
 	if (sig && !(method & LIO_USE_SIGNAL) && !(method & LIO_WAIT_SIGTYPES)) {
-
 		sig = 0;	/* ignore signal parameter */
 	}
+#ifdef HAVE_AIO_H
 	if (sig && (method & LIO_WAIT_CBTYPES))
 		sig = 0;	/* ignore signal parameter */
 
@@ -626,6 +634,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 		aiocbp.aio_sigevent.sigev_notify_attributes =
 		    (void *)(uintptr_t) size;
 	}
+#endif
 
 	/*
 	 * Determine the system call that will be called and produce
@@ -684,6 +693,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 	}
 
 	else if (method & LIO_IO_ASYNC) {
+#ifdef HAVE_AIO_H
 		sprintf(Lio_SysCall,
 			"aio_write(fildes=%d, buf, nbytes=%d, signo=%d)", fd,
 			size, sig);
@@ -705,9 +715,11 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 				sigrelse(sig);
 			return -errno;
 		}
+#endif
 	}
 	/* LIO_IO_ASYNC */
 	else if (method & LIO_IO_SLISTIO) {
+#ifdef HAVE_AIO_H
 		aiocbp.aio_lio_opcode = LIO_WRITE;
 		listio_cmd = LIO_WAIT;
 		io_type = "lio_listio(3) sync write";
@@ -739,9 +751,11 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 
 		ret = lio_check_asyncio(io_type, size, &aiocbp, method);
 		return ret;
+#endif
 	}
 	/* LIO_IO_SLISTIO */
 	else if (method & LIO_IO_ALISTIO) {
+#ifdef HAVE_AIO_H
 		aiocbp.aio_lio_opcode = LIO_WRITE;
 		listio_cmd = LIO_NOWAIT;
 		io_type = "lio_listio(3) async write";
@@ -766,6 +780,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 				sigrelse(sig);
 			return -errno;
 		}
+#endif
 	}
 	/* LIO_IO_ALISTIO */
 	else if (method & LIO_IO_SYNCV) {
@@ -796,6 +811,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 
 		return ret;
 	}			/* LIO_IO_SYNCV */
+#ifdef HAVE_AIO_H
 	else if (method & LIO_IO_SYNCP) {
 		io_type = "pwrite(2)";
 
@@ -827,6 +843,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 
 		return ret;
 	}			/* LIO_IO_SYNCP */
+#endif
 	else {
 		printf("DEBUG %s/%d: No I/O method chosen\n", __FILE__,
 		       __LINE__);
@@ -836,7 +853,9 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 	/*
 	 * wait for async io to complete.
 	 */
+#ifdef HAVE_AIO_H
 	ret = lio_wait4asyncio(method, fd, &aiocbp);
+#endif
 
 	/*
 	 * If there was an error waiting for async i/o to complete,
@@ -862,7 +881,9 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 	 * have been updated but the actual i/o size if returned.
 	 */
 
+#ifdef HAVE_AIO_H
 	ret = lio_check_asyncio(io_type, size, &aiocbp, method);
+#endif
 
 	return ret;
 }				/* end of lio_write_buffer */
@@ -924,9 +945,11 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	int listio_cmd;		/* Holds the listio/lio_listio cmd */
 	int omethod = method;
 	struct iovec iov;	/* iovec for readv(2) */
+#ifdef HAVE_AIO_H
 	struct aiocb aiocbp;	/* POSIX aio control block */
 	struct aiocb *aiolist[1];	/* list of aio control blocks for lio_listio */
 	off64_t poffset;	/* pread(2) offset */
+#endif
 
 	/*
 	 * If LIO_RANDOM bit specified, get new method randomly.
@@ -945,12 +968,15 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 		*errmsg = Errormsg;
 
 	Rec_signal = Received_signal;	/* get the current number of signals received */
+#ifdef HAVE_AIO_H
 	Rec_callback = Received_callback;	/* get the current number of callbacks received */
+#endif
 
 	memset(&iov, 0x00, sizeof(struct iovec));
 	iov.iov_base = buffer;
 	iov.iov_len = size;
 
+#ifdef HAVE_AIO_H
 	memset(&aiocbp, 0x00, sizeof(struct aiocb));
 
 	aiocbp.aio_fildes = fd;
@@ -998,6 +1024,7 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	}
 	poffset = (off64_t) ret;
 	aiocbp.aio_offset = ret;
+#endif
 
 	/*
 	 * If the LIO_USE_SIGNAL bit is not set, only use the signal
@@ -1010,6 +1037,7 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 		sig = 0;	/* ignore signal parameter */
 	}
 
+#ifdef HAVE_AIO_H
 	if (sig && (method & LIO_WAIT_CBTYPES))
 		sig = 0;	/* ignore signal parameter */
 
@@ -1020,7 +1048,6 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	 * old signal handler will not be restored.
 	 *** restoring the signal handler could be added ***
 	 */
-
 	if (sig && (method & LIO_WAIT_SIGTYPES)) {
 		aiocbp.aio_sigevent.sigev_notify = SIGEV_SIGNAL;
 		aiocbp.aio_sigevent.sigev_signo = sig;
@@ -1035,6 +1062,7 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 		aiocbp.aio_sigevent.sigev_notify_attributes =
 		    (void *)(uintptr_t) size;
 	}
+#endif
 
 	/*
 	 * Determine the system call that will be called and produce
@@ -1093,6 +1121,7 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 			wait4sync_io(fd, 1);
 		}
 
+#ifdef HAVE_AIO_H
 	} else if (method & LIO_IO_ASYNC) {
 		sprintf(Lio_SysCall,
 			"aio_read(fildes=%d, buf, nbytes=%d, signo=%d)", fd,
@@ -1236,7 +1265,8 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 			     __FILE__, __LINE__, ret);
 
 		return ret;
-	}			/* LIO_IO_SYNCP */
+#endif
+	}
 
 	else {
 		printf("DEBUG %s/%d: No I/O method chosen\n", __FILE__,
@@ -1248,7 +1278,9 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	 * wait for async io to complete.
 	 * Note: Sync io should have returned prior to getting here.
 	 */
+#ifdef HAVE_AIO_H
 	ret = lio_wait4asyncio(method, fd, &aiocbp);
+#endif
 
 	/*
 	 * If there was an error waiting for async i/o to complete,
@@ -1274,12 +1306,14 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	 * have been updated but the actual i/o size if returned.
 	 */
 
+#ifdef HAVE_AIO_H
 	ret = lio_check_asyncio(io_type, size, &aiocbp, method);
+#endif
 
 	return ret;
 }				/* end of lio_read_buffer */
 
-#if !defined(__sun) && !defined(__hpux) && !defined(_AIX)
+#ifdef HAVE_AIO_H
 /***********************************************************************
  * This function will check that async io was successful.
  * It can also be used to check sync listio since it uses the
-- 
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
