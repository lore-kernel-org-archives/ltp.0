Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47BAC3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 12:55:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 376E43CE791
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 13:55:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6551C3CB4B6
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 13:55:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DF1AB1A00808
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 13:55:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3909E21CDC;
 Wed,  3 Jan 2024 12:55:19 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 861F31340C;
 Wed,  3 Jan 2024 12:55:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LADhHjZZlWXMLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 03 Jan 2024 12:55:18 +0000
Date: Wed, 3 Jan 2024 13:55:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20240103125516.GF1073466@pevik>
References: <20240103112023.32355-1-akumar@suse.de>
 <20240103112536.1925-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240103112536.1925-1-akumar@suse.de>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Queue-Id: 3909E21CDC
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Improve doc
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

Hi Avinesh,

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  lib/README.md | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)

> diff --git a/lib/README.md b/lib/README.md
> index ccb1cf1da..dd79e70f4 100644
> --- a/lib/README.md
> +++ b/lib/README.md
> @@ -27,16 +27,16 @@

>  When a test is executed the very first thing to happen is that we check for
>  various test prerequisites. These are described in the tst\_test structure and
> -range from simple '.require\_root' to a more complicated kernel .config boolean
> +range from simple '.needs\_root' to a more complicated kernel .config boolean
Good catch!

>  expressions such as: "CONFIG\_X86\_INTEL\_UMIP=y | CONFIG\_X86\_UMIP=y".

> -If all checks are passed the process carries on with setting up the test
> +If all checks are passed, the process continues with setting up the test
>  environment as requested in the tst\_test structure. There are many different
>  setup steps that have been put into the test library again ranging from rather
>  simple creation of a unique test temporary directory to a bit more complicated
>  ones such as preparing, formatting, and mounting a block device.

> -The test library also intializes shrared memory used for IPC at this step.
> +The test library also initializes shared memory used for IPC at this step.

>  Once all the prerequisites are checked and test environment has been prepared
>  we can move on executing the testcase itself. The actual test is executed in a
> @@ -62,12 +62,11 @@ for test_variants:
>  		fork_testrun()
>  ```

> -Before we fork() the test process the test library sets up a timeout alarm and
> -also a heartbeat signal handlers and also sets up an alarm(2) accordingly to
> -the test timeout. When a test times out the test library gets SIGALRM and the
> -alarm handler mercilessly kills all forked children by sending SIGKILL to the
> -whole process group. The heartbeat handler is used by the test process to reset
> -this timer for example when the test functions run in a loop.
> +Before we fork() the test process, the test library sets up a timeout alarm and
nit: "Before we fork " or "Before 'fork() '.

> +also a heartbeat signal handler. When a test times out, the test library gets

I'm not sure about this, isn't the original description correct? (1) timeout
alarm() 2) a heartbeat signal handlers 3) second alarm() accordingly to the test
timeout?

I mean there are 2 alarm() calls in tst_test.c.

Otherwise LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +SIGALRM and the alarm handler mercilessly kills all forked children by sending
> +SIGKILL to the whole process group. The heartbeat handler is used by the test
> +process to reset this timer for example when the test functions run in a loop.

>  With that done we finally fork() the test process. The test process firstly
>  resets signal handlers and sets its pid to be a process group leader so that we
> @@ -97,14 +96,14 @@ usually better option than exiting it in the middle.
>  The test cleanup() is also called by the tst\_brk() handler in order to cleanup
>  before exiting the test process, hence it must be able to cope even with
>  partial test setup. Usually it suffices to make sure to clean up only
> -resources that already have been set up and to do that in an inverse order that
> -we did in setup().
> +resources that already have been set up and to do that in the reverse order
> +that we did in setup().

>  Once the test process exits or leaves the run() or run\_all() function the test
>  library wakes up from the waitpid() call, and checks if the test process
>  exited normally.

> -Once the testrun is finished the test library does a cleanup() as well to clean
> +Once the testrun is finished, the test library does a cleanup() as well to clean
>  up resources set up in the test library setup(), reports test results and
>  finally exits the process.

> @@ -126,8 +125,8 @@ This especially means that:
>  - While the test results are, by the design, propagated to the test library
>    we may still miss a child that gets killed by a signal or exits unexpectedly.

> -The test writer should, because of this, take care for reaping these proceses
> -properly, in most cases this could be simply done by calling
> +The test writer should, because of this, take care of reaping these
> +processes properly, in most cases this could be simply done by calling
>  tst\_reap\_children() to collect and dissect deceased.

>  Also note that tst\_brk() does exit only the current process, so if a child
> @@ -136,9 +135,9 @@ exits.

>  ### Test library and exec()

> -The piece of mapped memory to store the results to is not preserved over
> +The piece of mapped memory to store the results is not preserved over
>  exec(2), hence to use the test library from a binary started by an exec() it
> -has to be remaped. In this case the process must to call tst\_reinit() before
> +has to be remapped. In this case, the process must call tst\_reinit() before
>  calling any other library functions. In order to make this happen the program
>  environment carries LTP\_IPC\_PATH variable with a path to the backing file on
>  tmpfs. This also allows us to use the test library from shell testcases.
> @@ -148,5 +147,5 @@ tmpfs. This also allows us to use the test library from shell testcases.
>  The piece of mapped memory is also used as a base for a futex-based
>  synchronization primitives called checkpoints. And as said previously the
>  memory can be mapped to any process by calling the tst\_reinit() function. As a
> -matter of a fact there is even a tst\_checkpoint binary that allows us to use
> +matter of a fact, there is even a tst\_checkpoint binary that allows us to use
>  the checkpoints from shell code as well.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
