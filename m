From: Jiri Vohanka <jvohanka@redhat.com>
Date: Wed, 25 Nov 2015 11:47:36 +0100
Subject: [LTP] mtest01 parent/child process synchronization issue
In-Reply-To: <5652E62A.3090403@redhat.com>
References: <564CACAF.1080201@redhat.com> <5652E62A.3090403@redhat.com>
Message-ID: <565591C8.7060308@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

>> diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
>> index 8c9e81c..06f41d5 100644
>> --- a/testcases/kernel/mem/mtest01/mtest01.c
>> +++ b/testcases/kernel/mem/mtest01/mtest01.c

>> @@ -51,9 +51,12 @@
>>   char *TCID = "mtest01";
>>   int TST_TOTAL = 1;
>>   int pid_count = 0;
>> +int oom_count = 0;
>
> both of these should be static

You are right, I also added volatile just to be sure.

>> @@ -284,7 +288,9 @@ int main(int argc, char *argv[])
>>   			kill(pid_list[i], SIGKILL);
>>   			i++;
>>   		}
>> -		if (dowrite)
>> +		if (oom_count)
>> +			tst_resm(TFAIL, "the child process was killed");
>
> I wouldn't combine two "if"s into one if else block, the information how
> much was allocated could be useful even when we hit OOM.

The original_maxbytes tells us how much we want to allocate, not how much was already allocated. You have to watch TINFO messages emitted by 
child processes to see what was actually allocated. I think that printing ""%llu kbytes allocated" would be misleading since that is true only 
if the test passes. I kept the if statement at its current place, but I made the fail message more verbose.

> But mainly, problem here is that ~6 lines above child processes get killed,
> so you are racing with SIGCHLD here. I'd suggest to move this TFAIL before
> kill() loop.

I moved the part that kills the child processes after PASS/FAIL evaluation to avoid possible race condition.
(Another option would be to uninstall the SIGCHLD signal handler before killing the processes.)

>> +		else if (dowrite)
>>   			tst_resm(TPASS, "%llu kbytes allocated and used.",
>>   				 original_maxbytes / 1024);
>>   		else

I am new to the list and I am not sure what the rules for posting patches are. Should I use 'git send-email', sign the patch or something?

Regards,
Jiri
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Watch-for-SIGCHLD-in-mtest01-in-case-the-child-gets-.patch
Type: text/x-patch
Size: 2887 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151125/77c5390d/attachment.bin>
