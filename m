From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Jul 2018 13:54:59 +0200
Subject: [LTP] [PATCH] cpuset_lib: Replace index() with strchr()
In-Reply-To: <20180711164925.65342-1-astrachan@google.com>
References: <20180703091057.pfvdfxelb2u6cewi@dell5510>
 <20180711164925.65342-1-astrachan@google.com>
Message-ID: <20180723115459.GA28159@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alistair,

> The index() function was removed in POSIX.2008. It is not implemented by
> Android's bionic C library for 64-bit platforms.

> Use the more portable strchr() function from C89.

> Signed-off-by: Alistair Strachan <astrachan@google.com>

Thanks for your patch, pushed!

Kind regards,
Petr
