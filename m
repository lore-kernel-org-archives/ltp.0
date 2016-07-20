From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Jul 2016 16:28:28 +0800
Subject: [LTP] [PATCH] swapping: replace mem_free by mem_available
In-Reply-To: <1469000896-6122-1-git-send-email-liwang@redhat.com>
References: <1469000896-6122-1-git-send-email-liwang@redhat.com>
Message-ID: <20160720082828.GA7288@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jul 20, 2016 at 03:48:16PM +0800, Li Wang wrote:
> -		sleep(5);
> -		if (mem_free_init < 10240)
> +	if (!FILE_LINES_SCANF(cleanup, "/proc/meminfo", "MemAvailable: %ld",
> +				&mem_available_init))

slight correction: the "!" is redundant. That should be like:

	if (FILE_LINES_SCANF(cleanup, "/proc/meminfo", "MemAvailable: %ld",
				&mem_available_init))

Regards,
Li Wang
