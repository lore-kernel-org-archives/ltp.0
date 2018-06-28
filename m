From: Li Wang <liwang@redhat.com>
Date: Thu, 28 Jun 2018 18:08:53 +0800
Subject: [LTP] [PATCH 1/2 v2] tst_test: Fail the test subprocess cannot
	be killed
In-Reply-To: <CAEemH2f7TQG+eSznxEnM-NgBx4gjvx=wy6JZh0mjCD_+=mbsGQ@mail.gmail.com>
References: <20180627152217.7067-1-chrubis@suse.cz>
 <CAEemH2f7TQG+eSznxEnM-NgBx4gjvx=wy6JZh0mjCD_+=mbsGQ@mail.gmail.com>
Message-ID: <CAEemH2dag5EXRbWdHf31Qj9Wx9O+MJHuwR5xxaemG50g6b5wSg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jun 28, 2018 at 5:41 PM, Li Wang <liwang@redhat.com> wrote:
> Hi Cyril,
>
> On Wed, Jun 27, 2018 at 11:22 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
>> If there are any leftover children the main test process will likely be
>> killed while sleeping in wait(). That is because all child processes are
>> either waited explicitely by the test code or implicitly by the test
>> library.
>>
>> We also send SIGKILL to the whole process group, so if one of the
>> children continues to live for long enough that very likely means that
>> it ended up stuck in the kernel.
>>
>> So if there are any processes left with in the process group we created
>> once the process group leader i.e. main test process has been waited
>> for we loop for a short while to give the init daemon chance to reap the
>> process after it has been reparented and if that does not happen for a
>> few seconds we declare the process to be stuck in the kernel.
>>
>> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>> CC: Eric Biggers <ebiggers3@gmail.com>
>> ---
>>  lib/tst_test.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/tst_test.c b/lib/tst_test.c
>> index 80808854e..329168a24 100644
>> --- a/lib/tst_test.c
>> +++ b/lib/tst_test.c
>> @@ -1,5 +1,5 @@
>>  /*
>> - * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
>> + * Copyright (c) 2015-2018 Cyril Hrubis <chrubis@suse.cz>
>>   *
>>   * This program is free software: you can redistribute it and/or modify
>>   * it under the terms of the GNU General Public License as published by
>> @@ -1047,6 +1047,21 @@ static int fork_testrun(void)
>>         alarm(0);
>>         SAFE_SIGNAL(SIGINT, SIG_DFL);
>>
>> +       unsigned int sleep = 100;
>> +       unsigned int retries = 0;
>> +
>> +       while (kill(-test_pid, 0) == 0) {
>
> I'm a little worried about here, image that, if a process_A(test_pid)
> exist to make function kill(-test_pid, 0) return 0 at first time, then
> we go into this while loop, but during the sleeping time process_A
> exit and system reuse the test_pid to another process_B, we will still
> keep looping and very probably make mistake to report TFAIL(with stack
> of  process_B dump to ltp user in PATCH 2/2).

Maybe we could verify the content of '/proc/test_pid/cmdline' in this loop
to make sure test_pid is still using by the process we wanted?

>
>> +
>> +               usleep(sleep);
>> +               sleep*=2;
>> +
>> +               if (retries++ <= 14)
>> +                       continue;
>> +
>> +               tst_res(TFAIL, "Test process child stuck in the kernel!");
>> +               tst_brk(TFAIL, "Congratulation, likely test hit a kernel bug.");
>> +       }
>> +
>>         if (WIFEXITED(status) && WEXITSTATUS(status))
>>                 return WEXITSTATUS(status);
>>
>> --
>> 2.13.6
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>
>
> --
> Regards,
> Li Wang



-- 
Regards,
Li Wang
