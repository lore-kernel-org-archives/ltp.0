From: Michal Hocko <mhocko@suse.cz>
Date: Wed, 18 Nov 2015 16:34:44 +0100
Subject: [LTP] controllers/memcg_stress: Does not work correctly?
In-Reply-To: <20151116115729.GB17888@rei.suse.cz>
References: <330BE2030BD7834286495D8B7FCF1FB71D30473D@mbx02.itr.canon-is.co.jp>
 <20151116115729.GB17888@rei.suse.cz>
Message-ID: <20151118153443.GH19145@dhcp22.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon 16-11-15 12:57:30, Cyril Hrubis wrote:
> Hi!
> > About testcase "controllers/memcg_stress", I have a question.
> > 
> > This test calculates a memory size to use on a test as follows.
> > ------
> > - testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> > 
> >   mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
> >   swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
> > 
> >   mem=$(( $mem_free + $swap_free / 2 ))
> >   mem=$(( mem / 1024 ))
> > ------
> > 
> > In the case of this calculation, Lack of memory occurs when this test runs in "swap off" systems.

I am not sure I understand what is the actual problem. Swap off system
will not have any swap available. Or did you mean that the swap off will
happen during the test? If yes then the test case is clearly not
prepared for that and it would get killed by the OOM killer.

I am not entirely sure I understand the purpose of the test case but it
seems it just wants to generate the global memory pressure via memcg
loads. Whether that is a useful test is hard to judge. What is the
pass/fail metric? If the failure is the OOM killer then this is
extremely fragile because of what Cyril mentions below:
 
> My guess is that the test fails to account for memory consumed by the
> system when forking processes, system reserve, page tables, etc. And
> that it works just fine in case there is enough swap space. The second
> test actually tries to reserve 150MB but the first one just blindly
> allocates and page-faults all free memory.
> 
> > As for the calculation of the memory size to use for a test, may the following be right?
> > ------
> > - testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> > 
> >   mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
> >   swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
> > 
> >   mem=$(( ($mem_free + $swap_free) / 2 ))
> >   mem=$(( mem / 1024 ))
> 
> Hmm, halving the memory is likely too much. I would guess that we need
> to reserve something as 10% or less otherwise this test wouldn't do any
> system stress at all.

Halving the requested size wouldn't generate the global memory pressure
which seems to be the primary purpose of the test AFAIU.
-- 
Michal Hocko
SUSE Labs
