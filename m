From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Apr 2018 20:52:59 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Add test cmd helper
 tst_test_cmds()
In-Reply-To: <20180409131447.GC26048@rei.lan>
References: <20180406064204.9252-1-pvorel@suse.cz>
 <20180409131447.GC26048@rei.lan>
Message-ID: <20180409185259.GA30997@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> > +'tst_test_cmds()' can be used for requirements just for a particular test
> > +as it doesn't exit. Supposed usage is:
>                          ^
> 			 Expected

> Also we really should say that the call will issue TCONF here, because
> it's not clear that it would.

...
> > +tst_cmd_available()
> > +{
> > +	if type command > /dev/null 2>&1; then
> > +		command -v $1 > /dev/null 2>&1 || return 1
> > +	else
> > +		which $1 > /dev/null 2>&1 || return 1
> > +	fi
> > +}

> We are falling back to which if command is not available here?

> Are you aware of any shell that is lacking command?
Busybox configured with CONFIG_WHICH=n (but default is 'y') => corner case.

> Also we should probably add return 0 at the end of the function, as it
> is the code is correct, since the return value would be return value of
> the last executed line, which is guaranteed to be 0 because of the
> || return 1 but it's kind of confusing to omit it.
Sure, I'll do. (I've learned to avoid 'return 0' from test_net.sh, but it can be
dangerous).


Kind regards,
Petr
