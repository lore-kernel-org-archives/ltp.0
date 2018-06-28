From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Jun 2018 09:10:04 +0200
Subject: [LTP] [PATCH 1/2 v2] tst_test: Fail the test subprocess cannot
 be killed
In-Reply-To: <20180627152217.7067-1-chrubis@suse.cz>
References: <20180627152217.7067-1-chrubis@suse.cz>
Message-ID: <20180628071004.5detyb7nkfbsneen@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> +	while (kill(-test_pid, 0) == 0) {
> +
> +		usleep(sleep);
> +		sleep*=2;
> +
> +		if (retries++ <= 14)
                          ^
Maybe some constant for it?


Kind regards,
Petr
