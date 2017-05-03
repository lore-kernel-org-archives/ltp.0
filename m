From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 May 2017 14:35:41 +0200
Subject: [LTP] [PATCH v2] mmapstress04: rewrite to fix heap overwrite
In-Reply-To: <3cd0bc26ccba6d0bc890952e12ee312f95eaeebc.1493801364.git.jstancek@redhat.com>
References: <3cd0bc26ccba6d0bc890952e12ee312f95eaeebc.1493801364.git.jstancek@redhat.com>
Message-ID: <20170503123541.GA794@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void setup(void)
> +{
> +	page_size = getpagesize();
> +
> +	/*
> +	 * Pick large enough area, PROT_NONE doesn't matter,
> +	 * because we remap it later.
> +	 */
> +	mmap_area = SAFE_MMAP(NULL, page_size * NUM_PAGES, PROT_NONE,
> +		MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> +}
> +
> +static void write_fully(int fd, void *buf, int len)
> +{
> +	do {
> +		len -= SAFE_WRITE(0, fd, buf, len);
> +		buf += len;

This appears to be wrong. If SAFE_WRITE() writes 1 byte we end up with
offset len - 1 and lenght len - 1 which will cause reads outside of the
buffer.

We have to do:

		ret = SAFE_WRITE(...);
		buf += ret;
		len -= ret;

> +	} while (len > 0);
> +}

Otherwise it's fine. Acked with the write function fixed.

-- 
Cyril Hrubis
chrubis@suse.cz
