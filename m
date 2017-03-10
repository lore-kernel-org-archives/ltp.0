From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 10 Mar 2017 15:50:05 +0100
Subject: [LTP] [PATCH v4 2/3] lib: SAFE_MQ_OPEN() macro
In-Reply-To: <20170308142154.25916-2-pvorel@suse.cz>
References: <20170308142154.25916-1-pvorel@suse.cz>
 <20170308142154.25916-2-pvorel@suse.cz>
Message-ID: <20170310145004.GB2017@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +int safe_mq_open(const char *file, const int lineno, const char *pathname,
> +	int oflags, ...)
> +{
> +	va_list ap;
> +	int rval;
> +	mode_t mode;
> +	struct mq_attr *attr;
> +
> +	mode = 0;
> +	attr = NULL;

I've removed these two useless initializations and pushed along with the
third patch, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
