Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45F6CD5BDE
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 07:23:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51A533C74F7
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 09:23:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84C043C58CC
 for <ltp@lists.linux.it>; Wed, 27 May 2026 09:23:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 42FB11A0090B
 for <ltp@lists.linux.it>; Wed, 27 May 2026 09:23:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C33466D0C;
 Wed, 27 May 2026 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779866598;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Td8RXPM9V9f1P0v6ts+FzdhgpkFEnwA+21BfJp+w69A=;
 b=micIOXXdvgC3C13fzs7qmLTw1NFdalF/AnUHpGyAiQwc4golH8SdmJJrfiO0lOfcttvR3T
 TtLxqSnmNixvn1pbahP7x3VBKll1J6yaHxV46ijhg8qcJAex/79XSXKSB2Pz7oOFv2U9Dj
 b9NeH4MWOFUvpyJM8qiF7yauHu8ELac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779866598;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Td8RXPM9V9f1P0v6ts+FzdhgpkFEnwA+21BfJp+w69A=;
 b=fzPQ2hL2ET8hxB28N/yXjX7J9glMcQdl6t9WiA4/KkBD+PvEG1EoK9W3IwwjkzqUQ4WmFT
 8PouVyY1jF1d54AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=micIOXXd;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fzPQ2hL2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779866598;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Td8RXPM9V9f1P0v6ts+FzdhgpkFEnwA+21BfJp+w69A=;
 b=micIOXXdvgC3C13fzs7qmLTw1NFdalF/AnUHpGyAiQwc4golH8SdmJJrfiO0lOfcttvR3T
 TtLxqSnmNixvn1pbahP7x3VBKll1J6yaHxV46ijhg8qcJAex/79XSXKSB2Pz7oOFv2U9Dj
 b9NeH4MWOFUvpyJM8qiF7yauHu8ELac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779866598;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Td8RXPM9V9f1P0v6ts+FzdhgpkFEnwA+21BfJp+w69A=;
 b=fzPQ2hL2ET8hxB28N/yXjX7J9glMcQdl6t9WiA4/KkBD+PvEG1EoK9W3IwwjkzqUQ4WmFT
 8PouVyY1jF1d54AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 259BD5A6EC;
 Wed, 27 May 2026 07:23:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lKoUCOabFmqKMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 27 May 2026 07:23:18 +0000
Date: Wed, 27 May 2026 09:23:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: AnonymeMeow <anonymemeow@gmail.com>
Message-ID: <20260527072312.GA231966@pevik>
References: <CAOQ4uxgrLEJDskC8Ku8evT21un=AMnMgrKJwAN5ceUFDrJY=GA@mail.gmail.com>
 <20260527064041.50443-1-anonymemeow@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260527064041.50443-1-anonymemeow@gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5C33466D0C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it,suse.cz,google.com,vger.kernel.org];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.cz:replyto];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify: prepare tests for thread pidfd reporting
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: jack@suse.cz, amir73il@gmail.com, linux-kernel@vger.kernel.org,
 repnop@google.com, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi AnonymeMeow, Amir,

[ Cc Cyril ]

> On 2026-05-25 12:04:32+02:00, Amir Goldstein wrote:
> > On Sun, May 24, 2026 at 12:25 PM AnonymeMeow <anonymemeow@gmail.com> wrote:
@AnonymeMeow nit: if you put whole conversation after --- (below), it will not
be part of the commit message when one applies the patch. And here should be a
proper commit message.

FYI We have just 2 days before releasing new LTP version, this will not get in
anyway.  At least I'm not sure if we want to risk regression in the release for
functionality which is not yet even in the next tree.

Also I found that fanotify21.c on the current master fails when running more
than 1 iteration:

# ./fanotify21 -i2
...
tst_test.c:1980: TINFO: === Testing on ext2 ===
tst_test.c:1291: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.4 (6-Mar-2025)
tst_test.c:1303: TINFO: Mounting /dev/loop0 to /tmp/LTP_fanWZr7p3/fs_mnt fstyp=ext2 flags=0
fanotify21.c:238: TINFO: Test #0.0: return a valid pidfd for event created by self
fanotify21.c:340: TPASS: event->fd 4 is valid as expected
fanotify21.c:415: TPASS: got an event with a valid pidfd info record, mask: 32, pid: 234527, fd: 4, pidfd: 5, info_type: 4, info_len: 8
fanotify21.c:238: TINFO: Test #1.0: return a valid pidfd for event created by child
fanotify21.c:340: TPASS: event->fd 4 is valid as expected
fanotify21.c:415: TPASS: got an event with a valid pidfd info record, mask: 32, pid: 234528, fd: 4, pidfd: 5, info_type: 4, info_len: 8
fanotify21.c:238: TINFO: Test #2.0: return invalid pidfd for event created by terminated child
fanotify21.c:340: TPASS: event->fd 4 is valid as expected
fanotify21.c:375: TPASS: pid: 234529 terminated before pidfd was created, pidfd set to the value of: -1, as expected
fanotify21.c:238: TINFO: Test #3.0: fail to open rw fd for event created on read-only mount
fanotify21.c:297: TPASS: cannot read event with rw fd from a ro fs
fanotify21.c:238: TINFO: Test #0.0: return a valid pidfd for event created by self
fanotify21.c:300: TBROK: reading fanotify events failed: EROFS (30)

Summary:
passed   7
failed   0
broken   1
skipped  0
warnings 0

That should be fixed. It might be worth to fix that before the release.

Kind regards,
Petr

> > > The FAN_REPORT_PIDFD and FAN_REPORT_TID flags used to be mutually
> > > exclusive because by the time the pidfd support was introduced to
> > > fanotify, pidfds could only be created for thread group leaders. Now
> > > that the pidfd API supports thread-specific pidfds via PIDFD_THREAD,
> > > this restriction can be lifted.

> > > This patch allows listeners using FAN_REPORT_PIDFD | FAN_REPORT_TID
> > > to receive the pidfd referring to the thread that triggered the
> > > event.

> > > Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>

> > Regarding the legal standpoint, as far as I can tell, commit d4563201f33a0
> > ("Documentation: simplify and clarify DCO contribution example language")
> > explicitly allowed pseudonyms, so although unorthodox, this seems to be legit.

> > In any case, the contributing itself seems legit to me, so

> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> > But before merging this, AnonymeMeow, since it is your first contribution
> > to the Linux kernel (right?) as well as a "I am not a robot" challenge
> > I would like to first see that the tests have been dealt with.

> > The LTP test fanotify20 explicitly checks that this flag combination is not
> > allowed. Need to discuss an acceptable solution with LTP developers -
> > remove this check depending on kernel version or whatever they choose.

> > The LTP test fanotify21 tests the FAN_REPORT_PIDFD functionality.
> > Please add two new variants for REPORT_TID:
> >         .test_variants = 4,

> > #define TST_VARIANT_FD_ERROR (tst_variant & 1)
> > #define TST_VARIANT_PIDFD_THREAD (tst_variant & 2)

> > The existing checks if (tst_variant) become if (TST_VARIANT_FD_ERROR)
> > so bit 0 represents the FAN_REPORT_FD_ERROR variation.

> > in do_setup() need to use if (TST_VARIANT_PIDFD_THREAD)
> > to add FAN_REPORT_TID and to use PIDFD_THREAD for pidfd.

> > Follow the footsteps of fd_error_unsupported to skip the
> > TST_VARIANT_PIDFD_THREAD variants on kernels where the flag
> > combination is not supported.

> > Good luck,
> > Amir.

> Thanks for the helpful and detailed guidance on how to extend the tests!
> I've updated the test cases according to your suggestions.

> After applying my previous patch, the LTP fanotify20 test needs to probe
> whether the running kernel supports thread pidfd reporting. I didn't use
> kernel version check because the LTP documentation notes that kernel
> versions do not always correspond to a well-defined feature set due to
> distribution backports, and recommends runtime feature checks. I probe
> whether fanotify_init() succeeds with FAN_REPORT_PIDFD | FAN_REPORT_TID
> as a workaround. The first test case uses exactly the same flags, but it
> still verifies the return value and errno, so I am not sure whether this
> should be considered duplicate logic. I also added one test case that
> passes all relevant FAN_REPORT_* flags and verifies whether
> fanotify_init() behaves as expected. The expected result depends on the
> previous probe result.

> Also, I added one test case and two test variants to LTP test
> fanotify21. The new test case verifies that fanotify reports the correct
> pidfd for the event generated by a child process or a worker thread
> created by the main thread. This is especially useful for the thread
> pidfd test variants, because it checks that the pidfd reported by
> fanotify really refers to the event-generating thread rather than to
> the thread-group leader. The two new test variants extend the existing
> ones by adding the thread pidfd mode, as you suggested.

> I ran all fanotify-related LTP tests on both a vanilla Linux 7.1-rc5
> kernel and a Linux 7.1-rc5 kernel with my patch applied. Both kernels
> passed all the tests. They were both built with the config file from the
> official Arch Linux package repo. More specifically, both kernels passed
> all three test cases in fanotify20, with no skips. The test cases expect
> different results from the two kernels, which is the expected behavior.
> For fanotify21, the patched kernel passed all test cases in all test
> variants. On the unpatched kernel, all test cases passed for variants
> without TST_VARIANT_PIDFD_THREAD, while all test cases in variants with
> TST_VARIANT_PIDFD_THREAD were skipped, which is also the expected
> behavior.

> Again, thanks for the detailed guidance on this!

> With Best Regards,
> AnonymeMeow

> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
> ---
>  testcases/kernel/syscalls/fanotify/Makefile   |   2 +-
>  .../kernel/syscalls/fanotify/fanotify20.c     |  24 +-
>  .../kernel/syscalls/fanotify/fanotify21.c     | 224 +++++++++++++-----
>  3 files changed, 184 insertions(+), 66 deletions(-)

> diff --git a/testcases/kernel/syscalls/fanotify/Makefile b/testcases/kernel/syscalls/fanotify/Makefile
> index 3628094ba..b20bb50e9 100644
> --- a/testcases/kernel/syscalls/fanotify/Makefile
> +++ b/testcases/kernel/syscalls/fanotify/Makefile
> @@ -2,7 +2,7 @@
>  #  Copyright (c) Jan Kara <jack@suse.cz>, 2013

>  top_srcdir		?= ../../../..
> -fanotify11: CFLAGS+=-pthread
> +fanotify11 fanotify21: CFLAGS+=-pthread
>  include $(top_srcdir)/include/mk/testcases.mk

>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index b32ecf6aa..5d77b485c 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -28,19 +28,27 @@
>  #define FLAGS_DESC(x) .flags = x, .desc = #x

>  static int fd;
> +static int thread_pidfd_unsupported;

>  static struct test_case_t {
>  	unsigned int flags;
>  	char *desc;
>  	int exp_errno;
> +	unsigned int needs_thread_pidfd;
>  } test_cases[] = {
>  	{
>  		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID),
>  		.exp_errno = EINVAL,
> +		.needs_thread_pidfd = 1,
>  	},
>  	{
>  		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME),
>  	},
> +	{
> +		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID | FAN_REPORT_FID | FAN_REPORT_DFID_NAME),
> +		.exp_errno = EINVAL,
> +		.needs_thread_pidfd = 1,
> +	},
>  };

>  static void do_setup(void)
> @@ -51,17 +59,29 @@ static void do_setup(void)
>  	 */
>  	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_PIDFD,
>  						    MOUNT_PATH);
> +
> +	/*
> +	 * Check whether the kernel supports FAN_REPORT_PIDFD in combination
> +	 * with FAN_REPORT_TID. Test cases with the needs_thread_pidfd field
> +	 * set expect different errno values depending on whether this
> +	 * combination is supported.
> +	 */
> +	thread_pidfd_unsupported = fanotify_init_flags_supported_on_fs(
> +		FAN_REPORT_PIDFD | FAN_REPORT_TID, MOUNT_PATH);
>  }

>  static void do_test(unsigned int i)
>  {
>  	struct test_case_t *tc = &test_cases[i];

> -	tst_res(TINFO, "Test %s on %s", tc->exp_errno ? "fail" : "pass",
> +	int exp_errno = tc->needs_thread_pidfd && !thread_pidfd_unsupported ?
> +		0 : tc->exp_errno;
> +
> +	tst_res(TINFO, "Test %s on %s", exp_errno ? "fail" : "pass",
>  		tc->desc);

>  	TST_EXP_FD_OR_FAIL(fd = fanotify_init(tc->flags, O_RDONLY),
> -			   tc->exp_errno);
> +			   exp_errno);

>  	if (fd > 0)
>  		SAFE_CLOSE(fd);
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
> index 340fb0018..4629860da 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify21.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
> @@ -20,9 +20,11 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <sys/mount.h>
> +#include <pthread.h>
>  #include "tst_test.h"
>  #include "tst_safe_stdio.h"
>  #include "tst_safe_macros.h"
> +#include "tst_safe_pthread.h"
>  #include "lapi/pidfd.h"

>  #ifdef HAVE_SYS_FANOTIFY_H
> @@ -42,7 +44,7 @@ struct pidfd_fdinfo_t {

>  static struct test_case_t {
>  	char *name;
> -	int fork;
> +	int trigger_in_child;
>  	int want_pidfd_err;
>  	int remount_ro;
>  } test_cases[] = {
> @@ -52,6 +54,12 @@ static struct test_case_t {
>  		0,
>  		0,
>  	},
> +	{
> +		"return a valid pidfd for event created by child",
> +		1,
> +		0,
> +		0,
> +	},
>  	{
>  		"return invalid pidfd for event created by terminated child",
>  		1,
> @@ -68,16 +76,17 @@ static struct test_case_t {

>  static int fanotify_fd;
>  static char event_buf[BUF_SZ];
> -static struct pidfd_fdinfo_t *self_pidfd_fdinfo;
> +static struct pidfd_fdinfo_t expected_pidfd_fdinfo;

>  static int fd_error_unsupported;
> +static int thread_pidfd_unsupported;
> +
> +#define TST_VARIANT_FD_ERROR (tst_variant & 1)
> +#define TST_VARIANT_PIDFD_THREAD (tst_variant & 2)

> -static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
> +static void read_pidfd_fdinfo(int pidfd, struct pidfd_fdinfo_t *pidfd_fdinfo)
>  {
>  	char *fdinfo_path;
> -	struct pidfd_fdinfo_t *pidfd_fdinfo;
> -
> -	pidfd_fdinfo = SAFE_MALLOC(sizeof(struct pidfd_fdinfo_t));

>  	SAFE_ASPRINTF(&fdinfo_path, "/proc/self/fdinfo/%d", pidfd);
>  	SAFE_FILE_LINES_SCANF(fdinfo_path, "pos: %d", &pidfd_fdinfo->pos);
> @@ -87,8 +96,6 @@ static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
>  	SAFE_FILE_LINES_SCANF(fdinfo_path, "NSpid: %d", &pidfd_fdinfo->ns_pid);

>  	free(fdinfo_path);
> -
> -	return pidfd_fdinfo;
>  }

>  static void generate_event(void)
> @@ -100,30 +107,91 @@ static void generate_event(void)
>  	SAFE_CLOSE(fd);
>  }

> -static void do_fork(void)
> +static pid_t do_fork(int want_pidfd_err)
>  {
> -	int status;
> +	int pidfd;
>  	pid_t child;

>  	child = SAFE_FORK();
>  	if (child == 0) {
>  		SAFE_CLOSE(fanotify_fd);
>  		generate_event();
> +		TST_CHECKPOINT_WAIT(0);
>  		exit(EXIT_SUCCESS);
>  	}

> -	SAFE_WAITPID(child, &status, 0);
> -	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> -		tst_brk(TBROK,
> -			"child process terminated incorrectly");
> +	pidfd = SAFE_PIDFD_OPEN(child, 0);
> +	read_pidfd_fdinfo(pidfd, &expected_pidfd_fdinfo);
> +	SAFE_CLOSE(pidfd);
> +
> +	if (want_pidfd_err) {
> +		int status;
> +		TST_CHECKPOINT_WAKE(0);
> +		SAFE_WAITPID(child, &status, 0);
> +		if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> +			tst_brk(TBROK, "child process terminated incorrectly");
> +		
> +		return -1;
> +	}
> +
> +	return child;
>  }

> -static void do_setup(void)
> +static void *thread_generate_event(void *arg)
> +{
> +	*(int *)arg = SAFE_PIDFD_OPEN(gettid(), PIDFD_THREAD);
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	generate_event();
> +	TST_CHECKPOINT_WAIT(0);
> +	pthread_exit(0);
> +}
> +
> +static pthread_t do_pthread_create(int want_pidfd_err)
>  {
>  	int pidfd;
> +	pthread_t worker;
> +
> +	SAFE_PTHREAD_CREATE(&worker, NULL, thread_generate_event, &pidfd);
> +
> +	TST_CHECKPOINT_WAIT(0);
> +	read_pidfd_fdinfo(pidfd, &expected_pidfd_fdinfo);
> +
> +	if (want_pidfd_err) {
> +		int status;
> +		struct pidfd_fdinfo_t thread_pidfd_fdinfo;
> +		TST_CHECKPOINT_WAKE(0);
> +		SAFE_PTHREAD_JOIN(worker, (void **)&status);
> +		if (status != 0)
> +			tst_brk(TBROK, "worker thread terminated incorrectly");
> +
> +		/*
> +		 * Unlike waitpid(), pthread_join() only waits until the worker thread
> +		 * has exited from the pthread point of view. The thread may still be
> +		 * visible through its pidfd for a short time afterwards, and fanotify
> +		 * creates the event pidfd when the event is read. Wait until the
> +		 * worker pidfd fdinfo reports Pid: -1 before reading the event so
> +		 * that fanotify reports ESRCH/FAN_NOPIDFD instead of a pidfd.
> +		 */
> +		do {
> +			read_pidfd_fdinfo(pidfd, &thread_pidfd_fdinfo);
> +		} while (thread_pidfd_fdinfo.pid != -1);
> +
> +		SAFE_CLOSE(pidfd);
> +
> +		return -1;
> +	}
> +
> +	SAFE_CLOSE(pidfd);
> +
> +	return worker;
> +}
> +
> +static void do_setup(void)
> +{
>  	int init_flags = FAN_REPORT_PIDFD;

> -	if (tst_variant) {
> +	if (TST_VARIANT_FD_ERROR) {
>  		fanotify_fd = -1;
>  		fd_error_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FD_ERROR, ".");
>  		if (fd_error_unsupported)
> @@ -131,6 +199,15 @@ static void do_setup(void)
>  		init_flags |= FAN_REPORT_FD_ERROR;
>  	}

> +	if (TST_VARIANT_PIDFD_THREAD) {
> +		fanotify_fd = -1;
> +		thread_pidfd_unsupported = fanotify_init_flags_supported_on_fs(
> +			FAN_REPORT_PIDFD | FAN_REPORT_TID, ".");
> +		if (thread_pidfd_unsupported)
> +			return;
> +		init_flags |= FAN_REPORT_TID;
> +	}
> +
>  	SAFE_TOUCH(TEST_FILE, 0666, NULL);

>  	/*
> @@ -144,15 +221,6 @@ static void do_setup(void)
>  	fanotify_fd = SAFE_FANOTIFY_INIT(init_flags, O_RDWR);
>  	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD,
>  			   TEST_FILE);
> -
> -	pidfd = SAFE_PIDFD_OPEN(getpid(), 0);
> -
> -	self_pidfd_fdinfo = read_pidfd_fdinfo(pidfd);
> -	if (self_pidfd_fdinfo == NULL) {
> -		tst_brk(TBROK,
> -			"pidfd=%d, failed to read pidfd fdinfo",
> -			pidfd);
> -	}
>  }

>  static void do_test(unsigned int num)
> @@ -160,17 +228,29 @@ static void do_test(unsigned int num)
>  	int i = 0, len;
>  	struct test_case_t *tc = &test_cases[num];
>  	int nopidfd_err = tc->want_pidfd_err ?
> -			  (tst_variant ? -ESRCH : FAN_NOPIDFD) : 0;
> -	int fd_err = (tc->remount_ro && tst_variant) ? -EROFS : 0;
> +			  (TST_VARIANT_FD_ERROR ? -ESRCH : FAN_NOPIDFD) : 0;
> +	int fd_err = (tc->remount_ro && TST_VARIANT_FD_ERROR) ? -EROFS : 0;
> +	union {
> +		pid_t pid;
> +		pthread_t pthread_id;
> +	} worker_id;

>  	tst_res(TINFO, "Test #%d.%d: %s %s", num, tst_variant, tc->name,
> -			tst_variant ? "(FAN_REPORT_FD_ERROR)" : "");
> +		TST_VARIANT_FD_ERROR ? (TST_VARIANT_PIDFD_THREAD ?
> +			"(FAN_REPORT_FD_ERROR, FAN_REPORT_TID)" : "(FAN_REPORT_FD_ERROR)") :
> +			(TST_VARIANT_PIDFD_THREAD ? "(FAN_REPORT_TID)" : ""));

> -	if (fd_error_unsupported && tst_variant) {
> +	if (fd_error_unsupported && TST_VARIANT_FD_ERROR) {
>  		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_FD_ERROR, fd_error_unsupported);
>  		return;
>  	}

> +	if (thread_pidfd_unsupported && TST_VARIANT_PIDFD_THREAD) {
> +		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_PIDFD | FAN_REPORT_TID,
> +				thread_pidfd_unsupported);
> +		return;
> +	}
> +
>  	if (tc->remount_ro) {
>  		/* SAFE_MOUNT fails to remount FUSE */
>  		if (mount(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
> @@ -182,14 +262,30 @@ static void do_test(unsigned int num)
>  	}

>  	/*
> -	 * Generate the event in either self or a child process. Event
> -	 * generation in a child process is done so that the FAN_NOPIDFD case
> -	 * can be verified.
> +	 * Generate the event either in the current task or in another task.
> +	 * When trigger_in_child is set, the event can be generated by either
> +	 * a child process or a worker thread depending on the test variant.
> +	 * The want_pidfd_err field determines whether the event-generating
> +	 * task is still valid when the event is read.
>  	 */
> -	if (tc->fork)
> -		do_fork();
> -	else
> +	if (tc->trigger_in_child) {
> +		if (TST_VARIANT_PIDFD_THREAD)
> +			worker_id.pthread_id = do_pthread_create(tc->want_pidfd_err);
> +		else
> +			worker_id.pid = do_fork(tc->want_pidfd_err);
> +	} else {
> +		/*
> +		 * Although the expected pid and the pid reported by fanotify are
> +		 * the same in this case, pidfds created with and without PIDFD_THREAD
> +		 * flag have different fdinfo flags. Use PIDFD_THREAD for the expected
> +		 * pidfd fdinfo so that the fdinfo can be compared bitwise.
> +		 */
> +		int pidfd = SAFE_PIDFD_OPEN(gettid(), TST_VARIANT_PIDFD_THREAD ? PIDFD_THREAD : 0);
> +		read_pidfd_fdinfo(pidfd, &expected_pidfd_fdinfo);
> +		SAFE_CLOSE(pidfd);
> +
>  		generate_event();
> +	}

>  	/*
>  	 * Read all of the queued events into the provided event
> @@ -208,7 +304,7 @@ static void do_test(unsigned int num)
>  	while (i < len) {
>  		struct fanotify_event_metadata *event;
>  		struct fanotify_event_info_pidfd *info;
> -		struct pidfd_fdinfo_t *event_pidfd_fdinfo = NULL;
> +		struct pidfd_fdinfo_t event_pidfd_fdinfo;

>  		event = (struct fanotify_event_metadata *)&event_buf[i];
>  		info = (struct fanotify_event_info_pidfd *)(event + 1);
> @@ -288,39 +384,32 @@ static void do_test(unsigned int num)
>  		 * No pidfd errors occurred, continue with verifying pidfd
>  		 * fdinfo validity.
>  		 */
> -		event_pidfd_fdinfo = read_pidfd_fdinfo(info->pidfd);
> -		if (event_pidfd_fdinfo == NULL) {
> -			tst_brk(TBROK,
> -				"reading fdinfo for pidfd: %d "
> -				"describing pid: %u failed",
> -				info->pidfd,
> -				(unsigned int)event->pid);
> -			goto next_event;
> -		} else if (event_pidfd_fdinfo->pid != event->pid) {
> +		read_pidfd_fdinfo(info->pidfd, &event_pidfd_fdinfo);
> +		if (event_pidfd_fdinfo.pid != event->pid) {
>  			tst_res(TFAIL,
>  				"pidfd provided for incorrect pid "
>  				"(expected pidfd for pid: %u, got pidfd for "
>  				"pid: %u)",
>  				(unsigned int)event->pid,
> -				(unsigned int)event_pidfd_fdinfo->pid);
> +				(unsigned int)event_pidfd_fdinfo.pid);
>  			goto next_event;
> -		} else if (memcmp(event_pidfd_fdinfo, self_pidfd_fdinfo,
> +		} else if (memcmp(&event_pidfd_fdinfo, &expected_pidfd_fdinfo,
>  				  sizeof(struct pidfd_fdinfo_t))) {
>  			tst_res(TFAIL,
>  				"pidfd fdinfo values for self and event differ "
>  				"(expected pos: %d, flags: %x, mnt_id: %d, "
>  				"pid: %d, ns_pid: %d, got pos: %d, "
>  				"flags: %x, mnt_id: %d, pid: %d, ns_pid: %d",
> -				self_pidfd_fdinfo->pos,
> -				self_pidfd_fdinfo->flags,
> -				self_pidfd_fdinfo->mnt_id,
> -				self_pidfd_fdinfo->pid,
> -				self_pidfd_fdinfo->ns_pid,
> -				event_pidfd_fdinfo->pos,
> -				event_pidfd_fdinfo->flags,
> -				event_pidfd_fdinfo->mnt_id,
> -				event_pidfd_fdinfo->pid,
> -				event_pidfd_fdinfo->ns_pid);
> +				expected_pidfd_fdinfo.pos,
> +				expected_pidfd_fdinfo.flags,
> +				expected_pidfd_fdinfo.mnt_id,
> +				expected_pidfd_fdinfo.pid,
> +				expected_pidfd_fdinfo.ns_pid,
> +				event_pidfd_fdinfo.pos,
> +				event_pidfd_fdinfo.flags,
> +				event_pidfd_fdinfo.mnt_id,
> +				event_pidfd_fdinfo.pid,
> +				event_pidfd_fdinfo.ns_pid);
>  			goto next_event;
>  		} else {
>  			tst_res(TPASS,
> @@ -342,9 +431,20 @@ next_event:

>  		if (info && info->pidfd >= 0)
>  			SAFE_CLOSE(info->pidfd);
> +	}

> -		if (event_pidfd_fdinfo)
> -			free(event_pidfd_fdinfo);
> +	if (tc->trigger_in_child && !tc->want_pidfd_err) {
> +		int status;
> +		TST_CHECKPOINT_WAKE(0);
> +		if (TST_VARIANT_PIDFD_THREAD) {
> +			SAFE_PTHREAD_JOIN(worker_id.pthread_id, (void **)&status);
> +			if (status != 0)
> +				tst_brk(TBROK, "worker thread terminated incorrectly");
> +		} else {
> +			SAFE_WAITPID(worker_id.pid, &status, 0);
> +			if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> +				tst_brk(TBROK, "child process terminated incorrectly");
> +		}
>  	}
>  }

> @@ -352,19 +452,17 @@ static void do_cleanup(void)
>  {
>  	if (fanotify_fd >= 0)
>  		SAFE_CLOSE(fanotify_fd);
> -
> -	if (self_pidfd_fdinfo)
> -		free(self_pidfd_fdinfo);
>  }

>  static struct tst_test test = {
>  	.setup = do_setup,
>  	.test = do_test,
>  	.tcnt = ARRAY_SIZE(test_cases),
> -	.test_variants = 2,
> +	.test_variants = 4,
>  	.cleanup = do_cleanup,
>  	.all_filesystems = 1,
>  	.needs_root = 1,
> +	.needs_checkpoints = 1,
>  	.mount_device = 1,
>  	.mntpoint = MOUNT_PATH,
>  	.forks_child = 1,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
