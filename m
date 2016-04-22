From: Mason <slash.tmp@free.fr>
Date: Fri, 22 Apr 2016 15:29:46 +0200
Subject: [LTP] Issue with the reporting of failed tests
In-Reply-To: <571907A2.10208@free.fr>
References: <5718D4CA.5010607@free.fr> <5718E81B.6060101@free.fr>
 <20160421153041.GA25307@rei> <5718F4EE.2060009@free.fr>
 <571907A2.10208@free.fr>
Message-ID: <571A274A.60707@free.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 21/04/2016 19:02, Mason wrote:
> On 21/04/2016 17:42, Mason wrote:
>> On 21/04/2016 17:30, Cyril Hrubis wrote:
>>> Hi!
>>>> Calling fflush does appear to solve the problem:
>>>>
>>>> # grep -c FAIL result-log.5160
>>>> 38
>>>>
>>>> # wc -l result-failed.5160
>>>> 38 result-failed.5160
>>>>
>>>> Does this mean no one ever reads FAILCMDFILE?!
>>>
>>> Just to have complete image here. I've discussed this a bit more at #ltp
>>> irc channel and the reason why we do not see this bug often is that the
>>> exec() that is done by the child after pan forks must fail (for example
>>> since bash is missing) then the code proceeds to exit(errno) line which
>>> flushes the buffers on open files...
>>
>> Note: in my latest LTP run, I disabled memory overcommit, and pan
>> failed to launch several tests:
>>
>> pan(5163): fork failed (tag proc01).  errno:12  Cannot allocate memory
>> pan(5163): fork failed (tag fs_racer).  errno:12  Cannot allocate memory
>> pan(5163): fork failed (tag quota_remount_test01).  errno:12  Cannot allocate memory
>> pan(5163): fork failed (tag isofs).  errno:12  Cannot allocate memory
>> pan(5163): fork failed (tag fs_perms01).  errno:12  Cannot allocate memory
>> [747 similar lines]
>>
>> /tmp is a ramfs. Maybe something fills it up...
> 
> With overcommit enabled, all tests complete, but some problems remain:
> 
> $ grep -c FAIL result-log.24583 
> 85
> 
> $ wc -l result-failed.24583
> 157 result-failed.24583
> 
> $ sort result-failed.24583 | uniq | wc -l
> 83
> 
> I'm confused as to what else is causing this...

I am now testing yet another LTP run with the following patch applied.

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index cee71aa3b587..ceaa56c5a21d 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -949,6 +949,8 @@ run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode,
                if (!quiet_mode)
                        write_test_start(active);
 
+       fflush(NULL); /* flush all open output streams before forking */
+
        if ((cpid = fork()) == -1) {
                fprintf(stderr,
                        "pan(%s): fork failed (tag %s).  errno:%d  %s\n",
@@ -1042,7 +1044,7 @@ run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode,
                }
                WRITE_OR_DIE(errpipe[1], &errlen, sizeof(errlen));
                WRITE_OR_DIE(errpipe[1], errbuf, errlen);
-               exit(errno);
+               _exit(errno); /* terminate "immediately" */
        }
 
        /* parent */

