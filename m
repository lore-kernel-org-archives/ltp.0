From: Petr Vorel <pvorel@suse.com>
Date: Thu, 16 Jul 2020 11:15:28 +0200
Subject: [LTP] [v2,2/2] ioperm: Convert to new API
In-Reply-To: <20200716061059.30525-2-liwang@redhat.com>
Message-ID: <20200716091528.GA6383@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

Actually it fails to build on non-intel.
https://travis-ci.org/github/pevik/ltp/jobs/708655670
/usr/src/ltp/testcases/kernel/syscalls/iopl/iopl02.c:21:10: fatal error: sys/io.h: No such file or directory
9793 #include <sys/io.h>

https://travis-ci.org/github/pevik/ltp/builds/708655668

<sys/io.h> needs to be included behind #if defined __i386__ ||
defined(__x86_64__) guarder.

Please fix it before merge.

Kind regards,
Petr

