From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 21 Jan 2021 14:47:57 +0000
Subject: [LTP] [PATCH 1/2] docparse: Replace \t with space
In-Reply-To: <20210121130033.20764-1-pvorel@suse.cz>
References: <20210121130033.20764-1-pvorel@suse.cz>
Message-ID: <87mtx29wiq.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> to avoid constant failures because tabs are forbidden in JSON.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
>
> Currently required for "Convert CAN tests to new LTP API" patchset
> https://patchwork.ozlabs.org/project/ltp/patch/20210120143723.26483-5-rpalethorpe@suse.com/
> https://patchwork.ozlabs.org/project/ltp/patch/20210120143723.26483-6-rpalethorpe@suse.com/
>
> Kind regards,
> Petr
>
>  docparse/data_storage.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/docparse/data_storage.h b/docparse/data_storage.h
> index ef420c08f..99c2514b7 100644
> --- a/docparse/data_storage.h
> +++ b/docparse/data_storage.h
> @@ -54,6 +54,7 @@ static inline struct data_node *data_node_string(const char *string)
>  {
>  	size_t size = sizeof(struct data_node_string) + strlen(string) + 1;
>  	struct data_node *node = malloc(size);
> +	char *ix = node->string.val;
>  
>  	if (!node)
>  		return NULL;
> @@ -61,6 +62,9 @@ static inline struct data_node *data_node_string(const char *string)
>  	node->type = DATA_STRING;
>  	strcpy(node->string.val, string);
>  
> +	while ((ix = strchr(ix, '\t')))
> +		*ix++ = ' ';


JQ says "control characters from U+0000 through U+001F must be
escaped". So I expect it is only a matter of time until some other
control character is used.

Perhaps we should escape all control characters into the \uXXXX
hexidecimal form?

http://www.json.org/json-en.html

> +
>  	return node;
>  }


-- 
Thank you,
Richard.
