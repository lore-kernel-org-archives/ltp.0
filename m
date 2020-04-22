From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Apr 2020 14:05:16 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls/pipe2_03: Add new test for pipe2
 O_DIRECT flag
In-Reply-To: <be1c1761-c518-f3ee-ef19-b4f45d36df80@cn.fujitsu.com>
References: <1586927503-10827-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eeUa0XJSGeyid2J373FnvqSAQCjdO1AkbpHGTFisGGNA@mail.gmail.com>
 <be1c1761-c518-f3ee-ef19-b4f45d36df80@cn.fujitsu.com>
Message-ID: <CAEemH2diTUc226+Lr7ksyTw9BPMg2M5awZvrYo-j7oMT=pTPQQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xu,

On Tue, Apr 21, 2020 at 6:24 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> ...
> >
> >     +       if (pid == 0) {
> >     +               (*test_func[n])();
> >
> >     +               tst_reap_children();
> >     +               SAFE_CLOSE(fds[0]);
> >     +               SAFE_CLOSE(fds[1]);
> >
> >
> > I tend to move the cloese(fd) to the test process to nearby pipe2().
> > Otherwise, it causes an unclear error like:
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

My test env is kernel-5.7.0-rc1+ x86_64, I haven't figured out why the
read() get more words from the pipe, but the error has gone one I move the
safe_close(fd) part to the test main process.


> --- a/testcases/kernel/syscalls/pipe2/pipe2_03.c
> +++ b/testcases/kernel/syscalls/pipe2/pipe2_03.c
> @@ -59,6 +59,7 @@ static void check_peer_rw(void)
>                                          "Each read(2) doesn't read a
> separate packet, return %ld", TST_RET);
>                  }
>                  tst_res(TPASS, "Each read(2) reads a separate packet");
> +                _exit(0);
>          }
>   }
>
> @@ -79,6 +80,7 @@ static void check_split(void)
>                                          "write(higner than PIPE_BUF)
> split into multiple packet, return %ld", TST_RET);
>                  }
>                  tst_res(TPASS, "write(higner than PIPE_BUF) split into
> multiple packet");
> +                _exit(0);
>          }
>   }
>
> @@ -107,21 +109,17 @@ static void check_discard(void)
>                                  tst_res(TFAIL,
>                                          "the excess bytes in the packet
> is discarded by read, expect 1 got %s", tmp_secondbuf);
>                  }
> +                _exit(0);
>          }
>   }
>
>   static void verify_pipe2(unsigned int n)
>   {
> -       int pid;
> -
> -       pid = SAFE_FORK();
> -       if (pid == 0) {
> -               (*test_func[n])();
> -               tst_reap_children();
> -               SAFE_CLOSE(fds[0]);
> -               SAFE_CLOSE(fds[1]);
> -       }
> +       (*test_func[n])();
> +       SAFE_CLOSE(fds[0]);
> +       SAFE_CLOSE(fds[1]);
>          tst_reap_children();
>

In my opinion, it is not a good habit to wait for children's status after
the test function, we'd better do that at the behind of fork() in the test
main process. I'd only keep the  (*test_func[n])(); in this verify_pipe2()
but no more else.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200422/2144c942/attachment.htm>
