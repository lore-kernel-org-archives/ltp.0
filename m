Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE4FEDA68E
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772552817; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=s4Cd9H2McK4EQBI8mRNUQiIn96nxLednuoJjSsJDfZM=;
 b=Ldsig9Q4ICDixaTVg5Em5PD4Agc+sSeSx63YpzDqHfF3B2rtMxTdZ/Jtco/WFucf7iMY4
 AMy0IcQIHM/gsQb0x4mGaKbKhV/rw//PyqFBV0OPLchvC++PBlLUAGUoRnHMqFLlZFJl0EF
 kjgiPn0A80R8LlSu+J5pwqy0ha0w9as=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D8593DAE58
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 16:46:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FA6F3DAC03
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 16:46:26 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9D25B2009A5
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 16:46:25 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4837584120eso42628005e9.1
 for <ltp@lists.linux.it>; Tue, 03 Mar 2026 07:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772552785; x=1773157585; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JlNMjAz/v9hE9+E6wP8WUf+noUs9P2BtkOSC9k34nEk=;
 b=C5qWssWSq9TqEO6BHLnJoHl7fBVxoEqAOO0Qyc1b4QReJb8nnxZG0GPGNr+0Nl/od8
 nU/bdmX5/7yKYt32m2MG84cFCs7tMbZWcMdewjRccKYN9M4wqxB+B+Yer/EooZn0GmQB
 PMewzZYlfS4xiq60MlebZXDSt1dAmQwTrU3d/3wxIIippuCeJsRqayvwKmRt4t4WBEXf
 ZaIYYrvcvY3dAI4r4G6KEVm1vYVN48lgd956CpJazB20V/ZsipnenanPPzITcm071tcj
 4uY4L6sQsqCaa7Pk6vcYSqCIaStsWu4fxByDdgQFba4M2q/0l+oSIJut5+ileNhUAICu
 1EUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772552785; x=1773157585;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JlNMjAz/v9hE9+E6wP8WUf+noUs9P2BtkOSC9k34nEk=;
 b=XLwSIcClHQa2xIu8fgC/5HvsWgMQ7m1WJfv4wpD31IPAWVzZYm8OlZZX9BO4LxxWqy
 D5j5cycKIqw7KscWNrIXgPE2eaJMCf6qV2TmZ1B8YRvbrcxIF9co8MdjHReJ2YYh83Lq
 G25SG+AziF8P0YJod3fWE0/mfrL2dRAhnlyoQelpQxKgxZrFzfFQvWqODL/RQrKh8CVT
 zB+cwf/OKHD43aDpY/hyd6FMtmPaHSAPiqYYX9JJH+Ra2cQifeCJx3hSk5t3M9cf6CMI
 2G5H5VMxrOzeIG4+ecggkwLOkclIFhIt5dgmjJLPw2fo9lKMKxCbWJek8K7VEROtBE/m
 Og7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaXgno2dCi01/cioUieUVVnTd7ZtaO3pcjJUn6JjKOR23cHXgZhMZBV2re1aeyaD5d5Ms=@lists.linux.it
X-Gm-Message-State: AOJu0YyhFxN+4/eEuU/YAD1SP7unpLjJm/kf6c5W//ekH4SRZGfeMZjq
 8Gt+5wasYuCq+XEL16tT2eceuB/eTBz8F1imj8s/PW6MEamjY5oD5aC2fSMl7KRAk4T2E0YZguz
 jZrRhVjE=
X-Gm-Gg: ATEYQzwyrWRkZXUGtwacdkIFtNH+qrD3qaLRRZaUnsLev5CyAciUxipsLRbp1G7aG+f
 mVSmzQ1hYqC3GERzk9W2SbDw2tZp+AXkDpOHKD6Z4yPMTmxkes9JkrrOXTnKGHmvz7zIPuxITkr
 OZhPixiieaaZSWCx6bYIQWKfown2ABDoxXQqX+np+4kucKVK+owIY9c+YkDLv4oLOGTmqPNnHdZ
 1EAdEy/s3XPszu5Ylth9yCHEHvbLsbFblsjJUVwep1q6D3RZiEhJuMkb04kP9kQTFZO+esWyufR
 etPZIhfazLDgGpQ2+eYrtX2hQhJlzWUa2aqPvB0yIpExYSGo664CBVD9vShrQ6fAmq7z5V7yZ8M
 SNe0RBAqisew+4Fhwsjw2GtuZfsxylnxA/O3nNAIAcRhRTNMBCOEDaXoEgOVGJnX9a3bs/NaEuR
 LcrxvXzGd8OsSmy5zA5oImiizbfRLzS5JY4049o96X
X-Received: by 2002:a05:600c:3b99:b0:483:71f7:2796 with SMTP id
 5b1f17b1804b1-483c9b9d99cmr299255415e9.10.1772552784782; 
 Tue, 03 Mar 2026 07:46:24 -0800 (PST)
Received: from localhost.localdomain ([88.128.90.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48516f74a1dsm13200875e9.2.2026.03.03.07.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 07:46:24 -0800 (PST)
Message-ID: <69a70250.050a0220.3bc433.165d@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, ltp@lists.linux.it
In-Reply-To: <20260301165726.4984-1-always.starving0@gmail.com>
Date: Tue, 03 Mar 2026 15:46:23 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inotify: clean up build and make check findings
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

> Fix various issues reported by `make` and `make check`:
> 
> - Drop ENOSYS-based logic and rely on TERRNO reporting
> - Silence known format-truncation warnings locally
> - Clean up string handling and permissions
> - Fix minor style and prototype issues

This is a lot of stuff for a single commit :-) we might need to separate
these changes into multiple commits.

> 
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
>  testcases/kernel/syscalls/inotify/Makefile    |  1 +
>  testcases/kernel/syscalls/inotify/inotify.h   | 13 +++-------
>  testcases/kernel/syscalls/inotify/inotify01.c |  4 ++-
>  testcases/kernel/syscalls/inotify/inotify02.c | 26 ++++++++++---------
>  testcases/kernel/syscalls/inotify/inotify03.c |  5 ++--
>  testcases/kernel/syscalls/inotify/inotify04.c | 23 ++++++++--------
>  testcases/kernel/syscalls/inotify/inotify05.c |  2 +-
>  testcases/kernel/syscalls/inotify/inotify07.c | 16 ++++++------
>  testcases/kernel/syscalls/inotify/inotify08.c |  5 ++--
>  testcases/kernel/syscalls/inotify/inotify10.c | 18 +++++++------
>  10 files changed, 58 insertions(+), 55 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/inotify/Makefile b/testcases/kernel/syscalls/inotify/Makefile
> index 16d430864..57124c739 100644
> --- a/testcases/kernel/syscalls/inotify/Makefile
> +++ b/testcases/kernel/syscalls/inotify/Makefile
> @@ -4,6 +4,7 @@
>  top_srcdir		?= ../../../..
> 
>  include $(top_srcdir)/include/mk/testcases.mk
> +inotify02: CFLAGS+=-Wno-format-truncation

uhm? Is it really needed?

>  inotify09: CFLAGS+=-pthread
>  inotify09: LDLIBS+=-lrt
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/inotify/inotify.h b/testcases/kernel/syscalls/inotify/inotify.h
> index dbf814902..1bc36defa 100644
> --- a/testcases/kernel/syscalls/inotify/inotify.h
> +++ b/testcases/kernel/syscalls/inotify/inotify.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>  /*
>   * inotify testcase common definitions.
>   *
> @@ -33,14 +33,8 @@
>  static inline int safe_myinotify_init(const char *file, const int lineno, int fd)
>  {
>  	if (fd < 0) {
> -		if (errno == ENOSYS) {
> -			tst_brk(TCONF,
> -				"%s:%d: inotify is not configured in this kernel",

Here we are suppressing a TCONF and threating everything as TERRNO. This
needs to be reverted.

> +		tst_brk(TBROK | TERRNO, "%s:%d: inotify_init failed",
>  				file, lineno);
> -		} else {
> -			tst_brk(TBROK | TERRNO, "%s:%d: inotify_init failed",
> -				file, lineno);
> -		}
>  	}
>  	return fd;
>  }
> @@ -51,7 +45,8 @@ static inline int safe_myinotify_init(const char *file, const int lineno, int fd
>  #define SAFE_MYINOTIFY_INIT1(flags) \
>  	safe_myinotify_init(__FILE__, __LINE__, myinotify_init1(flags))
> 
> -static inline int safe_myinotify_watch(const char *file, const int lineno, int wd, int fd, const char* fname, const char* mask)
> +static inline int safe_myinotify_watch(const char *file, const int lineno, int wd,
> +				       int fd, const char *fname, const char *mask)
>  {
>  	if (wd < 0) {
>  		tst_brk(TBROK | TERRNO,
> diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
> index 972b1025e..12aadf862 100644
> --- a/testcases/kernel/syscalls/inotify/inotify01.c
> +++ b/testcases/kernel/syscalls/inotify/inotify01.c
> @@ -40,7 +40,7 @@ static unsigned int event_set[EVENT_MAX];
> 
>  static char event_buf[EVENT_BUF_LEN];
> 
> -void verify_inotify(void)
> +static void verify_inotify(void)
>  {
>  	int test_cnt = 0;
> 
> @@ -79,6 +79,7 @@ void verify_inotify(void)
>  	 * get list of events
>  	 */
>  	int len, i = 0, test_num = 0;
> +
>  	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
> 
>  	/*
> @@ -86,6 +87,7 @@ void verify_inotify(void)
>  	 */
>  	while (i < len) {
>  		struct inotify_event *event;
> +
>  		event = (struct inotify_event *)&event_buf[i];
>  		if (test_num >= test_cnt) {
>  			tst_res(TFAIL,
> diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
> index 314c1bd49..5f288b270 100644
> --- a/testcases/kernel/syscalls/inotify/inotify02.c
> +++ b/testcases/kernel/syscalls/inotify/inotify02.c
> @@ -43,6 +43,7 @@ struct event_t {
>  	char name[BUF_SIZE];
>  	unsigned int mask;
>  };
> +
>  #define FILE_NAME1 "test_file1"
>  #define FILE_NAME2 "test_file2"
> 
> @@ -50,7 +51,7 @@ static struct event_t event_set[EVENT_MAX];
> 
>  static char event_buf[EVENT_BUF_LEN];
> 
> -void verify_inotify(void)
> +static void verify_inotify(void)
>  {
>  	unsigned int stored_cookie = UINT_MAX;
> 
> @@ -61,40 +62,40 @@ void verify_inotify(void)
>  	 */
>  	SAFE_CHMOD(".", 0755);
>  	event_set[test_cnt].mask = IN_ISDIR | IN_ATTRIB;
> -	strcpy(event_set[test_cnt].name, "");
> +	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", "");

This is quite an overkill. To reset a string in C you just need

  buff[0] = '\0';

And the same for the others.. also make sure that boundaries are
correct, because I have the feeling we might easily overbound memories
when using snprintf() here.

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
