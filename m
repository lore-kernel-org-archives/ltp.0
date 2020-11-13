From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Nov 2020 18:06:52 +0100
Subject: [LTP] [PATCH v2 00/11] 	Test metadata extraction
In-Reply-To: <20201112131139.GA4962@pevik>
References: <20201103191327.11081-1-pvorel@suse.cz>
 <20201112131139.GA4962@pevik>
Message-ID: <20201113170652.GA29443@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

...
> Anybody against pushing whole patchset [1] with fix below for third commit
> ("docparse: Add test documentation parser").

Going to merge whole patchset with diff below
(https://github.com/pevik/ltp/commits/test-metadata-extraction.v2.fixes).

Can I add you Reviewed-by: tag to whole patchset or a subset?

Kind regards,
Petr


> Kind regards,
> Petr

> [1] https://patchwork.ozlabs.org/project/ltp/list/?series=211956&state=*

> Fix for third commit:

> diff --git docparse/docparse.c docparse/docparse.c
> index 63d131c87..be6125353 100644
> --- docparse/docparse.c
> +++ docparse/docparse.c
> @@ -138,10 +138,8 @@ const char *next_token(FILE *f, struct data_node *doc)

>  		if (in_str) {
>  			if (c == '"') {
> -				if (i == 0 || buf[i-1] != '\\') {
> -					buf[i++] = c;
> +				if (i == 0 || buf[i-1] != '\\')
>  					goto exit;
> -				}
>  			}

>  			buf[i++] = c;
> @@ -189,7 +187,7 @@ const char *next_token(FILE *f, struct data_node *doc)
>  	}

>  exit:
> -	if (i == 0)
> +	if (i == 0 && !in_str)
>  		return NULL;

>  	buf[i] = 0;
