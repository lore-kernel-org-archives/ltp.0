From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 1 Mar 2021 08:38:57 +0100
Subject: [LTP] [Automated-testing] [PATCH v2 2/5] lib: Add minimalistic
 json parser
In-Reply-To: <20210224165045.17738-3-chrubis@suse.cz>
References: <20210224165045.17738-1-chrubis@suse.cz>
 <20210224165045.17738-3-chrubis@suse.cz>
Message-ID: <YDyaEd7xNx3NcMGE@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Nice work!

> +static int eatws(struct tst_json_buf *buf)
> +{
> +	while (!buf_empty(buf)) {
> +		switch (buf->json[buf->off]) {
> +		case ' ':
> +		case '\t':
> +		case '\n':
> +		case '\f':
Shouldn't there be '\r' as well? (handled at copy_str()).
> +		break;
> +		default:
> +			goto ret;
> +		}
> +
> +		buf->off += 1;
> +	}
> +ret:
> +	return buf_empty(buf);
> +}


Kind regards,
Petr
