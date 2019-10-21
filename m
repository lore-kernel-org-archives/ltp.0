From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Oct 2019 20:10:16 +0200
Subject: [LTP] [PATCH v4 5/5] Adopt doc for TST_RETRY_FUNC for
 LTP_TIMEOUT_MUL
In-Reply-To: <20191021144601.GC27848@rei>
References: <20191018124502.25599-1-cfamullaconrad@suse.de>
 <20191018124502.25599-6-cfamullaconrad@suse.de>
 <87h842o2pp.fsf@rpws.prws.suse.cz> <20191021144601.GC27848@rei>
Message-ID: <20191021181016.GA2279@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > I think the function tst_multiply_timeout also needs documenting.

> That depends on if we want to export it or not.

> We may as well keep it in API and create a helper under testcases/lib/
> tehn we could use the C code that can multiply precisely in the shell as
> well. But I do not care that much either way...
+1. I wouldn't export it unless it's needed.

Kind regards,
Petr
