From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Sep 2019 16:54:07 +0200
Subject: [LTP] [PATCH] timer_create01: accept ENOTSUP
In-Reply-To: <20190927145316.GA8472@calabresa>
References: <20190926144507.15765-1-cascardo@canonical.com>
 <20190927144902.GA25060@rei.lan> <20190927145316.GA8472@calabresa>
Message-ID: <20190927145407.GE17233@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > CLOCK_REALTIME_ALARM and CLOCK_BOOTTIME_ALARM require an RTC with alarm
> > > support, which may not be present on a system. In that case, the kernel
> > > will return EOPNOTSUPP, which is defined as ENOTSUP in userspace.
> > > 
> > > As these clocks are already possibly unsupported, accept that as an error
> > > code besides the EINVAL code.
> > > 
> > > Note that previously the kernel would incorrectly return the ENOTSUPP code,
> > > which is undefined in userspace. With these unfixed kernels, the test will
> > > fail when those RTCs are not present.
> > 
> > Can you please include the kernel commit id that fixed the kernel here?
> > 
> > Otherwise this patch is fine.
> 
> f18ddc13af981ce3c7b7f26925f099e7c6929aba ("alarmtimer: Use EOPNOTSUPP instead of ENOTSUPP")
> 
> Do you want me to send a v2, or will you fixup the patch?

No need, I will add that info, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
