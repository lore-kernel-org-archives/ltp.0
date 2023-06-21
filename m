Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0A0EB64D7
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 09:03:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6345B3CCD25
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 11:03:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D6F23C9BB9
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 11:03:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 074ED6007B9
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 11:03:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9386C1F8CC;
 Wed, 21 Jun 2023 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687338212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qkx49Qli4ftTjFBs+tiKWKmndtUGNmq+NWlTBjgNHXU=;
 b=Q57y8kK2NR7ESA54Q5bazeXsaSp9afWgRgiHL0ntIIgo24+sQYKOs039jiFV6OOkWrWgOP
 W1a1lXWCwk4yuDH8xNhrJq8G5+uTERhbpHuyQ26L/qrBHUmzA7RhCgs9DUOP38S5Qu72ag
 RFY83FyLFJIonHhFpamlFK11BbgRlPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687338212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qkx49Qli4ftTjFBs+tiKWKmndtUGNmq+NWlTBjgNHXU=;
 b=5bMVg1fZLE5Vun7ESSCJSEWshGeGsDtJxc1lhzK76ONihn4jaTDnpLxOb46ImRqdjYR3gf
 Tqf3UhwNzcxJA+DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7612A134B1;
 Wed, 21 Jun 2023 09:03:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id l+TVGuS8kmSSZAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 21 Jun 2023 09:03:32 +0000
Date: Wed, 21 Jun 2023 11:03:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alexander Aring <aahringo@redhat.com>
Message-ID: <20230621090331.GA365741@pevik>
References: <20230530203707.2965684-1-aahringo@redhat.com>
 <20230530203707.2965684-2-aahringo@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230530203707.2965684-2-aahringo@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] fcntl40: test for owner values on classic
 posix lock
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Alexander,

> This patch adds fcntl40 to test similar owner values for classical owner
> locks. There was an issue been found in the gfs2 filesystem because
> there can be collisions with identical owner values.

Thanks for your work!

...
> +++ b/testcases/kernel/syscalls/fcntl/fcntl40.c
> @@ -0,0 +1,188 @@
There is no SPDX and copyright, see other files:

// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (c) 2023 ...
 */

> +/*
NOTE: this should be /*\
to be able to get the description in our automatically generated documentation

https://github.com/linux-test-project/ltp/releases/download/20230516/metadata.20230516.html

> + * [Description]
> + * Tests gfs2 dlm posix op queue handling in the kernel.
> + * It is recommended to run watch -n 0.1 "dlm_tool plocks $LS"
> + * aside to monitor dlm plock handling.
> + *
> + * [How to use it]
> + * Call it with TMPDIR=/mnt ./fcntl40 where TMPDIR is a gfs2 mountpoint.
I wonder if we could check for GFS2_MAGIC (we'd need to add it to
include/tst_fs.h => 0x01161970) and quit the test with tst_brk(TCONF) if TMPDIR
is not on gfs2.

ATM we don't have any helper in struct tst_test, which would do it.

> + * Try it on other filesystems to compare results.
> + *
> + * [What's it doing]
nit: I'd replace this with [Algorithm].

...
> +void do_child(void)
This should be static (in all files).

make check (or make check-fcntl40) is your friend.

> +{
> +	pthread_t t1, t2;
> +
> +	SAFE_PTHREAD_CREATE(&t1, NULL, do_thread1, NULL);
> +	SAFE_PTHREAD_CREATE(&t2, NULL, do_thread2, NULL);
> +
> +	SAFE_PTHREAD_JOIN(t1, NULL);
> +	SAFE_PTHREAD_JOIN(t2, NULL);
> +
> +	tst_res(TPASS, "Child passed!");
> +}
> +
> +void do_parent(void)
This should also be static.

> +{
> +	struct flock fl = {
> +		.l_whence = SEEK_SET,
> +	};
> +
> +	/* wait for 1 seconds so thread2 lock 1-1 tries to acquires at first
> +	 * than thread1 lock 0-0 tries to acquired to have a specific waiting
> +	 * order in dlm posix handling.
> +	 */
> +	sleep(1);

I wonder if there could be some proactive check instead of sleep.
FYI we have undocumented TST_RETRY_FUNC() in C API.

> +	/* tell thread2 to call SETLKW for lock 0-0 */
> +	TST_CHECKPOINT_WAKE(1);
> +	/* wait 3 seconds for thread 1 and 2 being in waiting state */
> +	sleep(3);
> +
> +	/* unlock 0-1, should be successful */
> +	fl.l_type = F_UNLCK;
> +	fl.l_start = 1;
> +	fl.l_len = 1;
> +	tst_res(TINFO, "unlock region 1-1 thread2");
> +	SAFE_FCNTL(fd, F_SETLK, &fl);
> +
> +	/* wait until thread 2 got acquired and leave waiting */
> +	TST_CHECKPOINT_WAIT(2);
> +
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +	fl.l_type = F_UNLCK;
> +	tst_res(TINFO, "unlock region 0-0 thread2");
> +	SAFE_FCNTL(fd, F_SETLK, &fl);
> +}
> +
> +static void fcntl40_test(void)
> +{
> +	struct flock fl = {
> +		.l_type = F_WRLCK,
> +		.l_whence = SEEK_SET,
> +		.l_start = 0L,
> +		.l_len = 2L,
> +	};
> +	pid_t pid;
> +
> +	tst_res(TINFO, "parent lock region 0-1 - should be successful");
> +	SAFE_FCNTL(fd, F_SETLK, &fl);
> +	tst_res(TINFO, "parent region 0-1 locked");
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		do_child();
> +		return;
> +	}
> +
> +	do_parent();
> +	wait(NULL);

waitpid() should be replaced by tst_reap_children(), see
https://github.com/linux-test-project/ltp/wiki/C-Test-API#18-doing-the-test-in-the-child-process

> +
> +	tst_res(TPASS, "Parent passed!");
There is TPASS in child, does it really need to be in the parent as well?
> +}
> +
> +static void setup(void)
> +{
> +	fd = SAFE_OPEN("filename", O_RDWR | O_CREAT, 0700);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > -1)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.test_all = fcntl40_test,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
