From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Apr 2018 20:44:59 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Add test cmd helper
 tst_test_cmds()
In-Reply-To: <20180409131852.GD26048@rei.lan>
References: <20180406064204.9252-1-pvorel@suse.cz>
 <20180406070844.dbbedq7c4qso25ct@dell5510>
 <20180409131852.GD26048@rei.lan>
Message-ID: <20180409184459.GA26623@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > > +		which $1 > /dev/null 2>&1 || return 1
> > Pedantic version would check $? for 127 (indicating which itself it's not found).
> > Probably worth of adding it.

> Are you sure?

> $ which foo
> ...
> $ echo $?
> 1

> Also:

> $ busybox which foo
> $ echo $?
> 1

Yes, exit code 1 is when 'which' command doesn't find command.
Exit code 127 at least some shells use when command not found (in this case when 'which'
command itself is not found.

$ busybox foo; echo $?
foo: applet not found
127

Missing which IMHO only the case of busybox build with CONFIG_WHICH=n (but default is 'y')
=> corner case. I understand if we want to ignore it.

(+ Android - at least old versions had 'toolbox' instead of busybox => we'd ignore this
Android it's special and currently not fully supported anyway.


Kind regards,
Petr
