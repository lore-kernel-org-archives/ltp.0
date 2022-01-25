Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51823C433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 10:29:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04BB33C953A
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 11:28:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C25B63C54C9
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 11:28:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DA71660085C
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 11:28:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E03FD2198B;
 Tue, 25 Jan 2022 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643106527;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xh3qLUxaZ32wp4dvnE/DxP7zY1cjpEvEdIM0v92270E=;
 b=heVPqSMN7YuBqA19WFf/MkLIojvjdcMGr6QJ0j3DCmCoknbVbCnYMIvBAbyUvB+XuHdifd
 WNp+f32o/ny8t42/vMUvbNBybeIlhOg7if1gnRtpFNZmcbj2xHBu9PpwDKnaWTvYtkbpRg
 ZBeCDFyZ2W5tdc879gWT5TVQDOnpD7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643106527;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xh3qLUxaZ32wp4dvnE/DxP7zY1cjpEvEdIM0v92270E=;
 b=3zjHhys3MkSoDePIaFsisFs+Y1O5sGdfjQa7CbS/15u7ltv7cNlDsLzp5hlvYJFjWRZ/Sc
 fcYiN3ZsIXEDoTAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B60E13DB5;
 Tue, 25 Jan 2022 10:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZgGnHN/Q72F4aAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Jan 2022 10:28:47 +0000
Date: Tue, 25 Jan 2022 11:28:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Murphy Zhou <jencce.kernel@gmail.com>
Message-ID: <Ye/Q3fUheO3mbbRj@pevik>
References: <20220125024718.jszwoussimqk6trf@xzhoux.usersys.redhat.com>
 <CAOQ4uxh4b-sPZqt4MMDFHWZVfJCp5ZAF=N-c-k-0mhzOyxLE_w@mail.gmail.com>
 <20220125083049.3b6v2tbv33sgrjoc@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220125083049.3b6v2tbv33sgrjoc@xzhoux.usersys.redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] kernel/fs/fs-notify: fsnotify stress tests
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Murphy, Amir,

Amir, thanks a lot for your review, comments.

> Hi Amir,

> On Tue, Jan 25, 2022 at 09:29:47AM +0200, Amir Goldstein wrote:
> > On Tue, Jan 25, 2022 at 4:47 AM Murphy Zhou <jencce.kernel@gmail.com> wrote:

> > > Exercise fsnotify and inotify interfaces while IO going on.

> > Hi Murphy,

> > It's worth documenting in main test script that this test
> > was created as a regression test for commit
> > 4396a73115fc fsnotify: fix sb_connectors leak

> Ah, the tests were created for the goal of stress test. This leak
> was one of the bugs that this test found.
But still, it can be worth to mention it for affected systems without this bug
(v5.14?).

> > Can you elaborate a bit more about the expectation from this test.
> > I do not see any error checking in the main script.

> Sure. Will explain more.

> > Is any perror supposed to fail the test?

> No.

> > Is its purpose to catch kernel dmesg splats of all sorts?

> Not needed.

> My intend is to use these interfaces insanely a while, if kernel 
> does not panic or hang, pass. This test is not checking *notify
> function which has already been covered.

FYI for hitting a race conditions we have fuzzy sync library, it can reduce
running time a lot specially for two race windows (I see you use 2x infinite loop)
https://github.com/linux-test-project/ltp/wiki/C-Test-API#133-reproducing-race-conditions


> > In your original post you wrote that bug makes the test hang:
> > https://lore.kernel.org/linux-fsdevel/20210907063338.ycaw6wvhzrfsfdlp@xzhoux.usersys.redhat.com/

> > If that is the case, better mention this to the LTP maintainers.
+1, helps to understand the context.


Few general notes for porting reproducer to LTP. Takes time, but the result is
support for wide range of kernel versions and different user space (including
different init systems, test are used also on AOSP).
Maybe quite a lot of new things, thus don't hesitate to ask for help.

1) using C API (tst_test.h) helps to have more compact code
i.e. instead of
fd = open(argv[1], O_RDWR);
	if (fd == -1) {
		perror("writefile open");
		exit(EXIT_FAILURE);
	}
	ret = write(fd, buf, BUFSIZ);
	if (ret == -1)
		perror("writefile write");
	usleep(1);

you can have just 2 lines:

fd = SAFE_OPEN(argv[1], O_RDWR);
SAFE_WRITE(fd, buf, BUFSIZ);

See
https://github.com/linux-test-project/ltp/wiki/C-Test-API

2) shell must be POSIX compliant (some systems use other shells e.g. dash), i.e.
no bashisms (e.g. function, pushd, popd).
And for sure no /bin/bash, but /bin/sh

and use LTP shell API (tst_test.sh)

See
https://github.com/linux-test-project/ltp/wiki/Shell-Test-API

fsnotify-stress.sh looks like a custom runner, please don't reinvent a wheel.
We have in the API support for timeout, temporary directories etc.

Also I'd write only necessary minimum in shell (C is much more portable than
shell, also C does not bring unnecessary userspace dependencies).
C API has many helper, you don't have to write things from scratch.

3) make check
You can use make check in testcases/kernel/fs/fs-notify/ directory to
see common C and shell errors.

Below is the output for current code.

Kind regards,
Petr

CHECK testcases/kernel/fs/fs-notify/fanotify_flush_stress.c
fanotify_flush_stress.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
make: [../../../../include/mk/rules.mk:48: check-fanotify_flush_stress] Error 1 (ignored)
CHECK testcases/kernel/fs/fs-notify/fanotify_init_stress.c
fanotify_init_stress.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
fanotify_init_stress.c:13: WARNING: Missing a blank line after declarations
make: [../../../../include/mk/rules.mk:48: check-fanotify_init_stress] Error 1 (ignored)
CHECK testcases/kernel/fs/fs-notify/fanotify_mark_stress.c
fanotify_mark_stress.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
make: [../../../../include/mk/rules.mk:48: check-fanotify_mark_stress] Error 1 (ignored)
fanotify_mark_stress.c:12:6: warning: Symbol 'add_mark' has no prototype or library ('tst_') prefix. Should it be static?
fanotify_mark_stress.c:18:6: warning: Symbol 'remove_mark' has no prototype or library ('tst_') prefix. Should it be static?
CHECK testcases/kernel/fs/fs-notify/fanotify_watch.c
fanotify_watch.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
fanotify_watch.c:15: ERROR: "foo * bar" should be "foo *bar"
fanotify_watch.c:17: ERROR: "foo * bar" should be "foo *bar"
fanotify_watch.c:18: ERROR: "foo * bar" should be "foo *bar"
fanotify_watch.c:60: ERROR: space required before the open parenthesis '('
fanotify_watch.c:88: WARNING: Block comments use * on subsequent lines
fanotify_watch.c:89: WARNING: Block comments use a trailing */ on a separate line
fanotify_watch.c:175: WARNING: Consider removing the code enclosed by this #if 0 and its #endif
fanotify_watch.c:199: WARNING: Block comments use * on subsequent lines
fanotify_watch.c:201: WARNING: Block comments use a trailing */ on a separate line
make: [../../../../include/mk/rules.mk:48: check-fanotify_watch] Error 1 (ignored)
CHECK testcases/kernel/fs/fs-notify/freadfile.c
freadfile.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
freadfile.c:16: ERROR: space required before the open parenthesis '('
make: [../../../../include/mk/rules.mk:48: check-freadfile] Error 1 (ignored)
CHECK testcases/kernel/fs/fs-notify/fwritefile.c
fwritefile.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
fwritefile.c:16: ERROR: space required before the open parenthesis '('
make: [../../../../include/mk/rules.mk:48: check-fwritefile] Error 1 (ignored)
CHECK testcases/kernel/fs/fs-notify/inotify_add_rm_stress.c
inotify_add_rm_stress.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
make: [../../../../include/mk/rules.mk:48: check-inotify_add_rm_stress] Error 1 (ignored)
CHECK testcases/kernel/fs/fs-notify/inotify_init_stress.c
inotify_init_stress.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
make: [../../../../include/mk/rules.mk:48: check-inotify_init_stress] Error 1 (ignored)
CHECK testcases/kernel/fs/fs-notify/inotify_inmodify_stress.c
inotify_inmodify_stress.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
inotify_inmodify_stress.c:11: WARNING: Missing a blank line after declarations
inotify_inmodify_stress.c:13: WARNING: Missing a blank line after declarations
make: [../../../../include/mk/rules.mk:48: check-inotify_inmodify_stress] Error 1 (ignored)
CHECK testcases/kernel/fs/fs-notify/inotify_watch.c
inotify_watch.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
inotify_watch.c:47: WARNING: Missing a blank line after declarations
make: [../../../../include/mk/rules.mk:48: check-inotify_watch] Error 1 (ignored)
CHECK testcases/kernel/fs/fs-notify/readfile.c
readfile.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
make: [../../../../include/mk/rules.mk:48: check-readfile] Error 1 (ignored)
CHECK testcases/kernel/fs/fs-notify/writefile.c
writefile.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
make: [../../../../include/mk/rules.mk:48: check-writefile] Error 1 (ignored)
CHECK testcases/kernel/fs/fs-notify/fsnotify-stress.sh
possible bashism in fsnotify-stress.sh line 13 ('function' is useless):
function cleanup_processes()
possible bashism in fsnotify-stress.sh line 22 ('function' is useless):
function cleanup()
possible bashism in fsnotify-stress.sh line 31 ('function' is useless):
function run_stress()
possible bashism in fsnotify-stress.sh line 34 (echo -e):
	echo -e "* CPU count: $NR_CPUS"
possible bashism in fsnotify-stress.sh line 35 (echo -e):
	echo -e "* TIMEOUT for each subcase: $TIMEOUT"
possible bashism in fsnotify-stress.sh line 37 (echo -e):
	echo -e "* Starting fsnotify stress on directory and regular file"
possible bashism in fsnotify-stress.sh line 42 (should be 'b = a'):
			[ "$i" == "$j" ] && continue
possible bashism in fsnotify-stress.sh line 45 (echo -e):
			echo -e "* Starting $i and $j, rcnt $rcnt"
possible bashism in fsnotify-stress.sh line 52 (echo -e):
			echo -e "$i $j" >> tmp
possible bashism in fsnotify-stress.sh line 53 ('((' should be '$(('):
			((rcnt++))
possible bashism in fsnotify-stress.sh line 63 (echo -e):
echo -e "\n***** Cleanup fanotify inotify device *****"
make: [../../../../include/mk/rules.mk:58: check-fsnotify-stress.sh] Error 1 (ignored)
CHECK testcases/kernel/fs/fs-notify/rw_files.sh
possible bashism in rw_files.sh line 12 ('function' is useless):
function add_files()
possible bashism in rw_files.sh line 28 ('((' should be '$(('):
		((i++))
possible bashism in rw_files.sh line 29 ($FUNCNAME):
		[ -e stoptest ] && { echo $FUNCNAME; exit; }
possible bashism in rw_files.sh line 33 ('function' is useless):
function mv_files()
possible bashism in rw_files.sh line 41 ('((' should be '$(('):
		((i++))
possible bashism in rw_files.sh line 42 ($FUNCNAME):
		[ -e stoptest ] && { echo $FUNCNAME; exit; }
possible bashism in rw_files.sh line 46 ('function' is useless):
function read_files()
possible bashism in rw_files.sh line 53 ($FUNCNAME):
		[ -e stoptest ] && { echo $FUNCNAME; exit; }
possible bashism in rw_files.sh line 57 ('function' is useless):
function write_files()
possible bashism in rw_files.sh line 64 ($FUNCNAME):
			[ -e stoptest ] && { echo $FUNCNAME; exit; }
possible bashism in rw_files.sh line 66 ($FUNCNAME):
		[ -e stoptest ] && { echo $FUNCNAME; exit; }
possible bashism in rw_files.sh line 70 ('function' is useless):
function rm_files()
possible bashism in rw_files.sh line 76 ($FUNCNAME):
		[ -e stoptest ] && { echo $FUNCNAME; exit; }
possible bashism in rw_files.sh line 80 ((push|pop)d):
pushd $TDIR > /dev/null 2>&1
possible bashism in rw_files.sh line 87 ((push|pop)d):
popd > /dev/null 2>&1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
