From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 8 Sep 2017 21:10:50 +0200
Subject: [LTP] [RFC PATCH v9 2/7] network/stress: Add library helper for
 stress testing
In-Reply-To: <b43be661-9e80-ca2a-66ce-f44b2499cca7@oracle.com>
References: <20170824234436.18145-1-pvorel@suse.cz>
 <20170824234436.18145-3-pvorel@suse.cz>
 <b43be661-9e80-ca2a-66ce-f44b2499cca7@oracle.com>
Message-ID: <20170908191050.llca2c7vegqear72@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thanks for your review and fixes!

> > +LINK_TOTAL=$(echo $LHOST_HWADDRS | wc -w)
> > +RHOST_LINK_TOTAL=$(echo $RHOST_HWADDRS | wc -w)
> > +[ $LINK_TOTAL -ne $RHOST_LINK_TOTAL ] && \
> > +	tst_brkm TBROK "the number of element in LHOST_HWADDRS differs from RHOST_HWADDRS" \
> > +	"($LINK_TOTAL vs. $RHOST_LINK_TOTAL," \
> > +	"LHOST_HWADDRS: '$LHOST_HWADDRS' RHOST_HWADDRS: '$RHOST_HWADDRS')"

> Didn't find the place where you need these variables. Are you going to
> use them somewhere or they are here just for checking network configuration?
> I've removed them and applied the patch.

These are used in route4-change-if. I left them here while excluding route tests from v9.
As you were talking about that multi test links are problematic and not many other tests
are using them it was a right decision not to include it.

BTW Tests requiring multi test links are these:
route{4,6}-change-if (I tend to delete it)
tcp4-multi-diffnic01
udp4-multi-diffnic01
icmp4-multi-diffnic01


Kind regards,
Petr
