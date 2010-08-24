Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OnrHJ-00054C-K6
	for ltp-list@lists.sourceforge.net; Tue, 24 Aug 2010 11:02:53 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OnrHI-0007VH-4K
	for ltp-list@lists.sourceforge.net; Tue, 24 Aug 2010 11:02:53 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7OAitsL009263
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Aug 2010 06:44:55 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7OB2kB8075358
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Aug 2010 07:02:46 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o7OB2jqR013743
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Aug 2010 05:02:45 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTinO-wfFsoQmCChRXSC0FpVSs0SGOkp4726yuyJF@mail.gmail.com>
References: <1281958501-17087-1-git-send-email-harsh@linux.vnet.ibm.com>
	<1281968496.5120.12.camel@subratamodak.linux.ibm.com>
	<AANLkTinO-wfFsoQmCChRXSC0FpVSs0SGOkp4726yuyJF@mail.gmail.com>
Date: Tue, 24 Aug 2010 16:32:47 +0530
Message-Id: <1282647767.4833.9.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] ltp setrlimit testcase patch for
	RLIMIT_FSIZE	resource
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Ok. Merged.

Regards--
Subrata

On Mon, 2010-08-16 at 08:52 -0700, Garrett Cooper wrote: 
> On Mon, Aug 16, 2010 at 7:21 AM, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
> > On Mon, 2010-08-16 at 17:05 +0530, Harsh Prateek Bora wrote:
> >> Current testcase for setrlimit resource RLIMIT_FSIZE
> >> is using a global integer variable to communicate the number of
> >> bytes from child to parent which is incorrect. This
> >> has been corrected by introducing a pipe to transfer
> >> this information from child to parent process.
> >>
> >> Signed-off-by: Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
> >> ---
> >>  testcases/kernel/syscalls/setrlimit/setrlimit01.c |   15 +++++++++++++++
> >>  1 files changed, 15 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
> >> index 6952eb3..2bb1e9d 100644
> >> --- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
> >> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
> >> @@ -156,7 +156,11 @@ void test2()
> >>        * an wired value!  So, it is essential to fflush the parent's
> >>        * write buffer HERE
> >>        */
> >> +     int pipefd[2];
> >>       fflush(stdout);
> >> +     if (pipe(pipefd) == -1) {
> >> +             tst_brkm(TBROK | TERRNO, NULL, "pipe creation failed");
> >> +     }
> >>
> >>       /*
> >>        * Spawn a child process, and reduce the filesize to
> >> @@ -170,6 +174,7 @@ void test2()
> >>       }
> >>
> >>       if (pid == 0) {
> >> +             close(pipefd[0]); /* close unused read end */
> >>               rlim.rlim_cur = 10;
> >>               rlim.rlim_max = 10;
> >>               if ((setrlimit(RLIMIT_FSIZE, &rlim)) == -1) {
> >> @@ -181,6 +186,11 @@ void test2()
> >>               }
> >>
> >>               if ((bytes = write(fd, buf, 26)) != 10) {
> >> +                     if (write(pipefd[1], &bytes, sizeof(bytes))
> >> +                             < sizeof(bytes)) {
> >> +                             perror("child: write to pipe failed");
> >
> > You still uses perror() here. Use tst_resm() instead.
> 
> This patch is actually ok. If you look at the test in context (as
> Harsh pointed out), the perror(3) call was within a forked process,
> and that's fine. It's the other areas that need to be tst_resm(3)
> calls because they're in the parent process and actually affect the
> final outcome of the test, and provide a uniform means of reporting.
> 
> Thanks,
> -Garrett


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
