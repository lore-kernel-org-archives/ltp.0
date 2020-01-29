From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Jan 2020 17:22:29 +0100
Subject: [LTP] [PATCH v2] Add a regression test for cve-2017-15649
In-Reply-To: <20200129120231.17375-1-mmoese@suse.de>
References: <20200129120231.17375-1-mmoese@suse.de>
Message-ID: <20200129162229.GA19893@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_kconfigs = kconfigs,
> +	.caps = caps

Also adding tags would be nice (at least CVE + consider adding 008ba2a13f2d:

    .tags = (const struct tst_tag[]) {
        {"CVE", "2017-15649"},
        {"linux-git", "008ba2a13f2d"},
        {}
    }
> +};

Kind regards,
Petr
