From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Aug 2020 17:33:29 +0200
Subject: [LTP] [PATCH 1/4] Integrate tst_taint_check() into main LTP
 library
In-Reply-To: <20200811130502.12010-1-mdoucha@suse.cz>
References: <20200811130502.12010-1-mdoucha@suse.cz>
Message-ID: <20200814153329.GA30390@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Add .taint_check attribute to struct tst_test and use it to initialize
> taint checking functions. Then call tst_taint_check() automatically at the end
> of testing if needed.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Nice, thank you!

Kind regards,
Petr
