From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Apr 2020 17:59:00 +0800
Subject: [LTP] [PATCH v3 2/3] syscalls/pipe2_02: Add new test for pipe2
 O_CLOEXEC flag
In-Reply-To: <324c7f62-a57f-b950-7178-5ba05ac6616b@cn.fujitsu.com>
References: <1586927503-10827-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eN1gJ8p2EWts4qj=tDaV0QUoHrNX36cqkPM0xf92KDuw@mail.gmail.com>
 <324c7f62-a57f-b950-7178-5ba05ac6616b@cn.fujitsu.com>
Message-ID: <CAEemH2cetwZ7bsdVxoogMzRBUZRWetOEAwU2aZN=v5y6NX8a=w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

...
> >     +static void verify_pipe2(void)
> >     +{
> >     +       int pid, status;
> >     +       char buf[20];
> >     +
> >     +       SAFE_PIPE2(fds, O_CLOEXEC);
> >     +       sprintf(buf, "%d", fds[1]);
> >     +       pid = SAFE_FORK();
> >     +       if (pid == 0) {
> >     +               if (execlp(TESTBIN, TESTBIN, buf, NULL))
> >     +                       exit(2);
> >
> >
> > Do we really need the if() condition and exit(2)? AFAIK, the exec()
> > family of functions replaces the current process image with a new
> > process and returns zero if succeeded.
>   If failed, it will return -1. So we can catch 2(exit code) in the
> following code, but SAFE_EXECLP is also ok.
>

Since we have do check the status of children via WIFEXITED(status), so
even failed with -1, that also should be caught. Anyway, SAFE_EXECLP()
should work for us.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200421/a05de910/attachment.htm>
