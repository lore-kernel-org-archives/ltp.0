From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Aug 2021 18:03:19 +0200
Subject: [LTP] [PATCH] lib/tst_test.sh: fix ROD_SILENT command return
 status check
In-Reply-To: <20210819152154.16185-1-aleksei.kodanev@bell-sw.com>
References: <20210819152154.16185-1-aleksei.kodanev@bell-sw.com>
Message-ID: <YR6Ax7TXsa5tipei@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> "local tst_out=$(some_command)" always returns status 0, i.e.
> not the return status of the command in the assignment, but the
> status for 'local' builtin command, which creates a new local
> variable inside the function.

> As a result, the library calls and tests that invoke ROD_SILENT
> don't actually check the return status of commands passed to it.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Very good catch, thanks!

Tested-by: Petr Vorel <pvorel@suse.cz>
Working the same in: bash, dash, busybox sh, mksh (android).

> The old API library function is also fixed.
+1

Kind regards,
Petr
