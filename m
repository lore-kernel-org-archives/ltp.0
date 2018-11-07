From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 7 Nov 2018 18:36:16 +0100
Subject: [LTP] [PATCH 4/6] network/mpls02: new test with lwtunnel
In-Reply-To: <14316198-1a4b-ad70-5ff3-295b75f5faf9@oracle.com>
References: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
 <1540818202-11247-5-git-send-email-alexey.kodanev@oracle.com>
 <20181102200207.GA17405@dell5510>
 <14316198-1a4b-ad70-5ff3-295b75f5faf9@oracle.com>
Message-ID: <20181107173615.GA12378@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> >> +	ROD modprobe mpls_router
> >> +	ROD modprobe mpls_iptunnel
> >> +	ROD modprobe mpls_gso
> > Maybe just?
> > ROD modprobe mpls_gso $TST_NEEDS_DRIVERS

> OK, and it will need the '-a' option.
I wonder if we want to have a simple helper in tst_net.sh for loading modules on
both sides, similar to tst_set_sysctl and tst_net_driver (from my pull request):

tst_net_driver()
{
	ROD modprobe -a $@
	tst_rhost_run -c "modprobe -a $@"
}

Kind regards,
Petr
