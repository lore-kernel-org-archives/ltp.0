From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 23 Jun 2021 13:20:35 +0200
Subject: [LTP] [PATCH 0/3] cpuset_regression_test: convert and improve
In-Reply-To: <87mtrg4yz6.fsf@suse.de>
References: <20210623071543.171021-1-lkml@jv-coder.de> <87mtrg4yz6.fsf@suse.de>
Message-ID: <3a6d7a45-2205-34f9-aaab-2d039d132456@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

On 6/23/2021 1:11 PM, Richard Palethorpe wrote:
> Hello Joerg,
>
> Joerg Vehlow <lkml@jv-coder.de> writes:
>
>> Hi,
>>
>> this is more or less a v2 of a patch I send previously (patch 3).
>> I know that richard is not entirely happy with this patch, I will
>> give it another try anyway...
>> It is either this patch or another patch, that has to look through
>> the cgroup hierarchy, to check if there is any group,that explicitely
>> uses cpu 0.
> If it is already being used then can you set it?
The test can use any cpu, that is not explicitly assigned to a group 
already.
What I mean by "either this or another patch" (and forgot to type), the 
alternative
patch has to check if anything is using cpu 0 explicitly and then fail 
with TCONF.
Or it has to look for an used cpu core. That would be another possibility...

>
>> To me, it is a better solution to just change groups for a short time,
>> and check if the bug exists. If ltp tests are running, the chance, that
>> there is anything running, that really needs a correct cpuset is very low.
>> I am comming from a system, where cgroups are setup by a container launcher,
>> that just happens to assign cpus to the containers - not even exclusively.
>> LTP tests are used as some part of the testsuite, to test as close to a
>> production system as possible.
> I was thinking that if you are already using CPU sets then you either
> don't have the bug or you won't hit it on your setup(s)? If so then the
> test is redundant.
True about the "don't hit it part", at least with the setup, but I guess 
the reason for a regression test,
is to prevent regressions. This was clearly a bug in the kernel and not 
only an inconvenience. And since
there? is not "the one kernel source", I think it is important to run 
tests like this for as many different
kernels as possible. Apart from the already setup cgroups, there may be 
other uses of cgroups as well,
that try to set them up the other way around (first exclusive, then cpus).
>
>> The only way I could think of a process misbehaving by disabeling cpu pinning,
>> would be a badly written multithread application, that cannot correctly run,
>> if threads are really running in parallel, but this would also require a scheduling
>> policy, that makes scheduling points predicatable. While I know that software like
>> that exists (in fact I was working on something like that in the past), I think it
>> is highly unlikely, that it is running parallel to ltp.
>> And even then, this could be mitigated by not just setting cpu binding to undefined,
>> but to one fixed core. But with the changes in patch 2, this is not
>> possible.
>>
>> But anyhow ltp fiddles with lots of critical system parameters during it's runtime,
>> there is no guarantee, that an application that requires some very specific kernel
>> runtime settings survives this. That's why I would still vote for this patch.
>>
>> J?rg
> I still think it has a small chance of causing problems for us. There
> are some heterogeneous CPU systems where control software should run on
> a given CPU. I don't know whether CGroups are used to control that or if
> it would matter if the process is moved temporarily. It's just a small
> risk I would avoid if the test is not really worth it.
I get that, but these systems may have to opt-out of some tests anyway.
>
> OTOH the patch looks good otherwise, so it should be merged if no one
> else agrees with me.
Ok, lets see what the others have to say :)

J?rg
