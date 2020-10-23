From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Oct 2020 17:22:56 -0700
Subject: [LTP] mmstress[1309]: segfault at 7f3d71a36ee8 ip
 00007f3d77132bdf sp 00007f3d71a36ee8 error 4 in
 libc-2.27.so[7f3d77058000+1aa000]
In-Reply-To: <CAHk-=wi=sf4WtmZXgGh=nAp4iQKftCKbdQqn56gjifxWNpnkxw@mail.gmail.com>
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
 <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
 <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com>
 <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com>
 <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
 <CAHk-=wi=sf4WtmZXgGh=nAp4iQKftCKbdQqn56gjifxWNpnkxw@mail.gmail.com>
Message-ID: <CAHk-=wgeHE7AS2Q4kPrkC5dMqfx_6+E84+FcEDYJSTugxqivUA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 22, 2020 at 5:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In particular, I wonder if it's that KASAN causes some reload pattern,
> and the whole
>
>      register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);
> ..
>      asm volatile(.. "r" (__val_pu) ..)
>
> thing causes problems.

That pattern isn't new (see the same pattern and the comment above get_user).

But our previous use of that pattern had it as an output of the asm,
and the new use is as an input. That obviously shouldn't matter, but
if it's some odd compiler code generation interaction, all bets are
off..

                Linus
