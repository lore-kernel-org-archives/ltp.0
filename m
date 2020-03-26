From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Mar 2020 21:32:22 +0100
Subject: [LTP] [PATCH 2/2] Avoid zero or negative int results in
 calculations
In-Reply-To: <20200326134603.GA5185@yuki.lan>
References: <20200324143839.3647c485@daedruan>
 <20200326084504.GB29830@dell5510> <20200326134603.GA5185@yuki.lan>
Message-ID: <20200326203222.GA19445@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > Define BUF_SIZE smaller than BLOCKSIZE for possitive offset result

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > BTW it significantly prolongs the run, but IMHO ok.

> Longer testruns should be avoided unless there is a good reason for it.
+1. Although the commit message does not describe what it fixes, it obviously
fixes something. It'd be nice to explain it a bit.

Before:
real	0m0,013s
user	0m0,004s
sys	0m0,009s

After (slowed by second commit, not by the rewrite):
real	0m0,402s
user	0m0,042s
sys	0m0,360s

Looks like the smaller buffer the faster it is.
I haven't tested other Martin's fix reported later.

Kind regards,
Petr
