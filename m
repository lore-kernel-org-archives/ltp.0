From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 18 May 2016 08:34:57 -0400 (EDT)
Subject: [LTP] ltp-full-20160510 compile failed
In-Reply-To: <20160518082726.GA3920@localhost.localdomain>
References: <20160518082726.GA3920@localhost.localdomain>
Message-ID: <1923642895.3898894.1463574897794.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> To: ltp@lists.linux.it
> Sent: Wednesday, 18 May, 2016 10:27:26 AM
> Subject: [LTP] ltp-full-20160510 compile failed
> 
> Hi,
> 
> When I try to compile the latest LTP, it failed:
> 
>     % ./configure --with-open-posix-testsuite --prefix=`pwd`
>     % make -j 64 all
> ... ...
> functional/mqueues/send_rev_1 compile PASSED
> make[4]: Leaving directory
> '/home/hpt/ltp-full-20160510/testcases/open_posix_testsuite/functional/mqueues'
> make[4]: Entering directory
> '/home/hpt/ltp-full-20160510/testcases/open_posix_testsuite/functional/semaphores'
> make[4]: *** No rule to make target 'all'.  Stop.
> make[4]: Leaving directory
> '/home/hpt/ltp-full-20160510/testcases/open_posix_testsuite/functional/semaphores'
> make[4]: Entering directory
> '/home/hpt/ltp-full-20160510/testcases/open_posix_testsuite/functional/threads'
> make[5]: Entering directory
> '/home/hpt/ltp-full-20160510/testcases/open_posix_testsuite/functional/threads/condva
> r'
> make[5]: *** No rule to make target 'all'.  Stop.
> make[5]: Leaving directory
> '/home/hpt/ltp-full-20160510/testcases/open_posix_testsuite/functional/threads/condvar
> '
> make[5]: Entering directory
> '/home/hpt/ltp-full-20160510/testcases/open_posix_testsuite/functional/threads/pi_tes
> t'
> make[5]: *** No rule to make target 'all'.  Stop.
> make[5]: Leaving directory
> '/home/hpt/ltp-full-20160510/testcases/open_posix_testsuite/functional/threads/pi_test
> '
> make[5]: Entering directory
> '/home/hpt/ltp-full-20160510/testcases/open_posix_testsuite/functional/threads/schedule'
> make[5]: *** No rule to make target 'all'.  Stop.
> make[5]: Leaving directory
> '/home/hpt/ltp-full-20160510/testcases/open_posix_testsuite/functional/threads/schedule'
> Makefile:8: recipe for target 'all' failed
> make[4]: *** [all] Error 2
> make[4]: Leaving directory
> '/home/hpt/ltp-full-20160510/testcases/open_posix_testsuite/functional/threads'
> Makefile:8: recipe for target 'all' failed
> make[3]: *** [all] Error 2
> make[3]: Leaving directory
> '/home/hpt/ltp-full-20160510/testcases/open_posix_testsuite/functional'
> /home/hpt/ltp-full-20160510/testcases/open_posix_testsuite/Makefile:82:
> recipe for target 'functional-all' failed
> make[2]: *** [functional-all] Error 2
> make[2]: Leaving directory
> '/home/hpt/ltp-full-20160510/testcases/open_posix_testsuite'
> ../include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
> make[1]: *** [all] Error 2
> make[1]: Leaving directory '/home/hpt/ltp-full-20160510/testcases'
> Makefile:114: recipe for target 'testcases-all' failed
> make: *** [testcases-all] Error 2
> 
> The Makefile in
> 
>     /home/hpt/ltp-full-20160510/testcases/open_posix_testsuite/functional/semaphores
> 
> is empty.  And if I compile the package like this:

This looks like an issue that was brought up a while back:
  [LTP] [PATCH] Makefile: Disable parallel build for $(CRITICAL_MAKEFILES)
  https://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg15795.html

So I think you need to stick with non-parallel builds open_posix_testsuite
for now.

Regards,
Jan

> 
>     % ./configure --with-open-posix-testsuite --prefix=`pwd`
>     % cd testcases/open_posix_testsuite
>     % make -j 64
>     % cd -
>     % make -j 64 all
> 
> Then it will succeed. Not sure if it is usable when compiling like this?
> Please advise. Thanks in advance!
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
