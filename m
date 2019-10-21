From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Oct 2019 15:53:46 +0200
Subject: [LTP] [PATCH v4 5/5] Adopt doc for TST_RETRY_FUNC for
 LTP_TIMEOUT_MUL
In-Reply-To: <1571665264.4633.8.camel@suse.de>
References: <20191018124502.25599-1-cfamullaconrad@suse.de>
 <20191018124502.25599-6-cfamullaconrad@suse.de>
 <87h842o2pp.fsf@rpws.prws.suse.cz> <20191021131530.GB18513@x230>
 <1571665264.4633.8.camel@suse.de>
Message-ID: <20191021135345.GA8999@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clemens,

> > Isn't it meant to be used just in library (in lib/tst_test.c)?
> > Thus I wouldn't document it here. And in fact remove it from
> > include/tst_test.h
> > (second commit).

> I'm ok with private function. But you need to make it available to
> tst_common.h. We could use extern. But not sure if this is what we
> want.

> On the other hand, we could make it as lib function, so others, who
> need to set timeout in arbitrary way, have a utility to adjust there
> timeout in a generic way. WDYT? But we also could leave this for later,
> and simply change it if really needed.
Well, it's not that important to complicate things.
My point was, that function is used only internally, unlike tst_set_timeout()
and tst_timeout_remaining() which are also used in some tests.

> Thanks
> Clemens

Kind regards,
Petr
