Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EADC83F26
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 19:10:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BDB43CCE5F
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 21:10:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E6793C91B5
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 21:09:54 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B157F200914
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 21:09:53 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ae0d7b32322so220371166b.2
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 12:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753384193; x=1753988993; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9LqfXKAvVEtud9EERMEbY0MkdiiIPOYbag0U6oWeTfg=;
 b=OKkpuuMg5kx5DIByMOGi61u033ZxbAjOTJ+A7MQU8x90MYaJgkABtWd06yKAK0DPVP
 i4idszNOJ+G0+ZbIFbgaVhyMNCNw8k9Bw2T8HuoQPxegUj/48aKXh2dG5jZgqKnHPXur
 QJt3u7XhzZvWyeLfschRlXK47bjNm0m2d6BjG6o3I7Y0+9xEgGhmcdFLYof/ehSYVRxL
 Y89LjU2TD82RtYY/kLSL3jeoBzL4bUbGQ0qWSB7G6NmjSF7Wzs53DMiZxHXD6o33VHfz
 yLJlCo7Gt8cRC7/1PX6TXn4RtP7tkJq78Ltk8xAuAOEJnQrIPEgeRYtFCVQGlYiayfl9
 JGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753384193; x=1753988993;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9LqfXKAvVEtud9EERMEbY0MkdiiIPOYbag0U6oWeTfg=;
 b=tpbcEOZFo0BIG77b2Z4qXX33hkBM/toTDtXrXbgSfYEFG4fl2Eo74dIoSjMl0aEywL
 FhNI5nIVTm0now2WOjv3EQJrjRZy4WT4ubmePdryBinu64UmzYtP+4Y6vV3C3Gcfnrle
 HU8XZEx7Q0C1tPFt6oqIFK64AQqHu8LHz5PX4A3adkqhvGSwj/LVVFpCUfb5rPaWX0rU
 U3LLHdenbKfa+nccYqLfi4hWh/L4O4oXAElR4kq0yK6NWMi/Q72qmLX4dL108QY6170R
 a5Zn9dR/IWnI5ujDUnD3RLUrm7lsYoBWz8FuTA8cbAAPREa+t9QhEkLIlIf8yC+d4Kin
 ay5A==
X-Gm-Message-State: AOJu0Yxek0GllMfcJKMn4kTZPfxjFO1Eljche5sGbGh/BAI/d9LPCYh1
 01DT+HeFWRKgxj39cokIz/ykP212xIcP92d9VchAsianzHPQkZkOJMvCgUaSPQ==
X-Gm-Gg: ASbGncux4mu85J99epE6hm64JYKmv4mvnqnLId/xFY049KQ9dWEXaYmTJubtjhnabLM
 L+nWU6Y6fRriZMzoPPY/CopzWKHc/VBnMcMgeZhgWQl8nS7U2W6p44vIr7ij2edA+zS5QXMXIzP
 jZ/td1NKZFiBBWV0uEE1KGITyVANfvoIJuyxMyyKzg4CXGI+q7cdT7xOMTf9HM4hs1CNVO/lUXG
 3uzMuTec5PPr/7X8MYsp0+OCogJ3gtMaK7gQRVOHO58qk4Knoves4zMLpNvXR0iNvCP0iZD1T+A
 PqISliRjjjhBhh7aqeQ5EPBIfSbkaxiDKjoaT+nE3D7I+4PZi/H9fQ9EeuKaxZbVvMnQg458lSa
 n1Sr2/FtAYFzsQSJPbNyC/EIvnuXiHTL+s00s
X-Google-Smtp-Source: AGHT+IHuiLZp5i/IGfsIMoXSiQfheK1gJmcwxG8+IEPp0ncHNjd4hmygpHxwtL5zoMqBONGB3M+oGg==
X-Received: by 2002:a17:907:3c95:b0:ae0:d798:2ebd with SMTP id
 a640c23a62f3a-af2f8958823mr849803466b.35.1753384192692; 
 Thu, 24 Jul 2025 12:09:52 -0700 (PDT)
Received: from x230 (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47cc6cb75sm150481466b.41.2025.07.24.12.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 12:09:52 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 24 Jul 2025 21:09:45 +0200
Message-ID: <20250724190946.338828-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tlibio: Restore uclibc-ng support
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

uclibc-ng does not implement <aio.h>. Requiring it for the core LTP
library breaks the build. Restore unintentional removal in fed3e3ee63.

Simplify original macros:
* Comment out also if block first and last 'line if (...) {' and '}' if
  the block would be empty anyway.
* Simplify check - use just __UCLIBC__ - no need for defined(__linux__)
* Further join #ifndef __UCLIBC__ as code prior fed3e3ee63 contained
  code compiled for old unixes, which fed3e3ee63 removed.
* lio_wait4asyncio() was commented out for uclibc, there is no point to
  add further !uclibc checks in it's content
* Detecting __UCLIBC__ requires to include <features.h>

NOTE: original #endif comments in the commit prior fed3e3ee63 was
sometimes wrong.

Fixes: fed3e3ee63 ("lib/tlibio: Get rid of support for old UNIXes")
Fixes: https://autobuild.buildroot.org/results/f3e/f3e03b9a1a69988d6497f36c9d64a37a66e9ad20/
Fixes: https://autobuild.buildroot.org/results/856/856365f467efc449faee1951250e63d8d4442bbc/
Fixes: https://autobuild.buildroot.org/results/2ac/2ac08cecd6a505f1bac1a673efc280b3a8dcb23a/
Fixes: https://autobuild.buildroot.org/results/59b/59b3ad33667b7e87c81e49dd434d5f494e189e0d/
Fixes: https://autobuild.buildroot.org/results/b1a/b1a36f9971c97300670d8d772ace11e5fedceaaa/
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 lib/tlibio.c | 53 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/lib/tlibio.c b/lib/tlibio.c
index b877393df2..fe87c65ea4 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -73,6 +73,7 @@
 #define _LARGEFILE64_SOURCE
 
 #include "config.h"
+#include <features.h>
 #include <stdio.h>
 #include <ctype.h>
 #include <fcntl.h>
@@ -88,7 +89,9 @@
 #include <stdint.h>
 #include <sys/uio.h>		/* readv(2)/writev(2) */
 #include <string.h>
-#include <aio.h>
+#ifndef __UCLIBC__
+# include <aio.h>
+#endif
 #include <stdlib.h>		/* atoi, abs */
 
 #include "tlibio.h"		/* defines LIO* macros */
@@ -515,9 +518,11 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 	int omethod = method;
 	int listio_cmd;		/* Holds the listio/lio_listio cmd */
 	struct iovec iov;	/* iovec for writev(2) */
+#ifndef __UCLIBC__
 	struct aiocb aiocbp;	/* POSIX aio control block */
 	struct aiocb *aiolist[1];	/* list of aio control blocks for lio_listio */
 	off64_t poffset;	/* pwrite(2) offset */
+#endif
 
 	/*
 	 * If LIO_RANDOM bit specified, get new method randomly.
@@ -536,12 +541,15 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 		*errmsg = Errormsg;
 
 	Rec_signal = Received_signal;	/* get the current number of signals received */
+#ifndef __UCLIBC__
 	Rec_callback = Received_callback;	/* get the current number of callbacks received */
+#endif
 
 	memset(&iov, 0x00, sizeof(struct iovec));
 	iov.iov_base = buffer;
 	iov.iov_len = size;
 
+#ifndef __UCLIBC__
 	memset(&aiocbp, 0x00, sizeof(struct aiocb));
 
 	aiocbp.aio_fildes = fd;
@@ -589,6 +597,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 
 	poffset = (off64_t) ret;
 	aiocbp.aio_offset = ret;
+#endif
 
 	/*
 	 * If the LIO_USE_SIGNAL bit is not set, only use the signal
@@ -600,6 +609,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 
 		sig = 0;	/* ignore signal parameter */
 	}
+#ifndef __UCLIBC__
 	if (sig && (method & LIO_WAIT_CBTYPES))
 		sig = 0;	/* ignore signal parameter */
 
@@ -626,6 +636,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 		aiocbp.aio_sigevent.sigev_notify_attributes =
 		    (void *)(uintptr_t) size;
 	}
+#endif
 
 	/*
 	 * Determine the system call that will be called and produce
@@ -684,6 +695,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 	}
 
 	else if (method & LIO_IO_ASYNC) {
+#ifndef __UCLIBC__
 		sprintf(Lio_SysCall,
 			"aio_write(fildes=%d, buf, nbytes=%d, signo=%d)", fd,
 			size, sig);
@@ -705,9 +717,11 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 				sigrelse(sig);
 			return -errno;
 		}
+#endif
 	}
 	/* LIO_IO_ASYNC */
 	else if (method & LIO_IO_SLISTIO) {
+#ifndef __UCLIBC__
 		aiocbp.aio_lio_opcode = LIO_WRITE;
 		listio_cmd = LIO_WAIT;
 		io_type = "lio_listio(3) sync write";
@@ -739,9 +753,11 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 
 		ret = lio_check_asyncio(io_type, size, &aiocbp, method);
 		return ret;
+#endif
 	}
 	/* LIO_IO_SLISTIO */
 	else if (method & LIO_IO_ALISTIO) {
+#ifndef __UCLIBC__
 		aiocbp.aio_lio_opcode = LIO_WRITE;
 		listio_cmd = LIO_NOWAIT;
 		io_type = "lio_listio(3) async write";
@@ -766,6 +782,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 				sigrelse(sig);
 			return -errno;
 		}
+#endif
 	}
 	/* LIO_IO_ALISTIO */
 	else if (method & LIO_IO_SYNCV) {
@@ -796,6 +813,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 
 		return ret;
 	}			/* LIO_IO_SYNCV */
+#ifndef __UCLIBC__
 	else if (method & LIO_IO_SYNCP) {
 		io_type = "pwrite(2)";
 
@@ -827,6 +845,7 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 
 		return ret;
 	}			/* LIO_IO_SYNCP */
+#endif
 	else {
 		printf("DEBUG %s/%d: No I/O method chosen\n", __FILE__,
 		       __LINE__);
@@ -836,7 +855,9 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 	/*
 	 * wait for async io to complete.
 	 */
+#ifndef __UCLIBC__
 	ret = lio_wait4asyncio(method, fd, &aiocbp);
+#endif
 
 	/*
 	 * If there was an error waiting for async i/o to complete,
@@ -862,7 +883,9 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 	 * have been updated but the actual i/o size if returned.
 	 */
 
+#ifndef __UCLIBC__
 	ret = lio_check_asyncio(io_type, size, &aiocbp, method);
+#endif
 
 	return ret;
 }				/* end of lio_write_buffer */
@@ -924,9 +947,11 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	int listio_cmd;		/* Holds the listio/lio_listio cmd */
 	int omethod = method;
 	struct iovec iov;	/* iovec for readv(2) */
+#ifndef __UCLIBC__
 	struct aiocb aiocbp;	/* POSIX aio control block */
 	struct aiocb *aiolist[1];	/* list of aio control blocks for lio_listio */
 	off64_t poffset;	/* pread(2) offset */
+#endif
 
 	/*
 	 * If LIO_RANDOM bit specified, get new method randomly.
@@ -945,12 +970,15 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 		*errmsg = Errormsg;
 
 	Rec_signal = Received_signal;	/* get the current number of signals received */
+#ifndef __UCLIBC__
 	Rec_callback = Received_callback;	/* get the current number of callbacks received */
+#endif
 
 	memset(&iov, 0x00, sizeof(struct iovec));
 	iov.iov_base = buffer;
 	iov.iov_len = size;
 
+#ifndef __UCLIBC__
 	memset(&aiocbp, 0x00, sizeof(struct aiocb));
 
 	aiocbp.aio_fildes = fd;
@@ -962,7 +990,6 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 
 	aiocbp.aio_sigevent.sigev_notify_function = NULL;
 	aiocbp.aio_sigevent.sigev_notify_attributes = 0;
-
 	aiolist[0] = &aiocbp;
 
 	if ((ret = lseek(fd, 0, SEEK_CUR)) == -1) {
@@ -998,6 +1025,7 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	}
 	poffset = (off64_t) ret;
 	aiocbp.aio_offset = ret;
+#endif
 
 	/*
 	 * If the LIO_USE_SIGNAL bit is not set, only use the signal
@@ -1010,6 +1038,7 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 		sig = 0;	/* ignore signal parameter */
 	}
 
+#ifndef __UCLIBC__
 	if (sig && (method & LIO_WAIT_CBTYPES))
 		sig = 0;	/* ignore signal parameter */
 
@@ -1020,7 +1049,6 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	 * old signal handler will not be restored.
 	 *** restoring the signal handler could be added ***
 	 */
-
 	if (sig && (method & LIO_WAIT_SIGTYPES)) {
 		aiocbp.aio_sigevent.sigev_notify = SIGEV_SIGNAL;
 		aiocbp.aio_sigevent.sigev_signo = sig;
@@ -1035,6 +1063,7 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 		aiocbp.aio_sigevent.sigev_notify_attributes =
 		    (void *)(uintptr_t) size;
 	}
+#endif
 
 	/*
 	 * Determine the system call that will be called and produce
@@ -1093,7 +1122,9 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 			wait4sync_io(fd, 1);
 		}
 
-	} else if (method & LIO_IO_ASYNC) {
+	}
+#ifndef __UCLIBC__
+	else if (method & LIO_IO_ASYNC) {
 		sprintf(Lio_SysCall,
 			"aio_read(fildes=%d, buf, nbytes=%d, signo=%d)", fd,
 			size, sig);
@@ -1116,9 +1147,7 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 			return -errno;
 		}
 	}
-	/* LIO_IO_ASYNC */
 	else if (method & LIO_IO_SLISTIO) {
-		aiocbp.aio_lio_opcode = LIO_READ;
 		listio_cmd = LIO_WAIT;
 		io_type = "lio_listio(3) sync read";
 
@@ -1150,7 +1179,6 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 		ret = lio_check_asyncio(io_type, size, &aiocbp, method);
 		return ret;
 	}
-	/* LIO_IO_SLISTIO */
 	else if (method & LIO_IO_ALISTIO) {
 		aiocbp.aio_lio_opcode = LIO_READ;
 		listio_cmd = LIO_NOWAIT;
@@ -1177,7 +1205,6 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 			return -errno;
 		}
 	}
-	/* LIO_IO_ALISTIO */
 	else if (method & LIO_IO_SYNCV) {
 		io_type = "readv(2)";
 
@@ -1236,7 +1263,9 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 			     __FILE__, __LINE__, ret);
 
 		return ret;
-	}			/* LIO_IO_SYNCP */
+	}
+
+#endif
 
 	else {
 		printf("DEBUG %s/%d: No I/O method chosen\n", __FILE__,
@@ -1248,7 +1277,9 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	 * wait for async io to complete.
 	 * Note: Sync io should have returned prior to getting here.
 	 */
+#ifndef __UCLIBC__
 	ret = lio_wait4asyncio(method, fd, &aiocbp);
+#endif
 
 	/*
 	 * If there was an error waiting for async i/o to complete,
@@ -1274,12 +1305,15 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	 * have been updated but the actual i/o size if returned.
 	 */
 
+#ifndef __UCLIBC__
 	ret = lio_check_asyncio(io_type, size, &aiocbp, method);
+#endif
 
 	return ret;
 }				/* end of lio_read_buffer */
 
 #if !defined(__sun) && !defined(__hpux) && !defined(_AIX)
+#ifndef __UCLIBC__
 /***********************************************************************
  * This function will check that async io was successful.
  * It can also be used to check sync listio since it uses the
@@ -1479,6 +1513,7 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
 
 }				/* end of lio_wait4asyncio */
 
+#endif
 #endif
 
 #if UNIT_TEST
-- 
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
