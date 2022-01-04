Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2C2C433EF
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 11:21:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BE783C903B
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 12:21:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AB2D3C051B
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 12:21:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5D7F860057A
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 12:21:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 24AF321107;
 Tue,  4 Jan 2022 11:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641295262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtZKfVDNwwUVI356NkBNVvqDtitc0obI4GSBuYuGDZI=;
 b=OmLc/py/QVgOd8FxiWXkPIR5P7ijTa7FYBEJaDsgWZqVdrdOY3fvyiNZ32AL/w2LZCkAUQ
 wbHWYEIDPZeyrTseevBFz9R9wW/dm/sDiPtfSBG/eZG/AjA/0dMzabmuWbulFWbdtgAHLM
 04ufaZftUokXsXZU6kaVzpMnFYd6SsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641295262;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtZKfVDNwwUVI356NkBNVvqDtitc0obI4GSBuYuGDZI=;
 b=yamSdvG68Ym0AADJ1545NpPJ2yf2/tTg+YztorW/hZmh6HHb2ZqlmTmR1d0v6CZdGkEEld
 ci3n5qc5OtUUdYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 105FC13AE7;
 Tue,  4 Jan 2022 11:21:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DPdlA54t1GGrNgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 04 Jan 2022 11:21:02 +0000
Date: Tue, 4 Jan 2022 12:22:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YdQt9isU3u5CFRcZ@yuki>
References: <20220104081836.22827-1-andrea.cervesato@suse.com>
 <20220104081836.22827-3-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220104081836.22827-3-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 02/10] Add wqueue01 new test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This test checks if KEYCTL_UPDATE event is recognized by watch queue
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/watchqueue/common.h   | 153 +++++++++++++++++++++++++
>  testcases/kernel/watchqueue/wqueue01.c |  68 +++++++++++
>  2 files changed, 221 insertions(+)
>  create mode 100644 testcases/kernel/watchqueue/common.h
>  create mode 100644 testcases/kernel/watchqueue/wqueue01.c
> 
> diff --git a/testcases/kernel/watchqueue/common.h b/testcases/kernel/watchqueue/common.h
> new file mode 100644
> index 000000000..6a7ae213e
> --- /dev/null
> +++ b/testcases/kernel/watchqueue/common.h
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef WQUEUE_COMMON_H__
> +#define WQUEUE_COMMON_H__
> +
> +#define _FCNTL_H

This is certainly wrong a hack that will break sooner or later.

What is this needed for?

> +#include <linux/watch_queue.h>

We will need a configure check for this one and either add fallback
structures and constants in lapi/ or skip the test build when this file
is not present.

> +#include "tst_test.h"
> +#include "lapi/keyctl.h"
> +
> +static struct watch_notification_filter wqueue_key_filter = {
> +	.nr_filters	= 1,
> +	.__reserved	= 0,

This is a global no need to zero out any members like that.

> +	.filters = {
> +		[0]	= {
> +			.type = WATCH_TYPE_KEY_NOTIFY,
> +			.subtype_filter[0] = UINT_MAX,
> +		},
> +	},
> +};
> +
> +static const char *key_subtypes[256] = {
> +	[NOTIFY_KEY_INSTANTIATED]	= "instantiated",
> +	[NOTIFY_KEY_UPDATED]		= "updated",
> +	[NOTIFY_KEY_LINKED]		= "linked",
> +	[NOTIFY_KEY_UNLINKED]		= "unlinked",
> +	[NOTIFY_KEY_CLEARED]		= "cleared",
> +	[NOTIFY_KEY_REVOKED]		= "revoked",
> +	[NOTIFY_KEY_INVALIDATED]	= "invalidated",
> +	[NOTIFY_KEY_SETATTR]		= "setattr",
> +};
> +
> +static inline long safe_keyctl(int cmd, ...)
> +{
> +	long ret;
> +	va_list va;
> +	unsigned long arg2, arg3, arg4, arg5;
> +
> +	va_start(va, cmd);
> +	arg2 = va_arg(va, unsigned long);
> +	arg3 = va_arg(va, unsigned long);
> +	arg4 = va_arg(va, unsigned long);
> +	arg5 = va_arg(va, unsigned long);
> +	va_end(va);
> +
> +	ret = tst_syscall(__NR_keyctl, cmd, arg2, arg3, arg4, arg5);
> +	if (ret == -1)
> +		tst_brk(TBROK, "keyctl error: %s", tst_strerrno(errno));

We do have lapi/keyctl.h that defines keyctl() you should use that
instead.

> +	return ret;
> +}
>
> +static int wqueue_key_event(struct watch_notification *n, size_t len, unsigned int wtype, int type)
> +{
> +	struct key_notification *k;
> +	const char* msg;
> +
> +	if (wtype != WATCH_TYPE_KEY_NOTIFY)
> +		return 0;
> +
> +	if (len != sizeof(struct key_notification))
> +		tst_brk(TBROK, "Incorrect key message length");
> +
> +	k = (struct key_notification *)n;
> +	msg = key_subtypes[n->subtype];
> +
> +	tst_res(TINFO, "KEY %08x change=%u[%s] aux=%u",
> +	    k->key_id, n->subtype, msg, k->aux);
> +
> +	if (n->subtype == type)
> +        return 1;

Wrong indentation here, do not forget to run make check before
posting...

> +    return 0;
> +}
> +
> +static key_serial_t wqueue_add_key(int fd)
> +{
> +	key_serial_t key;
> +
> +	key = add_key("user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
> +	if (key == -1)
> +		tst_brk(TBROK, "add_key error: %s", tst_strerrno(errno));
> +
> +	safe_keyctl(KEYCTL_WATCH_KEY, key, fd, 0x01);
> +	safe_keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fd, 0x02);
> +
> +	return key;
> +}
> +
> +static int wqueue_watch(int buf_size, struct watch_notification_filter *filter)
> +{
> +	int pipefd[2];
> +	int fd;
> +
> +	SAFE_PIPE2(pipefd, O_NOTIFICATION_PIPE);
> +
> +	fd = pipefd[0];
> +
> +	SAFE_IOCTL(fd, IOC_WATCH_QUEUE_SET_SIZE, buf_size);
> +	SAFE_IOCTL(fd, IOC_WATCH_QUEUE_SET_FILTER, filter);
> +
> +	return fd;
> +}
> +
> +typedef void (*wqueue_callback) (struct watch_notification *n, size_t len, unsigned int wtype);
> +
> +static void wqueue_consumer(int fd, volatile int *keep_polling, wqueue_callback cb)
> +{
> +	unsigned char buffer[433], *p, *end;
> +	union {
> +		struct watch_notification n;
> +		unsigned char buf1[128];
> +	} n;
> +	ssize_t buf_len;
> +
> +	tst_res(TINFO, "Waiting for watch queue events");
> +
> +	while (*keep_polling) {
> +		buf_len = SAFE_READ(0, fd, buffer, sizeof(buffer));
> +
> +		p = buffer;
> +		end = buffer + buf_len;
> +		while (p < end) {
> +			size_t largest, len;
> +
> +			largest = end - p;
> +			if (largest > 128)
> +				largest = 128;
> +
> +			if (largest < sizeof(struct watch_notification))
> +				tst_brk(TBROK, "Short message header: %zu", largest);
> +
> +			memcpy(&n, p, largest);
> +
> +			tst_res(TINFO, "NOTIFY[%03zx]: ty=%06x sy=%02x i=%08x",
> +			       p - buffer, n.n.type, n.n.subtype, n.n.info);
> +
> +			len = n.n.info & WATCH_INFO_LENGTH;
> +			if (len < sizeof(n.n) || len > largest)
> +				tst_brk(TBROK, "Bad message length: %zu/%zu", len, largest);
> +
> +			cb(&n.n, len, n.n.type);
> +
> +			p += len;
> +		}
> +	}
> +}
> +
> +#endif
> diff --git a/testcases/kernel/watchqueue/wqueue01.c b/testcases/kernel/watchqueue/wqueue01.c
> new file mode 100644
> index 000000000..f22682eed
> --- /dev/null
> +++ b/testcases/kernel/watchqueue/wqueue01.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test if keyctl update is correctly recognized by watch queue.
> + */
> +
> +#define _FCNTL_H
> +
> +#include "tst_test.h"
> +#include "lapi/keyctl.h"
> +#include "common.h"
> +
> +static int *keep_polling;
> +
> +static void saw_key_updated(struct watch_notification *n, size_t len, unsigned int wtype)
> +{
> +	if (wqueue_key_event(n, len, wtype, NOTIFY_KEY_UPDATED))
> +		tst_res(TPASS, "keyctl update has been recognized");
> +	else
> +		tst_res(TFAIL, "keyctl update has not been recognized");
> +}
> +
> +static void setup(void)
> +{
> +	keep_polling = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	*keep_polling = 0;
> +	SAFE_MUNMAP(keep_polling, sizeof(int));
> +}
> +
> +static void run(void)
> +{
> +	int fd;
> +	int pid;
> +	key_serial_t key;
> +
> +	fd = wqueue_watch(256, &wqueue_key_filter);
> +	key = wqueue_add_key(fd);
> +
> +	*keep_polling = 1;
> +
> +	pid = SAFE_FORK();
> +	if (pid > 0) {
> +		wqueue_consumer(fd, keep_polling, saw_key_updated);
> +		return;
> +	}

Do we really need to run the part that reads the notification in a
separate process? For these single cases we can just do the keyctl and
then read from the pipe and check if there is anything in there.

> +	safe_keyctl(KEYCTL_UPDATE, key, "b", 1);
> +
> +	*keep_polling = 0;
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.forks_child = 1
> +};
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
