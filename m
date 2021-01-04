From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 4 Jan 2021 07:53:28 +0100
Subject: [LTP] [PATCH 1/1] if-mtu-change.sh: Add max packet size
 detection for IPv4
In-Reply-To: <X9ogSVvjhY+iBpBD@pevik>
References: <20201215190545.19939-1-pvorel@suse.cz>
 <53607e8b-176f-5aaf-4b5f-9efabd1d756f@oracle.com>
 <X9ogSVvjhY+iBpBD@pevik>
Message-ID: <X/K7aC0n6ks1jYDM@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > > -		tst_ping -s "1 1000 65507"
> > > +		tst_ping -s "1 1000 $MAX_PACKET_SIZE"

> > tst_ping -s "1 $((mtu / 2)) $mtu $MAX_PACKET_SIZE"?
> Thinking about this twice: adding forth size prolong test a bit (test is already
> quite slow. But it makes sense to me to test all 4 variants.

Merged the original version. I wonder if we can change the default
CHANGE_INTERVAL to 3 or even less (1) to make testing a bit faster.
Is the value more important for two host based testing?
Because it works on netns based testing.

Kind regards,
Petr
