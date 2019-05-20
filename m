From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 May 2019 17:18:26 +0200
Subject: [LTP] [PATCH] lib: Migrate tst_get_unused_port to new API
In-Reply-To: <20190520145002.GA28760@dell5510>
References: <20190520135450.22014-1-pvorel@suse.cz>
 <20190520141940.GB28976@rei.lan> <20190520145002.GA28760@dell5510>
Message-ID: <20190520151826.GA10350@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Pushed with following diff:
> -	return TST_GET_UNUSED_PORT(family, type);
> +	printf("%d", TST_GET_UNUSED_PORT(family, type));
> +	return 0;
>  }

Kind regards,
Petr
