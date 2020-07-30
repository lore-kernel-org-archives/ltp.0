From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 30 Jul 2020 14:53:29 +0200
Subject: [LTP] [PATCH 1/1] semctl: Fix 32 bit build
In-Reply-To: <20200730122226.GD3457@yuki.lan>
References: <20200730092637.487-1-pvorel@suse.cz>
 <20200730094842.GB3457@yuki.lan> <20200730101643.GA6381@dell5510>
 <20200730122226.GD3457@yuki.lan>
Message-ID: <20200730125329.GA31867@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > > And I guess the safest rule would be to add the -lltp* libraries first,
> > > because naturally none of the code in LTP but the test depends on these.
> > Are you're going to fix by changing order somewhere in include/mk/?
> > Or shell I push the fix with your ack?
> > I'd prefer proper fix so commits like this or 22f510de8 ("Fix static linking
> > with musl-fts") aren't needed any more.

> I wonder what would be the easiest solution here.

> The main problem is that these flags are per-testcase defined and are
> not expanded before we enter rule to build a test. And as we are using
> implicit rules to compile C code we cannot easily change that.

> I guess that we can write down our rules and do whatever we want there
> though.
Thanks for info. Well, I'll probably merge the original fix then.

Kind regards,
Petr
