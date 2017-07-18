From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 18 Jul 2017 03:58:29 -0400 (EDT)
Subject: [LTP] [PATCH 4/4] Test for CVE-2016-10044 mark AIO pseudo-fs
 noexec
In-Reply-To: <20170718073319.23543-5-rpalethorpe@suse.com>
References: <20170718073319.23543-1-rpalethorpe@suse.com>
 <20170718073319.23543-5-rpalethorpe@suse.com>
Message-ID: <1513116395.54444036.1500364708984.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
...
> +
> +#include "tst_test.h"
> +
> +#ifdef HAVE_LINUX_AIO_ABI_H
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <linux_syscall_numbers.h>
> +#include <linux/aio_abi.h>

Hi,

from LTP docs:
"Don't use +linux/+ headers if at all possible. Usually they are replaced with
+sys/+ headers as things work their way into glibc.  Furthermore, +linux/+
headers get shuffled around a lot more than their +sys/+ counterparts it
seems."

If we really have to use linux header then I'd suggest a configure check
that also checks it's compilable.

Regards,
Jan
