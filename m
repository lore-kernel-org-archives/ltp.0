From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 May 2018 11:40:29 +0200
Subject: [LTP] [PATCH 1/2] network/route: Rewrite route-change-dst into
	new API
In-Reply-To: <f566c2ba-5a7e-2fe7-e92f-1da4459e18c5@oracle.com>
References: <20180517103527.23542-1-pvorel@suse.cz>
 <f566c2ba-5a7e-2fe7-e92f-1da4459e18c5@oracle.com>
Message-ID: <20180518094029.ylc7walhx6vwx5uk@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > +		# Load the route with one UDP datagram
> > +		ROD ns-udpsender -f $ipver -D $addr -p $cnt -o -s $udp_size

> '-p' parameter should be in range from 1 to 65535, $cnt can exceed that.

> It would be good to print some intermediate result message inside
> the loop to show the current progress.
Thank you, good points, I'll add it into v2!


Kind regards,
Petr
