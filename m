From: Punit Agrawal <punit.agrawal@arm.com>
Date: Tue, 14 Nov 2017 13:11:44 +0000
Subject: [LTP] [PATCH 09/18] kill05: fix race on getpwnam
In-Reply-To: <20171031120144.GI14550@rei.lan> (Cyril Hrubis's message of "Tue, 
 31 Oct 2017 13:01:44 +0100")
References: <20171026141447.26749-1-punit.agrawal@arm.com>
 <20171026141447.26749-10-punit.agrawal@arm.com>
 <20171031120144.GI14550@rei.lan>
Message-ID: <87vaidt373.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> Two threads doing getpwnam to a static struct in the library, sometimes
>> end up using the same UID. Fix this.
>
> Hmm these getpwnam() calls are done from different processes, so I
> suppose that this happens on uClinux, or do I miss something?

This is another patch we've been carrying for long enough to have lost
context around it's origin.

I don't see a reasonable explanation for why the change makes sense,
especially as it was done on a non-uClinux stack.

I'll drop this patch from the next posting.

>
> Also we should move these calls to the test setup anyways.
>
>> Reported-by: Tony Thompson <anthony.thompson@arm.com>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> ---
>>  testcases/kernel/syscalls/kill/kill05.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/testcases/kernel/syscalls/kill/kill05.c b/testcases/kernel/syscalls/kill/kill05.c
>> index ccef5afd6..2ae046130 100644
>> --- a/testcases/kernel/syscalls/kill/kill05.c
>> +++ b/testcases/kernel/syscalls/kill/kill05.c
>> @@ -174,15 +174,16 @@ void do_master_child(char **av)
>>  		do_child();
>>  #endif
>>  	}
>> +
>> +	/* wait until child sets its euid (and has finished with the static getpwnam result struct) */
>> +	wait_for_flag(1);
>> +
>>  	ltpuser2 = SAFE_GETPWNAM(NULL, user2name);
>>  	if (setreuid(ltpuser2->pw_uid, ltpuser2->pw_uid) == -1) {
>>  		perror("seteuid failed");
>>  		exit(1);
>>  	}
>>  
>> -	/* wait until child sets its euid */
>> -	wait_for_flag(1);
>> -
>>  	TEST(kill(pid1, TEST_SIG));
>>  
>>  	/* signal the child that we're done */
>> -- 
>> 2.14.2
>> 
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
