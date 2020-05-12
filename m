From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 May 2020 21:50:33 +0200
Subject: [LTP] [PATCH 1/1] rpc: Warn when tests aren't compiled
In-Reply-To: <d011a55b-a5b5-049f-9037-235d1f18cf1b@oracle.com>
References: <20200512152701.23625-1-pvorel@suse.cz>
 <d011a55b-a5b5-049f-9037-235d1f18cf1b@oracle.com>
Message-ID: <20200512195033.GA3784@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

...
> >  rpc_parse_args()
> >  {
> > +	local err="LTP compiled without TI-RPC support"
> > +
> >  	case "$1" in
> > -		c) CLIENT="$OPTARG" ;;
> > -		e) CLIENT_EXTRA_OPTS="$OPTARG" ;;
> > -		s) SERVER="$OPTARG" ;;
> > +	c) CLIENT="$OPTARG"; tst_cmd_available $OPTARG || tst_brk TCONF $err;;
> > +	e) CLIENT_EXTRA_OPTS="$OPTARG";;
> > +	s) SERVER="$OPTARG"; tst_cmd_available $OPTARG || tst_brk TCONF $err;;
> >  	esac

> Perhaps this one, to write about the missing command:
> tst_require_cmds $CLIENT $SERVER

> or just $CLIENT because it's always used, and if the hint is needed:
> tst_check_cmds $CLIENT $SERVER || tst_brk TCONF "LTP compiled without TI-RPC support?"
I prefer to have the hint, so I'll merge this variant.

Thanks for your review!

Kind regards,
Petr
