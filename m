From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Nov 2015 12:57:30 +0100
Subject: [LTP] controllers/memcg_stress: Does not work correctly?
In-Reply-To: <330BE2030BD7834286495D8B7FCF1FB71D30473D@mbx02.itr.canon-is.co.jp>
References: <330BE2030BD7834286495D8B7FCF1FB71D30473D@mbx02.itr.canon-is.co.jp>
Message-ID: <20151116115729.GB17888@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> About testcase "controllers/memcg_stress", I have a question.
> 
> This test calculates a memory size to use on a test as follows.
> ------
> - testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> 
>   mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
>   swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
> 
>   mem=$(( $mem_free + $swap_free / 2 ))
>   mem=$(( mem / 1024 ))
> ------
> 
> In the case of this calculation, Lack of memory occurs when this test runs in "swap off" systems.

Looking at the code it runs helpers that try to allocate all system free
memory. There are two testcases one simply runs single process that and
second one that does so in 15 processes.

My guess is that the test fails to account for memory consumed by the
system when forking processes, system reserve, page tables, etc. And
that it works just fine in case there is enough swap space. The second
test actually tries to reserve 150MB but the first one just blindly
allocates and page-faults all free memory.

> As for the calculation of the memory size to use for a test, may the following be right?
> ------
> - testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> 
>   mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
>   swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
> 
>   mem=$(( ($mem_free + $swap_free) / 2 ))
>   mem=$(( mem / 1024 ))

Hmm, halving the memory is likely too much. I would guess that we need
to reserve something as 10% or less otherwise this test wouldn't do any
system stress at all.

Also CCing our kernel dev, he should know much more.

-- 
Cyril Hrubis
chrubis@suse.cz
