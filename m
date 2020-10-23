From: Sean Christopherson <sean.j.christopherson@intel.com>
Date: Thu, 22 Oct 2020 22:02:14 -0700
Subject: [LTP] mmstress[1309]: segfault at 7f3d71a36ee8 ip
 00007f3d77132bdf sp 00007f3d71a36ee8 error 4 in
 libc-2.27.so[7f3d77058000+1aa000]
In-Reply-To: <CAHk-=wgqAp5B46SWzgBt6UkheVGFPs2rrE6H4aqLExXE1TXRfQ@mail.gmail.com>
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
 <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
 <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com>
 <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com>
 <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
 <CAHk-=wi=sf4WtmZXgGh=nAp4iQKftCKbdQqn56gjifxWNpnkxw@mail.gmail.com>
 <CAEUSe78A4fhsyF6+jWKVjd4isaUeuFWLiWqnhic87BF6cecN3w@mail.gmail.com>
 <CAHk-=wgqAp5B46SWzgBt6UkheVGFPs2rrE6H4aqLExXE1TXRfQ@mail.gmail.com>
Message-ID: <20201023050214.GG23681@linux.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 22, 2020 at 08:05:05PM -0700, Linus Torvalds wrote:
> On Thu, Oct 22, 2020 at 6:36 PM Daniel D?az <daniel.diaz@linaro.org> wrote:
> >
> > The kernel Naresh originally referred to is here:
> >   https://builds.tuxbuild.com/SCI7Xyjb7V2NbfQ2lbKBZw/
> 
> Thanks.
> 
> And when I started looking at it, I realized that my original idea
> ("just look for __put_user_nocheck_X calls, there aren't so many of
> those") was garbage, and that I was just being stupid.
> 
> Yes, the commit that broke was about __put_user(), but in order to not
> duplicate all the code, it re-used the regular put_user()
> infrastructure, and so all the normal put_user() calls are potential
> problem spots too if this is about the compiler interaction with KASAN
> and the asm changes.
> 
> So it's not just a couple of special cases to look at, it's all the
> normal cases too.
> 
> Ok, back to the drawing board, but I think reverting it is probably
> the right thing to do if I can't think of something smart.
> 
> That said, since you see this on x86-64, where the whole ugly trick with that
> 
>    register asm("%"_ASM_AX)
> 
> is unnecessary (because the 8-byte case is still just a single
> register, no %eax:%edx games needed), it would be interesting to hear
> if the attached patch fixes it. That would confirm that the problem
> really is due to some register allocation issue interaction (or,
> alternatively, it would tell me that there's something else going on).

I haven't reproduced the crash, but I did find a smoking gun that confirms the
"register shenanigans are evil shenanigans" theory.  I ran into a similar thing
recently where a seemingly innocuous line of code after loading a value into a
register variable wreaked havoc because it clobbered the input register.

This put_user() in schedule_tail():

   if (current->set_child_tid)
           put_user(task_pid_vnr(current), current->set_child_tid);

generates the following assembly with KASAN out-of-line:

   0xffffffff810dccc9 <+73>: xor    %edx,%edx
   0xffffffff810dcccb <+75>: xor    %esi,%esi
   0xffffffff810dcccd <+77>: mov    %rbp,%rdi
   0xffffffff810dccd0 <+80>: callq  0xffffffff810bf5e0 <__task_pid_nr_ns>
   0xffffffff810dccd5 <+85>: mov    %r12,%rdi
   0xffffffff810dccd8 <+88>: callq  0xffffffff81388c60 <__asan_load8>
   0xffffffff810dccdd <+93>: mov    0x590(%rbp),%rcx
   0xffffffff810dcce4 <+100>: callq  0xffffffff817708a0 <__put_user_4>
   0xffffffff810dcce9 <+105>: pop    %rbx
   0xffffffff810dccea <+106>: pop    %rbp
   0xffffffff810dcceb <+107>: pop    %r12

__task_pid_nr_ns() returns the pid in %rax, which gets clobbered by
__asan_load8()'s check on current for the current->set_child_tid dereference.
