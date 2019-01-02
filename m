From: Li Wang <liwan@redhat.com>
Date: Wed, 2 Jan 2019 16:14:16 +0800
Subject: [LTP] [PATCH] syscalls/ptrace07: handle potential SIGSEGV on
	older kernels
In-Reply-To: <b8db71df3a21f600e2a52064df6d2a21ed2195a9.1545400016.git.jstancek@redhat.com>
References: <b8db71df3a21f600e2a52064df6d2a21ed2195a9.1545400016.git.jstancek@redhat.com>
Message-ID: <CAEemH2eL-C0EcU9T_E6qvhqrHYcR9_vrwNuerP_fK7jUNyNKCQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Dec 21, 2018 at 9:51 PM Jan Stancek <jstancek@redhat.com> wrote:
>
> If a ptraced test process hits SIGSEGV, the entire testcase hangs.
>
> Older kernels such as RHEL7 (3.10.0), check the error code returned
> by restore_fpu_checking() and do drop_init_fpu() if it fails.
> So the FPU state of the prev task can't leak.
>
> But in the more likely case a task with xcomp_bv != 0 will be killed
> by SIGSEGV; either from do_device_not_available() or from
> sys_rt_sigreturn()->__restore_xstate_sig().
>
> And this is why the test case hangs; it wrongly assumes that the
> traced child can only exit and report nothing else. But since it
> receives SIGSEGV it reports this signal to the main process and
> sleeps in ptrace_stop(), it does not exit and thus the test-case
> hangs in tst_reap_children() after return from do_test().
>
> Replace PTRACE_CONT with PTRACE_DETACH, so we don't need to
> handle subsequent stops. And treat exit code from test process
> as info-only.

ptrace07(with this patch applied) passed with kernel 3.10 and 4.18
multi arches test.

>
> Debugged-by: Oleg Nesterov <onestero@redhat.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Tested-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
