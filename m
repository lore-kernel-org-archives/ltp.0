From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Feb 2018 17:34:53 +0100
Subject: [LTP] [PATCH] openposix: mmap/21-1: adjust the test to work
 with MAP_SHARED_VALIDATE
In-Reply-To: <1518105323-12867-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1518105323-12867-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20180208163453.GA2049@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +int is_valid(int flag)
> +{
> +	if (flag == MAP_SHARED || flag == MAP_PRIVATE || flag == MAP_FIXED)
> +		return 1;
> +
> +#ifdef __linux__
> +
> +#ifndef MAP_SHARED_VALIDATE
> +#define MAP_SHARED_VALIDATE 0x03
> +#endif
> +
> +	if (flag == MAP_SHARED_VALIDATE)
> +		return 1;
> +#endif
> +
> +	return 0;
> +}

Hmm, this probably does not scale up, what about setting the flag to
have all its bits set (i.e. passing ~0 to the mmap()) from the start
instead?

-- 
Cyril Hrubis
chrubis@suse.cz
