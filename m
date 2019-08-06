From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 06 Aug 2019 11:03:11 +0200
Subject: [LTP] [RFC PATCH 1/9] lib: Add support for guarded buffers
In-Reply-To: <20190801092616.30553-2-chrubis@suse.cz>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-2-chrubis@suse.cz>
Message-ID: <871rxyd5tc.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Cyril Hrubis <chrubis@suse.cz> writes:
> +void tst_free_all(void)
> +{
> +	struct map *i = maps;
> +
> +	while (i) {
> +		struct map *j = i;
> +		tst_res(TINFO, "Freeing %p %zu", i->addr, i->size);

This seems like debug info to me. Not really useful most of the time.

> +		SAFE_MUNMAP(i->addr, i->size);
> +		i = i->next;
> +		free(j);
> +	}
> +
> +	maps = NULL;
> +}

-- 
Thank you,
Richard.
