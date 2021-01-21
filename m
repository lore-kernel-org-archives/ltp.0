From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Jan 2021 14:05:37 +0100
Subject: [LTP] [PATCH 1/2] docparse: Replace \t with space
In-Reply-To: <20210121130033.20764-1-pvorel@suse.cz>
References: <20210121130033.20764-1-pvorel@suse.cz>
Message-ID: <YAl8ITSPUxDAZb40@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
>  	size_t size = sizeof(struct data_node_string) + strlen(string) + 1;
>  	struct data_node *node = malloc(size);
> +	char *ix = node->string.val;

>  	if (!node)
>  		return NULL;
> @@ -61,6 +62,9 @@ static inline struct data_node *data_node_string(const char *string)
>  	node->type = DATA_STRING;
>  	strcpy(node->string.val, string);

Probably better to comment this:
/* tabs are not allowed in JSON */
> +	while ((ix = strchr(ix, '\t')))
> +		*ix++ = ' ';

Kind regards,
Petr
