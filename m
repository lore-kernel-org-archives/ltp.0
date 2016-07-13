From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Jul 2016 15:54:28 +0200
Subject: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
In-Reply-To: <57863E28.7020309@redhat.com>
References: <cad01181438a055f45b32fc28b33a8b8da74b768.1465903335.git.jstancek@redhat.com>
 <CAEemH2fGEGXftvF_HttR18KSbp8YRL_zaMhb38MQ4cpXqr-fMg@mail.gmail.com>
 <1589618283.6491776.1465976075619.JavaMail.zimbra@redhat.com>
 <57614F55.9090407@redhat.com> <20160616052544.GA18852@gmail.com>
 <1809783770.6955910.1466060898915.JavaMail.zimbra@redhat.com>
 <20160713093505.GA6033@gmail.com> <57863E28.7020309@redhat.com>
Message-ID: <20160713135428.GD2232@rei.scz.novell.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Latest idea attached.
> 
> It's similar to SAFE_FILE_SCANF, but it scanfs each line and first
> matching all scanf directives wins and terminates search, otherwise
> you get non-zero ret code. For example:
> 
> if (SAFE_FILE_LINES_SCANF("/proc/meminfo", "MemFree: %ld", &free))
>         tst_brk(TBROK, "Could not parse MemFree");

The API looks good to me. Nice work.

We should call this version FILE_LINES_SCANF() since the SAFE_ variants
call tst_brkm() on failure.

> diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
> index dff85cd83fec..db1660b1f684 100644
> --- a/lib/safe_file_ops.c
> +++ b/lib/safe_file_ops.c
> @@ -169,6 +169,49 @@ void safe_file_scanf(const char *file, const int lineno,
>  	}
>  }
>  
> +
> +/*
> + * Try to parse each line from file specified by 'path' according
> + * to scanf format 'fmt'. If all fields could be parsed, stop and
> + * return 0, otherwise continue or return 1 if EOF is reached.
> + */
> +int safe_file_lines_scanf(const char *file, const int lineno,
> +			  void (*cleanup_fn)(void),
> +			  const char *path, const char *fmt, ...)
> +{
> +	FILE *fp;
> +	int ret = 0;
> +	int arg_count = 0;
> +	char line[BUFSIZ];
> +	va_list ap;
> +
> +	if (!fmt) {
> +		tst_brkm(TBROK, cleanup_fn, "pattern is NULL, %s:%d",
> +			file, lineno);
> +	}
> +
> +	fp = fopen(path, "r");
> +	if (fp == NULL) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +			"Failed to open FILE '%s' for reading at %s:%d",
> +			path, file, lineno);
> +	}
> +
> +	arg_count = count_scanf_conversions(fmt);
> +
> +	while (fgets(line, BUFSIZ, fp) != NULL) {
> +		va_start(ap, fmt);
> +		ret = vsscanf(line, fmt, ap);
> +		va_end(ap);
> +
> +		if (ret == arg_count)
> +			break;
> +	}
> +	fclose(fp);

I wonder if it would be easier to take the fmt and append "%*[^\n]\n" to
it so that we can use fscanf() directly without the line buffer...

I guess that both of these are similarily complicated.

-- 
Cyril Hrubis
chrubis@suse.cz
