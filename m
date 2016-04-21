From: Mason <slash.tmp@free.fr>
Date: Thu, 21 Apr 2016 17:42:38 +0200
Subject: [LTP] Issue with the reporting of failed tests
In-Reply-To: <20160421153041.GA25307@rei>
References: <5718D4CA.5010607@free.fr> <5718E81B.6060101@free.fr>
 <20160421153041.GA25307@rei>
Message-ID: <5718F4EE.2060009@free.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 21/04/2016 17:30, Cyril Hrubis wrote:
> Hi!
>> Calling fflush does appear to solve the problem:
>>
>> # grep -c FAIL result-log.5160
>> 38
>>
>> # wc -l result-failed.5160
>> 38 result-failed.5160
>>
>> Does this mean no one ever reads FAILCMDFILE?!
> 
> Just to have complete image here. I've discussed this a bit more at #ltp
> irc channel and the reason why we do not see this bug often is that the
> exec() that is done by the child after pan forks must fail (for example
> since bash is missing) then the code proceeds to exit(errno) line which
> flushes the buffers on open files...

Note: in my latest LTP run, I disabled memory overcommit, and pan
failed to launch several tests:

pan(5163): fork failed (tag proc01).  errno:12  Cannot allocate memory
pan(5163): fork failed (tag fs_racer).  errno:12  Cannot allocate memory
pan(5163): fork failed (tag quota_remount_test01).  errno:12  Cannot allocate memory
pan(5163): fork failed (tag isofs).  errno:12  Cannot allocate memory
pan(5163): fork failed (tag fs_perms01).  errno:12  Cannot allocate memory
[747 similar lines]

/tmp is a ramfs. Maybe something fills it up...

Regards.
