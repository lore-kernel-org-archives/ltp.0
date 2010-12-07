Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PPmkF-00072u-Hs
	for ltp-list@lists.sourceforge.net; Tue, 07 Dec 2010 01:53:31 +0000
Received: from out08.sjc.mx.trendmicro.com ([216.99.131.45])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PPmkE-0006Ot-1A
	for ltp-list@lists.sourceforge.net; Tue, 07 Dec 2010 01:53:31 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.10])
	by out08.sjc.mx.trendmicro.com (Postfix) with ESMTP id 061A398041B
	for <ltp-list@lists.sourceforge.net>;
	Tue,  7 Dec 2010 01:53:24 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 903C79583C
	for <ltp-list@lists.sourceforge.net>;
	Tue,  7 Dec 2010 01:53:23 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Dec 2010 10:53:21 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 7 Dec 2010 10:53:21 +0900
Message-ID: <000001cb95b1$86e389c0$94aa9d40$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] POSIX "aio_read/8-1" and "aio_write/6-1" failed.
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


"aio_read/8-1" and "aio_write/6-1" tests failed in my environments 
(RHEL5.5-x86, RHEL4.8-x86_64/ia64):
------------<RHEL5.5 - x86>
conformance/interfaces/aio_read/8-1: execution: FAILED: Output: 
aio_read/8-1.c aio_read() should fail!
[...]
conformance/interfaces/aio_write/6-1: execution: FAILED: Output: 
aio_write/6-1.c aio_write should fail!
------------


I tried "aio_read/8-1" manually:
------------
[root@RHEL55-LTP-x86 aio_read]# ./8-1.run-test
aio_return: 0
aio_read(errno): 0
aio_read(strerror): Success
aio_read/8-1.c aio_read() should fail!
------------

This test expects that "aio_read()" with "aio_buf = NULL" fails:
------------<aio_read/8-1.c>
 *      - fill in an aiocb with a NULL aio_buf
 *      - call aio_read
 *      - check aio_read return value
 */
[...]
int main()
{
        struct aiocb aiocb;

        if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
                return PTS_UNSUPPORTED;

        /* submit a request with a NULL buffer */
        aiocb.aio_fildes = 0;
        aiocb.aio_buf = NULL;
        aiocb.aio_nbytes = 0;
        aiocb.aio_offset = 0;

        if (aio_read(&aiocb) != -1)
        {
                printf(TNAME " aio_read() should fail!\n");
                exit(PTS_FAIL);
        }
------------

But "aio_read()" succeeded.


The manual says:
------------
[root@RHEL55-LTP-x86 aio_read]# man aio_read
AIO_READ(3)                Linux Programmer's Manual
AIO_READ(3)

NAME
       aio_read - asynchronous read

SYNOPSIS
       #include <aio.h>

       int aio_read(struct aiocb *aiocbp);

[...]
RETURN VALUE
       On success, 0 is returned. On error the request is  not  enqueued,
-1  is
       returned,  and  errno  is set appropriately. If an error is first
detected
       later, it will be reported  via  aio_return(3)  (returns  status  -1)
and
       aio_error(3)  (error  status whatever one would have gotten in errno,
such
       as EBADF).

ERRORS
       EAGAIN Out of resources.

       EBADF  aio_fildes is not a valid file descriptor open for reading.

       EINVAL One or more of aio_offset, aio_reqprio, aio_nbytes are
invalid.

       ENOSYS This function is not supported.

       EOVERFLOW
              The file is a regular file, we start reading before
end-of-file and
              want at least one byte, but the starting position is past the
maxi-
              mum offset for this file.

NOTES
       It is a good idea to zero out the control block before use.  This
control
       block  must  not  be changed while the read operation is in progress.
The
       buffer area being read into must not be accessed during the
operation  or
       undefined  results may occur. The memory areas involved must remain
valid.
------------

Manual says that "aio_read()" fails when aio_offset, aio_reqprio, 
aio_nbytes, aio_fildes are invalid.
But the manual doesn't say about "aio_buf".

"aio_write/6-1"is same situation as "aio_read/8-1".

What meaning do these tests have?
Does "aio_read()" fail in the systems except Linux?
If so, may I judge the possibility of this tests by judging 
the environment is Linux or not?


Please give me some opinion.


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
