From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 19 Feb 2018 09:34:42 +0100
Subject: [LTP] [RFC PATCH v2 3/3] test_net.sh: Add checks for external
	commands
In-Reply-To: <913e5d05-a499-a1dc-6551-c07663b0c6ef@oracle.com>
References: <20180215204714.14597-1-pvorel@suse.cz>
 <20180215204714.14597-3-pvorel@suse.cz>
 <913e5d05-a499-a1dc-6551-c07663b0c6ef@oracle.com>
Message-ID: <20180219083442.qlwhjm7ioset5a6j@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 15.02.2018 23:47, Petr Vorel wrote:
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ...
> > diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> > index fa06e0991..ffb646d87 100644
> > --- a/testcases/lib/test_net.sh
> > +++ b/testcases/lib/test_net.sh
> > @@ -472,8 +472,10 @@ tst_netload()

> >  	local sock_cmd=
> >  	if [ "$type" = "sctp" ]; then
> > +		tst_check_cmds netstat
> >  		sock_cmd="netstat -naS | grep $port | grep -q LISTEN"
> >  	else
> > +		tst_check_cmds ss
> >  		sock_cmd="ss -ln$(echo $type | head -c1) | grep -q $port"
> >  	fi

> Hi Petr,

> The changes looks good, I also have a draft patch that removes the
> need for a socket checks in tst_netload(), so it should fix the problem
> with netstat as well. I will send it soon.
OK, I'll wait with this, if you know you're going to remove it soon and rebase my version
after you fix it.


Kind regards,
Petr
