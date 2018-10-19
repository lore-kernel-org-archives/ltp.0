From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 Oct 2018 14:21:27 +0200
Subject: [LTP] [PATCH v3] setregid03: convert to newlib
In-Reply-To: <20181018133810.29420-1-cfamullaconrad@suse.de>
References: <20181018133810.29420-1-cfamullaconrad@suse.de>
Message-ID: <20181019122127.GC31934@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor change, thanks.

> +void run_all(void)
> +{
> +	unsigned int i;
> +
> +	if (!SAFE_FORK())
> +		for (i = 0; i < ARRAY_SIZE(tcases); i++)
> +			run(i);
> +}

LKML coding style preferes to have curly braces around blocks that have
inner blocks, so I added them for the if () and pushed.

-- 
Cyril Hrubis
chrubis@suse.cz
