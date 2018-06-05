From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Jun 2018 08:42:43 +0200
Subject: [LTP] [PATCH] sctp: change the layout of tst_brkm()
In-Reply-To: <20180604092712.7436-1-sunlw.fnst@cn.fujitsu.com>
References: <20180604092712.7436-1-sunlw.fnst@cn.fujitsu.com>
Message-ID: <20180605064243.gunhxvr7whq26isp@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sun,

pushed, thanks!
> The statement tst_brkm(TBROK, tst_exit, "a b"
> 						 "c");
> which will error output "a bc", and this layout is not good for git grep.
I'm sorry, I forget to add this explanation (I need to apply the patch with 'patch' as git
am/apply refused to work due whitespace errors, even with --whitespace=warn).
I also removed trailing whitespace.

> Reported-by: Wei Xingshen <weixshen@gmail.com>
> Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>


Kind regards,
Petr
