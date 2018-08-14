From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Aug 2018 09:13:56 +0200
Subject: [LTP] [PATCH] Move getcwd05 to realpath01 and fix for old distro
In-Reply-To: <20180813142631.GA4374@rei>
References: <20180801134717.29909-1-mmoese@suse.de>
 <20180813134152.GA7239@dell5510> <20180813142631.GA4374@rei>
Message-ID: <20180814071356.GA8012@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > >  rename testcases/kernel/syscalls/{getcwd/getcwd05.c => realpath/realpath01.c} (72%)
> > I wonder whether file should be named realpath_buffer_underflow.c to be more
> > descriptive.

> We usually keep just the names short and simple, so I would keep it as
> it is.
I think CVE related are the only exception (see Eric Biggers's post [1]), but
I'm ok with keeping it only realpath01.c.


Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2018-March/007388.html
