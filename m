From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 31 Jul 2019 14:05:03 +0200
Subject: [LTP] [PATCH v7 1/3] lib: alter find_free_loopdev()
In-Reply-To: <1564569629-2358-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190730110555.GB7528@rei.lan>
 <1564569629-2358-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190731120503.GC22537@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/lib/tst_device.c
...
> -			return 0;
> +			if (path != NULL)
> +				strncpy(path, buf, path_len);
Is it safe to assume that path_len is *always* < 1024 (size of buf)?
> +			return i;
...


Kind regards,
Petr
