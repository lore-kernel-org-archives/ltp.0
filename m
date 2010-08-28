Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OpQqc-0008UT-29
	for ltp-list@lists.sourceforge.net; Sat, 28 Aug 2010 19:13:50 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OpQqa-0006ci-St
	for ltp-list@lists.sourceforge.net; Sat, 28 Aug 2010 19:13:50 +0000
Received: by bwz12 with SMTP id 12so3471895bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 28 Aug 2010 12:13:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1B9B8FA5-4113-480C-BBDB-4CF300D631B1@gmail.com>
References: <001301cb4594$6e7d4190$4b77c4b0$@co.jp>
	<1B9B8FA5-4113-480C-BBDB-4CF300D631B1@gmail.com>
Date: Sat, 28 Aug 2010 12:13:43 -0700
Message-ID: <AANLkTimCn3s52bvL7n8FVzjmtioEhXSAVp98nH40-O6K@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Build of test cases using
	"pthread_barrierattr_getpshared" failed.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Thu, Aug 26, 2010 at 9:54 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Aug 26, 2010, at 8:03 PM, Mitani wrote:
>
>> Hi,
>>
>> I tried to build open_posix_testsuite test cases.
>> But, in RHEL4.8 systems (x86, x86_64, ia64), some test cases failed to
>> build as follows:
>> ------------
>> [...]
>> conformance/interfaces/pthread_barrierattr_getpshared/1-1 compile FAILED
>> /tmp/cceTtlYC.o(.text+0x5c): In function `main':
>> : undefined reference to `pthread_barrierattr_getpshared'
>> collect2: ld returned 1 exit status
>> conformance/interfaces/pthread_barrierattr_getpshared/2-1 compile FAILED
>> /tmp/ccMhUJvM.o(.text+0x125): In function `main':
>> : undefined reference to `pthread_barrierattr_getpshared'
>> collect2: ld returned 1 exit status
>> conformance/interfaces/pthread_barrierattr_init/1-1 compile FAILED
>> /tmp/cc6vNdZV.o(.text+0x5c): In function `main':
>> : undefined reference to `pthread_barrierattr_getpshared'
>> collect2: ld returned 1 exit status
>> conformance/interfaces/pthread_barrierattr_init/2-1 compile PASSED
>> conformance/interfaces/pthread_barrierattr_setpshared/1-1 compile FAILED
>> /tmp/cc2gjFbd.o(.text+0x9c): In function `main':
>> : undefined reference to `pthread_barrierattr_getpshared'
>> /tmp/cc2gjFbd.o(.text+0x128): In function `main':
>> : undefined reference to `pthread_barrierattr_getpshared'
>> collect2: ld returned 1 exit status
>> conformance/interfaces/pthread_barrierattr_setpshared/2-1 compile PASSED
>> [...]
>> ------------
>>
>> These errors are linkage error about "pthread_barrierattr_getpshared".
>>
>> I searched "pthread_barrierattr_getpshared" in libraries (*.a, *.o, *.so*).
>> I found it in "/usr/lib64/libpthread.a", but the name is
>> "__pthread_barrierattr_getpshared":
>> ------------
>> [root@RHEL48-LTP-EM64T pthread_barrierattr_getpshared]# find / -name \*.a
>> -print | xargs n
>> m -o | grep pthread_barrierattr_getpshared
>> nm: fromhost.o: no symbols
>> nm: tli.o: no symbols
>> nm: myvsyslog.o: no symbols
>> nm: mcst_grp.o: no symbols
>> [...]
>> nm: liblua_la-ltests.o: no symbols
>> nm: ptlongjmp.o: no symbols
>> nm: oldsemaphore.o: no symbols
>> /usr/lib64/libpthread.a:barrier.o:0000000000000150 T
>> __pthread_barrierattr_getpshared
>> nm: libc-tls-loc.o: no symbols
>> nm: ptw-lseek.o: no symbols
>> nm: ptw-lseek64.o: no symbols
>> [...]
>> nm: apptype.o: no symbols
>> nm: fromhost.o: no symbols
>> nm: tli.o: no symbols
>> nm: myvsyslog.o: no symbols
>> [root@RHEL48-LTP-EM64T pthread_barrierattr_getpshared]#
>> ------------
>>
>> This name includes "__" for prefix.
>> I think it is strange.
>>
>> On the other hand, as indicated above, "conformance/interfaces/
>> pthread_barrierattr_setpshared/2-1" succeeded to build.
>> This test case uses "pthread_barrierattr_setpshared", and does not use
>> "pthread_barrierattr_getpshared".
>> I searched "pthread_barrierattr_getpshared" just in case:
>> ------------
>> [root@RHEL48-LTP-EM64T pthread_barrierattr_getpshared]# find / -name \*.a
>> -print | xargs n
>> m -o | grep pthread_barrierattr_setpshared
>> nm: fromhost.o: no symbols
>> nm: tli.o: no symbols
>> nm: myvsyslog.o: no symbols
>> nm: mcst_grp.o: no symbols
>> nm: ibmcgrp.o: no symbols
>> [...]
>> nm: ptlongjmp.o: no symbols
>> nm: oldsemaphore.o: no symbols
>> nm: libc-tls-loc.o: no symbols
>> /usr/lib64/libpthread.a:barrier.o:0000000000000160 T
>> pthread_barrierattr_setpshared
>> nm: ptw-lseek.o: no symbols
>> nm: ptw-lseek64.o: no symbols
>> nm: ptw-pread64.o: no symbols
>> [...]
>> nm: apptype.o: no symbols
>> nm: fromhost.o: no symbols
>> nm: tli.o: no symbols
>> nm: myvsyslog.o: no symbols
>> [root@RHEL48-LTP-EM64T pthread_barrierattr_getpshared]#
>> ------------
>>
>> This name does not include prefix "__".
>>
>>
>> I think that this linkage error of "pthread_barrierattr_getpshared" is
>> caused by the malfunction of RHEL4.8.
>>
>> Therefore, "SKIPPED" is necessary for the compilation of such above
>> test case, I think.
>> But "SKIPPED" was deleted from last month git.
>> Can "SKIPPED" be displayed again as before?

Ok... but how does one quantify a SKIPPED from a FAILED case? The
outcome is ultimately the same: your test didn't compile, you need to
determine _why_ it didn't compile and/or qualify whether or not the
result is sane. With the build-only's it's a little more fun because
there's no reason why SKIPPED should be output. For the
non-build-only's, I could see the potential need, but again... it's
just presenting the outcome in a different light.

Also, SKIPPED does still exist for runtime tests (where it ultimately
should apply):

$ grep SKIPPED bin/run-tests.sh
		echo "$testname: execution: SKIPPED (test not present)"

So, I don't think this is an issue.

> What does the manpage say is required for the API?

Also, you may be using an ancient version of gcc/glibc which means
that you have to modify the value used in the top-level CFLAGS file to
get the appropriate behavior you want, via -pthread, manually linking
in the libraries, etc. But please be sure to look up the manpage
stated requirements and report them back here so I can help you
resolve your issue.

Thanks,
-Garrett

------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
