Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3865C3DA4A
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 16:58:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6F4B3D1F35
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 18:58:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0642D3D1ECE
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 18:58:00 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 01E151A00E0A
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 18:57:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1235D21A03;
 Thu,  1 Aug 2024 16:57:56 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAD2013946;
 Thu,  1 Aug 2024 16:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VSpgLJO+q2aELgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 01 Aug 2024 16:57:55 +0000
Date: Thu, 1 Aug 2024 18:57:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240801165756.GA1526142@pevik>
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1235D21A03
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/5] Add fchmodat2 testing suite
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
Cc: Christian Brauner <brauner@kernel.org>,
 =?iso-8859-2?Q?Ga=EBl?= PORTAY <gael.portay@rtone.fr>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
 Alexey Gladkov <legion@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> This is a patch-set that implements fchmodat2() syscall coverage.
> fchmodat2() has been added in kernel 6.6 in order to support
> AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH in fchmodat().
> There's no man pages yet, so please take the following links as
> main documentation along with kernel source code:

I would hope that it'd be at least Christian's fork [1], but it's not there.
I suppose nobody is working on the man page.

> https://www.phoronix.com/news/fchmodat2-For-Linux-6.6
> https://lore.kernel.org/lkml/20230824-frohlocken-vorabend-725f6fdaad50@brauner/

> ***********
> * WARNING *
> ***********

> fchmodat2_02 fails with EOPNOTSUPP because of missing feature.

For a record, it's fchmodat2_01.c (from this patchset) which is failing (on
6.10.1-1.g4c78d6f-default Tumbleweed and 6.6.21-0-lts Alpine, both x86_64 VMs).

Andrea, I would personally just skip test on EOPNOTSUPP (that's what we do in
LTP on EOPNOTSUPP). The question why is not supported and whether is going to be
fixed.

Looking into glibc change 65341f7bbe ("linux: Use fchmodat2 on fchmod for flags
different than 0 (BZ 26401)") one year old change from glibc-2.39 [2] it looks
just accepted behavior (glibc returns EOPNOTSUPP on symlink):

+  /* Some Linux versions with some file systems can actually
+     change symbolic link permissions via /proc, but this is not
+     intentional, and it gives inconsistent results (e.g., error
+     return despite mode change).  The expected behavior is that
+     symbolic link modes cannot be changed at all, and this check
+     enforces that.  */
+  if (S_ISLNK (st.st_mode))
+    {
       __close_nocancel (pathfd);
-      return ret;
+      __set_errno (EOPNOTSUPP);
+      return -1;
+    }

Also musl also behaves the same on his fallback on old kernels [3]
(it started 10 years ago on 0dc48244 ("work around linux's lack of flags
argument to fchmodat syscall") when SYS_fchmodat was used and kept when this
year SYS_fchmodat2 started to be used in d0ed307e):

	int ret = __syscall(SYS_fchmodat2, fd, path, mode, flag);
	if (ret != -ENOSYS) return __syscall_ret(ret);

	if (flag != AT_SYMLINK_NOFOLLOW)
		return __syscall_ret(-EINVAL);

	struct stat st;
	int fd2;
	char proc[15+3*sizeof(int)];

	if (fstatat(fd, path, &st, flag))
		return -1;
	if (S_ISLNK(st.st_mode))
		return __syscall_ret(-EOPNOTSUPP);


> According to documentation, the feature has been implemented in
> kernel 6.6, but __in reality__ AT_SYMLINK_NOFOLLOW is not working
> on symbolic files. Also kselftests, which are meant to test the
> functionality, are not working and they are treating fchmodat2()
> syscall failure as SKIP. Please take a look at the following code
> before reviewing:

> https://github.com/torvalds/linux/blob/8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6/tools/testing/selftests/fchmodat2/fchmodat2_test.c#L123

I see there is a kselftest workaround in 4859c257d295 ("selftests: Add fchmodat2
selftest") [4], where fchmodat2 failure on symlink is simply skipped.

Aleksa, you're probably aware of this fchmodat2() failure on symlinks. Does
anybody work or plan to work on fixing it? LTP has policy to not cover kernel
bugs, if it's not expected to be working we might just skip the test as well.

I see a RFC UAPI related patchset [5] which touches include/uapi/linux/fcntl.h,
but AFAIK it's not related to this problem.

Kind regards,
Petr

[1] https://github.com/brauner/man-pages-md
[2] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=65341f7bbea824d2ff9d37db15d8be162df42bd3;hp=c52c2c32db15aba8bbe1a0b4d3235f97d9c1a525
[3] https://git.musl-libc.org/cgit/musl/tree/src/stat/fchmodat.c
[4] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/tools/testing/selftests/fchmodat2/fchmodat2_test.c?h=next-20240801&id=4859c257d295949c23f4074850a8c2ec31357abb
[5] https://lore.kernel.org/lkml/20240801-exportfs-u64-mount-id-v3-0-be5d6283144a@cyphar.com/

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v4:
> - add SAFE_FCHMODAT2
> - Link to v3: https://lore.kernel.org/r/20240724-fchmodat2-v3-0-1dc7cfc634b8@suse.com

> Changes in v3:
> - removed fchmodat2.h
> - Link to v2: https://lore.kernel.org/r/20240723-fchmodat2-v2-0-e658a98b113e@suse.com

> Changes in v2:
> - merge first 3 tests into a unique one
> - move fchmodat2 in lapi/stat.h
> - add test for error checking
> - Link to v1: https://lore.kernel.org/r/20240521-fchmodat2-v1-0-191b4a986202@suse.com

> ---
> Andrea Cervesato (5):
>       Add SAFE_SYMLINKAT macro
>       Add fchmodat2 syscalls definitions
>       Add fchmodat2 fallback definition
>       Add fchmodat2_01 test
>       Add fchmodat2_02 test

>  include/lapi/stat.h                                |  16 +++
>  include/lapi/syscalls/aarch64.in                   |   1 +
>  include/lapi/syscalls/arc.in                       |   1 +
>  include/lapi/syscalls/arm.in                       |   1 +
>  include/lapi/syscalls/hppa.in                      |   1 +
>  include/lapi/syscalls/i386.in                      |   1 +
>  include/lapi/syscalls/ia64.in                      |   1 +
>  include/lapi/syscalls/loongarch.in                 |   1 +
>  include/lapi/syscalls/mips_n32.in                  |   1 +
>  include/lapi/syscalls/mips_n64.in                  |   1 +
>  include/lapi/syscalls/mips_o32.in                  |   1 +
>  include/lapi/syscalls/powerpc.in                   |   1 +
>  include/lapi/syscalls/powerpc64.in                 |   1 +
>  include/lapi/syscalls/s390.in                      |   1 +
>  include/lapi/syscalls/s390x.in                     |   1 +
>  include/lapi/syscalls/sh.in                        |   1 +
>  include/lapi/syscalls/sparc.in                     |   1 +
>  include/lapi/syscalls/sparc64.in                   |   1 +
>  include/lapi/syscalls/x86_64.in                    |   1 +
>  include/safe_macros_fn.h                           |   4 +
>  include/tst_safe_macros.h                          |   3 +
>  lib/safe_macros.c                                  |  20 ++++
>  runtest/syscalls                                   |   3 +
>  testcases/kernel/syscalls/fchmodat2/.gitignore     |   2 +
>  testcases/kernel/syscalls/fchmodat2/Makefile       |   7 ++
>  testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c | 114 +++++++++++++++++++++
>  testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c |  68 ++++++++++++
>  27 files changed, 255 insertions(+)
> ---
> base-commit: 8422d4680b21e6576da63c677b5d49f46b477df0
> change-id: 20240517-fchmodat2-5b82867d71fc

> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
