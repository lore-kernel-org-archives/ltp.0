Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PELqP-00045a-MG
	for ltp-list@lists.sourceforge.net; Fri, 05 Nov 2010 12:56:37 +0000
Received: from out12.sjc.mx.trendmicro.com ([216.99.131.49])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PELqM-0004cx-Mu
	for ltp-list@lists.sourceforge.net; Fri, 05 Nov 2010 12:56:37 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001cb74af$8658b390$930a1ab0$@co.jp>	<AANLkTimQc+8+ytEWT3zXVE1dCf-SKZp-hrt7RRkXUDX4@mail.gmail.com>	<000b01cb764a$12ae2050$380a60f0$@co.jp>
	<AANLkTikYjD9UT5Tw7rkY9QJcN1kgKwu21wv6+6CORfVK@mail.gmail.com>
In-Reply-To: <AANLkTikYjD9UT5Tw7rkY9QJcN1kgKwu21wv6+6CORfVK@mail.gmail.com>
Date: Fri, 5 Nov 2010 21:56:22 +0900
Message-ID: <000001cb7ce8$d8c95080$8a5bf180$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] About POSIX "sched_yield/1-1.c" buld failure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Tuesday, November 02, 2010 3:43 PM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] About POSIX "sched_yield/1-1.c" buld failure
> =

> On Wed, Oct 27, 2010 at 7:44 PM, Mitani <mitani@ryobi.co.jp> wrote:
> >> -----Original Message-----
> >> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> >> Sent: Tuesday, October 26, 2010 3:57 PM
> >> To: Mitani
> >> Cc: ltp-list@lists.sourceforge.net
> >> Subject: Re: [LTP] About POSIX "sched_yield/1-1.c" buld failure
> >>
> >> On Mon, Oct 25, 2010 at 6:45 PM, Mitani <mitani@ryobi.co.jp> wrote:
> >> > Hi,
> >> >
> >> > I reported that build failure of POSIX test set
> >> "conformance/interfaces/
> >> > sched_yield/1-1" was still left in RHEL4.8 system:
> >> >
> >> >
> >>
> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg1071
> >> 3.html
> >> >
> >> > In addition, build of the following tests failed by the reason
> of
> >> > "undefined reference":
> >>
> >> =A0 =A0 Some versions of gcc didn't function properly with -lpthread;
> try
> >> -pthread instead at the top-level LDLIBS file and see whether or
> not
> >> it works for you.
> >> HTH,
> >> -Garrett
> >
> > Hi,
> >
> > I tried to use "-pthread" instead of "-lpthread".
> > But "sched_yield/1-1" failed in my all archtectures (RHEL4.8-x86,
> x86_64,
> > ia64).
> > Other 27 tests, too.
> =

> What does `man pthread_barrierattr_getpshared' say?
> -Garrett


"man pthread_barrierattr_getpshared" in my system "RHEL4.8-x86_64".

------------
[root@RHEL48-LTP-EM64T make]# man pthread_barrierattr_getpshared
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
[root@RHEL48-LTP-EM64T make]#
------------

In the manual, it seems not to be mentioned the necessity of the "". =

Sorry, but I examine context and e-mail a few days later.


Regards--

-Tomonori Mitani




---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
