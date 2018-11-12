From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 12 Nov 2018 21:37:23 +0100
Subject: [LTP] [PATCH v3 1/2] net: Add tst_net_run helper
In-Reply-To: <d25987dd-f70b-224e-19cf-f887fbb342f0@oracle.com>
References: <20181108142409.4955-1-pvorel@suse.cz>
 <d25987dd-f70b-224e-19cf-f887fbb342f0@oracle.com>
Message-ID: <20181112203723.GC13928@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > +	[ -n "$safe" ] && ROD $cmd || sh -c "$cmd"
>                                       ^
>                                   just $cmd?
Yes, sh -c does not work for shell functions unless are exported
(tst_test_drivers() in next commit is a shell function).
I somehow overlooked it.

But sh -c is used for all test links in tst_rhost_run(),
I guess we don't want to do export -f FUNCNAME for all functions in tst_net.sh,
do we?

> > +
> > +	cmd="$cmd $rparams $@"
>                ^
> So, now it is "$cmd $lparams $@", we need to store $1 in a separate variable.
Good catch, thx!


Kind regards,
Petr
