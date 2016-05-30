From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 30 May 2016 17:50:39 +0300
Subject: [LTP] [PATCH] memcg/functional: check several times if the
 process is killed
In-Reply-To: <20160524104806.GC10029@rei.lan>
References: <1463669724-7193-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160523160257.GF25488@rei.lan>
 <1653845167.258778.1464080543100.JavaMail.zimbra@redhat.com>
 <20160524091819.GA10029@rei.lan> <57442727.3000600@oracle.com>
 <20160524101528.GB10029@rei.lan>
 <812583643.272236.1464085966204.JavaMail.zimbra@redhat.com>
 <20160524104806.GC10029@rei.lan>
Message-ID: <574C533F.9000000@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 05/24/2016 01:48 PM, Cyril Hrubis wrote:
> Hi!
>>>>> We should better change this for something more robust. Given that the
>>>>> memgc_progcess does while (!flag_exit) sleep(1); in the main loop we may
>>>>> as well wait till the process gets into the sleep state.
>>>>>
>>>>
>>>> I don't understand why it's more robust. For example, a process can get
>>>> into the sleep state (interruptible sleep) due to a call to a syscall, no?
>>>
>>> Generally yes, but in this case it's unlikely that opening /dev/zero or
>>> calling sigaction() would block.
>>
>> There's also some ld setup going on before that. Opening/mapping/reading
>> various config and .so files.
>
> Ah right, I tend to forgot that part.
>
>>>> So maybe keep this sleep() as is?
>>>
>>> I'm Ok with that one as well. But we should rethink and fix it later.
>>
>> My immediate idea was to let memcg_process open "/tmp/memcg_process_ready"
>> and shell script would monitor /proc/$pid/fd/ until sees that or hits timeout.
>
> Or we can reuse the checkpoint library, given that the memory is now
> backed by tmpfs and path to the file si passed in environment it should
> be relatively easy to write a helper binary so that we can use it from
> the shell as well.
>

memcg_lib.sh has 22 instances of 'sleep 1', which are used in scenarios:
  * it starts memcg_process_stress and 'sleep 1' (presumably) until the 
process finishes setting up signal signal handlers
  * it does 'sleep 1' after it sends USR1 to the memcg_process_stress. I 
believe it's just to make sure that the sigusr handler finished its job

It seems that both the scenarios could modified to use a different form 
of communication not involving 'sleep'.

Let my try the proposed checkpoint library here. I think I'll come up 
with something later this week.

Thanks.
