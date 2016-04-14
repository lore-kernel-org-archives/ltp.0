From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 Apr 2016 16:33:55 +0200
Subject: [LTP] [PATCH v2 2/4] m4: add a check for __sync_add_and_fetch
In-Reply-To: <57e43baa7463633bf01e477091502718d176dad3.1460622188.git.jstancek@redhat.com>
References: <7260589f891c8c60ada465b5086215c4eba8d346.1460622188.git.jstancek@redhat.com>
 <57e43baa7463633bf01e477091502718d176dad3.1460622188.git.jstancek@redhat.com>
Message-ID: <20160414143355.GB22998@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#if HAVE_SYNC_ADD_AND_FETCH == 1
> +static inline __attribute__((always_inline)) int atomic_add_return(int i, int *v)

As this is publicly exported interface I would prefer adding tst_ prefix
to the function name.

> +{
> +	return __sync_add_and_fetch(v, i);
> +}
> +#else
> +#error Your compiler does not provide __sync_add_and_fetch and LTP\
> + implementation is missing for your architecture.
> +#endif
> +
>  static inline int tst_atomic_inc(int *v)
>  {
> -	return __sync_add_and_fetch(v, 1);
> +	return atomic_add_return(1, v);
>  }

-- 
Cyril Hrubis
chrubis@suse.cz
