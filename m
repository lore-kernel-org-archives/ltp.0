Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86C7C433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 19:50:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 418A03C9237
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 20:50:06 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16EB33C2417
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 20:49:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5B2DA601390
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 20:49:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C0001F38D;
 Fri,  7 Jan 2022 19:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641584994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IZ/I5gpmcip8eVW2Ll4MwBpoh5499y01OAq04hwwa+U=;
 b=ZlvlchJ+/A7uBocKz/toCFf+NKeDZqyBb1kY4RvJFPcv3M9+o5cfUvv9uN2c7TvcRQV/M5
 OtpkzcBQQeliUbp9O12uuywtbzvILQ7MZTAf2UDbsD0C9ZUfuAhO/e3K8LONUaW9WXt7Sj
 2jGF/OfcjNkoP2gjMnu7zY9K/q+2xFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641584994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IZ/I5gpmcip8eVW2Ll4MwBpoh5499y01OAq04hwwa+U=;
 b=v2gL1r0v35TJgRCePhPDCXO4d7W7iUXsf1yNtN7kBkjIHlNf9KpWWtavQ/2ve6Z/FG+X8N
 Skx9G81EW6yJpAAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EFE913D40;
 Fri,  7 Jan 2022 19:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tUnHEmKZ2GFXeAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 07 Jan 2022 19:49:54 +0000
Date: Fri, 7 Jan 2022 20:51:27 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YdiZv6yQfxWMHKJh@yuki>
References: <20220107163834.7086-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220107163834.7086-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add wqueue01 test
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
> diff --git a/testcases/kernel/watchqueue/common.h b/testcases/kernel/watchqueue/common.h
> new file mode 100644
> index 000000000..97e210a29
> --- /dev/null
> +++ b/testcases/kernel/watchqueue/common.h
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef WQUEUE_COMMON_H__
> +#define WQUEUE_COMMON_H__
> +
> +#include "tst_test.h"
> +#include "lapi/watch_queue.h"
> +#include "lapi/keyctl.h"
> +
> +static struct watch_notification_filter wqueue_filter = {
> +	.nr_filters	= 2,
> +	.filters = {
> +		[0]	= {
> +			.type			= WATCH_TYPE_META,
> +			.subtype_filter[0]	= UINT_MAX,
> +		},
> +		[1]	= {
> +			.type			= WATCH_TYPE_KEY_NOTIFY,
> +			.subtype_filter[0]	= UINT_MAX,
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
> +static inline int wqueue_key_event(struct watch_notification *n, size_t len, unsigned int wtype, int type)
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

Actually we have no guarantee that the subtype is not pointing outside
of the array, do we?

I tend to write the code that converts flags to names as a function with
a switch:

	switch (foo) {
	case FOO_A:
		retrun "FOO_A";
	case FOO_B:
		return "FOO_B";
	default:
		return "Invalid value?!";
	}

which does not suffer this problem. Otherwise you would have to check
the bounds before attempts to get the value.

> +	tst_res(TINFO, "KEY %08x change=%u[%s] aux=%u",
> +	    k->key_id, n->subtype, msg, k->aux);
> +
> +	if (n->subtype == type)
> +        return 1;
> +
> +    return 0;

Wrong indentation here.

> +}
> +
> +static inline key_serial_t wqueue_add_key(int fd)
> +{
> +	key_serial_t key;
> +
> +	key = add_key("user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
> +	if (key == -1)
> +		tst_brk(TBROK, "add_key error: %s", tst_strerrno(errno));
> +
> +	keyctl(KEYCTL_WATCH_KEY, key, fd, 0x01);
> +	keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fd, 0x02);

The KEYCTL_WATCH_KEY is recent addition you should add a fallback
definition to the lapi/keyctl.h as well.

> +	return key;
> +}
> +
> +static inline int wqueue_watch(int buf_size, struct watch_notification_filter *filter)
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
> +static void wqueue_consumer(int fd, wqueue_callback cb)
> +{
> +	unsigned char buffer[433], *p, *end;
> +	union {
> +		struct watch_notification n;
> +		unsigned char buf1[128];
> +	} n;
> +	ssize_t buf_len;
> +
> +	tst_res(TINFO, "Reading watch queue events");
> +
> +	buf_len = SAFE_READ(0, fd, buffer, sizeof(buffer));
> +
> +	p = buffer;
> +	end = buffer + buf_len;
> +	while (p < end) {
> +		size_t largest, len;
> +
> +		largest = end - p;
> +		if (largest > 128)
> +			largest = 128;
> +
> +		if (largest < sizeof(struct watch_notification))
> +			tst_brk(TBROK, "Short message header: %zu", largest);
> +
> +		memcpy(&n, p, largest);
> +
> +		tst_res(TINFO, "NOTIFY[%03zx]: ty=%06x sy=%02x i=%08x",
> +				p - buffer, n.n.type, n.n.subtype, n.n.info);
> +
> +		len = n.n.info & WATCH_INFO_LENGTH;
> +		if (len < sizeof(n.n) || len > largest)
> +			tst_brk(TBROK, "Bad message length: %zu/%zu", len, largest);
> +
> +		cb(&n.n, len, n.n.type);
> +
> +		p += len;
> +	}
> +}
> +
> +#endif
> diff --git a/testcases/kernel/watchqueue/wqueue01.c b/testcases/kernel/watchqueue/wqueue01.c
> new file mode 100644
> index 000000000..33a9de3db
> --- /dev/null
> +++ b/testcases/kernel/watchqueue/wqueue01.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test if keyctl update is correctly recognized by watch queue.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/keyctl.h"
> +#include "common.h"
> +
> +static void saw_key_updated(struct watch_notification *n, size_t len, unsigned int wtype)
> +{
> +	if (wqueue_key_event(n, len, wtype, NOTIFY_KEY_UPDATED))
> +		tst_res(TPASS, "keyctl update has been recognized");
> +	else
> +		tst_res(TFAIL, "keyctl update has not been recognized");
> +}
> +
> +static void run(void)
> +{
> +	int fd;
> +	key_serial_t key;
> +
> +	fd = wqueue_watch(256, &wqueue_filter);
> +	key = wqueue_add_key(fd);
> +
> +	keyctl(KEYCTL_UPDATE, key, "b", 1);
> +	wqueue_consumer(fd, saw_key_updated);

For some reason I do not like the callback here, but I guess that
anything else would be a bit more complicated, so we may as well live
with it.

> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,

What do we need the root for?

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
