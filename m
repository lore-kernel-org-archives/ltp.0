From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Apr 2016 13:35:31 +0200
Subject: [LTP] [PATCH v2 1/2] lib: add safe_pthread_create() &
 safe_pthread_join()
In-Reply-To: <1460016651-24181-1-git-send-email-alexey.kodanev@oracle.com>
References: <1460016651-24181-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160407113531.GA16682@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +int safe_pthread_join(const char *file, const int lineno,
> +		      pthread_t thread_id, void **retval)
> +{
> +	int rval;
> +
> +	rval = pthread_join(thread_id, retval);
> +
> +	if (rval) {
> +		tst_brk_(file, lineno, TBROK,
> +			 "pthread_join(%lu,%p) failed: %s", thread_id, retval,
> +			 tst_strerrno(rval));

Technically the thread_id does not need to be numeric type, POSIX
defines it as a opaque, may be structure as well.

But on the other hand I doubt that there is a Linux libc implementation
that actually defines it to be anything else than long int.

> +	}
> +
> +	return rval;
> +}

Otherwise this looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
