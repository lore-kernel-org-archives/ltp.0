From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Apr 2020 15:29:04 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls/pipe2_03: Add new test for pipe2
 O_DIRECT flag
In-Reply-To: <be1c1761-c518-f3ee-ef19-b4f45d36df80@cn.fujitsu.com>
References: <1586927503-10827-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eeUa0XJSGeyid2J373FnvqSAQCjdO1AkbpHGTFisGGNA@mail.gmail.com>
 <be1c1761-c518-f3ee-ef19-b4f45d36df80@cn.fujitsu.com>
Message-ID: <CAEemH2dj8vdicU76ewAAECgrEmVaEGN5uMZ4EmnzUa1v+Ez9Ng@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

...
> >
> > # ./pipe2_03
> > tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
> > pipe2_03.c:48: PASS: Each write(2) uses a separate packet
> > pipe2_03.c:61: PASS: Each read(2) reads a separate packet
> > pipe2_03.c:81: PASS: write(higner than PIPE_BUF) split into multiple
> packet
> > pipe2_03.c:108: FAIL: the excess bytes in the packet is discarded by
> > read, expect 1 got 1%A
> Even I use one fork and exit(0), I don't meet this problem. Or, I miss
> something?
>

I think I got the point.

In your test code for pipe2(), you didn't use pipe in the correct way. Even
that we define the fds[2] as a global variable, there still have a new copy
for fds[2] in the child process, we should close one of the pipes in child
and parent to make the connection is built correspondingly, then that will
work normally for us.

I suggest redesigning some of the test structs. What do you think?

Fyi:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/pipe/pipe02.c

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200422/13dcd3ed/attachment.htm>
