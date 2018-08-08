From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Wed, 8 Aug 2018 15:31:50 +0200
Subject: [LTP] [PATCH 2/2] testcases: netns: Handle "Operation not
 supported" error
In-Reply-To: <20180808130512.GD19147@rei>
References: <20180802141251.1571-1-mylene.josserand@bootlin.com>
 <20180802141251.1571-2-mylene.josserand@bootlin.com>
 <1ef13fe5-debb-57ff-422b-b2b5d3460523@oracle.com>
 <20180808130512.GD19147@rei>
Message-ID: <20180808153150.19d1f172@windsurf>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

On Wed, 8 Aug 2018 15:05:12 +0200, Cyril Hrubis wrote:

> > Not sure if the same should be here. The test-cases with IPsec involve
> > various crypto drivers that are much easier and better to check with
> > ip/netlink, and we also check both: the support in iproute and kernel.
> > I guess, veth and dummy virtual drivers could be checked with:
> >   
> >    modprobe -q veth || tst_brkm TCONF ...  
> 
> That will possibly break on embedded systems that have everything
> compiled-in kernel, not sure if there are any out there.

Perhaps LTP should require the kernel to be compiled with
CONFIG_IKCONFIG_PROC=y, so that LTP tests can check in /proc/config.gz
whether a given kernel feature is available or not ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
