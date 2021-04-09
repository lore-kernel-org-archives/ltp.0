From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 09 Apr 2021 10:34:56 +0100
Subject: [LTP] [PATCH v3 1/7] fzsync: Add self tests
In-Reply-To: <YG8ds1Xl53rAWoQc@yuki>
References: <20210319091837.27319-1-rpalethorpe@suse.com>
 <20210319091837.27319-2-rpalethorpe@suse.com> <YG8ds1Xl53rAWoQc@yuki>
Message-ID: <87wntb3inz.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> --- a/lib/newlib_tests/test16.c
>> +++ b/lib/newlib_tests/test16.c
>> @@ -9,6 +9,8 @@
>>   * which they should take it in turns to update.
>>   */
>>  
>> +#define _GNU_SOURCE
>
> This isn't needed anymore, right?

Yes.

>
>>  #include <stdlib.h>
>>  #include "tst_test.h"
>>  #include "tst_safe_pthread.h"
>> diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
>> new file mode 100644
>> index 000000000..8db102bdc
>> --- /dev/null
>> +++ b/lib/newlib_tests/tst_fuzzy_sync01.c
>> @@ -0,0 +1,232 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 Richard Palethorpe <rpalethorpe@suse.com>
>> + */
>> +/*\
>> + * [DESCRIPTION]
>> + *
>> + * This verifies Fuzzy Sync's basic ability to reproduce a particular
>> + * outcome to a data race when the critical sections are not aligned.
>> + *
>> + * We make the simplifying assumptions that:
>> + * - Each thread contains a single contiguous critical section.
>> + * - The threads only interact through a single variable.
>> + * - The various timings are constant except for variations introduced
>> + *   by the environment.
>> + *
>> + * If a single data race has N critical sections then we may remove
>> + * N-1 sections to produce a more difficult race. We may then test
>> + * only the more difficult race and induce from this the outcome of
>> + * testing the easier races.
>> + *
>> + * In real code, the threads may interact through many side
>> + * effects. While some of these side effects may not result in a bug,
>> + * they may effect the total time it takes to execute either
>> + * thread. This will be handled in tst_fuzzy_sync02.
>> + *
>> + * The number of variables which two threads interact through is
>> + * irrelevant as the combined state of two variables can be
>> + * represented with a single variable. We may also reduce the number
>> + * of states to simply those required to show the thread is inside or
>> + * outside of the critical section.
>> + *
>> + * There are two fundamental races which require alignment under these
>> + * assumptions:
>> + *      1        2
>> + * A +-----+  +----+	The outer box is total execution time.
>> + *   | #   |  | #  |	The '#' is the critical section.
>> + *
>> + *   |  # |   |   # |
>> + * B +----+   +-----+
>> + *
>> + * So we can either have the critical section of the shorter race
>> + * before that of the longer one. Or the critical section of the
>> + * longer one before the shorter.
>> + *
>> + * In reality both threads will never be the same length, but we can
>> + * test that anyway. We also test with both A as the shorter and B as
>> + * the shorter. We also vary the distance of the critical section from
>> + * the start or end. The delay times are cubed to ensure that a delay
>> + * range is required.
>> + *
>> + * When entering their critical sections, both threads increment the
>> + * 'c' counter variable atomically. They both also increment it when
>> + * leaving their critical sections. We record the value of 'c' when A
>> + * increments it. From the recorded values of 'c' we can deduce if the
>> + * critical sections overlap and their ordering.
>> + *
>> + * 	Start (cs)	| End (ct)	| Ordering
>> + * 	--------------------------------------------
>> + * 	1		| 2		| A before B
>> + * 	3		| 4		| B before A
>> + *
>> + * Any other combination of 'cs' and 'ct' means the critical sections
>> + * overlapped.
>> +\*/
>> +
>> +#define _GNU_SOURCE
>
> And here as well.
>
>> +#include "tst_test.h"
>> +#include "tst_fuzzy_sync.h"
>
> ...
>
>> +static void delay(const int t)
>> +{
>> +	int k = TIME_SCALE(t);
>> +
>> +	while (k--)
>> +		sched_yield();
>> +}
>
> The TIME_SCALE() is not explained anywhere. Also I do wonder if we need
> some kind of runtime tuning for this.

OK, I have added the following explanation:

+/* Scale all the delay times by this function. The races become harder
+ * the faster this function grows. With cubic scaling the race windows
+ * will be 27 times smaller than the entry or return delays. Because
+ * TIME_SCALE(1) = 1*1*1, TIME_SCALE(3) = 3*3*3.

Should I roll another version or will you fix it up?

>
> Otherwise I find these tests much easier to understand over the first
> version. Thanks a lot for the detailed descriptions, they really help a
> lot.
>
> With the _GNU_SOURCE revoved you can consider this:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Thank you,
Richard.
