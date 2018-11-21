From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 21 Nov 2018 10:37:56 +0100
Subject: [LTP] [PATCH ltp] syscalls/bind03: Modified to test errors
 separately.
In-Reply-To: <20181120155744.GA23648@x230>
References: <20180911102403.7094-1-junchi.chen@intel.com>
 <20181120155744.GA23648@x230>
Message-ID: <20181121093756.GA28552@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Junchi,

> > To avoid mess with the priority of EADDRINUSE and EINVAL, we split the
> > test to test these two -- one invalid parameter at a time.

> > Signed-off-by: Junchi Chen <junchi.chen@intel.com>
> > ---
> >  testcases/kernel/syscalls/bind/bind03.c | 47 +++++++++++++------------

> Thanks, merged.
I accidentally put myself as the author instead of me.
I'm sorry, I'll be careful this not happen next time.

Kind regards,
Petr
