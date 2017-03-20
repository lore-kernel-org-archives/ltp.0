From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Mar 2017 13:45:02 +0100
Subject: [LTP] [PATCH 1/1] lib: use tst_exit() instead of exit()
In-Reply-To: <20170320095313.GB2711@rei.lan>
References: <20170316112359.8642-1-pvorel@suse.cz>
 <20170320095313.GB2711@rei.lan>
Message-ID: <20170320124502.sleuxkf2aui2zy7f@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> The answer here is that we do not care in these cases. The difference
> between exit() and tst_exit() is that tst_exit() exits with correct exit
> value (bitflags stored in the test library) when tst_res() is used to
> report test results. And since the exit value from the code changed
> below is not used the difference is merely cosmetic.
Thanks for explaining. OK, forget on it. Sorry for wasting your time.


Kind regards,
Petr
