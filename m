Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1P45WE-0002D7-0h
	for ltp-list@lists.sourceforge.net; Fri, 08 Oct 2010 05:29:22 +0000
Received: from out20.sjc.mx.trendmicro.com ([216.99.131.77])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P45WC-00049F-Ik
	for ltp-list@lists.sourceforge.net; Fri, 08 Oct 2010 05:29:21 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.133])
	by out20.sjc.mx.trendmicro.com (Postfix) with ESMTP id 684CC980470
	for <ltp-list@lists.sourceforge.net>;
	Fri,  8 Oct 2010 05:29:14 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id D5C359583F
	for <ltp-list@lists.sourceforge.net>;
	Fri,  8 Oct 2010 05:29:08 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Oct 2010 14:29:06 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 8 Oct 2010 14:29:08 +0900
Message-ID: <000001cb66a9$bb3c52b0$31b4f810$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] POSIX "aio_return/2-1" failed.
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
To: ltp-list@lists.sourceforge.net

Hi,


"conformance/interfaces/aio_return/2-1" failed with following message:
------------
conformance/interfaces/aio_return/2-1: execution: FAILED: Output: 
aio_return/2-1.c Second call to aio_return() should return -1 : 111
------------

Same problem occurs in "aio_return/3-2.c" and "aio_return/4-1".

Environment is as follows:
  - RHEL5.5 --- (x86, x86_64, ia64)
  - RHEL4.8 --- (x86, x86_64, ia64)


This testset seems to be the error root test for "aio_return()".

First "aio_return()" returned with 111. This return value is the length 
of buffer of "aio_write()".
But second "aio_return()" returned with 111, too. It's unexpected 
result for this test set.
Therefore, this test failed.

Man page says that 
"This function should be called only once for any given request,  after
aio_error(2) returns something other than EINPROGRESS.":
------------
# LANG=C man 3 aio_return

AIO_RETURN(3)                  Linux Programmer's Manual
AIO_RETURN(3)

NAME
       aio_return - get return status of asynchronous I/O operation

SYNOPSIS
       #include <aio.h>

       ssize_t aio_return(struct aiocb *aiocbp);

DESCRIPTION
       The aio_return function returns the final return status for the
asynchronous I/O
       request with control block pointed to by aiocbp.

       This  function  should  be  called  only  once  for  any  given
request,  after
       aio_error(2) returns something other than EINPROGRESS.

RETURN VALUE
       If the asynchronous I/O operation has completed, this function
returns the value
       that would have been returned in case of a synchronous  read,  write,
or  fsync
       request.  Otherwise the return value is undefined.  On error, the
error value is
       returned.

ERRORS
       EINVAL aiocbp does not point at a control block for an asynchronous
I/O  request
              of which the return status has not been retrieved yet.

CONFORMING TO
       POSIX 1003.1-2003

SEE ALSO
       aio_cancel(3),    aio_error(3),   aio_fsync(3),   aio_read(3),
aio_suspend(3),
       aio_write(3)

                                       2003-11-14
AIO_RETURN(3)
#
------------

And, it says that 
"If the asynchronous I/O operation has completed, this function returns
the value that would have been returned in case of a synchronous read,
write, or fsync request.  Otherwise the return value is undefined.  On
error, the error value is returned.".


It can be supposed that the return value of second "aio_return()" is 
undefined.
Therefore, it is not mistake that return value of the second "aio_return()" 
is one at success, I think.
And, I think that "UNTESTED" or "UNRESOLVED" may be is more appropriate 
for this test.

How does that look?


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
