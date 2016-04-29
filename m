From: Hangbin Liu <haliu@redhat.com>
Date: Fri, 29 Apr 2016 10:05:13 +0800
Subject: [LTP] [PATCH v8 0/3] networking/stress/icmp: add ip xfrm ipsec
 support
In-Reply-To: <57221552.8050507@oracle.com>
References: <1461761676-28599-1-git-send-email-haliu@redhat.com>
 <57221552.8050507@oracle.com>
Message-ID: <20160429020513.GH4308@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

Thanks for your patient reviews and cosmetic changes.

Best Regards
Hangbin

On Thu, Apr 28, 2016 at 04:51:14PM +0300, Alexey Kodanev wrote:
> Hi,
> On 04/27/2016 03:54 PM, Hangbin Liu wrote:
> >As we know, most of the network stress tests have IPsec testing, and we use
> >setkey for configuration. But setkey[1] hasn't updated for a long time. And
> >some distros, RHEL7 for example, even don't have ipset-tools package. On
> >other hand, iproute2 is recommend for network configuration. And ip xfrm is
> >more powerful than setkey. So let's use ip xfrm for ipsec testing.
> >
> >[1] http://ipsec-tools.sourceforge.net/
> >
> >Change from V7:
> >1. correct array typo
> >2. use shift instead of bashism
> Patch-set applied, thank you.
> 
> Also made some cosmetic changes:
> 
> * reworded that really lengthy message with "Verify that kernel ...." in
> icmp-basic-uni,
> * added suffix ".sh" to icmp-uni-basic,
> * some lines were over 80 chars, changed them too where possible,
> * added copyright line from the previous version of uni-basic tests,
> * removed old uni-basic directory.
> 
> Thanks,
> Alexey
