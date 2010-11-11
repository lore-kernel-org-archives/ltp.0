Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1PGS2M-0005I1-AN
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 07:57:38 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGS2J-00081r-VD
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 07:57:38 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAB7jtAZ019749
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 00:45:55 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAB7vQYn127524
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 00:57:26 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAB7vPY0016301
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 00:57:26 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTikF7H=urGWh8pJDYse1cpgeK0m+8UoNfO5B2qL4@mail.gmail.com>
References: <1509752323.1389371288852590538.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<AANLkTikF7H=urGWh8pJDYse1cpgeK0m+8UoNfO5B2qL4@mail.gmail.com>
Date: Thu, 11 Nov 2010 13:27:12 +0530
Message-Id: <1289462232.5622.41.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v3] functional testing for Kernel Samepage Merging
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Mon, 2010-11-08 at 13:48 -0800, Garrett Cooper wrote: 
> On Wed, Nov 3, 2010 at 11:36 PM, CAI Qian <caiqian@redhat.com> wrote:
> > Basic tests were to start several programs with same and different
> > memory contents and ensure only to merge the ones with the same
> > contents. When changed the content of one of merged pages in a
> > process and to the mode "unmerging", it should discard all merged
> > pages there. Also tested it is possible to disable KSM. There are
> > also command-line options to specify the memory allocation size, and
> > number of processes have same memory contents so it is possible to
> > test more advanced things like KSM + OOM etc. KSM statistics numbers
> > look like hard to predict, so only check the ranges.
> 
> Can you provide documentation that describes the functionality under test?

Cai,

Can we get a V4 quickly. I can see that the initial submission has been
quite long back :-)

Regards--
Subrata

> 
> > Signed-off-by: CAI Qian <caiqian@redhat.com>
> > ---
> > v3: fixed expected values based on the feedback from KSM developers;
> >    fixed madvise return code; replaced malloc with mmap calls to better
> >    align page boundaries; added additional memory content verification
> >    after each run.
> >
> > v2: fixed stupid mistakes about memory content assignment.
> >
> >  testcases/kernel/mem/ksm/Makefile |   22 ++
> >  testcases/kernel/mem/ksm/ksm01.c  |  634 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 656 insertions(+), 0 deletions(-)
> >  create mode 100644 testcases/kernel/mem/ksm/Makefile
> >  create mode 100644 testcases/kernel/mem/ksm/ksm01.c
> >
> > diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm/Makefile
> > new file mode 100644
> > index 0000000..d3eb6ef
> > --- /dev/null
> > +++ b/testcases/kernel/mem/ksm/Makefile
> > @@ -0,0 +1,22 @@
> > +#
> > +#  Copyright (c) International Business Machines  Corp., 2001
> 
> Please fix the copyright date and owner.
> 
> ...
> 
> > + * 1) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
> > + *    distrub the testing as they also change some ksm tunables depends
> 
> *disturb
> 
> > + *    on current workloads.
> 
> How does one do this manually? Documentation?
> 
> > + * The test steps are:
> > + * - Check ksm feature and backup current run setting.
> > + * - Change run setting to 1 - merging.
> > + * - 3 memory allocation programs have the memory contents that 2 of
> > + *   them are all 'a' and one is all 'b'.
> > + * - Check ksm statistics and verify the content.
> > + * - 1 program changes the memory content from all 'a' to all 'b'.
> > + * - Check ksm statistics and verify the content.
> > + * - All programs change the memory content to all 'd'.
> > + * - Check ksm statistics and verify the content.
> > + * - Change one page of a process.
> > + * - Check ksm statistics and verify the content.
> > + * - Change run setting to 2 - unmerging.
> > + * - Check ksm statistics and verify the content.
> > + * - Change run setting to 0 - stop.
> 
> ...
> 
> > +       /* Check looping state if -i option given */
> > +       for (lc = 0; TEST_LOOPING(lc); lc++) {
> > +               /* Reset Tst_count in case we are looping. */
> > +               Tst_count = 0;
> > +
> > +               TEST(ksmtest());
> 
> There's no sense in running this through the TEST macro if you aren't
> going to use TEST_RETURN or TEST_ERRNO.
> 
> > +       }
> > +       cleanup();
> > +       return 0;
> 
> ...
> 
> > +       memory = malloc(num * sizeof(**memory));
> 
> Why are you referencing memory twice and then allocating heap memory
> to the pointer to memory? Seems really leaky.
> 
> > +       if (memory == NULL)
> > +               tst_brkm(TBROK, cleanup, "malloc");
> > +
> > +       if ((child[0] = fork()) == -1)
> > +               tst_brkm(TBROK|TERRNO, cleanup, "fork");
> > +       else if (child[0] == 0) {
> > +               tst_resm(TINFO, "child 0 stops.");
> > +               if (raise(SIGSTOP) == -1)
> 
> a.
> 
> switch ((child[0] = fork()) {
> case -1:
>     /* BUSTED */
>     break;
> case 0:
>     /* CHILD */
>     break;
> default:
>     /* PARENT */
>     break;
> }
> 
>     Is generally a bit easier to follow.
> b. Why not use kill(2)?
> 
> > +                       tst_brkm(TBROK|TERRNO, cleanup, "kill");
> > +
> > +               tst_resm(TINFO, "child 0 continues...");
> > +
> > +               /* Avoid THP allocation which can't ksm ATM. */
> 
> What does THP mean and why not just spell out ATM as "at the moment"?
> Less acronyms -> less confusion :).
> 
> > +               tst_resm(TINFO,
> > +                       "child 0 allocates %d MB filled with 'c'.",
> > +                       size);
> > +
> > +               memory[0] = malloc(size * sizeof(*memory));
> 
> More leaky memory?
> 
> > +               if (memory[0] == NULL)
> > +                       tst_brkm(TBROK|TERRNO, cleanup, "malloc");
> > +
> > +               for (j = 0; j < size; j++) {
> > +                       memory[0][j] = mmap(NULL, MB,
> > +                                       PROT_READ|PROT_WRITE,
> > +                                       MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> > +                       if (memory[0][j] == NULL)
> 
> I think you meant MAP_FAILED, not NULL.
> 
> > +                               tst_brkm(TBROK|TERRNO, cleanup, "mmap");
> > +                       if (madvise(memory[0][j], MB, MADV_MERGEABLE)
> > +                               == -1)
> > +                               tst_brkm(TBROK|TERRNO, cleanup,
> > +                                       "madvise");
> > +                       for (i = 0; i < MB; i++)
> > +                               memory[0][j][i] = 'c';
> 
> You could just use memset.
> 
> > +               }
> > +               tst_resm(TINFO, "child 0 stops.");
> > +               if (raise(SIGSTOP) == -1)
> > +                       tst_brkm(TBROK|TERRNO, cleanup, "kill");
> > +
> > +               tst_resm(TINFO, "child 0 continues...");
> > +               verify('c', 0, 0, size, 0, MB);
> > +               tst_resm(TINFO,
> > +                       "child 0 changes memory content to 'd'.");
> > +
> > +               for (j = 0; j < size; j++) {
> > +                       for (i = 0; i < MB; i++)
> > +                               memory[0][j][i] = 'd';
> 
> memset here too.
> 
> > +               }
> > +               /* Unmerge. */
> > +               tst_resm(TINFO, "child 0 stops.");
> > +               if (raise(SIGSTOP) == -1)
> 
> kill? here too.
> 
> > +                       tst_brkm(TBROK|TERRNO, cleanup, "kill");
> > +
> > +               tst_resm(TINFO, "child 0 continues...");
> > +               verify('d', 0, 0, size, 0, MB);
> > +
> > +               /* Stop. */
> > +               tst_resm(TINFO, "child 0 stops.");
> > +               if (raise(SIGSTOP) == -1)
> 
> kill? here too.
> 
> > +                       tst_brkm(TBROK|TERRNO, cleanup, "kill");
> > +
> > +               tst_resm(TINFO, "child 0 continues...");
> > +
> > +               exit(0);
> > +       }
> > +       if ((child[1] = fork()) == -1)
> > +               tst_brkm(TBROK|TERRNO, cleanup, "fork");
> > +       else if (child[1] == 0) {
> > +               tst_resm(TINFO, "child 1 stops.");
> > +               if (raise(SIGSTOP) == -1)
> 
> Same comments as above about kill and fork-switch.
> 
> ...
> 
> > +               if (waitpid(child[k], &status, WUNTRACED) == -1)
> 
> Do WUNTRACED | WNOHANG and sleep each iteration in the loop to avoid
> chewing up the CPU?
> 
> > +                       tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> > +               if (!WIFSTOPPED(status))
> > +                       tst_brkm(TBROK, cleanup,
> > +                               "child %d was not stopped.", k);
> > +       }
> > +
> > +       tst_resm(TINFO, "resume all children.");
> > +       for (k = 0; k < num; k++) {
> > +               if (kill(child[k], SIGCONT) == -1)
> > +                       tst_brkm(TBROK|TERRNO, cleanup,
> > +                               "kill child[%d]", k);
> > +       }
> > +       sleep(5);
> > +       tst_resm(TINFO, "check!");
> > +       check("run", NULL, 1);
> > +       check("pages_shared", NULL, 2);
> > +       check("pages_sharing", "pages_volatile", size * num * 256 - 2);
> > +       check("pages_unshared", NULL, 0);
> > +       check("sleep_millisecs", NULL, 0);
> > +       check("pages_to_scan", NULL, size * 256 * num);
> 
> A lot of this logic is unnecessarily duplicated below; please move it
> out into a function.
> 
> ...
> 
> > +       TEST_CLEANUP;
> > +       tst_rmdir();
> 
> Do you really need a temporary test directory? If not, I'd just drop
> cleanup and set all references to it in tst_brkm to NULL.
> 
> > +       tst_exit();
> > +}
> 
> ...
> 
> > +                       tst_brkm(TBROK, NULL, "stat");
> 
> TBROK | TERRNO please.
> 
> ...
> 
> > +       tst_resm(TINFO, "child %d verifies memory content.", proc);
> > +       for (j = start; j < end; j++)
> > +               for (i = start2; i < end2; i++)
> > +                       if (memory[proc][j][i] != value)
> > +                               tst_resm(TFAIL,
> > +                                       "child %d has %c at %d,%d,%d.",
> > +                                       proc, memory[proc][j][i], proc,
> > +                                       j, i);
> 
> memcmp'ing a fixed buffer should be considerably faster verifying
> values byte by byte.
> 
> Thanks,
> -Garrett
> 
> ------------------------------------------------------------------------------
> The Next 800 Companies to Lead America's Growth: New Video Whitepaper
> David G. Thomson, author of the best-selling book "Blueprint to a 
> Billion" shares his insights and actions to help propel your 
> business during the next growth cycle. Listen Now!
> http://p.sf.net/sfu/SAP-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
