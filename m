From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Dec 2020 16:18:08 +0100
Subject: [LTP] [PATCH v3] pty04: Limit the number of packets sent to
 avoid timeout
In-Reply-To: <20201214094951.24018-1-rpalethorpe@suse.com>
References: <X9ONfxzTVLT4Rgfd@yuki.lan>
 <20201214094951.24018-1-rpalethorpe@suse.com>
Message-ID: <X9eCMLvB37yCx5ff@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	tst_res(TPASS, "Writing to PTY interrupted by hangup");
> +	tst_res(TPASS, "Transmission on PTY interrupted by hangup");
>  
>  	tst_free_all();
>  }
>  
> +#undef RETRY_ASYNC

I've removed this now unused undef and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
