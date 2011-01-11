Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PcaHV-00082X-17
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 09:12:45 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PcaHS-0003Od-OU
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 09:12:44 +0000
Date: Tue, 11 Jan 2011 04:12:35 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1783539079.43214.1294737155893.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <95E78125-2C7F-4FC1-B547-C700EAA923B0@gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 13/13] oom04: check root
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>



----- Original Message -----
> On Jan 11, 2011, at 12:57 AM, CAI Qian wrote:
> 
> > Signed-off-by: CAI Qian <caiqian@redhat.com>
> > ---
> > testcases/kernel/mem/oom/oom04.c | 2 ++
> > 1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/testcases/kernel/mem/oom/oom04.c
> > b/testcases/kernel/mem/oom/oom04.c
> > index 5b403f4..befb7e9 100644
> > --- a/testcases/kernel/mem/oom/oom04.c
> > +++ b/testcases/kernel/mem/oom/oom04.c
> > @@ -133,6 +133,8 @@ void setup(void)
> > {
> > 	int fd;
> >
> > + tst_require_root(tst_exit);
> > +
> > 	tst_sig(FORK, DEF_HANDLER, cleanup);
> > 	TEST_PAUSE;
> 
> tst_require_root(NULL) is what you want for all of these patches.
> Makes me wonder if there's any value in having a cleanup argument or
> not...
I did try tst_require_root(NULL), but it kept calling cleanup() which
was unnecessary.

$ ./hugemmap05
hugemmap05    1  TCONF  :  Test needs to be run as root
hugemmap05    0  TWARN  :  open: errno=EACCES(13): Permission denied
hugemmap05    0  TINFO  :  restore nr_hugepages to .
hugemmap05    0  TWARN  :  write: errno=EBADF(9): Bad file descriptor
hugemmap05    0  TWARN  :  open: errno=EACCES(13): Permission denied
hugemmap05    0  TINFO  :  restore nr_overcommit_hugepages to .
hugemmap05    0  TWARN  :  write: errno=EBADF(9): Bad file descriptor
hugemmap05    0  TWARN  :  umount: errno=ENOENT(2): No such file or directory

CAI Qian

------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
