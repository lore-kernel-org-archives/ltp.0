From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Mon, 21 Oct 2019 15:41:04 +0200
Subject: [LTP] [PATCH v4 5/5] Adopt doc for TST_RETRY_FUNC for
 LTP_TIMEOUT_MUL
In-Reply-To: <20191021131530.GB18513@x230>
References: <20191018124502.25599-1-cfamullaconrad@suse.de>
 <20191018124502.25599-6-cfamullaconrad@suse.de>
 <87h842o2pp.fsf@rpws.prws.suse.cz> <20191021131530.GB18513@x230>
Message-ID: <1571665264.4633.8.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2019-10-21 at 15:15 +0200, Petr Vorel wrote:
<snip>
> > I think the function tst_multiply_timeout also needs documenting.
> 
> Isn't it meant to be used just in library (in lib/tst_test.c)?
> Thus I wouldn't document it here. And in fact remove it from
> include/tst_test.h
> (second commit).

I'm ok with private function. But you need to make it available to
tst_common.h. We could use extern. But not sure if this is what we
want.

On the other hand, we could make it as lib function, so others, who
need to set timeout in arbitrary way, have a utility to adjust there
timeout in a generic way. WDYT? But we also could leave this for later,
and simply change it if really needed.

Thanks
Clemens
