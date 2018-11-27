From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Nov 2018 13:40:00 +0100
Subject: [LTP] [PATCH] fs/growfiles.c: Fix the max size of every growing
 file
In-Reply-To: <1539771685-28323-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1539771685-28323-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20181127124000.GA31527@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
>  	unsigned long curr_size = 0;	/* BUG:14136 (keep track of file size) */
> -	const unsigned long ext2_limit = 2147483647;	/* BUG:14136 (2GB ext2 filesize limit) */
> +	unsigned long fs_limit = 2147483647; /* BUG:14136 (filesystem size limit is 2G by default) */
BTW I wonder if the "bug" is this one:
https://access.redhat.com/solutions/29129

doio code really needs cleanup.

Kind regards,
Petr
