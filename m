From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Jun 2020 09:46:16 +0200
Subject: [LTP] [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot
 aggregate
In-Reply-To: <20200615200121.GG129694@glitch>
References: <20200527071434.28574-1-pvorel@suse.cz>
 <1590601280.16219.1.camel@linux.ibm.com>
 <20200528140747.GA8401@dell5510>
 <1590679145.4457.39.camel@linux.ibm.com>
 <20200528160527.GA27243@dell5510> <20200615194134.GF129694@glitch>
 <20200615200121.GG129694@glitch>
Message-ID: <20200619074616.GA23036@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Bruno,

> > > > > > $ VERBOSE=1 make check TESTS=boog_aggregate.test
>                                        ^^^^
> 				       boot

> That's the issue :).

Thanks! Obviously everything is working with correct test name :).

Kind regards,
Petr
