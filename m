From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Jan 2021 13:16:03 +0100
Subject: [LTP] [PATCH v3 1/2] lib: Fix kernel module detection on BusyBox
In-Reply-To: <20210119160316.4776-2-pvorel@suse.cz>
References: <20210119160316.4776-1-pvorel@suse.cz>
 <20210119160316.4776-2-pvorel@suse.cz>
Message-ID: <YAgfA5XWXweaTkB1@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> +int tst_search_driver(const char *driver, const char *file)
As Joerg pointed out, this must be static.

...
> +int tst_check_driver_(const char *driver)
And this one as well.
> +{
> +	if (!tst_search_driver(driver, "modules.dep") ||
> +		!tst_search_driver(driver, "modules.builtin"))
> +		return 0;
> +
> +	return 1;
> +}
...

Kind regards,
Petr
