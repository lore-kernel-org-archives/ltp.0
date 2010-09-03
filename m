Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1OrRiZ-0004f5-LT
	for ltp-list@lists.sourceforge.net; Fri, 03 Sep 2010 08:33:51 +0000
Received: from out07.sjc.mx.trendmicro.com ([216.99.131.23])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OrRiV-0002cV-7I
	for ltp-list@lists.sourceforge.net; Fri, 03 Sep 2010 08:33:51 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <001301cb4594$6e7d4190$4b77c4b0$@co.jp>	<1B9B8FA5-4113-480C-BBDB-4CF300D631B1@gmail.com>
	<AANLkTimCn3s52bvL7n8FVzjmtioEhXSAVp98nH40-O6K@mail.gmail.com>
In-Reply-To: <AANLkTimCn3s52bvL7n8FVzjmtioEhXSAVp98nH40-O6K@mail.gmail.com>
Date: Fri, 3 Sep 2010 17:33:36 +0900
Message-ID: <000001cb4b42$b3e95850$1bbc08f0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Sunday, August 29, 2010 4:14 AM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] Build of test cases using
> "pthread_barrierattr_getpshared" failed.
> 
> On Thu, Aug 26, 2010 at 9:54 PM, Garrett Cooper <yanegomi@gmail.com>
> wrote:
> > On Aug 26, 2010, at 8:03 PM, Mitani wrote:
> >
> >> Hi,
> >>
> >> I tried to build open_posix_testsuite test cases.
> >> But, in RHEL4.8 systems (x86, x86_64, ia64), some test cases failed
> to
> >> build as follows:
> >> ------------
> >> [...]
> >> conformance/interfaces/pthread_barrierattr_getpshared/1-1
> compile FAILED
> >> /tmp/cceTtlYC.o(.text+0x5c): In function `main':
> >> : undefined reference to `pthread_barrierattr_getpshared'
> >> collect2: ld returned 1 exit status
> >> conformance/interfaces/pthread_barrierattr_getpshared/2-1
> compile FAILED
> >> /tmp/ccMhUJvM.o(.text+0x125): In function `main':
> >> : undefined reference to `pthread_barrierattr_getpshared'
> >> collect2: ld returned 1 exit status
> >> conformance/interfaces/pthread_barrierattr_init/1-1 compile
> FAILED
> >> /tmp/cc6vNdZV.o(.text+0x5c): In function `main':
> >> : undefined reference to `pthread_barrierattr_getpshared'
> >> collect2: ld returned 1 exit status
> >> conformance/interfaces/pthread_barrierattr_init/2-1 compile
> PASSED
> >> conformance/interfaces/pthread_barrierattr_setpshared/1-1
> compile FAILED
> >> /tmp/cc2gjFbd.o(.text+0x9c): In function `main':
> >> : undefined reference to `pthread_barrierattr_getpshared'
> >> /tmp/cc2gjFbd.o(.text+0x128): In function `main':
> >> : undefined reference to `pthread_barrierattr_getpshared'
> >> collect2: ld returned 1 exit status
> >> conformance/interfaces/pthread_barrierattr_setpshared/2-1
> compile PASSED
> >> [...]
> >> ------------
> >>
> >> These errors are linkage error about
> "pthread_barrierattr_getpshared".
> >>
> >> I searched "pthread_barrierattr_getpshared" in libraries (*.a, *.o,
> *.so*).
> >> I found it in "/usr/lib64/libpthread.a", but the name is
> >> "__pthread_barrierattr_getpshared":
> >> ------------
> >> [root@RHEL48-LTP-EM64T pthread_barrierattr_getpshared]# find /
> -name \*.a
> >> -print | xargs n
> >> m -o | grep pthread_barrierattr_getpshared
> >> nm: fromhost.o: no symbols
> >> nm: tli.o: no symbols
> >> nm: myvsyslog.o: no symbols
> >> nm: mcst_grp.o: no symbols
> >> [...]
> >> nm: liblua_la-ltests.o: no symbols
> >> nm: ptlongjmp.o: no symbols
> >> nm: oldsemaphore.o: no symbols
> >> /usr/lib64/libpthread.a:barrier.o:0000000000000150 T
> >> __pthread_barrierattr_getpshared
> >> nm: libc-tls-loc.o: no symbols
> >> nm: ptw-lseek.o: no symbols
> >> nm: ptw-lseek64.o: no symbols
> >> [...]
> >> nm: apptype.o: no symbols
> >> nm: fromhost.o: no symbols
> >> nm: tli.o: no symbols
> >> nm: myvsyslog.o: no symbols
> >> [root@RHEL48-LTP-EM64T pthread_barrierattr_getpshared]#
> >> ------------
> >>
> >> This name includes "__" for prefix.
> >> I think it is strange.
> >>
> >> On the other hand, as indicated above, "conformance/interfaces/
> >> pthread_barrierattr_setpshared/2-1" succeeded to build.
> >> This test case uses "pthread_barrierattr_setpshared", and does not
> use
> >> "pthread_barrierattr_getpshared".
> >> I searched "pthread_barrierattr_getpshared" just in case:
> >> ------------
> >> [root@RHEL48-LTP-EM64T pthread_barrierattr_getpshared]# find /
> -name \*.a
> >> -print | xargs n
> >> m -o | grep pthread_barrierattr_setpshared
> >> nm: fromhost.o: no symbols
> >> nm: tli.o: no symbols
> >> nm: myvsyslog.o: no symbols
> >> nm: mcst_grp.o: no symbols
> >> nm: ibmcgrp.o: no symbols
> >> [...]
> >> nm: ptlongjmp.o: no symbols
> >> nm: oldsemaphore.o: no symbols
> >> nm: libc-tls-loc.o: no symbols
> >> /usr/lib64/libpthread.a:barrier.o:0000000000000160 T
> >> pthread_barrierattr_setpshared
> >> nm: ptw-lseek.o: no symbols
> >> nm: ptw-lseek64.o: no symbols
> >> nm: ptw-pread64.o: no symbols
> >> [...]
> >> nm: apptype.o: no symbols
> >> nm: fromhost.o: no symbols
> >> nm: tli.o: no symbols
> >> nm: myvsyslog.o: no symbols
> >> [root@RHEL48-LTP-EM64T pthread_barrierattr_getpshared]#
> >> ------------
> >>
> >> This name does not include prefix "__".
> >>
> >>
> >> I think that this linkage error of "pthread_barrierattr_getpshared"
> is
> >> caused by the malfunction of RHEL4.8.
> >>
> >> Therefore, "SKIPPED" is necessary for the compilation of such above
> >> test case, I think.
> >> But "SKIPPED" was deleted from last month git.
> >> Can "SKIPPED" be displayed again as before?
> 
> Ok... but how does one quantify a SKIPPED from a FAILED case? The
> outcome is ultimately the same: your test didn't compile, you need to
> determine _why_ it didn't compile and/or qualify whether or not the
> result is sane. With the build-only's it's a little more fun because
> there's no reason why SKIPPED should be output. For the
> non-build-only's, I could see the potential need, but again... it's
> just presenting the outcome in a different light.
> 
> Also, SKIPPED does still exist for runtime tests (where it ultimately
> should apply):
> 
> $ grep SKIPPED bin/run-tests.sh
> 		echo "$testname: execution: SKIPPED (test not
> present)"
> 
> So, I don't think this is an issue.
> 
> > What does the manpage say is required for the API?
> 
> Also, you may be using an ancient version of gcc/glibc which means
> that you have to modify the value used in the top-level CFLAGS file
> to
> get the appropriate behavior you want, via -pthread, manually linking
> in the libraries, etc. But please be sure to look up the manpage
> stated requirements and report them back here so I can help you
> resolve your issue.
> 
> Thanks,
> -Garrett


Sorry for my late answer.

I couldn't understand written meanings well first. (The most of reasons 
that I couldn't understand are lack of my English comprehension.)
And I needed time to get my opinion in shape.


> What does the manpage say is required for the API?

Manpage doesn't say about requirements.
I show manpage of my test environmwent (RHEL4.8 x86_64):
------------
[root@RHEL48-LTP-EM64T usr]# man pthread_barrierattr_getpshared
PTHREAD_BARRIERATTR_GETPSHARED(P)
PTHREAD_BARRIERATTR_GETPSHARED(P)

NAME
       pthread_barrierattr_getpshared, pthread_barrierattr_setpshared - get
and set the
       process-shared attribute of the barrier  attributes  object
(ADVANCED  REALTIME
       THREADS)

SYNOPSIS
       #include <pthread.h>

       int pthread_barrierattr_getpshared(const pthread_barrierattr_t *
              restrict attr, int *restrict pshared);
       int pthread_barrierattr_setpshared(pthread_barrierattr_t *attr,
              int pshared);

DESCRIPTION
       The pthread_barrierattr_getpshared() function shall obtain the value
of the pro-
       cess-shared attribute  from  the  attributes  object  referenced  by
attr.  The
       pthread_barrierattr_setpshared() function shall set the
process-shared attribute
       in an initialized attributes object referenced by attr.

       The process-shared attribute is set to PTHREAD_PROCESS_SHARED to
permit  a  bar-
       rier  to  be operated upon by any thread that has access to the
memory where the
       barrier is allocated. If the process-shared  attribute  is
PTHREAD_PROCESS_PRI-
       VATE, the barrier shall only be operated upon by threads created
within the same
       process as the thread that initialized the barrier; if threads of
different pro-
       cesses  attempt  to  operate  on  such a barrier, the behavior is
undefined. The
       default value of the attribute shall be PTHREAD_PROCESS_PRIVATE. Both
constants
       PTHREAD_PROCESS_SHARED and PTHREAD_PROCESS_PRIVATE are defined in
<pthread.h>.

       Additional  attributes,  their  default  values, and the names of the
associated
       functions to get and set those attribute values are
implementation-defined.

RETURN VALUE
       If successful, the pthread_barrierattr_getpshared() function shall
return  zero
       and store the value of the process-shared attribute of attr into the
object ref-
       erenced by the pshared parameter. Otherwise, an error number shall
be  returned
       to indicate the error.

       If  successful, the pthread_barrierattr_setpshared() function shall
return zero;
       otherwise, an error number shall be returned to indicate the error.

ERRORS
       These functions may fail if:

       EINVAL The value specified by attr is invalid.

       The pthread_barrierattr_setpshared() function may fail if:

       EINVAL The new value specified for the process-shared attribute is
not  one  of
              the legal values PTHREAD_PROCESS_SHARED or
PTHREAD_PROCESS_PRIVATE.

       These functions shall not return an error code of [EINTR].

       The following sections are informative.

EXAMPLES
       None.

APPLICATION USAGE
       The  pthread_barrierattr_getpshared() and
pthread_barrierattr_setpshared() func-
       tions are part of the Barriers option and need not be provided on all
implemen-
       tations.

RATIONALE
       None.

FUTURE DIRECTIONS
       None.

SEE ALSO
       pthread_barrier_destroy()  ,  pthread_barrierattr_destroy()  ,
pthread_barrier-
       attr_init() , the Base Definitions volume of IEEE Std 1003.1-2001,
<pthread.h>

COPYRIGHT
       Portions of this text are reprinted and reproduced in electronic form
from  IEEE
       Std  1003.1, 2003 Edition, Standard for Information Technology --
Portable Oper-
       ating System Interface (POSIX), The Open  Group  Base  Specifications
Issue  6,
       Copyright  (C)  2001-2003  by  the Institute of Electrical and
Electronics Engi-
       neers, Inc and The Open Group. In the event of any discrepancy
between this ver-
       sion  and  the  original IEEE and The Open Group Standard, the
original IEEE and
       The Open Group Standard is the referee document. The original
Standard  can  be
       obtained online at http://www.opengroup.org/unix/online.html .

POSIX                                     2003
PTHREAD_BARRIERATTR_GETPSHARED(P)
[root@RHEL48-LTP-EM64T usr]#
------------

Manpage says that the function's name is "pthread_barrierattr_getpshared".
But the function name that is in the library was 
"__pthread_barrierattr_getpshared":
------------
[root@RHEL48-LTP-EM64T pthread_barrierattr_getpshared]# find / -name \*.a
-print | xargs n
m -o | grep pthread_barrierattr_getpshared
nm: fromhost.o: no symbols
nm: tli.o: no symbols
[...]
nm: oldsemaphore.o: no symbols
/usr/lib64/libpthread.a:barrier.o:0000000000000150 T
__pthread_barrierattr_getpshared
nm: libc-tls-loc.o: no symbols
[...]
nm: tli.o: no symbols
nm: myvsyslog.o: no symbols
[root@RHEL48-LTP-EM64T pthread_barrierattr_getpshared]#
------------


> Ok... but how does one quantify a SKIPPED from a FAILED case? The
> outcome is ultimately the same: your test didn't compile, you need to
> determine _why_ it didn't compile and/or qualify whether or not the
> result is sane. 

You right.
I considered it once again. And I thought that it is not problem that 
build failure by the glibc malfunction was displayed with "FAILED".

But I want to distinguish the reason of the failure by some kind of 
methods -- the reason is whether the failure depends on the test-set 
malfunction or it depends on environmental malfunction.
Otherwise somebody may have to do investigation same as what I did.


> Also, you may be using an ancient version of gcc/glibc [...]

Yes, I think so.
I only used gcc/glibc which RHEL4.8 distributes. I didn't install 
other version's gcc/glibc.
Perhaps, the library of RHEL4.8 has mistakes, I think.
But, I can't install new version's glibc, because the test by using 
new version's glibc is not pure test of RHEL4.8.


Thank you--


-Tomonori Mitani



------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
