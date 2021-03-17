From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 Mar 2021 10:19:46 +0100
Subject: [LTP] [PATCH 2/2] syscalls/getppid02: Convert to the new API
In-Reply-To: <OSBPR01MB2920359890156471406C642EF46A9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210304021304.1126635-1-ruansy.fnst@fujitsu.com>
 <20210304021304.1126635-2-ruansy.fnst@fujitsu.com>
 <YFDfbrziEwXgxpOS@pevik>
 <OSBPR01MB2920359890156471406C642EF46A9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
Message-ID: <YFHJsr1ORyl+k7dq@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > > +/*\
> > > + * [DESCRIPTION]
> > >   *
> > > + * Check that getppid() in child returns the same pid as getpid() in parent.
> > > +\*/
> > nit: this should be merged as */ only (drop leading \, see 96e964f97 ("docparse:
> > Use C standard comment end").

> Hi Petr,

> Do I need to send a v2 to fix this?
No need, we fix it before merge.

Kind regards,
Petr
