Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07068CCD18D
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 15:39:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 745F23CEC2E
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 17:38:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1EC13CE678
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 17:38:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1FEFE600066
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 17:38:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A506219FF;
 Mon, 13 Oct 2025 15:38:40 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1F481374A;
 Mon, 13 Oct 2025 15:38:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QkKjNP8c7WjKXgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 13 Oct 2025 15:38:39 +0000
Date: Mon, 13 Oct 2025 17:38:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20251013153838.GA111830@pevik>
References: <20251013-remove_todo-v3-1-533e47439a94@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251013-remove_todo-v3-1-533e47439a94@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7A506219FF
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Remove TODO
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

Hi Andrea,

once more, now Cc the list. I'm sorry for the noise.

Generally LGTM, notes below.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> TODO file is not updated and it talks about goals we already reached via
> new LTP documentation. In general, it contains generic and random topics
> which none is updating anymore, so it's better to remove it in order to
> create less confusion for new comers.

nit: s/new comers/newcomers/

> Instead, we create a todo list in the new documentation, providing a
> more clear intention of what are the current LTP goals.

> Acked-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v3:
> - fix typo
> - update command to generate test with old API
> - add kirk link in TODO
> - shell loader reference
> - Link to v2: https://lore.kernel.org/r/20251013-remove_todo-v2-1-d0a46ad14e34@suse.com

> Changes in v2:
> - add doc/users/todo.rst section
> - Link to v1: https://lore.kernel.org/r/20251006-remove_todo-v1-1-5bab5f6f77f5@suse.com
> ---
>  TODO               | 39 ----------------------------
>  doc/index.rst      |  4 +++
>  doc/users/todo.rst | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+), 39 deletions(-)

...
> diff --git a/doc/users/todo.rst b/doc/users/todo.rst
> new file mode 100644
> index 000000000..2484eaf32
> --- /dev/null
> +++ b/doc/users/todo.rst

IMHO this TODO page is for new LTP developers to see ideas what to work on,
right?  Thinking about it twice, IMHO this should be in doc/developers/.
At least normal LTP users (testers) don't bother what we want to develop.

> @@ -0,0 +1,74 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +List of ongoing tasks
> +=====================
> +
> +This is a comprehensive list of tasks where LTP maintainers are currently
> +working on. Priorities might change over time, but these are the most important
> +points which are currently being achieved.
> +
> +Fade out old tests runner
> +-------------------------
> +
> +``runltp`` script is old and unmaintaned. We are slowly shifting to
> +`kirk <https://github.com/linux-test-project/kirk>`_, that will be our official
> +tests runner in the next future.
> +
> +kirk provides support for remote testing via Qemu, SSH, LTX, parallel
> +execution and much more.

IMHO this TODO page is for new LTP developers to see ideas what to work on,
right? Wouldn't be more useful to put it to the page which people using LTP will
be reading? Maybe one of these:

https://linux-test-project.readthedocs.io/en/latest/users/quick_start.html
https://linux-test-project.readthedocs.io/en/latest/users/setup_tests.html

> +
> +Test new syscalls
> +-----------------
> +
> +Syscalls and new syscalls flags are added to Linux kernel each development
> +cycle and LTP still falls behind. Unfortunately there is no single place that
> +would store comprehensive list of syscalls, but there are a few places to look
> +at:
> +
> +- `man-pages repository <http://git.kernel.org/cgit/docs/man-pages/man-pages.git>`_
> +  or the ``man2`` directory, where it's possible to find newly documented
> +  functionalities.
> +- `LWN <http://lwn.net>`_ weekly editions.
> +- `linux-api mailing list <https://lore.kernel.org/linux-api/>`_ where
> +  changes in kernel userspace API are discussed.
> +- `LTP Github issues <https://github.com/linux-test-project/ltp/issues>`_
> +
> +Rewrite old API tests
> +---------------------
> +
> +LTP has a long story and, at certain point of its development, new API were
> +introduced to make kernel testing easier and more efficient. This happened when
> +lots of tests were still using old, messy API.
> +
> +Some of these tests have been converted to the new API, but this process is
> +still ongoing for many others. To have an overview of the tests using old API,
> +please run the following command inside the LTP root folder:
> +
> +.. code-block:: bash
> +
> +        git --no-pager grep 'include "test\.h"' testcases/ | cut -d: -f1

I quite like your first version which showed number of lines. But if you want to
just list of the old API tests, why not use git grep -l ?

git --no-pager grep -l 'include "test\.h"' testcases/

> +
> +Fade out shell scripts
> +----------------------
> +
> +LTP was initially thought as a generic framework for running tests with both
> +shell and plain-C languages. Even if writing tests in shell script might seem
> +easy, the reality is that debugging and maintaining certain test cases is
> +difficult and slow down the whole validation process. This is particularly
> +visible for cgroup tests, since shell doesn't add enough control over race
> +conditions.

That reminds me Cyril's saying "it's easy to write portable shell *interpreter*
than portable shell *scripts*. :).

> +
> +LTP maintainers are working on converting shell scripts to plain-C tests, in
> +order to reduce the impact that shell scripts might have on the overall kernel
> +testing.
> +
> +For a complete list of shell tests, please run the following command inside the
> +LTP root folder:
> +
> +.. code-block:: bash
> +
> +        git --no-pager grep -l -e '^\. .*_lib\.sh' -e '^\. .*test.sh'
> +
> +LTP also provides a shell loader implementation for plain-C tests using
> +``tst_run_script`` features. Please take a look at the

That's tst_run_shell. Could you please use link to the source?

:master:`testcases/lib/tst_run_shell.c`

> +:doc:`LTP API <../developers/api_c_tests>`.
For shell loader are useful only struct tst_test tags in JSON comments.
Maybe point directly to struct tst_test?

Maybe the most descriptive are tests in testcases/lib/tests/.

:master:`testcases/lib/tst_run_shell.c` features. Please take a look at the
:ref:`struct tst_test` and examples in :master:`testcases/lib/tests/`.

(NOTE: besides testcases/lib/tst_run_shell.c there is also
testcases/lib/tst_run.sh and testcases/lib/tst_env.sh but we can ignore it in
this short info.  If we really convert most of the shell tests to shell runner,
we should write doc in a separate page. In that case we could leave
doc/old/Shell-Test-API.asciidoc unconverted).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
