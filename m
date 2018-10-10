From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 10 Oct 2018 08:13:57 -0300
Subject: [LTP] LTP: futex_wake04 hangs forever on i386
In-Reply-To: <20181010104101.GA1990@rei>
References: <CA+G9fYs13QZtsREe3dvic+G6VPQ1dJroKH0sguBiNdtizRTeNQ@mail.gmail.com>
 <20181008133059.GB30978@rei>
 <3dbee853-6bce-d057-f42a-655a8f2991c3@linaro.org>
 <20181009092821.GA16630@rei>
 <6903290a-523f-7130-b64f-d1a73b601c38@linaro.org> <20181010104101.GA1990@rei>
Message-ID: <29fce88c-c771-0ca4-19b9-c9eb25484999@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/10/18 7:41 AM, Cyril Hrubis wrote:
> Jo!
>>> That shouldn't really happen, the wait_for_threads(2) function is called
>>> in a loop until there are two sleeping threads under the
>>> /proc/$pid/task/ directory (minus the main thread). So unless there is a
>>> problem with starting a thread or locking on a futex the loop will end
>>> eventually and the futexes are unlocked only after this loop finishes.
>>
>> Okay, so this is what is happening...
>>
>> Like we predicted, one of the threads had an issue and the logic was
>> stuck with 2 tasks only: parent and 1 thread. The parent in (R) mode and
>> the thread in (S) mode.
> 
> Actually the parent is in the (S) mode, that is because the parent
> spends most of the time in the sleep() anyways.
> 
>> Quoting as an example this situation:
>>
>> futex_wake04    0  TINFO  :  Thread 11405 not sleeping yet
>> futex_wake04    0  TINFO  :  Thread 11405 not sleeping yet
>> futex_wake04    0  TINFO  :  Thread 11405 not sleeping yet
>> futex_wake04    0  TINFO  :  Thread 11405 not sleeping yet
>> ...
>>
>> Despite, in the beginning, we had a situation that would allow the
>> "while(wait_for_threads(2))" to break, like showed here:
> 
> That is not true, see below.
> 
>> (k)inaddy@bug3984:/proc$ PID=11405 ; echo ==== PID=$PID ====; ls -d
>> $PID/task/* ; echo COMM ==== ; cat $PID/task/*/comm ; echo STAT ==== ;
>> cat $PID/task/*/stat | awk '{print $1" "$2" "$3}' ; echo STACK ====;
>> sudo cat $PID/task/*/stack
>>
>> ==== PID=11405 ====
>> 11405/task/11403  11405/task/11404  11405/task/11405
>> COMM ====
>> futex_wake04
>> futex_wake04
>> futex_wake04
>> STAT ====
>> 11403 (futex_wake04) S
>> 11404 (futex_wake04) S
>> 11405 (futex_wake04) R
> 
> The pids (tids) increment so the first one is the parent sleeping in
> sleep() the second one is the first forked thread locked on futex and
> the second one is the child that is supposed to lock on a futex.

Yes, I had realized this after I wrote this part, during conclusion, and 
never revisited the upper part of this e-mail, sorry.

> 
>> STACK ====
>> [<0>] hrtimer_nanosleep+0xe6/0x250
>> [<0>] sys_nanosleep+0x64/0xa0
>> [<0>] do_fast_syscall_32+0x7f/0x1b0
>> [<0>] entry_SYSENTER_32+0x4e/0x7c
>> [<0>] 0xffffffff
> 
> So this is the parent trace, as expected it sleeps in the nanosleep()
> timer.

Yep

> 
>> [<0>] futex_wait_queue_me+0xb8/0x120
>> [<0>] futex_wait+0xda/0x210
>> [<0>] do_futex+0x433/0x9b0
>> [<0>] sys_futex+0xe9/0x120
>> [<0>] do_fast_syscall_32+0x7f/0x1b0
>> [<0>] entry_SYSENTER_32+0x4e/0x7c
>> [<0>] 0xffffffff
> 
> This is the thread that is locked on a futex.
> 
>> [<0>] apic_timer_interrupt+0x3c/0x44
>> [<0>] 0xffffffff
> 
> Huh, are we even supposed to get apic_timer_interrupt in the process
> trace?

I believe this is the kernel stack for the process, showing it was 
preempted by the IRQ handler for the clock, right after it entered 
kernel.. IRQ handlers run with their own stacks, so we can't see the 
rest in here, but the function that prints the stack on dmesg does get 
it by checking "__softirqentry_text_start" session.

>> Something else happened, interfering in the expected behavior:
>>
>> (k)inaddy@bug3984:/proc$ PID=11405 ; echo ==== PID=$PID ====; ls -d
>> $PID/task/* ; echo COMM ==== ; cat $PID/task/*/comm ; echo STAT ==== ;
>> cat $PID/task/*/stat | awk '{print $1" "$2" "$3}' ; echo STACK ====;
>> sudo cat $PID/task/*/{comm,stack}
>>
>> ==== PID=11405 ====
>> 11405/task/11403  11405/task/11405
>> COMM ====
>> futex_wake04
>> futex_wake04
>> STAT ====
>> 11403 (futex_wake04) S
>> 11405 (futex_wake04) R
> 
> Looks like the child that was locked on a futex is no longer there.
> 
> If this was running for long enough (5 minutes) the test library process
> (parent of 11403 here) send SIGKILL to the whole process group and the
> only process killed was the one that was not stuck in the kernel at the
> moment. >
>> STACK ====
>> futex_wake04
>> futex_wake04
>> [<0>] wait_woken+0x37/0x70
>> [<0>] n_tty_write+0x393/0x400
>> [<0>] tty_write+0x17d/0x310
>> [<0>] __vfs_write+0x1c/0x50
>> [<0>] vfs_write+0x94/0x1a0
>> [<0>] ksys_write+0x49/0xb0
>> [<0>] sys_write+0x16/0x20
>> [<0>] do_fast_syscall_32+0x7f/0x1b0
>> [<0>] entry_SYSENTER_32+0x4e/0x7c
>> [<0>] 0xffffffff
> 
> So supposedly the parent is writing something to stderr at this point.
> 
>> [<0>] apic_timer_interrupt+0x3c/0x44
>> [<0>] 0xffffffff
> 
> And the child is (again) in the interrupt handler.
> 
>> 11404 thread is missing in this last sample, meaning it could already be
>> gone, but the parent, 11405, running the wait_for_threads() function,
>> did not catch that (yet ?) due to a CPU stall related to the terminal
>> controller interrupts:
> 
> The parent will not catch that at all, as the wait_for_threads() is very
> simple function that stops the loop only and only if there are two
> threads, different from the caller thread, sleeping in kernel.

Agreed.

> 
>> ==============================================================
>> [  147.582036] INFO: rcu_sched detected stalls on CPUs/tasks:
>> [  147.583782] 	1-....: (2 GPs behind) idle=602/1/1073741828
>> softirq=20147/20148 fqs=2239
>> [  147.585973] 	(detected by 2, t=5252 jiffies, g=7585, c=7584, q=62923)
>> [  147.587806] Sending NMI from CPU 2 to CPUs 1:
>> [  147.590144] NMI backtrace for cpu 1
>>
>> [  147.590145] CPU: 1 PID: 11405 Comm: futex_wake04 Not tainted
>> 4.18.0-1-686 #1 Debian 4.18.6-1
>>
>> [  147.590146] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS 1.11.1-1 04/01/2014
>> [  147.590146] EIP: io_serial_out+0x17/0x20
>> [  147.590147] Code: ...
>> [  147.590165] EAX: 00000079 EBX: 00000079 ECX: 00000000 EDX: 000003f8
>> [  147.590165] ESI: f3be0000 EDI: d1446d60 EBP: f393bf2c ESP: f393bf28
>> [  147.590166] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000002
>> [  147.590166] CR0: 80050033 CR2: 0192144c CR3: 31f3b000 CR4: 000406d0
>> [  147.590167] Call Trace:
>> [  147.590167]  <IRQ>
>> [  147.590168]  serial8250_tx_chars+0xf5/0x1f0
>> [  147.590168]  serial8250_handle_irq.part.21+0xa7/0xd0
>> [  147.590168]  serial8250_default_handle_irq+0x49/0x60
>> [  147.590169]  serial8250_interrupt+0x61/0x130
>> [  147.590169]  __handle_irq_event_percpu+0x42/0x1a0
>> [  147.590170]  ? handle_level_irq+0x100/0x100
>> [  147.590170]  handle_irq_event_percpu+0x2b/0x70
>> [  147.590171]  handle_irq_event+0x2f/0x50
>> [  147.590171]  ? handle_level_irq+0x100/0x100
>> [  147.590172]  handle_edge_irq+0x71/0x160
>> [  147.590172]  handle_irq+0x92/0xa0
>> [  147.590173]  </IRQ>
>> [  147.590173]  <SOFTIRQ>
>> [  147.590173]  do_IRQ+0x44/0xc0
>> [  147.590174]  ? __softirqentry_text_start+0x8/0x8
>> [  147.590174]  common_interrupt+0x3b/0x40
>> [  147.590174] EIP: __do_softirq+0x5b/0x255
>> [  147.590175] Code: ...
>> [  147.590192] EAX: 00000282 EBX: f273bf84 ECX: 0000000f EDX: f393e000
>> [  147.590193] ESI: 00400040 EDI: d1647580 EBP: f393dff8 ESP: f393dfd4
>> [  147.590194] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000202
>> [  147.590194]  ? __softirqentry_text_start+0x8/0x8
>> [  147.590194]  ? __softirqentry_text_start+0x8/0x8
>> [  147.590195]  call_on_stack+0x45/0x50
>> [  147.590196]  </SOFTIRQ>
>> [  147.590196]  ? irq_exit+0xb5/0xc0
>> [  147.590196]  ? smp_apic_timer_interrupt+0x6c/0x120
>> [  147.590197]  ? apic_timer_interrupt+0x3c/0x44
>> ==============================================================
>>
>> Possibly the terminal I/O rate (stdout) has interfered with test
>> behavior. When having, together with this, the adding/removing
>> hugepages, I was able to "lock" this "sleep task detector" behavior for
>> quite sometime.
>>
>> Testing all this in a ssh session I had no issues. Adding 1 second delay
>> in between while() loop for the logic also mitigated the issue =).
>>
>> LKFT depends on serial console for the test results. Unfortunately we
>> don't have a stack trace to analyze, but, I would bet the console rate
>> limit could play tricks on us specially if we have already overloaded
>> console serial lines with buffer from other runs.
> 
> Doing a simple math if you have serial line on 115200 it can transwer
> about 11.5 bits in 100uS so yes we can easily overload serial connection
> if we print messages that fast, so increasing the sleep 10x times sounds
> only reasonable.
> 
> On the other hand I guess that kernel shouldn't produce stalls just
> because we write to serial too fast. I guess that the task writing to
> serial should be sleeping in a waitqueue somewhere in kernel if it
> attempts to write to a full serial buffer, which will effectivelly
> slow down the writer and the test would work fine in this case...

That is what happened, no ? Stack trace shows that possibly same process 
that had its execution interrupted by the time handler in a recent past 
(with a leftover frame pointer indicated by ? apic_timer_interrupt) also 
ran the handler for serial8250_interrupt() and that execution caused 
some dmesg warnings like:

serial8250: too much work for irq

which I had. I guess having the terminal with a smaller buffer would 
help here as well, since the calls to the interrupt handler would be 
more often and less time consuming (because of baud rate).

Continuing, there was a software interrupt to flush serial 8250 contents 
and it took too long to flush to the device, causing the task, waiting 
on the line, to wait.

HOWEVER, for this case, for example, every single byte written to a 
terminal memory mapped I/O register causes a VM_EXIT (in the host: 
cpu->kvm_run->exit_reason == 2), giving execution back to the QEMU vCPU 
(that had entered VM mode), that will schedule a function inside the 
emulation thread to deal with that I/O (for the virtualized serial HW 
being emulated) and calling the VM_ENTER again at some further point. 
This could make the interrupt handler even slower.

I sent a patch in the thread yesterday, feel free to change it 
(interval) if you need. After those 2 fixes I would ask Naresh to test 
this same test for some time (patching our LTP running version on LKFT) 
to make sure we solved original complain (despite this behavior) and 
interpretations were correct.
