From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Oct 2020 14:39:44 +0100
Subject: [LTP] [PATCH] syscalls/timer_settime01: adjust for rounding
 from nsec to usec
In-Reply-To: <20201026151250.GA370402@mussarela>
References: <20201006085309.32227-1-cascardo@canonical.com>
 <20201013140315.GD29925@yuki.lan> <20201020122351.GA15920@yuki.lan>
 <20201026151250.GA370402@mussarela>
Message-ID: <20201027133944.GA23030@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Sorry, I was out on vacation. This fixes it for me when using
> clocksource=jiffies.

Thanks a lot for testing, pushed.

-- 
Cyril Hrubis
chrubis@suse.cz
