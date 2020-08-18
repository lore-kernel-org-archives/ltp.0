From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Aug 2020 17:03:32 +0800
Subject: [LTP] [PATCH] clock_settime03: accept ENOTSUP if
 CLOCK_REALTIME_ALARM unsupported
In-Reply-To: <20200818083215.GA27964@yuki.lan>
References: <20200818061059.14680-1-liwang@redhat.com>
 <20200818083215.GA27964@yuki.lan>
Message-ID: <CAEemH2fX+MELKgR17YqwPpAGBHnZYRm3pTLaeHP4KbRnM5fUig@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 18, 2020 at 4:31 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > CLOCK_REALTIME_ALARM requires an RTC with alarm support, which may not be
> > present on a system. In that case, the kernel will return EOPNOTSUPP,
> which
> > is defined as ENOTSUP in userspace.
> >
> > As CLOCK_REALTIME_ALARM is already possibly unsupported, accept that as
> an
> > error besides the EINVAL code.
> >
> > For issue #712:
> >   https://github.com/linux-test-project/ltp/issues/712
>
> Actually I've commented on the issue, do we really need the _ALARM clock
> for anything? I guess that the test would work fine with old plain
> CLOCK_REALTIME as well.
>

You're right, the CLOCK_REALTIME works fine at this point. Also as you
commented, we do not suspend the OS in the middle, so I agree to use
 CLOCK_REALTIME.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200818/1c0f9d8f/attachment.htm>
