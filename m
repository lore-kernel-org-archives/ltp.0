From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 14 Dec 2020 13:18:48 +0000
Subject: [LTP] [PATCH v4] overcommit_memory: Fix unstable subtest
In-Reply-To: <20201214065528.453216-1-lkml@jv-coder.de>
References: <20201214065528.453216-1-lkml@jv-coder.de>
Message-ID: <87pn3ch6fb.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Joerg Vehlow <lkml@jv-coder.de> writes:

> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>
> Changes to v3:
>  - Change total_batch_size to kB. All sizes used in this test are in kB,
>    using bytes was wrong here
>  - Calculate total_batch_size during setup
>  - Formating of MIN/MAX construct
>
> The test sets overcommit policy to never overcommit and then tries
> to allocate the commit limit reported by /proc/meminfo. This value is an exact
> value (at least at that point in time) of memory, that can be allocated
> according to the policy and ratio settings. This should fail, since there
> is already some memory allocated for running the test programm, but due to
> inaccurate memory accounting in mm/util.c __vm_enough_memory(), the allocation
> can still succeed.
>
> The commited memory is stored in a percpu counter, that counts in 1 + ncpu
> variables. For small allocations and deallocations, the memory is counted
> in a counter per cpu, without locking. If this counter reaches a threshold,
> the value is committed to a global counter. Due to this the global counter
> can become negative. This global counter is the only thing taken into
> account in __vm_enough_memory, propably for performance reasons, because
> otherwise a lock is required.
>
> Because of the inaccuracy the system can overcommit a bit by number of cpus
> times threshold value. By adding this value to the exact commit limit
> reported by /proc/meminfo, we can be sure, that we really always hit the
> memory limit.
>
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>

LGTM

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.
