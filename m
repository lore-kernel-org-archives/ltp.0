From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Sep 2021 15:17:50 +0200
Subject: [LTP] [PATCH 1/4] doc: Mention make check
In-Reply-To: <20210902103740.19446-2-pvorel@suse.cz>
References: <20210902103740.19446-1-pvorel@suse.cz>
 <20210902103740.19446-2-pvorel@suse.cz>
Message-ID: <YTDO/mybX60s0agj@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  --------------------------------------------------------------------------------
>   statvfs01 statvfs01
>   statvfs02 statvfs02
> - 
> +
>  +statx01 statx01
>  +
>   stime01 stime01
>   stime02 stime02
> - 
> +

If we were pedantic this should probably be in a separate patch...


Otherwise the changes looks good, thanks for fixing this.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
