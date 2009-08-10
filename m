Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MaQ8C-0005WQ-KC
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 08:21:24 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MaQ85-0000U6-AY
	for ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 08:21:24 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7A8KTVP007712
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Aug 2009 04:20:29 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7A8LB8S112634
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Aug 2009 04:21:11 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7A8LB4e003478
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Aug 2009 04:21:11 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810908070843r77eb24b3i57a8ce4a6a929362@mail.gmail.com>
References: <f5a7b3810906300005q2cafdd3dtfe4d659ae6834bb@mail.gmail.com>
	<20090721044529.GB9807@jenkins.home.ifup.org>
	<f5a7b3810907210622o1539087al1eca42cc900e9a02@mail.gmail.com>
	<f5a7b3810908070059x33ffce53n6b00e999232101e2@mail.gmail.com>
	<1249648941.4851.47.camel@subratamodak.linux.ibm.com>
	<f5a7b3810908070843r77eb24b3i57a8ce4a6a929362@mail.gmail.com>
Date: Mon, 10 Aug 2009 13:50:41 +0530
Message-Id: <1249892442.5187.13.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v2] mq_send/5-1.c: Fix race conditions in the test
Reply-To: subrata@linux.vnet.ibm.com
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Brandon Philips <bphilips@suse.de>, maxin john <maxinbjohn@gmail.com>

> >
> > And then resend.
> 
> I am resending the same patch after this change.
> 
> Best regards,
> Naresh Kamboju
> 
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

Thanks. Applied. However, they create the following avoidable issues.
Please take care next time while creating a patch :-)

(Stripping trailing CRs from patch.)
patching file
testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c
(Stripping trailing CRs from patch.)
patching file testcases/open_posix_testsuite/include/mq_send.h
(Stripping trailing CRs from patch.)
patching file testcases/open_posix_testsuite/include/posixtest.h

Regards--
Subrata

> 
> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c	2008-12-12
> 18:26:25.000000000 +0530
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c	2009-08-07
> 11:29:42.000000000 +0530
> @@ -37,6 +37,7 @@
>  #include <signal.h>
>  #include <errno.h>
>  #include "posixtest.h"
> +#include "mq_send.h"
> 
>  #define NAMESIZE 50
>  #define MSGSTR "0123456789"
> diff -Naurb a/testcases/open_posix_testsuite/include/mq_send.h
> b/testcases/open_posix_testsuite/include/mq_send.h
> --- a/testcases/open_posix_testsuite/include/mq_send.h	1970-01-01
> 05:30:00.000000000 +0530
> +++ b/testcases/open_posix_testsuite/include/mq_send.h	2009-08-07
> 11:28:41.000000000 +0530
> @@ -0,0 +1,92 @@
> +
> +/*
> + * Copyright (c) 2002, Intel Corporation.
> + * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
> + * This file is licensed under the GPL license.  For the full content
> + * of this license, see the COPYING file at the top level of this
> + * source tree.
> + */
> +
> +
> +#include <sys/select.h>
> +
> +
> +int sync_pipe_create(int fd[])
> +{
> +        return pipe (fd);
> +}
> +
> +int sync_pipe_close(int fd[])
> +{
> +        int r = 0;
> +
> +        if (fd[0] != -1)
> +                r = close (fd[0]);
> +        if (fd[1] != -1)
> +                r |= close (fd[1]);
> +        return r;
> +}
> +
> +int sync_pipe_wait(int fd[])
> +{
> +        char buf;
> +        int r;
> +
> +        if (fd[1] != -1) {
> +                close (fd[1]);
> +                fd[1] = -1;
> +        }
> +
> +        r = read (fd[0], &buf, 1);
> +
> +        if ((r != 1) || (buf != 'A'))
> +                return -1;
> +        return 0;
> +}
> +
> +int sync_pipe_wait_select(int fd[], long tv_sec)
> +{
> +        char buf;
> +        int r;
> +       fd_set rfds;
> +       struct timeval tv;
> +       int err;
> +
> +       tv.tv_sec = tv_sec;
> +       tv.tv_usec = 0;
> +
> +        if (fd[1] != -1) {
> +                close (fd[1]);
> +                fd[1] = -1;
> +        }
> +
> +       FD_ZERO(&rfds);
> +       FD_SET(fd[0], &rfds);
> +
> +       r = select(fd[0] + 1, &rfds, NULL, NULL, &tv);
> +       err = errno;
> +
> +       if (FD_ISSET(fd[0], &rfds)) {
> +               return sync_pipe_wait(fd);
> +       }
> +
> +       return r ? err : -ETIMEDOUT;
> +}
> +
> +
> +int sync_pipe_notify(int fd[])
> +{
> +        char buf = 'A';
> +        int r;
> +
> +        if (fd[0] != -1) {
> +                close (fd[0]);
> +                fd[0] = -1;
> +        }
> +
> +        r = write (fd[1], &buf, 1);
> +
> +        if (r != 1)
> +                return -1;
> +        return 0;
> +}
> diff -Naurb a/testcases/open_posix_testsuite/include/posixtest.h
> b/testcases/open_posix_testsuite/include/posixtest.h
> --- a/testcases/open_posix_testsuite/include/posixtest.h	2009-08-06
> 21:49:42.000000000 +0530
> +++ b/testcases/open_posix_testsuite/include/posixtest.h	2009-08-07
> 11:28:41.000000000 +0530
> @@ -15,86 +15,3 @@
>  #define PTS_UNSUPPORTED 4
>  #define PTS_UNTESTED    5
> 
> -
> -#include <sys/select.h>
> -
> -
> -int sync_pipe_create(int fd[])
> -{
> -        return pipe (fd);
> -}
> -
> -int sync_pipe_close(int fd[])
> -{
> -        int r = 0;
> -
> -        if (fd[0] != -1)
> -                r = close (fd[0]);
> -        if (fd[1] != -1)
> -                r |= close (fd[1]);
> -        return r;
> -}
> -
> -int sync_pipe_wait(int fd[])
> -{
> -        char buf;
> -        int r;
> -
> -        if (fd[1] != -1) {
> -                close (fd[1]);
> -                fd[1] = -1;
> -        }
> -
> -        r = read (fd[0], &buf, 1);
> -
> -        if ((r != 1) || (buf != 'A'))
> -                return -1;
> -        return 0;
> -}
> -
> -int sync_pipe_wait_select(int fd[], long tv_sec)
> -{
> -        char buf;
> -        int r;
> -       fd_set rfds;
> -       struct timeval tv;
> -       int err;
> -
> -       tv.tv_sec = tv_sec;
> -       tv.tv_usec = 0;
> -
> -        if (fd[1] != -1) {
> -                close (fd[1]);
> -                fd[1] = -1;
> -        }
> -
> -       FD_ZERO(&rfds);
> -       FD_SET(fd[0], &rfds);
> -
> -       r = select(fd[0] + 1, &rfds, NULL, NULL, &tv);
> -       err = errno;
> -
> -       if (FD_ISSET(fd[0], &rfds)) {
> -               return sync_pipe_wait(fd);
> -       }
> -
> -       return r ? err : -ETIMEDOUT;
> -}
> -
> -
> -int sync_pipe_notify(int fd[])
> -{
> -        char buf = 'A';
> -        int r;
> -
> -        if (fd[0] != -1) {
> -                close (fd[0]);
> -                fd[0] = -1;
> -        }
> -
> -        r = write (fd[1], &buf, 1);
> -
> -        if (r != 1)
> -                return -1;
> -        return 0;
> -}
> 
> >
> > Regards--
> > Subrata
> >
> >> + * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
> >> + * This file is licensed under the GPL license.  For the full content
> >> + * of this license, see the COPYING file at the top level of this
> >> + * source tree.
> >> + */
> >> +
> >> +
> >> +#include <sys/select.h>
> >> +
> >> +
> >> +int sync_pipe_create(int fd[])
> >> +{
> >> +        return pipe (fd);
> >> +}
> >> +
> >> +int sync_pipe_close(int fd[])
> >> +{
> >> +        int r = 0;
> >> +
> >> +        if (fd[0] != -1)
> >> +                r = close (fd[0]);
> >> +        if (fd[1] != -1)
> >> +                r |= close (fd[1]);
> >> +        return r;
> >> +}
> >> +
> >> +int sync_pipe_wait(int fd[])
> >> +{
> >> +        char buf;
> >> +        int r;
> >> +
> >> +        if (fd[1] != -1) {
> >> +                close (fd[1]);
> >> +                fd[1] = -1;
> >> +        }
> >> +
> >> +        r = read (fd[0], &buf, 1);
> >> +
> >> +        if ((r != 1) || (buf != 'A'))
> >> +                return -1;
> >> +        return 0;
> >> +}
> >> +
> >> +int sync_pipe_wait_select(int fd[], long tv_sec)
> >> +{
> >> +        char buf;
> >> +        int r;
> >> +       fd_set rfds;
> >> +       struct timeval tv;
> >> +       int err;
> >> +
> >> +       tv.tv_sec = tv_sec;
> >> +       tv.tv_usec = 0;
> >> +
> >> +        if (fd[1] != -1) {
> >> +                close (fd[1]);
> >> +                fd[1] = -1;
> >> +        }
> >> +
> >> +       FD_ZERO(&rfds);
> >> +       FD_SET(fd[0], &rfds);
> >> +
> >> +       r = select(fd[0] + 1, &rfds, NULL, NULL, &tv);
> >> +       err = errno;
> >> +
> >> +       if (FD_ISSET(fd[0], &rfds)) {
> >> +               return sync_pipe_wait(fd);
> >> +       }
> >> +
> >> +       return r ? err : -ETIMEDOUT;
> >> +}
> >> +
> >> +
> >> +int sync_pipe_notify(int fd[])
> >> +{
> >> +        char buf = 'A';
> >> +        int r;
> >> +
> >> +        if (fd[0] != -1) {
> >> +                close (fd[0]);
> >> +                fd[0] = -1;
> >> +        }
> >> +
> >> +        r = write (fd[1], &buf, 1);
> >> +
> >> +        if (r != 1)
> >> +                return -1;
> >> +        return 0;
> >> +}
> >> diff -Naurb a/testcases/open_posix_testsuite/include/posixtest.h
> >> b/testcases/open_posix_testsuite/include/posixtest.h
> >> --- a/testcases/open_posix_testsuite/include/posixtest.h      2009-08-06
> >> 21:49:42.000000000 +0530
> >> +++ b/testcases/open_posix_testsuite/include/posixtest.h      2009-08-07
> >> 11:28:41.000000000 +0530
> >> @@ -15,86 +15,3 @@
> >>  #define PTS_UNSUPPORTED 4
> >>  #define PTS_UNTESTED    5
> >>
> >> -
> >> -#include <sys/select.h>
> >> -
> >> -
> >> -int sync_pipe_create(int fd[])
> >> -{
> >> -        return pipe (fd);
> >> -}
> >> -
> >> -int sync_pipe_close(int fd[])
> >> -{
> >> -        int r = 0;
> >> -
> >> -        if (fd[0] != -1)
> >> -                r = close (fd[0]);
> >> -        if (fd[1] != -1)
> >> -                r |= close (fd[1]);
> >> -        return r;
> >> -}
> >> -
> >> -int sync_pipe_wait(int fd[])
> >> -{
> >> -        char buf;
> >> -        int r;
> >> -
> >> -        if (fd[1] != -1) {
> >> -                close (fd[1]);
> >> -                fd[1] = -1;
> >> -        }
> >> -
> >> -        r = read (fd[0], &buf, 1);
> >> -
> >> -        if ((r != 1) || (buf != 'A'))
> >> -                return -1;
> >> -        return 0;
> >> -}
> >> -
> >> -int sync_pipe_wait_select(int fd[], long tv_sec)
> >> -{
> >> -        char buf;
> >> -        int r;
> >> -       fd_set rfds;
> >> -       struct timeval tv;
> >> -       int err;
> >> -
> >> -       tv.tv_sec = tv_sec;
> >> -       tv.tv_usec = 0;
> >> -
> >> -        if (fd[1] != -1) {
> >> -                close (fd[1]);
> >> -                fd[1] = -1;
> >> -        }
> >> -
> >> -       FD_ZERO(&rfds);
> >> -       FD_SET(fd[0], &rfds);
> >> -
> >> -       r = select(fd[0] + 1, &rfds, NULL, NULL, &tv);
> >> -       err = errno;
> >> -
> >> -       if (FD_ISSET(fd[0], &rfds)) {
> >> -               return sync_pipe_wait(fd);
> >> -       }
> >> -
> >> -       return r ? err : -ETIMEDOUT;
> >> -}
> >> -
> >> -
> >> -int sync_pipe_notify(int fd[])
> >> -{
> >> -        char buf = 'A';
> >> -        int r;
> >> -
> >> -        if (fd[0] != -1) {
> >> -                close (fd[0]);
> >> -                fd[0] = -1;
> >> -        }
> >> -
> >> -        r = write (fd[1], &buf, 1);
> >> -
> >> -        if (r != 1)
> >> -                return -1;
> >> -        return 0;
> >> -}
> >
> >


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
