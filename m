From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jan 2021 11:48:34 +0100
Subject: [LTP] [PATCH V2 0/3] add rtctime libs and rtc02 case
In-Reply-To: <20210111083711.1715851-1-gengcixi@gmail.com>
References: <20210111083711.1715851-1-gengcixi@gmail.com>
Message-ID: <YA6iAkYyomg1WkTS@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've fixed a few problems in the patchset and pushed, thanks.

Mostly minor changes such as constifying the rtc_dev string pointer and
a few typo fixes, but also added missing function prototypes to the rtc_time.h

> 1. keep tst_rtc_gettime and tst_rtc_settime no change to "static 
>    inline"(V1) for some compile warning and referring to 
>    tst_clock_gettime in tst_clocks.h

This was due to missing include to sys/ioctl.h which declares the _IO()
macro used to define RTC_RD_TIME and RTC_SET_TIME

> 2. in .h, use identifiers format "/* XXX /*" rather than "// XXX" 
>    for kernel checkpatch "WARNING" as follow:

I guess that we may as well switch to the kernel format then.

-- 
Cyril Hrubis
chrubis@suse.cz
