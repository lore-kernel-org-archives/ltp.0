From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 16 Jun 2020 16:57:07 +0200
Subject: [LTP] [x86/entry] 2bbc68f837: ltp.ptrace08.fail
In-Reply-To: <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
References: <87y2onbdtb.fsf@nanos.tec.linutronix.de>
 <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
Message-ID: <87ftav2h4s.fsf@nanos.tec.linutronix.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Andy Lutomirski <luto@amacapital.net> writes:
>> On Jun 16, 2020, at 1:44 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> 
>> ?kernel test robot <rong.a.chen@intel.com> writes:
>>> FYI, we noticed the following commit (built with gcc-9):
>>> 
>>> commit: 2bbc68f8373c0631ebf137f376fbea00e8086be7 ("x86/entry: Convert Debug exception to IDTENTRY_DB")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>> 
>> Is the head of linux.git exposing the same problem or is this an
>> intermittent failure, which only affects bisectability?
>
> It sure looks deterministic:
>
> ptrace08.c:62: BROK: Cannot find address of kernel symbol "do_debug"

Hahahaha. But not only LTP, also LKP-tests makes assumptions:

  monitors/irq_exception_noise:[ "$exception" -eq "1" ] && export ftrace_filters='__do_page_fault do_divide_error do_overflow do_bounds do_invalid_op do_device_not_available do_double_fault do_coprocessor_segment_overrun do_invalid_TSS do_segment_not_present do_spurious_interrupt_bug do_coprocessor_error do_alignment_check do_simd_coprocessor_error do_debug do_stack_segment do_general_protection'

stable-api-nonsense.rst comes to my mind.

Thanks,

        tglx

