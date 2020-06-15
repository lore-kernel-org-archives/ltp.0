From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Jun 2020 14:43:24 +0200
Subject: [LTP] [PATCH V2 2/5] include: Add declaration of struct
 ipc64_perm
In-Reply-To: <dc4d34a42d4ca85d4d73b9e87974382368d02296.1590131635.git.viresh.kumar@linaro.org>
References: <5a10d33509ac73c26b233ab72c579f44386d0a55.1590057824.git.viresh.kumar@linaro.org>
 <dc4d34a42d4ca85d4d73b9e87974382368d02296.1590131635.git.viresh.kumar@linaro.org>
Message-ID: <20200615124324.GB25279@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Applied with two changes, thanks.

* The header is moved to lapi/ where it should have been

* I've removed a piece of GPL header that probably ended up in the
  source due to copy&paste

> +#if defined(__powerpc__) || defined(__powerpc64__)
> +#define HAVE_IPC64_PERM
> +/*
> + * The ipc64_perm structure for the powerpc is identical to
> + * kern_ipc_perm as we have always had 32-bit UIDs and GIDs in the
> + * kernel.  Note extra padding because this structure is passed back
> + * and forth between kernel and user space.  Pad space is left for:
> + *	- 1 32-bit value to fill up for 8-byte alignment
> + *	- 2 miscellaneous 64-bit values
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
            ^
	    This part.

-- 
Cyril Hrubis
chrubis@suse.cz
