From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Nov 2015 15:10:25 +0100
Subject: [LTP] [PATCH v2 2/2] Fix the order between 2>&1 and >/dev/null
In-Reply-To: <1448346118-24387-2-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1448345330-23620-2-git-send-email-weijg.fnst@cn.fujitsu.com>
 <1448346118-24387-1-git-send-email-weijg.fnst@cn.fujitsu.com>
 <1448346118-24387-2-git-send-email-weijg.fnst@cn.fujitsu.com>
Message-ID: <20151124141024.GC4151@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- a/tools/pounder21/libpounder.sh
> +++ b/tools/pounder21/libpounder.sh
> @@ -1,3 +1,4 @@
> +#!/bin/sh
>  # Common shell functions and variables that all pounder scripts can use.
>  
>  # Copyright (C) 2003-2006 IBM

Is there a reason to add the shebang here? And if there is, the change
should be described in the git commit message.

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
