From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 2 Oct 2017 19:36:01 +0200
Subject: [LTP] [RFC] [PATCH] lib/tst_test: Do TBROK on unexpected
 arguments.
In-Reply-To: <20171002091949.21900-1-chrubis@suse.cz>
References: <20171002091949.21900-1-chrubis@suse.cz>
Message-ID: <20171002173601.jphgzviaoy37uyod@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> +	if (optind < argc)
> +		tst_brk(TBROK, "Unexpected argument(s) '%s'...", argv[optind]);
LGTM.

Kind regards,
Petr
