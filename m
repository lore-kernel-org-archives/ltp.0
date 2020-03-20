From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 20 Mar 2020 12:27:20 +0800
Subject: [LTP] [PATCH] openposix/twoptimers.c: Use other signal instead
 of SIGALRM
In-Reply-To: <5E71F152.5010909@cn.fujitsu.com>
References: <1584523008-27044-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5E71F152.5010909@cn.fujitsu.com>
Message-ID: <604acf72-5cda-0eee-b4ab-ef083a6b4d2b@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao

> On 2020/3/18 17:16, Yang Xu wrote:
>> Currently, run this case failed as below:
>>
>> Got it!? Child
>> Alarm clock
>>
>> Parent process doesn't get SIGALRM siganl by using sigwait. It
>> seems SIGALRM siganl is handled by system but not user.
>>
>>> From timer_create man-page, it said "
>> Specifying? sevp as NULL is equivalent to specifying a pointer to
>> a sigevent structure in which sigev_notify is SIGEV_SIGNAL, sigev_signo
>> is SIGALRM, and sigev_value.sival_int is the timer ID".
>>
>> I think this is the reason. So use SIGILL signal to avoid system caught.
> Hi Xu,
> 
> I don't like the fix.? You don't figure out the root cause of issue and 
> just bypass it.(User can catch SIGALRM by default usually).
Sorry for this.
Yes. But user usually will install customized singal handler for SIGALRM 
by using sigaction function. On multi threads program, user will set 
SIGALRM signal into signal mask by using sigprocmask, so it can ensure 
current thread can get this signal from pending list.

So I plan to fix this bug as below:

--- a/testcases/open_posix_testsuite/functional/timers/timers/twoptimers.c
+++ b/testcases/open_posix_testsuite/functional/timers/timers/twoptimers.c
@@ -50,7 +50,10 @@ int main(int argc, char *argv[])
                         perror("sigaddset() failed\n");
                         return PTS_UNRESOLVED;
                 }
-
+               if (sigprocmask(SIG_BLOCK, &set, NULL) == -1) {
+                       perror("sigprocmask() failed\n");
+                       return PTS_UNRESOLVED;
+               }
                 ev.sigev_notify = SIGEV_SIGNAL;
                 ev.sigev_signo = SIGABRT;
                 if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
@@ -73,8 +76,10 @@ int main(int argc, char *argv[])
                         perror("sigwait() failed\n");
                         return PTS_UNRESOLVED;
                 }
-               printf("Got it!  Child\n");
-
+               if (sig == SIGABRT)
+                       printf("Got it!  Child\n");
+               else
+                       printf("Got another signal! Child\n");
                 sleep(LONGTIME);
                 return CHILDPASS;
         } else {
@@ -96,6 +101,10 @@ int main(int argc, char *argv[])
                         perror("sigaddset() failed\n");
                         return PTS_UNRESOLVED;
                 }
+               if (sigprocmask(SIG_BLOCK, &set, NULL) == -1) {
+                       perror("sigprocmask() failed\n");
+                       return PTS_UNRESOLVED;
+                }

                 ev.sigev_notify = SIGEV_SIGNAL;
                 ev.sigev_signo = SIGALRM;
@@ -119,8 +128,10 @@ int main(int argc, char *argv[])
                         perror("sigwait() failed\n");
                         return PTS_UNRESOLVED;
                 }
-               printf("Got it!  Parent\n");
-
+               if (sig == SIGALRM)
+                       printf("Got it!  Parent\n");
+               else
+                       printf("Got another signal! Parent\n");

How about this?

Best Regards
Yang Xu
> 
> Perhaps, you need to reset the behavior of SIGALRM to default if it is 
> not default..
> 
> Thanks,
> Xiao Yang
>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> ---
>> ? .../functional/timers/timers/twoptimers.c???????????????????? | 4 ++--
>> ? 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git 
>> a/testcases/open_posix_testsuite/functional/timers/timers/twoptimers.c 
>> b/testcases/open_posix_testsuite/functional/timers/timers/twoptimers.c
>> index 84bea3f0a..7e1648d5b 100644
>> --- 
>> a/testcases/open_posix_testsuite/functional/timers/timers/twoptimers.c
>> +++ 
>> b/testcases/open_posix_testsuite/functional/timers/timers/twoptimers.c
>> @@ -92,13 +92,13 @@ int main(int argc, char *argv[])
>> ????????????? return PTS_UNRESOLVED;
>> ????????? }
>>
>> -??????? if (sigaddset(&set, SIGALRM) == -1) {
>> +??????? if (sigaddset(&set, SIGILL) == -1) {
>> ????????????? perror("sigaddset() failed\n");
>> ????????????? return PTS_UNRESOLVED;
>> ????????? }
>>
>> ????????? ev.sigev_notify = SIGEV_SIGNAL;
>> -??????? ev.sigev_signo = SIGALRM;
>> +??????? ev.sigev_signo = SIGILL;
>> ????????? if (timer_create(CLOCK_REALTIME,&ev,&tid) != 0) {
>> ????????????? perror("timer_create() did not return success\n");
>> ????????????? return PTS_UNRESOLVED;
> 


