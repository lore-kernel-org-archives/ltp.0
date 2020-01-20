From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jan 2020 14:52:43 +0100
Subject: [LTP] [PATCH 2/2] tst_device: Move tst_dev_sync() into from
 header to source file
In-Reply-To: <20200120133646.8629-2-pvorel@suse.cz>
References: <20200120133646.8629-1-pvorel@suse.cz>
 <20200120133646.8629-2-pvorel@suse.cz>
Message-ID: <20200120135243.GA10589@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> -static inline int tst_dev_sync(int fd)
> -{
> -	return syscall(__NR_syncfs, fd);
> -}
> +static int tst_dev_sync(int fd);
This is obviously wrong.

> diff --git a/lib/tst_device.c b/lib/tst_device.c
...
> +static int tst_dev_sync(int fd)
And here as well.
> +{
> +	return syscall(__NR_syncfs, fd);
> +}

Sorry for wrong patch.

Kind regards,
Petr
