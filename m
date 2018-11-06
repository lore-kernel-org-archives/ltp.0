From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Nov 2018 16:46:05 +0100
Subject: [LTP] [PATCH 2/5] syscalls/chmod07: Use new ltp library
In-Reply-To: <20181105235019.254846-3-sspatil@google.com>
References: <20181105235019.254846-1-sspatil@google.com>
 <20181105235019.254846-3-sspatil@google.com>
Message-ID: <20181106154605.GC3014@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ---
>  testcases/kernel/syscalls/chmod/chmod07.c | 174 ++++++----------------
>  1 file changed, 42 insertions(+), 132 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/chmod/chmod07.c b/testcases/kernel/syscalls/chmod/chmod07.c
> index 6a3938840..4e43f2e32 100644
> --- a/testcases/kernel/syscalls/chmod/chmod07.c
> +++ b/testcases/kernel/syscalls/chmod/chmod07.c
> @@ -1,20 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0

Should have been GPL-2.0-or-later

I fixed that and also removed a few useless comments in the source and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
