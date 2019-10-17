From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Oct 2019 10:48:59 +0200
Subject: [LTP] [PATCH v3 3/4] tst_common.h: Use tst_multiply_timeout in
 TST_RETRY_FN()
In-Reply-To: <20191016161519.11256-3-cfamullaconrad@suse.de>
References: <1571225126.8494.1.camel@suse.de>
 <20191016161519.11256-1-cfamullaconrad@suse.de>
 <20191016161519.11256-3-cfamullaconrad@suse.de>
Message-ID: <20191017084859.GA14386@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Because of timeout problems when using TST_RETRY_FN() we want a LTP_TIMEOUT_MUL
> adopted timeout value here as well.

> Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
