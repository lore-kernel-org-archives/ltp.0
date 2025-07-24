Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34277C83F26
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 19:10:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B1F23CCDF9
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 21:10:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D90113C91B5
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 21:09:54 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 805642009C1
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 21:09:54 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ae3be3eabd8so307530866b.1
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 12:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753384194; x=1753988994; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1S45zhIgSYaLAtMWTDcWgW0WkkRxD6U1jxnuGWxCbI=;
 b=TPOV+yVhAaZAhGBDXD8NQX1+SiL4rS6BySp0nOfK6Wu8p0nRskiaVAZwDMhI0bwnQM
 mNofAoCt3WzaeTRJUIhzTh/V0imL20AUvVcBaT7YI58gFh5DV6JiF/EP7A3d/IXoBrbc
 a0tmwwGpBKRyiP7nOvVku3g5qzCmInO2yBtVPcivEHEm9pFfn4EuBX4VXTqlsiUwPnoS
 sm4tkpol7fF0IxKDuHxUXGBegO9pmzLNoSUVrFj1YwHiCABwRdnG7jPG8ljglijd8cBo
 tCyw0T2lhbmlvwb+VDmk2dWI4KmH4REaGP19Dl0kGVzgsQFVWflAeWbfwyODx+at906M
 7m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753384194; x=1753988994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1S45zhIgSYaLAtMWTDcWgW0WkkRxD6U1jxnuGWxCbI=;
 b=afKpzNmAPw+pC9+6VeB6xXlB0GHICmbNIKcNm7NcrOcoWKvw0VQBO6Gu+97wEtk0+q
 lCoDvjCTvl+3xnirdY6NyDrDSGdAHfKMRgZ3/u9GCAxCn1Me2YFOYIEgm/io7Hj6KYvO
 WKBu78a6lpmGlz+A1usn0TggnmqIL7VR9w15o9JQfl2mcKWECh8QSAfhzMk6oWcgBYpI
 h/92TVqMURDc6LFJlKhtOkN/VLVj5xnRqCjJ4cvd00nu8YunSl8hCYBjBybevZjb1fSo
 9dCJkM++De9RLf/0Ux1LZZlzVzQYNgvjqZ3Za8FLmp6mni0oQzE3i0EKyiJ7PN+PotB4
 B+sg==
X-Gm-Message-State: AOJu0YzVDjeu5fRYEkoiziIB/GhAgL1XEn+7F7t8KqIreJGLKfRE17oG
 g6Ih44i0TliIPHChg9n9O/+t3rMIOoX2sG2ctv2aD227ZS3JnZ71jHyYwm1f2A==
X-Gm-Gg: ASbGncs4hWxrlH90Ojf+uDP8r3cEprelVm/izDFz/HNS97DlABRpZVUwXLeSmUJFe7z
 VLVFdNfpprtqmvpbGc1epQb5s8eiTdmN2oo8p/uFt1EmNzR1rzWy8m0kZ9nxuTrmyBslGVWZOEG
 LeRhb7QKhiqH3TTWIuaqlHlQhuHPS3mw93igpkmYwOQEk9dOy4igDQeVick6UsgxGrbVuTJpy6o
 0vLllnD8IgwpJj42HqXs9CqOjzqEK3zVWxIbCqfsDVquDz1bEQtCjO2vfuhGAce43lb9yTW4Ck0
 /fy57KzF0qbRBUOd5BFSyG5hTFfVuRi6DMZH1jTerA6ZiBrclFDdpk2A0pMsLiL6r99g/h1hE2/
 EgiE/pyxEoaOOg2z+C/VDrmhunw==
X-Google-Smtp-Source: AGHT+IEE/NbVoXiId8YL9BR/l4hTiahEhhPe8/OrxbCMPFdCZDQxeURgFbVdVyIkPD9HEe1aY1sWwA==
X-Received: by 2002:a17:907:bb49:b0:ad8:e448:6c64 with SMTP id
 a640c23a62f3a-af4c43209ecmr365536966b.24.1753384193716; 
 Thu, 24 Jul 2025 12:09:53 -0700 (PDT)
Received: from x230 (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47cc6cb75sm150481466b.41.2025.07.24.12.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 12:09:53 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 24 Jul 2025 21:09:46 +0200
Message-ID: <20250724190946.338828-2-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724190946.338828-1-petr.vorel@gmail.com>
References: <20250724190946.338828-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tlibio: Further cleanup of old unixes
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

From: Petr Vorel <pvorel@suse.cz>

I also wonder if #else part of struct lio_info_type Lio_info1[]
should be really defined for uclibc/uclibc-ng.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Hi,

I can squash this one into previous commit if you don't think it's worth
to keep it separate.

 lib/tlibio.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/tlibio.c b/lib/tlibio.c
index fe87c65ea4..bc1172f0c6 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -111,7 +111,7 @@ struct lio_info_type Lio_info1[] = {
 	{"b", LIO_IO_ASYNC | LIO_WAIT_SIGPAUSE, "async i/o using pause"},
 	{"a", LIO_IO_ASYNC | LIO_WAIT_RECALL,
 	 "async i/o using recall/aio_suspend"},
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
+#ifndef __UCLIBC__
 	{"r",
 	 LIO_RANDOM | LIO_IO_TYPES | LIO_WAIT_TYPES,
 	 "random sync i/o types and wait methods"},
@@ -162,7 +162,7 @@ char Lio_SysCall[PATH_MAX];	/* string containing last i/o system call */
 
 static volatile int Received_signal = 0;	/* number of signals received */
 static volatile int Rec_signal;
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
+#ifndef __UCLIBC__
 static volatile int Received_callback = 0;	/* number of callbacks received */
 static volatile int Rec_callback;
 #endif
@@ -402,7 +402,7 @@ static void lio_async_signal_handler(int sig)
 	return;
 }
 
-#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
+#ifndef __UCLIBC__
 /***********************************************************************
  * This is an internal callback handler.
  * If the handler is called, it will increment the Received_callback
@@ -420,7 +420,7 @@ static void lio_async_callback_handler(union sigval sigval)
 
 	return;
 }
-#endif /* sgi */
+#endif
 
 /***********************************************************************
  * lio_random_methods
@@ -1312,7 +1312,6 @@ int lio_read_buffer(int fd,	/* open file descriptor */
 	return ret;
 }				/* end of lio_read_buffer */
 
-#if !defined(__sun) && !defined(__hpux) && !defined(_AIX)
 #ifndef __UCLIBC__
 /***********************************************************************
  * This function will check that async io was successful.
@@ -1513,7 +1512,6 @@ int lio_wait4asyncio(int method, int fd, struct aiocb *aiocbp)
 
 }				/* end of lio_wait4asyncio */
 
-#endif
 #endif
 
 #if UNIT_TEST
-- 
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
