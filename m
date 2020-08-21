From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 21 Aug 2020 11:34:20 +0800
Subject: [LTP] [PATCH 2/4] syscalls/kill03,
 04: Cleanup && Convert to new library
In-Reply-To: <CAEemH2dzPyHYdnMJa1A15dLrLrt2m5q5HKo6PY+nrVzBuJjv0g@mail.gmail.com>
References: <1597919168-10702-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1597919168-10702-2-git-send-email-zhufy.jy@cn.fujitsu.com>
 <CAEemH2eUd3yCuxt3iawHPXKUSryiJprud3HvneSr=JK_1wFhXg@mail.gmail.com>
 <43a404a1-dd4b-d091-5723-e756604fbbc8@cn.fujitsu.com>
 <CAEemH2fjgYGLD0+JozNcMqv3Eo0eAwK8+BKOCo0QZihUPiP6eg@mail.gmail.com>
 <ebb95886-a352-ab26-2d40-8a3e2e7fa62f@cn.fujitsu.com>
 <CAEemH2dzPyHYdnMJa1A15dLrLrt2m5q5HKo6PY+nrVzBuJjv0g@mail.gmail.com>
Message-ID: <a6f38749-60fd-94b2-ea2c-c7c9f9a6dd1f@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li
> 
> 
> On Fri, Aug 21, 2020 at 10:22 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com 
> <mailto:xuyang2018.jy@cn.fujitsu.com>> wrote:
> 
>     ...
>      >? ? ?Also, we can use the current process id but it may has unexpected
>      >? ? ?result
>      >? ? ?when kill succeed. So fork a child to test maybe a better
>     solution.
>      >
>      >
>      > Hmm, sorry for the uncleared description, actually I meant, to
>     use real_pid
>      > instead of the?tc->child_flag directly, then start to reclaim the
>     child
>      > when the
>      > real_pid test finishing.
>      >
>      > Does this below diff work for you?
>     It looks well. But the real_pid only valid when the first sub test and
>     the real pid is equals to 0 when using -i parameters because we have
>     killed this children.
> 
> 
> Yes, you're right.
> How about moving up the real_pid creator to the main process? does it 
> work for you?
> 
> static void verify_kill(unsigned int n)
> {
>  ? ? ? ? if (!real_pid) {
>  ? ? ? ? ? ? ? ? real_pid = SAFE_FORK();
>  ? ? ? ? ? ? ? ? if (!real_pid)
>  ? ? ? ? ? ? ? ? ? ? ? ? pause();
>  ? ? ? ? }
> 
>  ? ? ? ? TEST(kill(*tc->pid, tc->test_sig));
> ...
> 
>  ? ? ? ? if (real_pid) {
>  ? ? ? ? ? ? ? ? cleanup();
>  ? ? ? ? ? ? ? ? real_pid = 0;
>  ? ? ? ? }
> 
> }
> 
Yes, it looks ok,
> 
>     For pid = 0, it means? then sig is sent to every process in the process
>     group of the calling process.? So it looks like we test different thing
>     when using -i parameters.? What do you think about this?
> 
> 
> I even think it is a good idea for code simplification:). In this case, 
> the first
> the subtest is just to verify invalid signal for kill(), it doesn't 
> matter to go with
> kill(0, invalid_signal), that only tries to kill the current main 
> process. isn't it?
Yes. I think using current process id instead of 0 is more easier 
because the invalid signal can't kill process forever.

static void setup(void)
{
         real_pid = getpid();
         fake_pid = tst_get_unused_pid();
         int_min_pid = INT_MIN;
}

> 
> If we go this way, not only the?tc->child_flag is no needed, but also 
> not necessary
> to fork a new child to be killed.
> 
> -- 
> Regards,
> Li Wang


