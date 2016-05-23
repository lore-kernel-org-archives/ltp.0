From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 23 May 2016 20:43:14 +0300
Subject: [LTP] [PATCH] memcg/functional: check several times if the
 process is killed
In-Reply-To: <20160523163929.GG25488@rei.lan>
References: <1463669724-7193-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160523160257.GF25488@rei.lan> <57432F07.3040207@oracle.com>
 <20160523163929.GG25488@rei.lan>
Message-ID: <57434132.4040100@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 05/23/2016 07:39 PM, Cyril Hrubis wrote:
> Hi!
>>> This does no seem right to me. The original code send a SIGUSR1 signal
>>> to the memcg_process which caused it to allocate memory which supposedly
>>> provokes OOM to kill it. Hence the sleep 1 after the kill -s USR $pid.
>>>
>>> Now this code hammers the memcg_process with SIGKILL instead.
>>>
>>> As far as I can tell the right thing to do here is to wait with
>>> reasonable timeout for the memcg_process to become zombie and only kill
>>> it if that hasn't happened. Or did I miss something?
>>
>> No, you didn't miss anything. I was planning to use 'kill' to check
>> whether the pid is alive or not. But I should have used 'kill -s 0'
>> instead of plain 'kill'.
>
> Would that even work? Technically till you wait the process the pid
> still exists albeit in a zombie state.
 >
 > And looking into POSIX there were some systems that returned ESRCH in
 > this case but it looks this behavior is strongly discouraged.
 >

I see that if I issue 'command &' in bash, it setups a handler for 
SIGCHLD signal, and executes a wait() in this handler. I.e. leaves no 
zombies on the system.

All I found in POSIX is that "APPLICATION USAGE" from 
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/wait.html 
states that "This volume of POSIX.1-2008 requires the implementation to 
keep the status of terminated jobs available until the status is 
requested,...".  The shell can get the status of terminated jobs only 
after it calls wait() on them. However, it is still not clear whether 
wait() must be called in a SIGCHLD handler, or when the 'wait' built-in 
is executed.

So, indeed, the approach with 'kill -s 0' may not be standard.

I'll switch to using 'ps' then, i.e. if there is memcg_process_stress 
listed as a zombie (Z) or there is no such process, it means that it was 
killed by the OOM handler, i.e. everything is fine.

Thanks.

