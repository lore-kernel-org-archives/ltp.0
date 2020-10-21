From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 Oct 2020 22:52:55 +0530
Subject: [LTP] mmstress[1309]: segfault at 7f3d71a36ee8 ip
 00007f3d77132bdf sp 00007f3d71a36ee8 error 4 in
 libc-2.27.so[7f3d77058000+1aa000]
In-Reply-To: <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
 <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
Message-ID: <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 21 Oct 2020 at 22:35, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Oct 21, 2020 at 9:58 AM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > LTP mm mtest05 (mmstress), mtest06_3 and mallocstress01 (mallocstress) tested on
> > x86 KASAN enabled build. But tests are getting PASS on Non KASAN builds.
> > This regression started happening from next-20201015 nowards
>
> Is it repeatable enough to be bisectable?

Yes. This is easily reproducible.
I will bisect and report here.

>
>              Linus

- Naresh
