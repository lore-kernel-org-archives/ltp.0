From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Jul 2018 14:06:37 +0200
Subject: [LTP] [PATCH] pounder21: Replace {r,}index() with str{r,}chr()
In-Reply-To: <20180711164925.65342-2-astrachan@google.com>
References: <20180703091057.pfvdfxelb2u6cewi@dell5510>
 <20180711164925.65342-1-astrachan@google.com>
 <20180711164925.65342-2-astrachan@google.com>
Message-ID: <20180723120637.GB28159@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alistair,

> The index() and rindex() functions were removed in POSIX.2008. They are
> not implemented by Android's bionic C library for 64-bit platforms.

> Use the more portable strchr() and strrchr() functions from C89.

> Affects fancy_timed_loop, infinite_loop, run-helper, and timed_loop
> targets.

> Signed-off-by: Alistair Strachan <astrachan@google.com>

Patch merged, thanks!


Kind regards,
Petr
