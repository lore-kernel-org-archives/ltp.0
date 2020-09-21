From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Sep 2020 13:59:51 +0200
Subject: [LTP] [PATCH 1/2] runtest/smoketest: Add smoketest
In-Reply-To: <20200921114026.11184-1-chrubis@suse.cz>
References: <20200921114026.11184-1-chrubis@suse.cz>
Message-ID: <20200921115951.GB1993@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

thanks for implementing this.
> This runtest file is meant to be used for infrastructure checks i.e. to
> test LTP integration with various frameworks. The testcases were choosen
> so that the testrun is fast and also represents reasonable subset of
> different LTP testcases, e.g. binary, shell, etc.

> The primary reason we are adding this is that we want to get rid of
> quickhit, which has been misused for this purpose.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: "Bird, Tim" <Tim.Bird@sony.com>
> CC: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
