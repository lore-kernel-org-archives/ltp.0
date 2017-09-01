From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 01 Sep 2017 11:34:56 +0200
Subject: [LTP] [PATCH] thp01: Find largest arguments size
In-Reply-To: <CAEemH2cdcy16cDifgMd=_pk=3z3M79Z=04iA4c0xfktgdONDog@mail.gmail.com>
References: <20170831083407.28402-1-rpalethorpe@suse.com>
 <CAEemH2cdcy16cDifgMd=_pk=3z3M79Z=04iA4c0xfktgdONDog@mail.gmail.com>
Message-ID: <87val2bw3j.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Thanks for the review,

Li Wang writes:

> On Thu, Aug 31, 2017 at 4:34 PM, Richard Palethorpe
> <rpalethorpe@suse.com> wrote:
>> Because of kernel commit da029c11e6b1 the arguments size for exec has been
>> reduced considerably. This causes exec to fail with E2BIG, so we call it
>> repeatedly with a decreasing number of arguments until it is successful.
>>
>> As far as I know, there is no other reliable and easy way to determine the
>> maximum argument length.
>>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>>  testcases/kernel/mem/thp/thp01.c | 83 ++++++++++++++++++++++++----------------
>>  1 file changed, 50 insertions(+), 33 deletions(-)
>>
>> diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/thp01.c
>> index 101a9b5c8..b90b9b637 100644
>> --- a/testcases/kernel/mem/thp/thp01.c
>> +++ b/testcases/kernel/mem/thp/thp01.c
>> @@ -30,6 +30,7 @@
>>   * ....
>>   */
>>
>> +#include <errno.h>
>>  #include <sys/types.h>
>>  #include <sys/resource.h>
>>  #include <sys/wait.h>
>> @@ -38,56 +39,72 @@
>>  #include <stdlib.h>
>>  #include <unistd.h>
>>  #include "mem.h"
>> +#include "tst_minmax.h"
>> +#include "tst_safe_sysv_ipc.h"
>>
>> -#define ARRAY_SZ       256
>> +#define ARGS_SZ        256
>>
>> -static int ps;
>> -static long length;
>> -static char *array[ARRAY_SZ];
>> +static int shm_id;
>> +static char *args[ARGS_SZ];
>>  static char *arg;
>> -static struct rlimit rl = {
>> -       .rlim_cur = RLIM_INFINITY,
>> -       .rlim_max = RLIM_INFINITY,
>> -};
>> +static long *arg_count;
>
>
> Two queries:
>
> 1. Can't we declare the arg_count just as a global variable? why
> should we take use of share memory, only for the loop counting?

It forks so that it can call exec without overwriting the test process
image. Global variables are copy-on-write for a child process (unless we
use clone()), so the parent's memory would not be updated by the
child. We need the parent to be updated so that, when the next child is
run, it already has the correct argument count saving a lot of calls to
exec.

>
>
> 2. The kernel patch limit all arg stack usage to at most 75% of _STK_LIM (6MB),
> and here the size of arg_len is 32*PAGE_SIZE.  So it means that there
> almost only have 6MB/(PAGE_SIZE*32) numbers can be accepted in
> args[(*arg_count)], if it is a ppc64 machine(*arg_count == 3) that's
> OK, but if a system PAGE_SIZE > 192KB, then the test will be break and
> your loop is absolutely useless. About that, if we shrink the arg_len
> size, things would be better I guess.

That is true, but even on PPC64 with a default page size of 64Kb, the
default huge page size is 15MB (I think). So, on PPC64, we are only
doing a very basic test of exec on current kernels. Systems with page
sizes over 192KB seem even less likely to have huge pages smaller than
6MB.

However I don't see any harm in reducing the PAGE_SIZE coefficient to 1
and multiplying the ARGS_SZ by 32, this will make the test slower, but
more accurate at finding the maximum argument size while maintaining the
allocation size of the original reproducer.

--
Thank you,
Richard.
