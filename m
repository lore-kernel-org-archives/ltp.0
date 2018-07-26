From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Jul 2018 09:45:26 +0200
Subject: [LTP] [PATCH 1/2] netstress: TCONF on wrong -T parameter
In-Reply-To: <20180719125358.948-1-pvorel@suse.cz>
References: <20180719125358.948-1-pvorel@suse.cz>
Message-ID: <20180726074525.GB17185@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Helps to find typo errors.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/netstress/netstress.c | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
> index 17e401eb0..48fb0aabd 100644
> --- a/testcases/network/netstress/netstress.c
> +++ b/testcases/network/netstress/netstress.c
> @@ -837,6 +837,8 @@ static void set_protocol_type(void)
>  		proto_type = TYPE_DCCP;
>  	else if (!strcmp(type, "sctp"))
>  		proto_type = TYPE_SCTP;
> +	else
> +		tst_brk(TCONF, "wrong proto_type: '%s'", type);

Pushed with minor change:
Using TBROK to be consistent with error messages in setup():
tst_brk(TBROK, "Invalid proto_type: '%s'", type);


Kind regards,
Petr

