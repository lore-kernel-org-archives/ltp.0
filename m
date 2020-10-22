From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Oct 2020 16:43:29 -0700
Subject: [LTP] mmstress[1309]: segfault at 7f3d71a36ee8 ip
 00007f3d77132bdf sp 00007f3d71a36ee8 error 4 in
 libc-2.27.so[7f3d77058000+1aa000]
In-Reply-To: <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com>
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
 <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
 <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com>
 <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com>
Message-ID: <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 22, 2020 at 1:55 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> The bad commit points to,
>
> commit d55564cfc222326e944893eff0c4118353e349ec
> x86: Make __put_user() generate an out-of-line call
>
> I have reverted this single patch and confirmed the reported
> problem is not seen anymore.

Thanks. Very funky, but thanks. I've been running that commit on my
machine for over half a year, and it still looks "trivially correct"
to me, but let me go look at it one more time. Can't argue with a
reliable bisect and revert..

            Linus
