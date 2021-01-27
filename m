From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 27 Jan 2021 11:26:13 +0800
Subject: [LTP] [PATCH] syscalls/times01: Convert to new API
In-Reply-To: <e9a9481d-60a6-68f3-859b-8ab25722a0b3@cn.fujitsu.com>
References: <20210127025112.1226584-1-ruansy.fnst@cn.fujitsu.com>
 <6010D950.30002@cn.fujitsu.com>
 <e9a9481d-60a6-68f3-859b-8ab25722a0b3@cn.fujitsu.com>
Message-ID: <6010DD55.8010600@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2021/1/27 11:12, Ruan Shiyang wrote:
>
>
> On 2021/1/27 ??11:09, Xiao Yang wrote:
>> On 2021/1/27 10:51, Shiyang Ruan wrote:
>>> Signed-off-by: Shiyang Ruan<ruansy.fnst@cn.fujitsu.com>
>>> ---
>>>   testcases/kernel/syscalls/times/times01.c | 168 
>>> +++-------------------
>>>   1 file changed, 20 insertions(+), 148 deletions(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/times/times01.c 
>>> b/testcases/kernel/syscalls/times/times01.c
>>> index 293a52957..87a0f6144 100644
>>> --- a/testcases/kernel/syscalls/times/times01.c
>>> +++ b/testcases/kernel/syscalls/times/times01.c
>>> @@ -1,162 +1,34 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>   /*
>>>    * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>>>    *
>>> - * This program is free software; you can redistribute it and/or 
>>> modify it
>>> - * under the terms of version 2 of the GNU General Public License as
>>> - * published by the Free Software Foundation.
>>> - *
>>> - * This program is distributed in the hope that it would be useful, 
>>> but
>>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>>> - *
>>> - * Further, this software is distributed without any warranty that 
>>> it is
>>> - * free of the rightful claim of any third person regarding 
>>> infringement
>>> - * or the like.  Any license provided herein, whether implied or
>>> - * otherwise, applies only to this software file.  Patent licenses, if
>>> - * any, provided herein do not apply to combinations of this 
>>> program with
>>> - * other software, or any other product whatsoever.
>>> - *
>>> - * You should have received a copy of the GNU General Public 
>>> License along
>>> - * with this program; if not, write the Free Software Foundation, 
>>> Inc.,
>>> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>> - *
>>> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre 
>>> Pkwy,
>>> - * Mountain View, CA  94043, or:
>>> - *
>>> - * http://www.sgi.com
>>> - *
>>> - * For further information regarding this notice, see:
>>> - *
>>> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
>>> - *
>>> - */
>>> -/* $Id: times01.c,v 1.6 2009/10/26 14:55:48 subrata_modak Exp $ */
>>> -/**********************************************************
>>> - *
>>> - *    OS Test - Silicon Graphics, Inc.
>>> - *
>>> - *    TEST IDENTIFIER    : times01
>>> - *
>>> - *    EXECUTED BY    : anyone
>>> - *
>>> - *    TEST TITLE    : Basic test for times(2)
>>> - *
>>> - *    PARENT DOCUMENT    : usctpl01
>>> - *
>>> - *    TEST CASE TOTAL    : 1
>>> - *
>>> - *    WALL CLOCK TIME    : 1
>>> - *
>>> - *    CPU TYPES        : ALL
>>> - *
>>> - *    AUTHOR        : William Roske
>>> - *
>>> - *    CO-PILOT        : Dave Fenner
>>> - *
>>> - *    DATE STARTED    : 03/30/92
>>> - *
>>> - *    INITIAL RELEASE    : UNICOS 7.0
>>> - *
>>> - *    TEST CASES
>>> - *
>>> - *     1.) times(2) returns...(See Description)
>>> - *
>>> - *    INPUT SPECIFICATIONS
>>> - *     The standard options for system call tests are accepted.
>>> - *    (See the parse_opts(3) man page).
>>> - *
>>> - *    OUTPUT SPECIFICATIONS
>>> - *$
>>> - *    DURATION
>>> - *     Terminates - with frequency and infinite modes.
>>> - *
>>> - *    SIGNALS
>>> - *     Uses SIGUSR1 to pause before test if option set.
>>> - *     (See the parse_opts(3) man page).
>>> - *
>>> - *    RESOURCES
>>> - *     None
>>> - *
>>> - *    ENVIRONMENTAL NEEDS
>>> - *      No run-time environmental needs.
>>> - *
>>> - *    SPECIAL PROCEDURAL REQUIREMENTS
>>> - *     None
>>> - *
>>> - *    INTERCASE DEPENDENCIES
>>> - *     None
>>> - *
>>> - *    DETAILED DESCRIPTION
>>> + * DESCRIPTION
>>>    *    This is a Phase I test for the times(2) system call.  It is 
>>> intended
>>> - *    to provide a limited exposure of the system call, for now.  It
>>> - *    should/will be extended when full functional tests are 
>>> written for
>>> - *    times(2).
>>> - *
>>> - *     Setup:
>>> - *       Setup signal handling.
>>> - *      Pause for SIGUSR1 if option specified.
>>> - *
>>> - *     Test:
>>> - *     Loop if the proper options are given.
>>> - *       Execute system call
>>> - *      Check return code, if system call failed (return=-1)
>>> - *        Log the errno and Issue a FAIL message.
>>> - *      Otherwise, Issue a PASS message.
>>> + *    to provide a limited exposure of the system call.
>>>    *
>>> - *     Cleanup:
>>> - *       Print errno log and/or timing stats if options given
>>
>> Hi Ruan,
>>
>> Please use the following format of description comment so that it can 
>> be picked up by docparser:
>> --------------------------------------
>> /*\
>>    * [DESCRIPTION]
>> ...
>> \*/
>> --------------------------------------
>>
>>> - *
>>> - *
>>> - *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
>>> + * ALGORITHM:
>>> + *    Execute system call
>>> + *    Check return code, if system call failed (return=-1)
>>> + *        Log the errno and Issue a FAIL message.
>>> + *    Otherwise, Issue a PASS message.
>>> + */
>>
>> This test is very easy so remove the algorithm comment directly.
>>
>>>
>>> -#include<sys/types.h>
>>>   #include<sys/times.h>
>>>   #include<errno.h>
>>> -#include<string.h>
>>> -#include<signal.h>
>>> -#include "test.h"
>>> -
>>> -void setup();
>>> -void cleanup();
>>> -
>>> -char *TCID = "times01";
>>> -int TST_TOTAL = 1;
>>> -
>>> -struct tms mytimes;
>>> +#include "tst_test.h"
>>>
>>> -int main(int ac, char **av)
>>> +static void verify_times(void)
>>>   {
>>> -    int lc;
>>> +    struct tms mytimes;
>>>
>>> -    tst_parse_opts(ac, av, NULL, NULL);
>>> +    TEST(times(&mytimes));
>>>
>>> -    setup();
>>> -
>>> -    for (lc = 0; TEST_LOOPING(lc); lc++) {
>>> -
>>> -        tst_count = 0;
>>> -
>>> -        TEST(times(&mytimes));
>>> -
>>> -        if (TEST_RETURN == -1)
>>> -            tst_resm(TFAIL | TTERRNO, "times failed");
>>> -        else
>>> -            tst_resm(TPASS, "times(&mytimes) returned %ld",
>>> -                 TEST_RETURN);
>>> -
>>> -    }
>>> -
>>> -    cleanup();
>>> -    tst_exit();
>>> +    if (TST_RET == -1)
>>> +        tst_res(TFAIL | TTERRNO, "times failed");
>>> +    else
>>> +        tst_res(TPASS, "times(&mytimes) returned %ld", TST_RET);
>> It is simpler to use TST_EXP_PASS() here (replace TEST()).
>
> Got it.  Thanks a lot.
Hi Ruan,

Sorry, times() returns the number of clock ticks instead of zero on success.
It is wrong to use TST_EXP_PASS() and just keep it.

Best Regards,
Xiao Yang
>
>
> -- 
> Thanks,
> Ruan Shiyang.
>>
>> Best Regards,
>> Xiao Yang
>>>   }
>>>
>>> -void setup(void)
>>> -{
>>> -    tst_sig(NOFORK, DEF_HANDLER, cleanup);
>>> -
>>> -    TEST_PAUSE;
>>> -}
>>> -
>>> -void cleanup(void)
>>> -{
>>> -}
>>> +static struct tst_test test = {
>>> +    .test_all = verify_times,
>>> +};
>>
> .
>



