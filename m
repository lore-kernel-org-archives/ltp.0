From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 18 Aug 2020 10:32:15 +0200
Subject: [LTP] [PATCH] clock_settime03: accept ENOTSUP if
 CLOCK_REALTIME_ALARM unsupported
In-Reply-To: <20200818061059.14680-1-liwang@redhat.com>
References: <20200818061059.14680-1-liwang@redhat.com>
Message-ID: <20200818083215.GA27964@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> CLOCK_REALTIME_ALARM requires an RTC with alarm support, which may not be
> present on a system. In that case, the kernel will return EOPNOTSUPP, which
> is defined as ENOTSUP in userspace.
> 
> As CLOCK_REALTIME_ALARM is already possibly unsupported, accept that as an
> error besides the EINVAL code.
> 
> For issue #712:
>   https://github.com/linux-test-project/ltp/issues/712

Actually I've commented on the issue, do we really need the _ALARM clock
for anything? I guess that the test would work fine with old plain
CLOCK_REALTIME as well.

-- 
Cyril Hrubis
chrubis@suse.cz
