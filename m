From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Aug 2018 15:05:12 +0200
Subject: [LTP] [PATCH 2/2] testcases: netns: Handle "Operation not
 supported" error
In-Reply-To: <1ef13fe5-debb-57ff-422b-b2b5d3460523@oracle.com>
References: <20180802141251.1571-1-mylene.josserand@bootlin.com>
 <20180802141251.1571-2-mylene.josserand@bootlin.com>
 <1ef13fe5-debb-57ff-422b-b2b5d3460523@oracle.com>
Message-ID: <20180808130512.GD19147@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Not sure if the same should be here. The test-cases with IPsec involve
> various crypto drivers that are much easier and better to check with
> ip/netlink, and we also check both: the support in iproute and kernel.
> I guess, veth and dummy virtual drivers could be checked with:
>   
>    modprobe -q veth || tst_brkm TCONF ...

That will possibly break on embedded systems that have everything
compiled-in kernel, not sure if there are any out there.

> Perhaps, we could add tst_drivers_available() helper to the library.

That's a good idea, that way it could be at least tweaked in a single
place.

-- 
Cyril Hrubis
chrubis@suse.cz
