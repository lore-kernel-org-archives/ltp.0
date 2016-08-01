From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 1 Aug 2016 06:29:59 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/mprotect04: Use
 __builtin___clear_cache() to sync caches
In-Reply-To: <1469550665-12918-1-git-send-email-peter.maydell@linaro.org>
References: <1469550665-12918-1-git-send-email-peter.maydell@linaro.org>
Message-ID: <1476945951.10231924.1470047399416.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: ltp@lists.linux.it
> Cc: patches@linaro.org, "Cyril Hrubis" <chrubis@suse.cz>, "Jan Stancek" <jstancek@redhat.com>, "Mark Rutland"
> <mark.rutland@arm.com>
> Sent: Tuesday, 26 July, 2016 6:31:05 PM
> Subject: [PATCH] syscalls/mprotect04: Use __builtin___clear_cache() to sync caches
> 
> In commit cf9a0800cd0 code was added to mprotect04 to synchronize
> the instruction and data caches on PowerPC before executing
> the copied code. This is also necessary on other architectures
> which have split instruction and data caches and need explicit
> cache maintenance operations, like ARM.
> 
> The GCC builtin __builtin___clear_cache() will correctly handle
> this for all architectures, so switch to using it. The builtin
> was only implemented at around GCC 4.1, so use a configure
> check so that we will skip the test with TCONF if the compiler
> doesn't support the builtin.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Looks good to me.

> ---
> Disclaimer: untested on PPC.

I don't have such HW available at the moment, but I tested this
on RHEL5.6/6.0/7.2 x86_64. RHEL5.6 exits with TCONF as expected.

Regards,
Jan
