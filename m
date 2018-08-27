From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue, 28 Aug 2018 01:43:46 +0200
Subject: [LTP] [PATCH 1/2] netstress: Update help for -m behavior for
 client and server
Message-ID: <20180827234345.GA13304@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

...
> > -	{"m:", &Targ, "-m x     Reply timeout in microsec."},
> > +	{"m:", &Targ, "-m x     Reply timeout in microsec (for udp, udp_lite, dccp is timeout always 100 microsec)"},

> The timeout value not in microseconds, but in milliseconds.
Sorry, I forget to change in 2069fe8ea.

> > +	{"m:", &Targ, "-m x     Connect timeout in microsec (only for udp, udp_lite)"},

> This is misleading actually, connect is for the client...

> Why not to stick with what we had already discussed some time ago,
> something like this?

> "-m x   Receive timeout in milliseconds (not used by UDP/DCCP client)"

Make sense, fixed this way. Thanks!

Kind regards,
Petr
