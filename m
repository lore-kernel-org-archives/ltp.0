Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA54BCCD18E
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 09:22:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B46C3CEC39
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 11:22:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7BA43CE4E2
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 11:22:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6DA651A00A49
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 11:22:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8659A21D7E;
 Tue, 14 Oct 2025 09:22:02 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76F2F139B0;
 Tue, 14 Oct 2025 09:22:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cc3vGzoW7mhDSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 14 Oct 2025 09:22:02 +0000
Date: Tue, 14 Oct 2025 11:22:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aO4WanlsicVtKsSw@yuki.lan>
References: <20251014-remove_todo-v5-1-2793dffdec2d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251014-remove_todo-v5-1-2793dffdec2d@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 8659A21D7E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Remove TODO
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
> diff --git a/doc/developers/todo.rst b/doc/developers/todo.rst
> new file mode 100644
> index 000000000..7daac7322
> --- /dev/null
> +++ b/doc/developers/todo.rst
> @@ -0,0 +1,75 @@
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
> +:master:`runltp` script is old and unmaintaned. We are slowly shifting to
> +`kirk <https://github.com/linux-test-project/kirk>`_, that will be our official
> +tests runner in the next future.
                       ^
		  Just: "in the future."

"next future" sounds like we are moving to a parallel reality or some
kind of scifi stuff.

> +kirk provides support for remote testing via Qemu, SSH, LTX, parallel
   ^
   Kirk
> +execution and much more.
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
> +        git --no-pager grep -l 'include "test\.h"' testcases/
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
> +LTP also provides a shell loader implementation for plain-C tests inside
> +:master:`testcases/lib/tst_run_shell.c` and it permits to run shell tests
> +into plain-C LTP API, featuring :ref:`struct tst_test` initializations and a
> +direct access to kernel syscalls.

Maybe we should link the (now empty) shell API page here:

https://linux-test-project.readthedocs.io/en/latest/developers/api_shell_tests.html

I plan to add the shell loader documentation there one day.


Otherwise it looks good to me, thanks for writing this.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
