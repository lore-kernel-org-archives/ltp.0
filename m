From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 Jul 2016 13:14:33 +0100
Subject: [LTP] netns_crtchild
In-Reply-To: <20160727102839.GD10903@rei.lan>
References: <CAJ5vXcS0eGf2bfM-mLdCd0pKvba73S+X00DEds6CjvQrr-Vtzw@mail.gmail.com>
 <20160727102839.GD10903@rei.lan>
Message-ID: <CAFEAcA_CG_JKLqrtr3NP7mh5rMw3Sm4EJ3aw5pqWCx5AV+VqCw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 27 July 2016 at 11:28, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> <<<test_start>>>
>> tag=netns_crtchild stime=1469762535
>> cmdline="nenetns_crtchild[14102]: unhandled level 2 translation fault
>> (11) at 0x00000000, esr 0x83000006
>> tns_crtchild"
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> pgd = ffffffc07f862000
>> [00000000] *pgd=00000000f7240003, *pmd=0000000000000000
>>
>> CPU: 0 PID: 14102 Comm: netns_crtchild Not tainted 3.14.65 #2
>> task: ffffffc03cedaa00 ti: ffffffc021d34000 task.ti: ffffffc021d34000
>> PC is at 0x0
>> LR is at 0x40574c
>> pc : [<0000000000000000>] lr : [<000000000040574c>] pstate: 00000000
>> sp : 0000007ffefaad30
>> x29: 0000007ffefaad30 x28: 0000000000000000
>> x27: 0000000000000000 x26: 0000000000000000
>> x25: 0000000000000000 x24: 0000000000000000
>> x23: 0000000000000000 x22: 0000000000000000
>> x21: 0000000040020000 x20: 0000000000000000
>> x19: 0000000000000000 x18: 0000007ffefaaaa0
>> x17: 0000007fb77270c0 x16: 0000000000000000
>> x15: 0000007fb766bac8 x14: ffffffffffffffff
>> x13: 0000000000000005 x12: 000000000000000a
>> x11: 0000000000000008 x10: 0101010101010101
>> x9 : 0000000000000000 x8 : 0000000000000039
>> x7 : 0000007fb77af2b0 x6 : 0000007fb77af2b0
>> x5 : 0000007fb77b0630 x4 : 0000007fb77b0598
>> x3 : 0000007fb77b0000 x2 : 0000000000000002
>> x1 : 0000000000407c10 x0 : 0000000000000000
>>
>> netns_parentns.sh 1 TFAIL : Error: unable to create veth pair
>> netns_crtchild    1  TFAIL  :  common.c:89: Error while
>> runninnetns_two_child[14159]: unhandled level 2 translation fault (11)
>> at 0x00000000, esr 0x83000006
>> g the script
>>
>> <<<execution_status>>>
>> initiation_status="ok"
>> pgd = ffffffc0f21cf000
>> [00000000] *pgd=000000011c7a3003ed termination_id=1 corefile=no
>>                                 cutime=1 cstime=1
>> <<<test_end>>>
>
> As far as I can tell you found a kernel/firmware/hardware bug.

Not necessarily -- I think this is just the kernel verbosely
reporting that userspace tried to execute from address zero
(PC is 0x0, LR looks like a valid value for in the userspace
binary, PSTATE indicates EL0, ESR is an instruction-abort fault);
it will have sent a SIGSEGV after reporting the register info.
That might be because of a kernel/hardware bug but the first
thing to look at is what the userspace binary is actually doing
(eg run it in a debugger) because the most plausible thing
here is "bug in userspace".

thanks
-- PMM
