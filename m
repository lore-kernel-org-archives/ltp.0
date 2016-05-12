From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 May 2016 18:36:35 +0200
Subject: [LTP] LTP uClinux support
Message-ID: <20160512163634.GB1372@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've started to investigate how to wire up the UCLINUX support to the
new test library however instead I've found that LTP support for UCLINUX
has been broken for some time without anybody noticing.

First of all LTP fails to compile with ./configure CFLAGS=-DUCLINUX
which has been firstly introduced about two years ago while cleaning up
testcases. There are 6 testcases that break compilation and while the
problems are easy to fix nobody has reported them so far.

And even if I skip testcases that does not compile the rest that does
FORK_OR_VFORK() fails in self_exec.c which seems to be due to:

commit c414040fa5f53e353f25c6d5d550dc42a62d32f7
Author: Manjeet Pawar <manjeet.p@samsung.com>
Date:   Thu May 28 04:41:36 2015 +0000

    lib/self_exec.c: Fix leaks and remove redundant code

    This patch free args before returning from function to avoid
    memory leaks and remove redundant code in self_exec().


That frees allocated pointer just before part of it is used (since the
string is parsed with strtok()).

So unless somebody stands up to regulary test and fix/report bugs for
-DUCLINUX I would wote for removing the support from LTP.

So is there anybody interested in continued uClinux support in LTP,
especially somebody from the uClinux mailing list?

-- 
Cyril Hrubis
chrubis@suse.cz
