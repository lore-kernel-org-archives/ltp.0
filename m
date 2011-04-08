Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1Q82Ib-00012n-Rr
	for ltp-list@lists.sourceforge.net; Fri, 08 Apr 2011 03:23:53 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q82Ia-000281-GA
	for ltp-list@lists.sourceforge.net; Fri, 08 Apr 2011 03:23:53 +0000
Date: Fri, 8 Apr 2011 11:28:44 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110408032844.GA2945@hpt.nay.redhat.com>
References: <2025116569.785721.1302133158267.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<4D9D5128.3060709@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D9D5128.3060709@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH]KSM: full_scans will stop increasing
	after	stopping ksm
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Apr 07, 2011 at 01:52:40PM +0800, Bian Naimeng wrote:
> 
> 
> CAI Qian wrote:
> > 
> > ----- Original Message -----
> >> Qian Cai wrote:
> >>> On 2011-4-4, at 0:47, Bian Naimeng <biannm@cn.fujitsu.com> wrote:
> >>>
> >>>> There are some problem in ksm tests.
> >>>>
> >>>> 1. We should break the test when checking is failure.
> >>> No, this is not the intention. The design here is to run all tests
> >>> to check for all stats to give a full picture even if the a single
> >>> failure has been observed. This type of the failures do not prevent
> >>> the rest of the tests from running, so there is no need to stop the
> >>> tests now which also give more insight to track down root causes.
> >> Various reason can make checking failure, someone can make the test
> >> hangup.
> >> I did this test on RHEL5, i found ksmd stopped before doing "echo 2 >
> >> /sys/kernel/mm/ksm/run",
> >> so group_check will be hanged on "new_num < old_num * 3".
> >>
> >> So, i think we should break the test if "run" is not expecting.
> > What happened if you run the tests for a recent upstream kernel? There
> > are some patches for ksm recently merged upstream. If the problem still
> > persistent, please paste the EXACT OUTPUT from the ksm01 test. If it is
> > hung, please upload sysrq-t output somewhere.
> > 
> 
> Maybe there are some bugs in the RHEL6's kernel, but the purpose of this patch
> is not to workround these bugs, i want to fix the test's bug.
> 
> Would you explain to me why we do this loop "while (new_num < old_num * 3)" in
> group_check, i think "while (new_num < old_num + 3)" is better.
> 
> Some time ago, the following patch insert this loop.
> http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTi%3Dg%3DojJu0m%2B556rnekYenRTXtX%2BVBOj%3DrPmnjSw%40mail.gmail.com&forum_name=ltp-list
> 
> The changelog of this patch said "we should wait 3~5 increments of the
> /sys/kernel/mm/ksm/full_scans before checking ksm* testcases's results", but
> it do "while (new_num < old_num * 3)" actually.
I made a mistake. The code is what I wanted to do, but the changelog was
wrong. When testing the new ksm patch, the developer told us we must
wait 3~5 times increments of the number before checking testing
results. So I coded to wait til new_num >= old_num * 3 before checking
the results. 

About 'echo 2 > /sys/kernel/mm/ksm/run' problem, I have tested it with
ksm01.
If I run the 'echo 2 > /sys/kernel/mm/ksm/run' before issue ksm test,
the content of /sys/kernel/mm/ksm/run will be changed to 1 and the test
can finished successfully. Only if I echo the 2 between the testing process,
ksm01 will hang up. On that time, new_num will be zero, so your plus 3
method won't work either. So what should we do in this circumstance?

Thanks.

Han Pingtian
> 
> Regards
>  Bian
> 
> > CAI Qian
> >  
> >>>> 2. The condition "new_num < old_num * 3" seems uncomfortable, i
> >>>> think
> >>>>   it should be "new_num < old_num + 3"
> >>> I don't understand. What error did you see from the testing output?
> >> Sometimes, the old_num is a big number, so it takes long time in this
> >> loop,
> >> i don't understand the purpose.
> >> Would you explain to me why we expect this condition "new_num <
> >> old_num * 3".
> >>
> >>>> 3. After stopping ksm(echo 2 > /sys/kernel/mm/ksm/run), the ksmd
> >>>>   will stop scaning pages, so looping in "new_num < old_num * 3"
> >>>>   is wrong.
> >>> Ditto.
> >>>
> >> After stopping ksm, looping in "new_num < old_num * 3" will make the
> >> process hang up,
> >> because new_num does not be increased.
> >>
> >> Regards
> >> Bian
> >>
> >>
> >>> CAI Qian
> >>>> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
> >>>>
> >>>> ---
> >>>> testcases/kernel/mem/include/mem.h | 2 +-
> >>>> testcases/kernel/mem/lib/mem.c | 19 ++++++++++---------
> >>>> 2 files changed, 11 insertions(+), 10 deletions(-)
> >>>>
> >>>> diff --git a/testcases/kernel/mem/include/mem.h
> >>>> b/testcases/kernel/mem/include/mem.h
> >>>> index 778d403..b640a63 100644
> >>>> --- a/testcases/kernel/mem/include/mem.h
> >>>> +++ b/testcases/kernel/mem/include/mem.h
> >>>> @@ -42,7 +42,7 @@ void check(char *path, long int value);
> >>>> void verify(char value, int proc, int start, int end, int start2,
> >>>> int end2);
> >>>> void group_check(int run, int pages_shared, int pages_sharing,
> >>>>        int pages_volatile, int pages_unshared, int sleep_millisecs,
> >>>> - int pages_to_scan);
> >>>> + int pages_to_scan, int scans);
> >>>> void create_same_memory(int size, int num, int unit);
> >>>> void check_ksm_options(int *size, int *num, int *unit);
> >>>> void write_cpusets(void);
> >>>> diff --git a/testcases/kernel/mem/lib/mem.c
> >>>> b/testcases/kernel/mem/lib/mem.c
> >>>> index 12e61e9..db1a7dd 100644
> >>>> --- a/testcases/kernel/mem/lib/mem.c
> >>>> +++ b/testcases/kernel/mem/lib/mem.c
> >>>> @@ -284,7 +284,7 @@ void check(char *path, long int value)
> >>>>
> >>>>    tst_resm(TINFO, "%s is %ld.", path, atol(buf));
> >>>>    if (atol(buf) != value)
> >>>> - tst_resm(TFAIL, "%s is not %ld.", path, value);
> >>>> + tst_brkm(TFAIL, tst_exit, "%s is not %ld.", path, value);
> >>>> }
> >>>>
> >>>> void verify(char value, int proc, int start, int end, int start2,
> >>>> int end2)
> >>>> @@ -312,7 +312,8 @@ void verify(char value, int proc, int start,
> >>>> int end, int start2, int end2)
> >>>>
> >>>> void group_check(int run, int pages_shared, int pages_sharing,
> >>>>        int pages_volatile, int pages_unshared,
> >>>> - int sleep_millisecs, int pages_to_scan)
> >>>> + int sleep_millisecs, int pages_to_scan,
> >>>> + int scans)
> >>>> {
> >>>>    int fd;
> >>>>    char buf[BUFSIZ];
> >>>> @@ -332,7 +333,7 @@ void group_check(int run, int pages_shared, int
> >>>> pages_sharing,
> >>>>    old_num = new_num = atoi(buf);
> >>>>    if (lseek(fd, 0, SEEK_SET) == -1)
> >>>>        tst_brkm(TBROK|TERRNO, cleanup, "lseek");
> >>>> - while (new_num < old_num * 3) {
> >>>> + while (new_num < old_num + scans) {
> >>>>        sleep(1);
> >>>>        if (read(fd, buf, BUFSIZ) < 0)
> >>>>            tst_brkm(TBROK|TERRNO, cleanup, "read");
> >>>> @@ -587,7 +588,7 @@ void create_same_memory(int size, int num, int
> >>>> unit)
> >>>>        if (kill(child[k], SIGCONT) == -1)
> >>>>            tst_brkm(TBROK|TERRNO, cleanup, "kill child[%d]", k);
> >>>>    }
> >>>> - group_check(1, 2, size * num * 256 - 2, 0, 0, 0, size * 256 *
> >>>> num);
> >>>> + group_check(1, 2, size * num * 256 - 2, 0, 0, 0, size * 256 *
> >>>> num, 3);
> >>>>
> >>>>    tst_resm(TINFO, "wait for child 1 to stop.");
> >>>>    if (waitpid(child[1], &status, WUNTRACED) == -1)
> >>>> @@ -599,7 +600,7 @@ void create_same_memory(int size, int num, int
> >>>> unit)
> >>>>    tst_resm(TINFO, "resume child 1.");
> >>>>    if (kill(child[1], SIGCONT) == -1)
> >>>>        tst_brkm(TBROK|TERRNO, cleanup, "kill");
> >>>> - group_check(1, 3, size * num * 256 - 3, 0, 0, 0, size * 256 *
> >>>> num);
> >>>> + group_check(1, 3, size * num * 256 - 3, 0, 0, 0, size * 256 *
> >>>> num, 3);
> >>>>
> >>>>    tst_resm(TINFO, "wait for child 1 to stop.");
> >>>>    if (waitpid(child[1], &status, WUNTRACED) == -1)
> >>>> @@ -613,7 +614,7 @@ void create_same_memory(int size, int num, int
> >>>> unit)
> >>>>        if (kill(child[k], SIGCONT) == -1)
> >>>>            tst_brkm(TBROK|TERRNO, cleanup, "kill child[%d]", k);
> >>>>    }
> >>>> - group_check(1, 1, size * num * 256 - 1, 0, 0, 0, size * 256 *
> >>>> num);
> >>>> + group_check(1, 1, size * num * 256 - 1, 0, 0, 0, size * 256 *
> >>>> num, 3);
> >>>>
> >>>>    tst_resm(TINFO, "wait for all children to stop.");
> >>>>    for (k = 0; k < num; k++) {
> >>>> @@ -627,7 +628,7 @@ void create_same_memory(int size, int num, int
> >>>> unit)
> >>>>    tst_resm(TINFO, "resume child 1.");
> >>>>    if (kill(child[1], SIGCONT) == -1)
> >>>>        tst_brkm(TBROK|TERRNO, cleanup, "kill");
> >>>> - group_check(1, 1, size * num * 256 - 2, 0, 1, 0, size * 256 *
> >>>> num);
> >>>> + group_check(1, 1, size * num * 256 - 2, 0, 1, 0, size * 256 *
> >>>> num, 3);
> >>>>
> >>>>    tst_resm(TINFO, "wait for child 1 to stop.");
> >>>>    if (waitpid(child[1], &status, WUNTRACED) == -1)
> >>>> @@ -647,7 +648,7 @@ void create_same_memory(int size, int num, int
> >>>> unit)
> >>>>        tst_brkm(TBROK|TERRNO, cleanup, "open");
> >>>>    if (write(fd, "2", 1) != 1)
> >>>>        tst_brkm(TBROK|TERRNO, cleanup, "write");
> >>>> - group_check(2, 0, 0, 0, 0, 0, size * 256 * num);
> >>>> + group_check(2, 0, 0, 0, 0, 0, size * 256 * num, 0);
> >>>>
> >>>>    tst_resm(TINFO, "wait for all children to stop.");
> >>>>    for (k = 0; k < num; k++) {
> >>>> @@ -668,7 +669,7 @@ void create_same_memory(int size, int num, int
> >>>> unit)
> >>>>    if (write(fd, "0", 1) != 1)
> >>>>        tst_brkm(TBROK|TERRNO, cleanup, "write");
> >>>>    close(fd);
> >>>> - group_check(0, 0, 0, 0, 0, 0, size * 256 * num);
> >>>> + group_check(0, 0, 0, 0, 0, 0, size * 256 * num, 0);
> >>>>    while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0)
> >>>>        if (WEXITSTATUS(status) != 0)
> >>>>            tst_resm(TFAIL, "child exit status is %d",
> >>>> --
> >>>> 1.7.1
> >>>>
> >>>>
> >>>
> >>
> >> ------------------------------------------------------------------------------
> >> Xperia(TM) PLAY
> >> It's a major breakthrough. An authentic gaming
> >> smartphone on the nation's most reliable network.
> >> And it wants your games.
> >> http://p.sf.net/sfu/verizon-sfdev
> >> _______________________________________________
> >> Ltp-list mailing list
> >> Ltp-list@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 
> > 
> 
> 
> ------------------------------------------------------------------------------
> Xperia(TM) PLAY
> It's a major breakthrough. An authentic gaming
> smartphone on the nation's most reliable network.
> And it wants your games.
> http://p.sf.net/sfu/verizon-sfdev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
