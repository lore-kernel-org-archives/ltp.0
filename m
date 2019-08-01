From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 1 Aug 2019 06:43:10 -0400 (EDT)
Subject: [LTP] [RFC PATCH 2/9] lib: Add a canary for guarded buffers
In-Reply-To: <20190801092616.30553-3-chrubis@suse.cz>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-3-chrubis@suse.cz>
Message-ID: <1516778317.3992530.1564656190448.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> In a case that the buffer size is not a multiple of a page size there is
> unused space before the start of the buffer. Let's fill that with
> center mirrored random bytes and check that the buffer wasn't modified
> before we unmap it.
> 
>  void *tst_alloc(size_t size)
>  {
>  	size_t page_size = getpagesize();
> @@ -34,9 +61,13 @@ void *tst_alloc(size_t size)
>  	maps = map;
>  
>  	if (size % page_size)
> -		ret += page_size - (size % page_size);
> +		map->buf_shift = page_size - (size % page_size);
> +	else
> +		map->buf_shift = 0;
> +
> +	setup_canary(map);
>  
> -	return ret;
> +	return ret + map->buf_shift;

My concern here is alignment.
