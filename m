Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A7DC369A4
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 16:17:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 580A83CB3B2
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 18:17:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7212A3C02B0
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 18:17:19 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 450C2200C26
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 18:17:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0F21921162
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744129037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oRphDQcTPN5FhAbvv8mK46rx/ZjaKGkFo+RzZtMpNTs=;
 b=2Zv9mlWqGLUT0r/bfN+8LFjsgNmIfpCMj2JehgEg0ilJdK7QXMmbnNqnYhg4HSdTU4HeaN
 SUJ2VKy2OI85PF5t9eD1aXKrPaOPnXwEQe9Y/KBTnVW5nUiPALzpVBLRTCrXfzbAG0aMYJ
 cnVz4u/HIYjcSLBMP8Gl/hgwmVW2vYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744129037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oRphDQcTPN5FhAbvv8mK46rx/ZjaKGkFo+RzZtMpNTs=;
 b=jiUsKhW8y3jTvyWf2Lin8mmZX7pPigk11K3/mqZIqoDj7kQDjQFqwIqu+vakTPhAgKIYq1
 /zsa3gQ8NT0RDTAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744129037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oRphDQcTPN5FhAbvv8mK46rx/ZjaKGkFo+RzZtMpNTs=;
 b=2Zv9mlWqGLUT0r/bfN+8LFjsgNmIfpCMj2JehgEg0ilJdK7QXMmbnNqnYhg4HSdTU4HeaN
 SUJ2VKy2OI85PF5t9eD1aXKrPaOPnXwEQe9Y/KBTnVW5nUiPALzpVBLRTCrXfzbAG0aMYJ
 cnVz4u/HIYjcSLBMP8Gl/hgwmVW2vYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744129037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oRphDQcTPN5FhAbvv8mK46rx/ZjaKGkFo+RzZtMpNTs=;
 b=jiUsKhW8y3jTvyWf2Lin8mmZX7pPigk11K3/mqZIqoDj7kQDjQFqwIqu+vakTPhAgKIYq1
 /zsa3gQ8NT0RDTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E231913A1E
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 16:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pOc8NgxM9WfWaAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 08 Apr 2025 16:17:16 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  8 Apr 2025 18:17:45 +0200
Message-ID: <20250408161745.9757-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/tlibio: Get rid of support for old UNIXes
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

Removes support for obsolete UNIXes CRAY, sgi, etc.

Also removes the UCLIBC ifdefs that disabled most of the code because
aio is not supported on UCLIBC.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tlibio.c | 566 ++-------------------------------------------------
 1 file changed, 14 insertions(+), 552 deletions(-)

diff --git a/lib/tlibio.c b/lib/tlibio.c
index ed82a85b4..451244525 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -53,15 +53,6 @@
  *  int  lio_read_buffer(int fd, int method, char *buffer, int size,
  *						char **errmsg, long wrd);
  *
- *  #ifdef CRAY
- *  int  lio_wait4asyncio(int method, int fd, struct iosw **statptr)
- *  int  lio_check_asyncio(char *io_type, int size, struct iosw *status)
- *  #endif
- *  #ifdef sgi
- *  int  lio_wait4asyncio(int method, int fd, aiocb_t *aiocbp)
- *  int  lio_check_asyncio(char *io_type, int size, aiocb_t *aiocbp, int method)
- *  #endif
- *
  *  int  lio_parse_io_arg1(char *string)
  *  void lio_help1(char *prefix);
  *
@@ -78,12 +69,9 @@
  *
  */
 
-#ifdef __linux__
-#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
-#endif
 #define _LARGEFILE64_SOURCE
-#endif
+
 #include "config.h"
 #include <stdio.h>
 #include <ctype.h>
@@ -98,20 +86,9 @@
 #include <sys/file.h>
 #include <signal.h>
 #include <stdint.h>
-#ifdef CRAY
-#include <sys/secparm.h>
-#include <sys/iosw.h>
-#include <sys/listio.h>
-#else
-/* for linux or sgi */
 #include <sys/uio.h>		/* readv(2)/writev(2) */
 #include <string.h>
-#endif
-#if defined(__linux__) || defined(__sun) || defined(__hpux) || defined(_AIX)
-#ifndef __UCLIBC__
 #include <aio.h>
-#endif
-#endif
 #include <stdlib.h>		/* atoi, abs */
 
 #include "tlibio.h"		/* defines LIO* macros */
@@ -121,15 +98,6 @@
 #define PATH_MAX	MAXPATHLEN
 #endif
 
-#if 0				/* disabled until it's needed -- roehrich 6/11/97 */
-#define BUG1_workaround	1	/* Work around a condition where aio_return gives
-				 * a value of zero but there is no errno followup
-				 * and the read/write operation actually did its
-				 * job.   spr/pv 705244
-				 */
-#endif
-
-
 /*
  * Define the structure as used in lio_parse_arg1 and lio_help1
  */
@@ -546,23 +514,11 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 	char *io_type;		/* Holds string of type of io */
 	int omethod = method;
 	int listio_cmd;		/* Holds the listio/lio_listio cmd */
-#ifdef  CRAY
-	struct listreq request;	/* Used when a listio is wanted */
-	struct iosw status, *statptr[1];
-#else
-	/* for linux or sgi */
 	struct iovec iov;	/* iovec for writev(2) */
-#endif
-#if defined (sgi)
-	aiocb_t aiocbp;		/* POSIX aio control block */
-	aiocb_t *aiolist[1];	/* list of aio control blocks for lio_listio */
-	off64_t poffset;	/* pwrite(2) offset */
-#endif
-#if defined(__linux__) && !defined(__UCLIBC__)
 	struct aiocb aiocbp;	/* POSIX aio control block */
 	struct aiocb *aiolist[1];	/* list of aio control blocks for lio_listio */
 	off64_t poffset;	/* pwrite(2) offset */
-#endif
+
 	/*
 	 * If LIO_RANDOM bit specified, get new method randomly.
 	 */
@@ -580,39 +536,23 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 		*errmsg = Errormsg;
 
 	Rec_signal = Received_signal;	/* get the current number of signals received */
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 	Rec_callback = Received_callback;	/* get the current number of callbacks received */
-#endif
 
-#ifdef  CRAY
-	memset(&status, 0x00, sizeof(struct iosw));
-	memset(&request, 0x00, sizeof(struct listreq));
-	statptr[0] = &status;
-#else
-	/* for linux or sgi */
 	memset(&iov, 0x00, sizeof(struct iovec));
 	iov.iov_base = buffer;
 	iov.iov_len = size;
-#endif
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
-#if defined(sgi)
-	memset(&aiocbp, 0x00, sizeof(aiocb_t));
-#else
+
 	memset(&aiocbp, 0x00, sizeof(struct aiocb));
-#endif
+
 	aiocbp.aio_fildes = fd;
 	aiocbp.aio_nbytes = size;
 	aiocbp.aio_buf = buffer;
 /*    aiocbp.aio_offset = lseek( fd, 0, SEEK_CUR ); -- set below */
 	aiocbp.aio_sigevent.sigev_notify = SIGEV_NONE;
 	aiocbp.aio_sigevent.sigev_signo = 0;
-#ifdef sgi
-	aiocbp.aio_sigevent.sigev_func = NULL;
-	aiocbp.aio_sigevent.sigev_value.sival_int = 0;
-#elif defined(__linux__) && !defined(__UCLIBC__)
 	aiocbp.aio_sigevent.sigev_notify_function = NULL;
 	aiocbp.aio_sigevent.sigev_notify_attributes = 0;
-#endif
+
 	aiolist[0] = &aiocbp;
 
 	if ((ret = lseek(fd, 0, SEEK_CUR)) == -1) {
@@ -646,13 +586,10 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 			return -errno;
 		}
 	}
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
+
 	poffset = (off64_t) ret;
-#endif
 	aiocbp.aio_offset = ret;
 
-#endif
-
 	/*
 	 * If the LIO_USE_SIGNAL bit is not set, only use the signal
 	 * if the LIO_WAIT_SIGPAUSE or the LIO_WAIT_SIGACTIVE bits are bit.
@@ -663,10 +600,8 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 
 		sig = 0;	/* ignore signal parameter */
 	}
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 	if (sig && (method & LIO_WAIT_CBTYPES))
 		sig = 0;	/* ignore signal parameter */
-#endif
 
 	/*
 	 * only setup signal hander if sig was specified and
@@ -677,26 +612,10 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 	 */
 
 	if (sig && (method & LIO_WAIT_SIGTYPES)) {
-#ifdef CRAY
-		sigctl(SCTL_REG, sig, lio_async_signal_handler);
-#endif
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 		aiocbp.aio_sigevent.sigev_notify = SIGEV_SIGNAL;
 		aiocbp.aio_sigevent.sigev_signo = sig;
 		sigset(sig, lio_async_signal_handler);
-#endif /* sgi */
-	}
-#if defined(sgi)
-	else if (method & LIO_WAIT_CBTYPES) {
-		/* sival_int just has to be something that I can use
-		 * to identify the callback, and "size" happens to be handy...
-		 */
-		aiocbp.aio_sigevent.sigev_notify = SIGEV_CALLBACK;
-		aiocbp.aio_sigevent.sigev_func = lio_async_callback_handler;
-		aiocbp.aio_sigevent.sigev_value.sival_int = size;
 	}
-#endif
-#if defined(__linux__) && !defined(__UCLIBC__)
 	else if (method & LIO_WAIT_CBTYPES) {
 		/* sival_int just has to be something that I can use
 		 * to identify the callback, and "size" happens to be handy...
@@ -707,7 +626,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 		aiocbp.aio_sigevent.sigev_notify_attributes =
 		    (void *)(uintptr_t) size;
 	}
-#endif
+
 	/*
 	 * Determine the system call that will be called and produce
 	 * the string of the system call and place it in Lio_SysCall.
@@ -765,27 +684,6 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 	}
 
 	else if (method & LIO_IO_ASYNC) {
-#ifdef CRAY
-		sprintf(Lio_SysCall,
-			"writea(%d, buf, %d, &status, %d)", fd, size, sig);
-		io_type = "writea";
-
-		if (Debug_level) {
-			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
-			       Lio_SysCall);
-		}
-
-		sigoff();
-		if ((ret = writea(fd, buffer, size, &status, sig)) == -1) {
-			sprintf(Errormsg,
-				"%s/%d writea(%d, buf, %d, &stat, %d) ret:-1, errno=%d %s",
-				__FILE__, __LINE__,
-				fd, size, sig, errno, strerror(errno));
-			sigon();
-			return -errno;
-		}
-#endif
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 		sprintf(Lio_SysCall,
 			"aio_write(fildes=%d, buf, nbytes=%d, signo=%d)", fd,
 			size, sig);
@@ -807,53 +705,9 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 				sigrelse(sig);
 			return -errno;
 		}
-#endif
 	}
 	/* LIO_IO_ASYNC */
 	else if (method & LIO_IO_SLISTIO) {
-#ifdef CRAY
-		request.li_opcode = LO_WRITE;
-		request.li_fildes = fd;
-		request.li_buf = buffer;
-		request.li_nbyte = size;
-		request.li_status = &status;
-		request.li_signo = sig;
-		request.li_nstride = 0;
-		request.li_filstride = 0;
-		request.li_memstride = 0;
-
-		listio_cmd = LC_WAIT;
-		io_type = "listio(2) sync write";
-
-		sprintf(Lio_SysCall,
-			"listio(LC_WAIT, &req, 1) LO_WRITE, fd:%d, nbyte:%d",
-			fd, size);
-
-		if (Debug_level) {
-			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
-			       Lio_SysCall);
-		}
-
-		sigoff();
-		if (listio(listio_cmd, &request, 1) == -1) {
-			sprintf(Errormsg,
-				"%s/%d %s failed, fd:%d, nbyte:%d errno=%d %s",
-				__FILE__, __LINE__, Lio_SysCall, fd, size,
-				errno, strerror(errno));
-			sigon();
-			return -errno;
-		}
-
-		if (Debug_level > 1)
-			printf("DEBUG %s/%d: %s did not return -1\n",
-			       __FILE__, __LINE__, Lio_SysCall);
-
-		ret = lio_check_asyncio(io_type, size, &status);
-		return ret;
-
-#endif
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
-
 		aiocbp.aio_lio_opcode = LIO_WRITE;
 		listio_cmd = LIO_WAIT;
 		io_type = "lio_listio(3) sync write";
@@ -885,44 +739,9 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 
 		ret = lio_check_asyncio(io_type, size, &aiocbp, method);
 		return ret;
-#endif
 	}
 	/* LIO_IO_SLISTIO */
 	else if (method & LIO_IO_ALISTIO) {
-#ifdef CRAY
-		request.li_opcode = LO_WRITE;
-		request.li_fildes = fd;
-		request.li_buf = buffer;
-		request.li_nbyte = size;
-		request.li_status = &status;
-		request.li_signo = sig;
-		request.li_nstride = 0;
-		request.li_filstride = 0;
-		request.li_memstride = 0;
-
-		listio_cmd = LC_START;
-		io_type = "listio(2) async write";
-
-		sprintf(Lio_SysCall,
-			"listio(LC_START, &req, 1) LO_WRITE, fd:%d, nbyte:%d",
-			fd, size);
-
-		if (Debug_level) {
-			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
-			       Lio_SysCall);
-		}
-
-		sigoff();
-		if (listio(listio_cmd, &request, 1) == -1) {
-			sprintf(Errormsg,
-				"%s/%d %s failed, fd:%d, nbyte:%d errno=%d %s",
-				__FILE__, __LINE__, Lio_SysCall, fd, size,
-				errno, strerror(errno));
-			sigon();
-			return -errno;
-		}
-#endif
-#if defined (sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 		aiocbp.aio_lio_opcode = LIO_WRITE;
 		listio_cmd = LIO_NOWAIT;
 		io_type = "lio_listio(3) async write";
@@ -947,41 +766,8 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 				sigrelse(sig);
 			return -errno;
 		}
-#endif
 	}
 	/* LIO_IO_ALISTIO */
-#ifndef CRAY
-	else if (method & LIO_IO_SYNCV) {
-		io_type = "writev(2)";
-
-		sprintf(Lio_SysCall, "writev(%d, &iov, 1) nbyte:%d", fd, size);
-
-		if (Debug_level) {
-			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
-			       Lio_SysCall);
-		}
-		if ((ret = writev(fd, &iov, 1)) == -1) {
-			sprintf(Errormsg,
-				"%s/%d writev(%d, iov, 1) nbyte:%d ret:-1, errno=%d %s",
-				__FILE__, __LINE__, fd, size, errno,
-				strerror(errno));
-			return -errno;
-		}
-
-		if (ret != size) {
-			sprintf(Errormsg,
-				"%s/%d writev(%d, iov, 1) nbyte:%d returned=%d",
-				__FILE__, __LINE__, fd, size, ret);
-		} else if (Debug_level > 1)
-			printf
-			    ("DEBUG %s/%d: writev completed without error (ret %d)\n",
-			     __FILE__, __LINE__, ret);
-
-		return ret;
-	}			/* LIO_IO_SYNCV */
-#endif
-
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 	else if (method & LIO_IO_SYNCP) {
 		io_type = "pwrite(2)";
 
@@ -1013,8 +799,6 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 
 		return ret;
 	}			/* LIO_IO_SYNCP */
-#endif
-
 	else {
 		printf("DEBUG %s/%d: No I/O method chosen\n", __FILE__,
 		       __LINE__);
@@ -1024,12 +808,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 	/*
 	 * wait for async io to complete.
 	 */
-#ifdef CRAY
-	ret = lio_wait4asyncio(method, fd, statptr);
-#endif
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 	ret = lio_wait4asyncio(method, fd, &aiocbp);
-#endif
 
 	/*
 	 * If there was an error waiting for async i/o to complete,
@@ -1055,12 +834,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 	 * have been updated but the actual i/o size if returned.
 	 */
 
-#ifdef CRAY
-	ret = lio_check_asyncio(io_type, size, &status);
-#endif
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 	ret = lio_check_asyncio(io_type, size, &aiocbp, method);
-#endif
 
 	return ret;
 }				/* end of lio_write_buffer */
@@ -1121,23 +895,10 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	char *io_type;		/* Holds string of type of io */
 	int listio_cmd;		/* Holds the listio/lio_listio cmd */
 	int omethod = method;
-#ifdef  CRAY
-	struct listreq request;	/* Used when a listio is wanted */
-	struct iosw status, *statptr[1];
-#else
-	/* for linux or sgi */
 	struct iovec iov;	/* iovec for readv(2) */
-#endif
-#ifdef sgi
-	aiocb_t aiocbp;		/* POSIX aio control block */
-	aiocb_t *aiolist[1];	/* list of aio control blocks for lio_listio */
-	off64_t poffset;	/* pread(2) offset */
-#endif
-#if defined (__linux__) && !defined(__UCLIBC__)
 	struct aiocb aiocbp;	/* POSIX aio control block */
 	struct aiocb *aiolist[1];	/* list of aio control blocks for lio_listio */
 	off64_t poffset;	/* pread(2) offset */
-#endif
 
 	/*
 	 * If LIO_RANDOM bit specified, get new method randomly.
@@ -1156,39 +917,24 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 		*errmsg = Errormsg;
 
 	Rec_signal = Received_signal;	/* get the current number of signals received */
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 	Rec_callback = Received_callback;	/* get the current number of callbacks received */
-#endif
 
-#ifdef  CRAY
-	memset(&status, 0x00, sizeof(struct iosw));
-	memset(&request, 0x00, sizeof(struct listreq));
-	statptr[0] = &status;
-#else
-	/* for linux or sgi */
 	memset(&iov, 0x00, sizeof(struct iovec));
 	iov.iov_base = buffer;
 	iov.iov_len = size;
-#endif
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
-#if defined(sgi)
-	memset(&aiocbp, 0x00, sizeof(aiocb_t));
-#else
+
 	memset(&aiocbp, 0x00, sizeof(struct aiocb));
-#endif
+
 	aiocbp.aio_fildes = fd;
 	aiocbp.aio_nbytes = size;
 	aiocbp.aio_buf = buffer;
 /*    aiocbp.aio_offset = lseek( fd, 0, SEEK_CUR ); -- set below */
 	aiocbp.aio_sigevent.sigev_notify = SIGEV_NONE;
 	aiocbp.aio_sigevent.sigev_signo = 0;
-#ifdef sgi
-	aiocbp.aio_sigevent.sigev_func = NULL;
-	aiocbp.aio_sigevent.sigev_value.sival_int = 0;
-#elif defined(__linux__) && !defined(__UCLIBC__)
+
 	aiocbp.aio_sigevent.sigev_notify_function = NULL;
 	aiocbp.aio_sigevent.sigev_notify_attributes = 0;
-#endif
+
 	aiolist[0] = &aiocbp;
 
 	if ((ret = lseek(fd, 0, SEEK_CUR)) == -1) {
@@ -1222,13 +968,9 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 			return -errno;
 		}
 	}
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 	poffset = (off64_t) ret;
-#endif
 	aiocbp.aio_offset = ret;
 
-#endif
-
 	/*
 	 * If the LIO_USE_SIGNAL bit is not set, only use the signal
 	 * if the LIO_WAIT_SIGPAUSE or the LIO_WAIT_SIGACTIVE bits are set.
@@ -1239,10 +981,9 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 
 		sig = 0;	/* ignore signal parameter */
 	}
-#if defined(sgi) || (defined(__linux__)&& !defined(__UCLIBC__))
+
 	if (sig && (method & LIO_WAIT_CBTYPES))
 		sig = 0;	/* ignore signal parameter */
-#endif
 
 	/*
 	 * only setup signal hander if sig was specified and
@@ -1253,27 +994,10 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	 */
 
 	if (sig && (method & LIO_WAIT_SIGTYPES)) {
-#ifdef CRAY
-		sigctl(SCTL_REG, sig, lio_async_signal_handler);
-#endif
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 		aiocbp.aio_sigevent.sigev_notify = SIGEV_SIGNAL;
 		aiocbp.aio_sigevent.sigev_signo = sig;
 		sigset(sig, lio_async_signal_handler);
-#endif /* CRAY */
-	}
-#if defined(sgi)
-	else if (method & LIO_WAIT_CBTYPES) {
-		aiocbp.aio_sigevent.sigev_notify = SIGEV_CALLBACK;
-		aiocbp.aio_sigevent.sigev_func = lio_async_callback_handler;
-		/* sival_int just has to be something that I can use
-		 * to identify the callback, and "size" happens to be handy...
-		 */
-		aiocbp.aio_sigevent.sigev_value.sival_int = size;
-	}
-#endif
-#if defined(__linux__) && !defined(__UCLIBC__)
-	else if (method & LIO_WAIT_CBTYPES) {
+	} else if (method & LIO_WAIT_CBTYPES) {
 		aiocbp.aio_sigevent.sigev_notify = SIGEV_THREAD;
 		aiocbp.aio_sigevent.sigev_notify_function =
 		    lio_async_callback_handler;
@@ -1283,7 +1007,6 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 		aiocbp.aio_sigevent.sigev_notify_attributes =
 		    (void *)(uintptr_t) size;
 	}
-#endif
 
 	/*
 	 * Determine the system call that will be called and produce
@@ -1342,30 +1065,7 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 			wait4sync_io(fd, 1);
 		}
 
-	}
-
-	else if (method & LIO_IO_ASYNC) {
-#ifdef CRAY
-		sprintf(Lio_SysCall,
-			"reada(%d, buf, %d, &status, %d)", fd, size, sig);
-		io_type = "reada";
-
-		if (Debug_level) {
-			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
-			       Lio_SysCall);
-		}
-
-		sigoff();
-		if ((ret = reada(fd, buffer, size, &status, sig)) == -1) {
-			sprintf(Errormsg,
-				"%s/%d reada(%d, buf, %d, &stat, %d) ret:-1, errno=%d %s",
-				__FILE__, __LINE__,
-				fd, size, sig, errno, strerror(errno));
-			sigon();
-			return -errno;
-		}
-#endif
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
+	} else if (method & LIO_IO_ASYNC) {
 		sprintf(Lio_SysCall,
 			"aio_read(fildes=%d, buf, nbytes=%d, signo=%d)", fd,
 			size, sig);
@@ -1387,51 +1087,9 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 				sigrelse(sig);
 			return -errno;
 		}
-#endif
 	}
 	/* LIO_IO_ASYNC */
 	else if (method & LIO_IO_SLISTIO) {
-#ifdef CRAY
-		request.li_opcode = LO_READ;
-		request.li_fildes = fd;
-		request.li_buf = buffer;
-		request.li_nbyte = size;
-		request.li_status = &status;
-		request.li_signo = sig;
-		request.li_nstride = 0;
-		request.li_filstride = 0;
-		request.li_memstride = 0;
-
-		listio_cmd = LC_WAIT;
-		io_type = "listio(2) sync read";
-
-		sprintf(Lio_SysCall,
-			"listio(LC_WAIT, &req, 1) LO_READ, fd:%d, nbyte:%d",
-			fd, size);
-
-		if (Debug_level) {
-			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
-			       Lio_SysCall);
-		}
-
-		sigoff();
-		if (listio(listio_cmd, &request, 1) == -1) {
-			sprintf(Errormsg,
-				"%s/%d %s failed, fd:%d, nbyte:%d errno=%d %s",
-				__FILE__, __LINE__, Lio_SysCall, fd, size,
-				errno, strerror(errno));
-			sigon();
-			return -errno;
-		}
-
-		if (Debug_level > 1)
-			printf("DEBUG %s/%d: %s did not return -1\n",
-			       __FILE__, __LINE__, Lio_SysCall);
-
-		ret = lio_check_asyncio(io_type, size, &status);
-		return ret;
-#endif
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 		aiocbp.aio_lio_opcode = LIO_READ;
 		listio_cmd = LIO_WAIT;
 		io_type = "lio_listio(3) sync read";
@@ -1463,44 +1121,9 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 
 		ret = lio_check_asyncio(io_type, size, &aiocbp, method);
 		return ret;
-#endif
 	}
 	/* LIO_IO_SLISTIO */
 	else if (method & LIO_IO_ALISTIO) {
-#ifdef CRAY
-		request.li_opcode = LO_READ;
-		request.li_fildes = fd;
-		request.li_buf = buffer;
-		request.li_nbyte = size;
-		request.li_status = &status;
-		request.li_signo = sig;
-		request.li_nstride = 0;
-		request.li_filstride = 0;
-		request.li_memstride = 0;
-
-		listio_cmd = LC_START;
-		io_type = "listio(2) async read";
-
-		sprintf(Lio_SysCall,
-			"listio(LC_START, &req, 1) LO_READ, fd:%d, nbyte:%d",
-			fd, size);
-
-		if (Debug_level) {
-			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
-			       Lio_SysCall);
-		}
-
-		sigoff();
-		if (listio(listio_cmd, &request, 1) == -1) {
-			sprintf(Errormsg,
-				"%s/%d %s failed, fd:%d, nbyte:%d errno=%d %s",
-				__FILE__, __LINE__, Lio_SysCall, fd, size,
-				errno, strerror(errno));
-			sigon();
-			return -errno;
-		}
-#endif
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 		aiocbp.aio_lio_opcode = LIO_READ;
 		listio_cmd = LIO_NOWAIT;
 		io_type = "lio_listio(3) async read";
@@ -1525,41 +1148,8 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 				sigrelse(sig);
 			return -errno;
 		}
-#endif
 	}
 	/* LIO_IO_ALISTIO */
-#ifndef CRAY
-	else if (method & LIO_IO_SYNCV) {
-		io_type = "readv(2)";
-
-		sprintf(Lio_SysCall, "readv(%d, &iov, 1) nbyte:%d", fd, size);
-
-		if (Debug_level) {
-			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
-			       Lio_SysCall);
-		}
-		if ((ret = readv(fd, &iov, 1)) == -1) {
-			sprintf(Errormsg,
-				"%s/%d readv(%d, iov, 1) nbyte:%d ret:-1, errno=%d %s",
-				__FILE__, __LINE__, fd, size, errno,
-				strerror(errno));
-			return -errno;
-		}
-
-		if (ret != size) {
-			sprintf(Errormsg,
-				"%s/%d readv(%d, iov, 1) nbyte:%d returned=%d",
-				__FILE__, __LINE__, fd, size, ret);
-		} else if (Debug_level > 1)
-			printf
-			    ("DEBUG %s/%d: readv completed without error (ret %d)\n",
-			     __FILE__, __LINE__, ret);
-
-		return ret;
-	}			/* LIO_IO_SYNCV */
-#endif
-
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 	else if (method & LIO_IO_SYNCP) {
 		io_type = "pread(2)";
 
@@ -1591,7 +1181,6 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 
 		return ret;
 	}			/* LIO_IO_SYNCP */
-#endif
 
 	else {
 		printf("DEBUG %s/%d: No I/O method chosen\n", __FILE__,
@@ -1603,12 +1192,7 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	 * wait for async io to complete.
 	 * Note: Sync io should have returned prior to getting here.
 	 */
-#ifdef CRAY
-	ret = lio_wait4asyncio(method, fd, statptr);
-#endif
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 	ret = lio_wait4asyncio(method, fd, &aiocbp);
-#endif
 
 	/*
 	 * If there was an error waiting for async i/o to complete,
@@ -1634,12 +1218,7 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	 * have been updated but the actual i/o size if returned.
 	 */
 
-#ifdef CRAY
-	ret = lio_check_asyncio(io_type, size, &status);
-#endif
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 	ret = lio_check_asyncio(io_type, size, &aiocbp, method);
-#endif
 
 	return ret;
 }				/* end of lio_read_buffer */
@@ -1656,37 +1235,9 @@ int lio_read_buffer(int fd,	/* open file descriptor */
  *
  * (rrl 04/96)
  ***********************************************************************/
-#ifdef CRAY
-int lio_check_asyncio(char *io_type, int size, struct iosw *status)
-#elif defined(sgi)
-int lio_check_asyncio(char *io_type, int size, aiocb_t * aiocbp, int method)
-#elif defined(__linux__) && !defined(__UCLIBC__)
 int lio_check_asyncio(char *io_type, int size, struct aiocb *aiocbp, int method)
 {
 	int ret;
-
-#ifdef CRAY
-	if (status->sw_error) {
-		sprintf(Errormsg,
-			"%s/%d %s, sw_error set = %d %s, sw_count = %d",
-			__FILE__, __LINE__, io_type,
-			status->sw_error, strerror(status->sw_error),
-			status->sw_count);
-		return -status->sw_error;
-	} else if (status->sw_count != size) {
-		sprintf(Errormsg,
-			"%s/%d %s, sw_count not as expected(%d), but actual:%d",
-			__FILE__, __LINE__, io_type, size, status->sw_count);
-	} else if (Debug_level > 1) {
-		printf
-		    ("DEBUG %s/%d: %s completed without error (sw_error == 0, sw_count == %d)\n",
-		     __FILE__, __LINE__, io_type, status->sw_count);
-	}
-
-	return status->sw_count;
-
-#else
-
 	int cnt = 1;
 
 	/* The I/O may have been synchronous with signal completion.  It doesn't
@@ -1710,10 +1261,6 @@ int lio_check_asyncio(char *io_type, int size, struct aiocb *aiocbp, int method)
 			(aiocbp->aio_sigevent.sigev_notify ==
 			 SIGEV_SIGNAL ? "signal" : aiocbp->aio_sigevent.
 			 sigev_notify == SIGEV_NONE ? "none" :
-#ifdef SIGEV_CALLBACK
-			 aiocbp->aio_sigevent.sigev_notify ==
-			 SIGEV_CALLBACK ? "callback" :
-#endif
 			 aiocbp->aio_sigevent.sigev_notify ==
 			 SIGEV_THREAD ? "thread" : "unknown"));
 		return -ret;
@@ -1731,18 +1278,6 @@ int lio_check_asyncio(char *io_type, int size, struct aiocb *aiocbp, int method)
 		sprintf(Errormsg,
 			"%s/%d %s, aio_return not as expected(%d), but actual:%d",
 			__FILE__, __LINE__, io_type, size, ret);
-
-#ifdef BUG1_workaround
-		if (ret == 0) {
-			ret = size;
-			if (Debug_level > 1) {
-				printf
-				    ("WARN %s/%d: %s completed with bug1_workaround (aio_error == 0, aio_return now == %d)\n",
-				     __FILE__, __LINE__, io_type, ret);
-			}
-		}
-#endif /* BUG1_workaround */
-
 	} else if (Debug_level > 1) {
 		printf
 		    ("DEBUG %s/%d: %s completed without error (aio_error == 0, aio_return == %d)\n",
@@ -1751,9 +1286,7 @@ int lio_check_asyncio(char *io_type, int size, struct aiocb *aiocbp, int method)
 
 	return ret;
 
-#endif
 }				/* end of lio_check_asyncio */
-#endif
 
 /***********************************************************************
  *
@@ -1773,45 +1306,20 @@ int lio_check_asyncio(char *io_type, int size, struct aiocb *aiocbp, int method)
  *
  * (rrl 04/96)
  ***********************************************************************/
-#ifdef CRAY
-int lio_wait4asyncio(int method, int fd, struct iosw **statptr)
-#elif defined(sgi)
-int lio_wait4asyncio(int method, int fd, aiocb_t * aiocbp)
-#elif defined(__linux__) && !defined(__UCLIBC__)
 int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
 {
 	int cnt;
-#ifdef sgi
-	int ret;
-	const aiocb_t *aioary[1];
-#endif
-#if defined(__linux__)&& !defined(__UCLIBC__)
 	int ret;
 	const struct aiocb *aioary[1];
-#endif
 
 	if ((method & LIO_WAIT_RECALL)
-#if defined(sgi) || (defined(__linux__)&& !defined(__UCLIBC__))
 	    || (method & LIO_WAIT_CBSUSPEND)
 	    || (method & LIO_WAIT_SIGSUSPEND)
-#endif
 	    || ((method & LIO_WAIT_TYPES) == 0)) {
 		/*
 		 * If method has LIO_WAIT_RECALL bit set or method does
 		 * not have any wait method bits set (default), use recall/aio_suspend.
 		 */
-#ifdef CRAY
-		if (Debug_level > 2)
-			printf("DEBUG %s/%d: wait method : recall\n", __FILE__,
-			       __LINE__);
-		sigon();
-		if (recall(fd, 1, statptr)) {
-			sprintf(Errormsg,
-				"%s/%d recall(%d, 1, stat) failed, errno:%d %s",
-				__FILE__, __LINE__, fd, errno, strerror(errno));
-			return -errno;
-		}
-#else
 		if (Debug_level > 2)
 			printf
 			    ("DEBUG %s/%d: wait method : aio_suspend, sigev_notify=%s\n",
@@ -1819,10 +1327,6 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
 			     (aiocbp->aio_sigevent.sigev_notify ==
 			      SIGEV_SIGNAL ? "signal" : aiocbp->aio_sigevent.
 			      sigev_notify == SIGEV_NONE ? "none" :
-#ifdef SIGEV_CALLBACK
-			      aiocbp->aio_sigevent.sigev_notify ==
-			      SIGEV_CALLBACK ? "callback" :
-#endif
 			      aiocbp->aio_sigevent.sigev_notify ==
 			      SIGEV_THREAD ? "thread" : "unknown"));
 
@@ -1843,10 +1347,6 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
 					 SIGEV_SIGNAL ? "signal" : aiocbp->
 					 aio_sigevent.sigev_notify ==
 					 SIGEV_NONE ? "none" :
-#ifdef SIGEV_CALLBACK
-					 aiocbp->aio_sigevent.sigev_notify ==
-					 SIGEV_CALLBACK ? "callback" :
-#endif
 					 aiocbp->aio_sigevent.sigev_notify ==
 					 SIGEV_THREAD ? "thread" : "unknown"));
 				return -errno;
@@ -1857,24 +1357,10 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
 				__FILE__, __LINE__, fd, errno, strerror(errno));
 			return -errno;
 		}
-#endif
-
 	} else if (method & LIO_WAIT_ACTIVE) {
 		if (Debug_level > 2)
 			printf("DEBUG %s/%d: wait method : active\n", __FILE__,
 			       __LINE__);
-#ifdef CRAY
-		sigon();
-		/*
-		 * loop until sw_flag, sw_count or sw_error field elements
-		 * change to non-zero.
-		 */
-		cnt = 0;
-		while ((*statptr)->sw_flag == 0 &&
-		       (*statptr)->sw_count == 0 && (*statptr)->sw_error == 0) {
-			cnt++;
-		}
-#else
 		/* loop while aio_error() returns EINPROGRESS */
 		cnt = 0;
 		while (1) {
@@ -1885,7 +1371,6 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
 			++cnt;
 		}
 
-#endif
 		if (Debug_level > 5 && cnt && (cnt % 50) == 0)
 			printf("DEBUG %s/%d: wait active cnt = %d\n",
 			       __FILE__, __LINE__, cnt);
@@ -1894,25 +1379,12 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
 		if (Debug_level > 2)
 			printf("DEBUG %s/%d: wait method : sigpause\n",
 			       __FILE__, __LINE__);
-#ifdef sgi
-		/* note: don't do the sigon() for CRAY in this case.  why? -- roehrich 6/11/97 */
-		if (aiocbp->aio_sigevent.sigev_notify == SIGEV_SIGNAL)
-			sigrelse(aiocbp->aio_sigevent.sigev_signo);
-		else {
-			printf("DEBUG %s/%d: sigev_notify != SIGEV_SIGNAL\n",
-			       __FILE__, __LINE__);
-			return -1;
-		}
-#endif
 		pause();
 
 	} else if (method & LIO_WAIT_SIGACTIVE) {
 		if (Debug_level > 2)
 			printf("DEBUG %s/%d: wait method : sigactive\n",
 			       __FILE__, __LINE__);
-#ifdef CRAY
-		sigon();
-#else
 		if (aiocbp->aio_sigevent.sigev_notify == SIGEV_SIGNAL)
 			sigrelse(aiocbp->aio_sigevent.sigev_signo);
 		else {
@@ -1920,14 +1392,9 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
 			       __FILE__, __LINE__);
 			return -1;
 		}
-#endif
 		/* loop waiting for signal */
 		while (Received_signal == Rec_signal) {
-#ifdef CRAY
-			sigon();
-#else
 			sigrelse(aiocbp->aio_sigevent.sigev_signo);
-#endif
 		}
 
 	} else if (method & LIO_WAIT_NONE) {
@@ -1944,10 +1411,6 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
 		sprintf(Errormsg,
 			"%s/%d LIO_WAIT_NONE was selected (this is broken)\n",
 			__FILE__, __LINE__);
-#ifdef CRAY
-		sigon();
-#endif
-/*        return 1;*/
 		return -1;
 	} else {
 		if (Debug_level > 2)
@@ -1960,7 +1423,6 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
 
 }				/* end of lio_wait4asyncio */
 
-#endif /* ifndef linux */
 #endif
 
 #if UNIT_TEST
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
