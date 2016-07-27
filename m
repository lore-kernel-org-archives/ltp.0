From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jul 2016 14:32:24 +0200
Subject: [LTP] netns_crtchild
In-Reply-To: <CAFEAcA_CG_JKLqrtr3NP7mh5rMw3Sm4EJ3aw5pqWCx5AV+VqCw@mail.gmail.com>
References: <CAJ5vXcS0eGf2bfM-mLdCd0pKvba73S+X00DEds6CjvQrr-Vtzw@mail.gmail.com>
 <20160727102839.GD10903@rei.lan>
 <CAFEAcA_CG_JKLqrtr3NP7mh5rMw3Sm4EJ3aw5pqWCx5AV+VqCw@mail.gmail.com>
Message-ID: <20160727123224.GA11986@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> netns_parentns.sh 1 TFAIL : Error: unable to create veth pair
> >> netns_crtchild    1  TFAIL  :  common.c:89: Error while

FYI these testcases were completely rewritten more than year ago mainly
because they were too messed up to be repaired. You should really try
with latest released LTP instead.

> >> runninnetns_two_child[14159]: unhandled level 2 translation fault (11)
> >> at 0x00000000, esr 0x83000006
> >> g the script
> >>
> >> <<<execution_status>>>
> >> initiation_status="ok"
> >> pgd = ffffffc0f21cf000
> >> [00000000] *pgd=000000011c7a3003ed termination_id=1 corefile=no
> >>                                 cutime=1 cstime=1
> >> <<<test_end>>>
> >
> > As far as I can tell you found a kernel/firmware/hardware bug.
> 
> Not necessarily -- I think this is just the kernel verbosely
> reporting that userspace tried to execute from address zero
> (PC is 0x0, LR looks like a valid value for in the userspace
> binary, PSTATE indicates EL0, ESR is an instruction-abort fault);
> it will have sent a SIGSEGV after reporting the register info.
> That might be because of a kernel/hardware bug but the first
> thing to look at is what the userspace binary is actually doing
> (eg run it in a debugger) because the most plausible thing
> here is "bug in userspace".

Well the binary in which it seems to trigger the trace calls clone() and
then executes a script via system() and all error paths seems to be
handled. If you are correct this may as well be glibc or compiler bug
but that is hard to say without further debugging...

-- 
Cyril Hrubis
chrubis@suse.cz
