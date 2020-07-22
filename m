From: Erico Nunes <ernunes@redhat.com>
Date: Wed, 22 Jul 2020 17:52:22 +0200
Subject: [LTP] [PATCH 2/3] ioperm01: skip test if kernel is locked down
In-Reply-To: <20200721152649.GB13733@yuki.lan>
References: <20200720194920.22784-1-ernunes@redhat.com>
 <20200720194920.22784-2-ernunes@redhat.com> <20200721152649.GB13733@yuki.lan>
Message-ID: <0386a2c0-607b-7f20-fb2a-221e963b45fc@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 7/21/20 5:26 PM, Cyril Hrubis wrote:
> Hi!
>> ioperm is restricted under kernel lockdown.
>>
>> Signed-off-by: Erico Nunes <ernunes@redhat.com>
>> ---
>>  testcases/kernel/syscalls/ioperm/ioperm01.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/testcases/kernel/syscalls/ioperm/ioperm01.c b/testcases/kernel/syscalls/ioperm/ioperm01.c
>> index 4c5c0e6ea..d1d633b20 100644
>> --- a/testcases/kernel/syscalls/ioperm/ioperm01.c
>> +++ b/testcases/kernel/syscalls/ioperm/ioperm01.c
>> @@ -42,6 +42,9 @@ static void verify_ioperm(void)
>>  
>>  static void setup(void)
>>  {
>> +	/* ioperm is restricted under kernel lockdown. */
>> +	tst_lockdown_skip();
>> +
>>  	/*
>>  	 * The value of IO_BITMAP_BITS (include/asm-i386/processor.h) changed
>>  	 * from kernel 2.6.8 to permit 16-bits ioperm
> 
> This looks good, however shouldn't we as well add a third ioperm test
> that checks that the call fails for root when lockdown is enabled?
> 

Good point. I think it is a good idea, but can be done in a separate
patchset.
There are many other things that can be covered together with that by
new tests considering the recent lockdown feature (enum lockdown_reason
seems to provide a good list and starting point).

Erico

