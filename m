From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 27 Jul 2016 08:14:26 -0700
Subject: [LTP] [PATCH V3 08/23] rt_sigaction/rt_sigprocmark: Replace
	SA_NOMASK with SA_NODEFER
In-Reply-To: <20160727101433.GA10903@rei.lan>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-8-raj.khem@gmail.com> <20160727101433.GA10903@rei.lan>
Message-ID: <4862EF4A-FCBC-476A-AD17-F5B7388E643F@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> On Jul 27, 2016, at 3:14 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> 
> Hi!
>> --- a/testcases/misc/crash/crash01.c
>> +++ b/testcases/misc/crash/crash01.c
>> @@ -49,7 +49,7 @@ stress test at the same time you run other tests, like a multi-user
>> benchmark.
>> 
>> */
>> -
>> +#define _GNU_SOURCE
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <string.h>
>> @@ -409,7 +409,7 @@ void my_signal(int sig, void (*func) ())
>> 
>> 	act.sa_handler = func;
>> 	memset(&act.sa_mask, 0x00, sizeof(sigset_t));
>> -	act.sa_flags = SA_NOMASK | SA_RESTART;
>> +	act.sa_flags = SA_NODEFER | SA_RESTART;
>> 	sigaction(sig, &act, 0);
>> }
>> 
>> diff --git a/testcases/misc/crash/crash02.c b/testcases/misc/crash/crash02.c
>> index 00fee34..1aba3b9 100644
>> --- a/testcases/misc/crash/crash02.c
>> +++ b/testcases/misc/crash/crash02.c
>> @@ -49,7 +49,6 @@ TODO:
>> 	* Does a syscall is supposed to send SIGSEGV?
>> */
>> 
>> -#define _GNU_SOURCE
>> #include <sys/syscall.h>
>> #include <stdio.h>
>> #include <stdlib.h>
>> @@ -358,7 +357,7 @@ void my_signal(int sig, void (*func) ())
>> 
>> 	act.sa_handler = func;
>> 	memset(&act.sa_mask, 0x00, sizeof(sigset_t));
>> -	act.sa_flags = SA_NOMASK | SA_RESTART;
>> +	act.sa_flags = SA_NODEFER | SA_RESTART;
>> 	sigaction(sig, &act, 0);
>> }
> 
> What is the reason to add #define _GNU_SOURCE to crash01 and to remove
> it from crash02? That looks like unintended change to me.

The define was needed only for these SA_* symbols which are removed
so I removed the define as well.

> 
> The rest is obviously OK.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 204 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160727/f531c8de/attachment.sig>
