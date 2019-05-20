From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 May 2019 15:47:48 +0200
Subject: [LTP] [PATCH 1/1] net: Introduce TST_GET_UNUSED_PORT() macro
 into C API
In-Reply-To: <20190520120848.GA27675@rei.lan>
References: <20190423193823.4580-1-pvorel@suse.cz>
 <20190520120848.GA27675@rei.lan>
Message-ID: <20190520134748.GA19968@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> Looks good, acked.
Thanks, merged with your ack.

> Btw the ltpapicmd implementation should get either removed (in a case
> that it will be no longer used) or we should convert it to a standalone
> helper the testcases/lib/ directory. But that is something that should
> be done in a seprate patch...
OK, going to push patch implementing it.

Kind regards,
Petr
