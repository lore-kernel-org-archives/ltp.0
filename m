Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAA4CCD18D
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 13:34:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42BE23CEB77
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 15:34:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 157813C8212
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 15:34:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 944D010006D5
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 15:34:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 37CD21F388;
 Mon, 13 Oct 2025 13:34:37 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F12D41374A;
 Mon, 13 Oct 2025 13:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1bxiN+z/7Gg7YgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 13 Oct 2025 13:34:36 +0000
Date: Mon, 13 Oct 2025 15:34:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20251013133435.GB78221@pevik>
References: <20251013-remove_todo-v2-1-d0a46ad14e34@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251013-remove_todo-v2-1-d0a46ad14e34@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 37CD21F388
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Remove TODO
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

Thanks!

LGTM, a few notes below.

Most important is switch gmane to lore. With that:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> -Rewrite old and add new controller testcases
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -
> -We already started working on this with rewriting cgroup_fj testcases and
> -newly added pids testcases. Have a look at testcases/kernel/controllers/.
> -
> -
> -Shell tests cleanups
> -~~~~~~~~~~~~~~~~~~~~
> -
> -There are numerous testcases written in shell that does not follow single style
> -and use the broken-by-design binaries from tools/apicmds. These should be
> -cleaned up and fixed to use the test.sh test library. These include most of
> -tests in testcases/commands/ for example.
> diff --git a/doc/index.rst b/doc/index.rst
> index acd16cdbf..6cfe21e8d 100644
> --- a/doc/index.rst
> +++ b/doc/index.rst
> @@ -13,6 +13,7 @@
>     users/supported_systems
>     users/stats
>     users/test_catalog
> +   users/todo

>  .. toctree::
>     :maxdepth: 3
> @@ -59,6 +60,9 @@ For users
>  :doc:`users/test_catalog`
>     The LTP test catalog

> +:doc:`users/todo`
> +   List of tasks maintainers are working on
> +
>  For developers
>  --------------

> diff --git a/doc/users/todo.rst b/doc/users/todo.rst
> new file mode 100644
> index 000000000..a8d8f9d37
> --- /dev/null
> +++ b/doc/users/todo.rst
> @@ -0,0 +1,50 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +List of ongoing tasks
> +=====================
> +
> +This is a comprehensive list of tasks where LTP maintainers are currently
> +working on. Priorities might change over time, but these are the most important
> +points which are currently being achieved.

Maybe mention here https://github.com/linux-test-project/ltp/issues ?
(i.e. Fixing bugs in the tests?)

I'm not sure if easyhacks are still relevant (atm 8 tasks):
https://github.com/linux-test-project/ltp/issues?q=state%3Aopen%20label%3Aeasyhack

> +
> +Test new syscalls
> +-----------------
> +
> +Syscalls and new syscalls flags are added to Linux kernel each development
> +cycle and LTP still falls behind. Unfortunately there is no single place that
> +would store comprehensive list of syscalls, but there are a few places to look
> +at:
> +
> +- `man-pages repo <http://git.kernel.org/cgit/docs/man-pages/man-pages.git>`_,
nit: s/repo/repository/ (spoken vs. written English?)

> +  or the ``man2`` directory, where it's possible to find newly documented
> +  functionalities.
> +- `LWN <http://lwn.net>`_ weekly editions.
> +- `linux-api mailing list <http://dir.gmane.org/gmane.linux.kernel.api>`_, where

http://dir.gmane.org/gmane.linux.kernel.api even does not exist any more
(gmane.org is gone), please use lore:

https://lore.kernel.org/linux-api/

NOTE kernel community switched even lkml.org to lore (they prefer it as it's run
by Linux Foundation instead of 3rd party):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=05a5f51ca566

> +  changes in kernel userspace API are discussed.
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
> +you can run the following command inside the LTP root folder:
> +
> +.. code-block:: bash
> +
> +        $ wc -l $(grep -R '"test\.h"' --include="*.c" testcases/kernel/ | cut -d: -f1) | sort -g

wc -l $(git grep 'include "test\.h"' testcases/ | cut -d: -f1) | sort -g

* there are other tests than in testcases/kernel/
* git grep is faster (we expect people working with git clone)

> +
> +Fade out shell scripts
> +----------------------
> +
> +LTP was initially thought as a generic framework for running tests with both
> +shell and plain-C languages. Even if writing tests in shell script might seem
> +easy, the reality is that debugging and maintaining certain test cases is
> +difficult and slow down the whole validation process.

+1 for pointing out shell is problematic and discourage users to write new
tests. Maybe mention also a shell loader?

I would say the problem is with unreliability/instability of shell
implementation (even we use C parts glued by shell it's not enough). Specially
cgroup related tests should be all rewritten in C as shell does not add enough
control + race condition.

> +
> +LTP maintainers are working on converting shell scripts to plain-C tests, in
> +order to reduce the impact that shell scripts might have on the overall kernel
> +testing.

I remember Wei converted recently test_6 to cpuset02.c and that's it. And we
~300 tests (both old and new API):

$ git grep -l -e '^\. .*_lib\.sh' -e '^\. .*test.sh' |wc -l
294

The reality is that we convert most of them to shell loader (way less work, also
for many tests e.g. in testcases/{commands,network}/ it could be sufficient
enough).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
