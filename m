From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 Apr 2016 16:36:23 +0200
Subject: [LTP] [PATCH v2 3/4] tst_atomic: add atomic_add_return for
 x86/64, ppc/64 and s390/x
In-Reply-To: <99010bd0c03b38684433361a65ebc345de98b63a.1460622188.git.jstancek@redhat.com>
References: <7260589f891c8c60ada465b5086215c4eba8d346.1460622188.git.jstancek@redhat.com>
 <99010bd0c03b38684433361a65ebc345de98b63a.1460622188.git.jstancek@redhat.com>
Message-ID: <20160414143622.GC22998@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  #if HAVE_SYNC_ADD_AND_FETCH == 1
> +#define HAVE_ATOMIC_ADD_RETURN 1
>  static inline __attribute__((always_inline)) int atomic_add_return(int i, int *v)
>  {
>  	return __sync_add_and_fetch(v, i);
>  }
> -#else
> +
> +#else /* HAVE_SYNC_ADD_AND_FETCH == 1 */
> +
> +#if defined(__i386__) || defined(__x86_64__)
> +#define HAVE_ATOMIC_ADD_RETURN 1
> +static inline __attribute__((always_inline)) int atomic_add_return(int i, int *v)
> +{

Maybe we can make the ifdefs a bit more readable by indenting them with
spaces after the hash.

#else
# if defined(__i386__) || defined(__x86_64__)
#  define HAVE_ATOMIC_ADD_RETURN 1

...

# endif


Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
