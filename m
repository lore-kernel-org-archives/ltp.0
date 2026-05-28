Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BC0CD5BD5
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 16:36:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C88E3D000B
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 18:36:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B55443CDA31
 for <ltp@lists.linux.it>; Thu, 28 May 2026 18:36:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 87F58600077
 for <ltp@lists.linux.it>; Thu, 28 May 2026 18:36:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A8E66A8C6;
 Thu, 28 May 2026 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779986171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X76ElhMV1kPGrgbnw2Nu4vT72sBwWQ2tUG68d5Ktf3s=;
 b=2g0H05lUsD24BEBaIgtMWnNjqIwDUHxpQDxFC+3ppBKn4t7MdLChLXQWge3+PYMFzrZ+DB
 lqrDBQ2lFM0KGuWP9IBq+LKwrHvw2h/Hfpzpnflpc9dGH/PHN8+FM3IA6s/RanesSfY27V
 dpVOTeW+0CUl8sYEEw5UsL1KpqFBXhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779986171;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X76ElhMV1kPGrgbnw2Nu4vT72sBwWQ2tUG68d5Ktf3s=;
 b=DSdAv+2J0C0NY0arna0H+Coyo5H/HqAFOexAeZMSQK7IK0eBgU+VXzviK4uLn+ZJFUMaUh
 iGdUmLTMhYqYsBDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2g0H05lU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DSdAv+2J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779986171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X76ElhMV1kPGrgbnw2Nu4vT72sBwWQ2tUG68d5Ktf3s=;
 b=2g0H05lUsD24BEBaIgtMWnNjqIwDUHxpQDxFC+3ppBKn4t7MdLChLXQWge3+PYMFzrZ+DB
 lqrDBQ2lFM0KGuWP9IBq+LKwrHvw2h/Hfpzpnflpc9dGH/PHN8+FM3IA6s/RanesSfY27V
 dpVOTeW+0CUl8sYEEw5UsL1KpqFBXhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779986171;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X76ElhMV1kPGrgbnw2Nu4vT72sBwWQ2tUG68d5Ktf3s=;
 b=DSdAv+2J0C0NY0arna0H+Coyo5H/HqAFOexAeZMSQK7IK0eBgU+VXzviK4uLn+ZJFUMaUh
 iGdUmLTMhYqYsBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81D025AEA3;
 Thu, 28 May 2026 16:36:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Sg0EH/tuGGodfwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Thu, 28 May 2026 16:36:11 +0000
Message-ID: <89e9004c-4415-4f05-8288-4f73a491d8dd@suse.cz>
Date: Thu, 28 May 2026 18:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sebastian Chlad <sebastianchlad@gmail.com>, ltp@lists.linux.it
References: <20260523101749.27657-1-sebastian.chlad@suse.com>
 <20260523165718.26187-1-sebastian.chlad@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20260523165718.26187-1-sebastian.chlad@suse.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9A8E66A8C6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,lists.linux.it];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim, suse.cz:mid,
 configure.ac:url, suse.com:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] io_uring/pintheft: Add CVE-2026-43494
 regression test
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
some suggestions below.

On 5/23/26 18:57, Sebastian Chlad wrote:
> Test for PinTheft (CVE-2026-43494), fixed by:
> e17492979319 ("net/rds: reset op_nents when zerocopy page pin fails")
> 
> The bug is in the RDS zerocopy send error path: when pinning user pages
> for zerocopy send fails partway through, the error cleanup drops a page
> reference that the RDS message cleanup will drop again. Combined with
> io_uring fixed buffer registrations, this double-drop drains the
> FOLL_PIN counter and causes a page-cache overwrite exploitable for local
> privilege escalation (PinTheft).
> 
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> ---
> 
> v4: (fixing pointers listed by AI LTP)
> - Fix double blank line
> - Correct HAVE_STRUCT_IO_URING_CLONE_BUFFERS
> 
>   configure.ac                                  |   1 +
>   include/lapi/io_uring.h                       |  14 +
>   runtest/cve                                   |   1 +
>   testcases/kernel/syscalls/io_uring/pintheft.c | 424 ++++++++++++++++++
>   4 files changed, 440 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/io_uring/pintheft.c
> 
> diff --git a/configure.ac b/configure.ac
> index 0653d7793..3a1283ac3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -255,6 +255,7 @@ AC_CHECK_TYPES([struct __kernel_old_timeval, struct __kernel_old_timespec, struc
>                   struct __kernel_old_itimerval],,,[#include <sys/socket.h>])
>   
>   AC_CHECK_TYPES([struct futex_waitv],,,[#include <linux/futex.h>])
> +AC_CHECK_TYPES([struct io_uring_clone_buffers],,,[#include <linux/io_uring.h>])
>   AC_CHECK_TYPES([struct mount_attr],,,[
>   #ifdef HAVE_MOUNT_SETATTR
>   # include <sys/mount.h>
> diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
> index 2026863a2..5c6f9a785 100644
> --- a/include/lapi/io_uring.h
> +++ b/include/lapi/io_uring.h

It'd be better to submit LAPI changes as a separate commit.

> @@ -265,6 +265,20 @@ struct io_uring_probe {
>   
>   #endif /* IOSQE_FIXED_FILE */
>   
> +/* linux/io_uring.h: IORING_REGISTER_CLONE_BUFFERS = 30 */
> +#ifndef IORING_REGISTER_CLONE_BUFFERS
> +#define IORING_REGISTER_CLONE_BUFFERS	30
> +#endif
> +
> +/* Argument for IORING_REGISTER_CLONE_BUFFERS */
> +#ifndef HAVE_STRUCT_IO_URING_CLONE_BUFFERS
> +struct io_uring_clone_buffers {
> +	uint32_t src_fd;
> +	uint32_t flags;
> +	uint32_t pad[6];
> +};
> +#endif
> +
>   #ifndef IOSQE_IO_HADRLINK
>   /* like LINK, but stronger */
>   #define IOSQE_IO_HARDLINK_BIT	3
> diff --git a/runtest/cve b/runtest/cve
> index 74ee8e9ba..32a0f237d 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -95,4 +95,5 @@ cve-2025-38236 cve-2025-38236
>   cve-2025-21756 cve-2025-21756
>   cve-2026-31431 af_alg08
>   cve-2026-43284 xfrm01
> +cve-2026-43494 pintheft
>   cve-2026-46300 xfrm02
> diff --git a/testcases/kernel/syscalls/io_uring/pintheft.c b/testcases/kernel/syscalls/io_uring/pintheft.c
> new file mode 100644
> index 000000000..6601c87ca
> --- /dev/null
> +++ b/testcases/kernel/syscalls/io_uring/pintheft.c

I recommend renaming the file to io_uring04.c.

> @@ -0,0 +1,424 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC Sebastian Chlad <sebastian.chlad@suse.com>
> + */
> +
> +/*\
> + * CVE-2026-43494
> + *
> + * Test for PinTheft, fixed by:
> + * e17492979319 ("net/rds: reset op_nents when zerocopy page pin fails").
> + *
> + * The bug is in the RDS zerocopy send error path. When RDS pins user pages for
> + * zerocopy send and a later page faults, the error cleanup can drop references
> + * for pages that are later released again during RDS message cleanup. This
> + * corrupts page reference accounting.
> + *
> + * The public exploit combines this RDS reference-counting bug with io_uring
> + * fixed buffers and cloned buffer registrations to turn stale page references
> + * into a page-cache overwrite and local privilege escalation.
> + *
> + * This test does not attempt privilege escalation. It triggers the underlying
> + * RDS zerocopy failure path by sending GUP_PIN_COUNTING_BIAS (1024) two-page
> + * iovecs where the first page is registered as an io_uring fixed buffer and
> + * the second page is PROT_NONE.  Each failing send steals one FOLL_PIN
> + * reference; after 1024 sends the io_uring-held page pin is exhausted.
> + * Unregistering the fixed buffers on a vulnerable kernel then tries to unpin
> + * a page with no remaining FOLL_PIN references, triggering a kernel WARN or
> + * BUG_ON and tainting the kernel.
> + *
> + * Vulnerable kernels may crash, taint, panic, or hang during sendmsg() or
> + * subsequent cleanup. Run only on disposable systems.
> + *
> + * Reproducer is based on:
> + * https://github.com/v12-security/pocs/tree/main/pintheft
> + */
> +
> +#include <errno.h>
> +#include <netinet/in.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/socket.h>
> +#include <sys/uio.h>
> +#include <sys/wait.h>
> +#include <unistd.h>

Most of these header files are included by tst_test.h. You don't need to 
include them explicitly.

> +
> +#include <linux/rds.h>
> +
> +/* Fallback for older userspace headers (e.g. openSUSE Leap 42.2). */
> +#ifndef RDS_CMSG_ZCOPY_COOKIE
> +#define RDS_CMSG_ZCOPY_COOKIE	12
> +#endif

It'd be better to have this fallback #define in LAPI.

> +
> +#include "tst_test.h"
> +#include "lapi/io_uring.h"
> +#include "lapi/socket.h"
> +
> +#define CLEANUP_WAIT_SECS	30

Isn't 30 seconds a bit too much?

> +#define RSS_CHECK_CHILDREN	8
> +#define RSS_CHECK_SIZE		(16 * 1024 * 1024)
> +
> +/*
> + * io_uring pins fixed-buffer pages with FOLL_PIN, which adds
> + * GUP_PIN_COUNTING_BIAS (1024) to the page reference count.  Each failing
> + * RDS zerocopy send steals one of those references via the double-drop bug.
> + * We need exactly 1024 iterations to fully drain the FOLL_PIN counter.
> + */
> +#define GUP_PIN_COUNTING_BIAS	1024
> +
> +static int ring_fd1 = -1;
> +static int ring_fd2 = -1;
> +static int rds_fd = -1;
> +static int buffer_registered;
> +static int buffer_cloned;
> +static long page_size;
> +static void *mapped_pages;
> +
> +static void cleanup(void);
> +
> +/* Inspired by liburing's io_uring_clone_buffers(), but using raw ring fds. */
> +static int clone_buffers(int dst_fd, int src_fd)
> +{
> +	struct io_uring_clone_buffers clone;
> +
> +	memset(&clone, 0, sizeof(clone));
> +	clone.src_fd = src_fd;
> +
> +	return io_uring_register(dst_fd, IORING_REGISTER_CLONE_BUFFERS,
> +				 &clone, 1);
> +}
> +
> +static void setup(void)
> +{
> +	struct io_uring_params params = {};
> +	struct iovec fixed_iov;
> +	int val;
> +
> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> +	io_uring_setup_supported_by_kernel();
> +
> +	/*
> +	 * The exploit primitive keeps one fixed-buffer registration alive and
> +	 * clones it to another ring.
> +	 */
> +	ring_fd1 = io_uring_setup(1, &params);
> +	if (ring_fd1 < 0)
> +		tst_brk(TBROK | TERRNO, "io_uring_setup() failed for first ring");
> +
> +	memset(&params, 0, sizeof(params));
> +
> +	ring_fd2 = io_uring_setup(1, &params);
> +	if (ring_fd2 < 0)
> +		tst_brk(TBROK | TERRNO, "io_uring_setup() failed for second ring");
> +
> +	rds_fd = socket(AF_RDS, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
> +	if (rds_fd < 0) {
> +		if (errno == EAFNOSUPPORT || errno == ESOCKTNOSUPPORT ||
> +		    errno == EPROTONOSUPPORT || errno == ENOPROTOOPT)
> +			tst_brk(TCONF | TERRNO, "RDS is not available");

EAFNOSUPPORT should be sufficient availability check.

> +
> +		tst_brk(TBROK | TERRNO, "socket(AF_RDS) failed");
> +	}
> +
> +	/* PinTheft uses the RDS TCP transport, so base RDS is not enough. */
> +	val = RDS_TRANS_TCP;
> +	TEST(setsockopt(rds_fd, SOL_RDS, SO_RDS_TRANSPORT, &val, sizeof(val)));
> +
> +	if (TST_RET) {
> +		if (TST_ERR == ENOPROTOOPT || TST_ERR == EINVAL)
> +			tst_brk(TCONF | TERRNO, "RDS TCP transport is not available");
> +
> +		tst_brk(TBROK | TERRNO, "setsockopt(SO_RDS_TRANSPORT) failed");
> +	}
> +
> +	/*
> +	 * Allocate two adjacent pages: the first one will be pinned as an
> +	 * io_uring fixed buffer, and the second one will be made inaccessible.
> +	 */
> +	mapped_pages = SAFE_MMAP(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
> +				 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	memset(mapped_pages, 0xa5, page_size);
> +
> +	/*
> +	 * RDS should successfully pin the first page, then fault on the second.
> +	 * That fault drives the buggy zerocopy error cleanup path.
> +	 */
> +	SAFE_MPROTECT((char *)mapped_pages + page_size, page_size, PROT_NONE);
> +
> +	fixed_iov.iov_base = mapped_pages;
> +	fixed_iov.iov_len = page_size;
> +
> +	/*
> +	 * Register only the first page as an io_uring fixed buffer. This creates
> +	 * the long-term page pin whose reference accounting the RDS bug damages.
> +	 */
> +	if (io_uring_register(ring_fd1, IORING_REGISTER_BUFFERS, &fixed_iov, 1))
> +		tst_brk(TBROK | TERRNO, "IORING_REGISTER_BUFFERS failed");
> +
> +	buffer_registered = 1;
> +
> +	/*
> +	 * Clone the fixed buffer registration into the second ring, matching the
> +	 * public reproducer's lifetime pattern without performing the later
> +	 * page-cache overwrite stage.
> +	 */
> +	if (clone_buffers(ring_fd2, ring_fd1)) {
> +		if (errno == EINVAL || errno == EOPNOTSUPP)
> +			tst_brk(TCONF | TERRNO, "IORING_REGISTER_CLONE_BUFFERS is not supported");
> +
> +		tst_brk(TBROK | TERRNO, "IORING_REGISTER_CLONE_BUFFERS failed");
> +	}
> +
> +	buffer_cloned = 1;
> +}
> +
> +static void trigger(void)
> +{
> +	/*
> +	 * Derive RDS ports from the process ID so concurrent test instances
> +	 * do not collide in the RDS port namespace.
> +	 */
> +	const uint16_t src_port = (uint16_t)(20000 + (getpid() % 20000));
> +	struct sockaddr_in bind_addr = {
> +		.sin_family = AF_INET,
> +		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
> +		.sin_port = htons(src_port),
> +	};
> +	struct sockaddr_in dst_addr = {
> +		.sin_family = AF_INET,
> +		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
> +		.sin_port = htons(src_port + 1),
> +	};
> +	char control[CMSG_SPACE(sizeof(uint32_t))];
> +	struct cmsghdr *cmsg;
> +	struct iovec iov = {
> +		.iov_base = mapped_pages,
> +		.iov_len = 2 * page_size,
> +	};
> +	struct msghdr msg = {
> +		.msg_name = &dst_addr,
> +		.msg_namelen = sizeof(dst_addr),
> +		.msg_iov = &iov,
> +		.msg_iovlen = 1,
> +		.msg_control = control,
> +		.msg_controllen = sizeof(control),
> +	};
> +	int ret;
> +	int val;
> +	int i, efaults, first_bad_errno = 0;
> +
> +	/* Mirror the public PoC trigger: RDS zerocopy over TCP. */
> +	val = 1;
> +	if (setsockopt(rds_fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
> +		if (errno == ENOPROTOOPT || errno == EINVAL)
> +			tst_brk(TCONF | TERRNO, "SO_ZEROCOPY not supported on RDS sockets");
> +		tst_brk(TBROK | TERRNO, "setsockopt(SO_ZEROCOPY) failed");
> +	}
> +
> +	val = 2 * page_size * 4;
> +	SAFE_SETSOCKOPT(rds_fd, SOL_SOCKET, SO_SNDBUF, &val, sizeof(val));
> +
> +	/*
> +	 * Bind to one loopback RDS port and send to another unbound local port.
> +	 * The sends are expected to fail before any useful delivery; the faulting
> +	 * iovec is the interesting part.
> +	 */
> +	SAFE_BIND(rds_fd, (struct sockaddr *)&bind_addr, sizeof(bind_addr));

I'm not sure if RDS bind() works the same as other protocols but you 
should be able to bind to port 0 (autoassign) and then read src_port 
using TST_GETSOCKPORT(rds_fd).

> +
> +	memset(control, 0, sizeof(control));
> +	cmsg = (struct cmsghdr *)control;
> +	cmsg->cmsg_level = SOL_RDS;
> +	cmsg->cmsg_type = RDS_CMSG_ZCOPY_COOKIE;
> +	cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
> +
> +	/*
> +	 * Repeatedly attempt a two-page zerocopy send where page 0 is pinnable
> +	 * and page 1 is PROT_NONE.  Each attempt should:
> +	 *   1. Pin page 0 successfully.
> +	 *   2. Fault on page 1, so RDS error path drops page 0's reference.
> +	 *   3. RDS message cleanup drops page 0's reference again (the bug).
> +	 *
> +	 * On a vulnerable kernel this steals one FOLL_PIN reference per
> +	 * iteration; GUP_PIN_COUNTING_BIAS iterations drain the counter to zero.
> +	 * Unregistering the io_uring fixed buffer then tries to unpin a page
> +	 * with no remaining FOLL_PIN references, causing a kernel WARN/BUG_ON
> +	 * and taint.
> +	 *
> +	 * EFAULT is the expected error because page 1 is PROT_NONE. Other
> +	 * errors do not count as successful pin-theft iterations.
> +	 *
> +	 * Vulnerable kernels may crash, taint, panic, or hang here or during
> +	 * cleanup() below.
> +	 */
> +	for (i = 0, efaults = 0; i < GUP_PIN_COUNTING_BIAS; i++) {
> +		/* rds_cmsg_zcopy() in net/rds/send.c */
> +		*(uint32_t *)CMSG_DATA(cmsg) = (uint32_t)i;
> +
> +		ret = sendmsg(rds_fd, &msg, MSG_ZEROCOPY | MSG_DONTWAIT);
> +		if (ret >= 0)
> +			tst_brk(TBROK, "sendmsg() unexpectedly succeeded at iter %d", i);
> +
> +		if (errno == EFAULT)
> +			efaults++;
> +		else if (!first_bad_errno)
> +			first_bad_errno = errno;
> +	}
> +
> +	if (first_bad_errno) {
> +		tst_res(TINFO, "sendmsg() returned unexpected errno %d (%s) on at least one iteration",
> +			first_bad_errno, tst_strerrno(first_bad_errno));
> +	}
> +
> +	tst_res(TINFO, "Completed %d/%d sendmsg() attempts with EFAULT",
> +		efaults, GUP_PIN_COUNTING_BIAS);
> +
> +	if (efaults == 0)
> +		tst_brk(TCONF, "sendmsg() never returned EFAULT - GUP pin path not exercised");
> +
> +	if (efaults < GUP_PIN_COUNTING_BIAS)
> +		tst_res(TWARN, "Only %d/%d sends returned EFAULT - FOLL_PIN counter may not be fully drained",
> +			efaults, GUP_PIN_COUNTING_BIAS);
> +
> +	/*
> +	 * Unregistering fixed buffers on a vulnerable kernel triggers a
> +	 * double-unpin: io_uring tries to release references that the RDS bug
> +	 * already dropped, which may produce a kernel WARN or BUG_ON and taint.
> +	 */
> +	cleanup();

You should not call cleanup() directly. You'll destroy resources 
allocated in setup() and the test will then fail on fixed kernels if 
your run it with -i 2.

> +}
> +
> +static void poke_rss_accounting(void)
> +{
> +	char *mem;
> +
> +	mem = SAFE_MMAP(NULL, RSS_CHECK_SIZE, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	memset(mem, 0x5a, RSS_CHECK_SIZE);
> +	SAFE_MUNMAP(mem, RSS_CHECK_SIZE);
> +}
> +
> +static void run(void)
> +{
> +	pid_t pid;
> +	int status;
> +	int i;
> +
> +	/*
> +	 * Run the dangerous part in a child so that process teardown can expose
> +	 * delayed RSS/page-accounting damage before the parent reports TPASS.
> +	 */
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		trigger();
> +		exit(0);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +	if (!WIFEXITED(status) || WEXITSTATUS(status))
> +		return;

You can do tst_reap_children() instead. There's no need to exit early if 
any child fails.

> +
> +	/*
> +	 * The visible failure can be delayed until another mm is torn down.
> +	 * Create short-lived children that dirty and release anonymous memory to
> +	 * encourage RSS accounting checks before the parent reports success.
> +	 */
> +	for (i = 0; i < RSS_CHECK_CHILDREN; i++) {
> +		pid = SAFE_FORK();
> +		if (!pid) {
> +			poke_rss_accounting();
> +			exit(0);
> +		}
> +
> +		SAFE_WAITPID(pid, &status, 0);

Why not only fork() in the loop, let all children run in parallel, and 
then reap + check taint after the loop?

> +
> +		if (tst_taint_check()) {
> +			tst_res(TFAIL, "Kernel is vulnerable: tainted during RSS accounting checks");
> +			return;
> +		}
> +
> +		if (!WIFEXITED(status) || WEXITSTATUS(status))
> +			return;
> +	}
> +
> +	/*
> +	 * RDS/page cleanup can run asynchronously after userspace returns from
> +	 * sendmsg() and after file descriptors are closed. Wait before declaring
> +	 * that the kernel merely "seems" to have survived.
> +	 */
> +	for (i = 0; i < CLEANUP_WAIT_SECS; i++) {
> +		sleep(1);
> +
> +		if (tst_taint_check()) {
> +			tst_res(TFAIL, "Kernel is vulnerable: tainted during RDS zerocopy cleanup");
> +			return;
> +		}
> +	}
> +
> +	tst_res(TPASS, "Kernel seems to have survived RDS zerocopy cleanup");
> +}
> +
> +static void cleanup(void)
> +{
> +	/*
> +	 * Unregister the clone first, then the source registration.
> +	 * Order matters: on a vulnerable kernel, unregistering ring_fd1
> +	 * (the original) after the FOLL_PIN references have been drained
> +	 * is what triggers the double-unpin WARN/BUG_ON.
> +	 */
> +	if (buffer_cloned) {
> +		io_uring_register(ring_fd2, IORING_UNREGISTER_BUFFERS, NULL, 0);
> +		buffer_cloned = 0;
> +	}
> +
> +	if (buffer_registered) {
> +		io_uring_register(ring_fd1, IORING_UNREGISTER_BUFFERS, NULL, 0);
> +		buffer_registered = 0;
> +	}

I think you could make the unregister calls together with closing the 
relevant ring_fd. You don't need to keep special flags what was registered.

> +
> +	if (ring_fd2 >= 0) {
> +		SAFE_CLOSE(ring_fd2);
> +		ring_fd2 = -1;

SAFE_CLOSE() sets the file descriptor to -1 automatically. Ignore any AI 
comments to the contrary.

> +	}
> +
> +	if (ring_fd1 >= 0) {
> +		SAFE_CLOSE(ring_fd1);
> +		ring_fd1 = -1;
> +	}
> +
> +	if (rds_fd >= 0) {
> +		SAFE_CLOSE(rds_fd);
> +		rds_fd = -1;
> +	}
> +
> +	if (mapped_pages) {
> +		SAFE_MUNMAP(mapped_pages, 2 * page_size);
> +		mapped_pages = NULL;
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.timeout = 60,
> +	.forks_child = 1,
> +	.taint_check = TST_TAINT_W | TST_TAINT_D,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_RDS",
> +		"CONFIG_RDS_TCP",
> +		"CONFIG_IO_URING",
> +		NULL
> +	},
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/kernel/io_uring_disabled", "0",
> +			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
> +		{}
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "e17492979319"},
> +		{"CVE", "2026-43494"},
> +		{}
> +	}
> +};


-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
