From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Jun 2019 18:11:17 +0200
Subject: [LTP] [PATCH v2 2/3] syscalls/asyncio02: convert to new library.
In-Reply-To: <20190610002610.2187-3-sspatil@android.com>
References: <20190610002610.2187-1-sspatil@android.com>
 <20190610002610.2187-3-sspatil@android.com>
Message-ID: <20190613161117.GA14232@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/stat/stat02.c b/testcases/kernel/syscalls/stat/stat02.c
> new file mode 100644
> index 000000000..8dbac7236
> --- /dev/null
> +++ b/testcases/kernel/syscalls/stat/stat02.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0

Changed this to GPL-2.0-or-later to match the original here as well and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
