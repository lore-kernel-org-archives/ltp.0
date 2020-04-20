From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 Apr 2020 14:55:58 +0200
Subject: [LTP] [PATCH v2 02/10] syscalls/ioctl:add common c file for
 loop ioctl
In-Reply-To: <8dd0a496-c46f-55d2-2393-5566eff618ff@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1586429086-22975-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200417151050.GA2491@yuki.lan>
 <8dd0a496-c46f-55d2-2393-5566eff618ff@cn.fujitsu.com>
Message-ID: <20200420125558.GA11604@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > In the end I've renamed and moved these functions into the test library
> > because the functionality is generic enough and I doubt that these
> > tests would be the only one using it.
> That's great.  I remember prctl cases use this function. Also, in some 
> cap cases, it needs bitwise operators(I only know prctl08.c). Maybe we 
> can add TST_ASSERT_BITWISE?

I guess that we would need to pass to numbers to the bitwise operation,
one would be mask for which bits should be used for the comparsion and
one with the actual bits. Which tests would need that? I looked at
capset and capget tests but there does not seem to any bitwise checks on
values on proc or sys files.

-- 
Cyril Hrubis
chrubis@suse.cz
