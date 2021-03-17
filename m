From: ruansy.fnst@fujitsu.com <ruansy.fnst@fujitsu.com>
Date: Wed, 17 Mar 2021 09:01:54 +0000
Subject: [LTP] [PATCH 2/2] syscalls/getppid02: Convert to the new API
In-Reply-To: <YFDfbrziEwXgxpOS@pevik>
References: <20210304021304.1126635-1-ruansy.fnst@fujitsu.com>
 <20210304021304.1126635-2-ruansy.fnst@fujitsu.com> <YFDfbrziEwXgxpOS@pevik>
Message-ID: <OSBPR01MB2920359890156471406C642EF46A9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



> -----Original Message-----
> From: Petr Vorel <pvorel@suse.cz>
> Subject: Re: [LTP] [PATCH 2/2] syscalls/getppid02: Convert to the new API
> 
> Hi Ruan,
> 
> > +/*\
> > + * [DESCRIPTION]
> >   *
> > + * Check that getppid() in child returns the same pid as getpid() in parent.
> > +\*/
> nit: this should be merged as */ only (drop leading \, see 96e964f97 ("docparse:
> Use C standard comment end").
> 

Hi Petr,

Do I need to send a v2 to fix this?


--
Thanks,
Ruan Shiyang.

> Kind regards,
> Petr
