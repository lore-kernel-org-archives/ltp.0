From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Apr 2020 18:05:06 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls/pipe2_03: Add new test for pipe2
 O_DIRECT flag
In-Reply-To: <20f5e406-f430-79ba-f911-015247e73d0d@cn.fujitsu.com>
References: <1586927503-10827-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eeUa0XJSGeyid2J373FnvqSAQCjdO1AkbpHGTFisGGNA@mail.gmail.com>
 <be1c1761-c518-f3ee-ef19-b4f45d36df80@cn.fujitsu.com>
 <CAEemH2dj8vdicU76ewAAECgrEmVaEGN5uMZ4EmnzUa1v+Ez9Ng@mail.gmail.com>
 <53bb4ba1-0e68-4abb-39fd-9e661ed38754@cn.fujitsu.com>
 <1f29b873-b256-b475-87c5-83378017aa39@cn.fujitsu.com>
 <20f5e406-f430-79ba-f911-015247e73d0d@cn.fujitsu.com>
Message-ID: <CAEemH2d6ObRfR12xvfpmE9KtTakobzvt6_md=Xrmd_rbKB7oAA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 22, 2020 at 5:31 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> ...
> >>> I think I got the point.
> >>>
> >>> In your test code for pipe2(), you didn't use pipe in the correct
> >>> way. Even that we define the fds[2] as a global variable, there still
> >>> have a new copy for fds[2] in the child process, we should close one
> >>> of the pipes in child and parent to make the connection is built
> >>> correspondingly, then that will work normally for us.
> >>>
> >>> I suggest redesigning some of the test structs. What do you think?
> >> Yes.
> >>>
> >>> Fyi:
> >>>
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/pipe/pipe02.c
> >
> > BTW, pipe02.c can use SAFE_PIPE macro and remove  UCLINUX ifdef.
> >>>
> >> In principle, we should use the following format
> >> step1      pipe(fds);
> >> step2      SAFE_FORK();
> >>        child process
> >> step3         close one fd and do something
> >>        parent process
> >> step4         close another fd and do something
> >>
> >> Also, we should not do write opeartion in step 1~2, otherwise child
> >> process will inherit data.
> modify this case ,url as below:
>
> https://github.com/xuyang0410/ltp/commit/6e701803b39123b5abf74bd292c36fee73b54065
>
> How about it?
>

I leave comment in your patch in github. Thanks for the quick fix, the rest
LGTM.

Can you rebase the code on the latest master and format V4 patch to ML?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200422/7623f96e/attachment.htm>
