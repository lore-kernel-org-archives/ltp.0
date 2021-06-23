From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 23 Jun 2021 12:11:41 +0100
Subject: [LTP] [PATCH 0/3] cpuset_regression_test: convert and improve
In-Reply-To: <20210623071543.171021-1-lkml@jv-coder.de>
References: <20210623071543.171021-1-lkml@jv-coder.de>
Message-ID: <87mtrg4yz6.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Joerg,

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi,
>
> this is more or less a v2 of a patch I send previously (patch 3).
> I know that richard is not entirely happy with this patch, I will
> give it another try anyway...
> It is either this patch or another patch, that has to look through
> the cgroup hierarchy, to check if there is any group,that explicitely
> uses cpu 0.

If it is already being used then can you set it?

>
> To me, it is a better solution to just change groups for a short time,
> and check if the bug exists. If ltp tests are running, the chance, that
> there is anything running, that really needs a correct cpuset is very low.
> I am comming from a system, where cgroups are setup by a container launcher,
> that just happens to assign cpus to the containers - not even exclusively.
> LTP tests are used as some part of the testsuite, to test as close to a
> production system as possible.

I was thinking that if you are already using CPU sets then you either
don't have the bug or you won't hit it on your setup(s)? If so then the
test is redundant.

>
> The only way I could think of a process misbehaving by disabeling cpu pinning,
> would be a badly written multithread application, that cannot correctly run,
> if threads are really running in parallel, but this would also require a scheduling
> policy, that makes scheduling points predicatable. While I know that software like
> that exists (in fact I was working on something like that in the past), I think it
> is highly unlikely, that it is running parallel to ltp.
> And even then, this could be mitigated by not just setting cpu binding to undefined,
> but to one fixed core. But with the changes in patch 2, this is not
> possible.
>
> But anyhow ltp fiddles with lots of critical system parameters during it's runtime,
> there is no guarantee, that an application that requires some very specific kernel
> runtime settings survives this. That's why I would still vote for this patch.
>
> J?rg

I still think it has a small chance of causing problems for us. There
are some heterogeneous CPU systems where control software should run on
a given CPU. I don't know whether CGroups are used to control that or if
it would matter if the process is moved temporarily. It's just a small
risk I would avoid if the test is not really worth it.

OTOH the patch looks good otherwise, so it should be merged if no one
else agrees with me.

-- 
Thank you,
Richard.
