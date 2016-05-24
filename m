From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 24 May 2016 13:04:23 +0300
Subject: [LTP] [PATCH] memcg/functional: check several times if the
 process is killed
In-Reply-To: <20160524091819.GA10029@rei.lan>
References: <1463669724-7193-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160523160257.GF25488@rei.lan>
 <1653845167.258778.1464080543100.JavaMail.zimbra@redhat.com>
 <20160524091819.GA10029@rei.lan>
Message-ID: <57442727.3000600@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 05/24/2016 12:18 PM, Cyril Hrubis wrote:
> Hi!
>>>>   	$TEST_PATH/memcg_process $2 -s $3 &
>>>>   	pid=$!
>>>> -	sleep 1
>>>
>>> This sleep sure is useless.
>>
>> Isn't it there to make sure, that SIGUSR1 handler had time
>> to set up? (for example with single CPU and sched_child_runs_first == 0)
>
> Looking at the code, you are right.

Indeed. Thanks!


>
> We should better change this for something more robust. Given that the
> memgc_progcess does while (!flag_exit) sleep(1); in the main loop we may
> as well wait till the process gets into the sleep state.
>

I don't understand why it's more robust. For example, a process can get 
into the sleep state (interruptible sleep) due to a call to a syscall, no?

So maybe keep this sleep() as is?
