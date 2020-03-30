From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Mar 2020 13:53:35 +0200
Subject: [LTP] [PATCH 4/6] lib/tst_run_cmd_*(): Search for program in
 $PATH
In-Reply-To: <20200330115224.GC23915@dell5510>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <20200327213924.18816-5-pvorel@suse.cz>
 <20200330114041.GF9845@yuki.lan> <20200330115224.GC23915@dell5510>
Message-ID: <20200330115335.GG9845@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +	/* exit with TCONF if program is not in path */
> > > +	TST_RUN_CMD_CHECK_CMD = 2,
> 
> > Shouldn't be this rather called TST_CMD_TCONF_ON_MISSING?
> +1.
> 
> If these two comments (with renaming to tst_cmd() + flags) are the only your
> concern, I'll rename it and just push without sending to ML.

Yes, minus the comments on the function and constant names the code
lookgs good.

> When we're in renaming, I guess I should rename SAFE_RUN_CMD() into SAFE_CMD(),

Indeed.

-- 
Cyril Hrubis
chrubis@suse.cz
