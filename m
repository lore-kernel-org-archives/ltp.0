From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Mon, 8 Oct 2018 11:28:55 +0200
Subject: [LTP] [PATCH 2/2] testcases: netns: Handle "Operation not
 supported" error
In-Reply-To: <20181004130611.GB32169@dell5510>
References: <20180802141251.1571-1-mylene.josserand@bootlin.com>
 <20180802141251.1571-2-mylene.josserand@bootlin.com>
 <20181004130611.GB32169@dell5510>
Message-ID: <20181008112855.5a7d3052@dell-desktop.home>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello,

On Thu, 4 Oct 2018 15:06:11 +0200
Petr Vorel <pvorel@suse.cz> wrote:

> Hi Mylène,
> 
> > If there is no support for "dummy" or "veth", the tests will fail
> > with errors:
> >    RTNETLINK answers: Operation not supported
> >    netns_sysfs 1 TBROK: failed to add a new (host) dummy device
> > and
> >    RTNETLINK answers: Operation not supported
> >    netns_comm_ip_ipv6_ioctl 1 TBROK: unable to create veth pair devices
> >    Cannot find device "veth0"  
> 
> > This commit is storing the output of the commands and verifies
> > if there is any reference to "Operation not supported".
> > This code is based on what it is already done in "ipsec_lib.sh"
> > stress test.  
> 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>  
> 
> ..
> > diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh  
> ...
> > +			tst_brkm TCONF "Command not supported (maybe missing 'veth' support)"  
> 
> ..
> > diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh  
> ..
> > +		tst_brkm TCONF "Command not supported (maybe missing 'dummy' support)"  
> 
> Can you implement this patch with TST_NEEDS_DRIVERS (recently contributed by
> Alexey Kodanev)? Thanks a lot!

Yes, sure !

I will implement it but not in the next weeks because I am going to be
away until the end of November.

Best regards,

-- 
Mylène Josserand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
