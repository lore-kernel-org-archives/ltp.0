From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 2 Sep 2021 13:50:54 +0200
Subject: [LTP] [PATCH 0/4] checkbashisms.pl in make check + fixed docs
In-Reply-To: <20210902103740.19446-1-pvorel@suse.cz>
References: <20210902103740.19446-1-pvorel@suse.cz>
Message-ID: <YTC6nujBQURztwei@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All,

> checkbashisms.pl has problem with type. Although it's in POSIX [1] even
> in old one from 2004 [2] and it's supported by all common shells (i.e.
> bash, zsh, dash, busybox sh, mksh; even in ksh; maybe just csh does not
> support it) checkbashisms.pl complains about it:

> $ make check-tst_test.sh
> CHECK testcases/lib/tst_test.sh
> possible bashism in tst_test.sh line 33 (type):
> 		if type $TST_CLEANUP >/dev/null 2>/dev/null; then
> possible bashism in tst_test.sh line 694 (type):
> 		if type $TST_SETUP >/dev/null 2>/dev/null; then
> possible bashism in tst_test.sh line 726 (type):
> 		if type ${TST_TESTFUNC}1 > /dev/null 2>&1; then
> make: [../../include/mk/rules.mk:58: check-tst_test.sh] Error 1 (ignored)


> Should I report it to Debian (the upstream)? Or at least ask for way to
> suppress the warning?

type is part of POSIX, but as part of the X/Open Systems Interfaces option
(XSI). The checkbashisms man page explicitly says:

	Note that the definition of a bashism in this context roughly equates to "a
	shell feature that is not required to be supported by POSIX"; this means that
	some issues flagged may be permitted under optional sections of POSIX, such as
	XSI or User Portability.

=> type is flagged because it is an optional feature.

I just send a patch which disabled it from source code.

Kind regards,
Petr
