From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 5 Nov 2018 08:37:35 +0100
Subject: [LTP] [PATCH 1/2] net: Add tst_net_driver helper
In-Reply-To: <20181102221454.5056-1-pvorel@suse.cz>
References: <20181102221454.5056-1-pvorel@suse.cz>
Message-ID: <20181105073734.GA24735@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> +tst_net_driver()
> +{
> +	tst_test_drivers $@
> +	tst_rhost_run "tst_test_drivers $@"
Error, needs:
tst_rhost_run -c "tst_test_drivers $@"


Kind regards,
Petr
