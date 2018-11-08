From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 8 Nov 2018 15:01:10 +0100
Subject: [LTP] [PATCH 4/6] network/mpls02: new test with lwtunnel
In-Reply-To: <855bab25-b1db-87a9-fd0e-3576ce2d8427@oracle.com>
References: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
 <1540818202-11247-5-git-send-email-alexey.kodanev@oracle.com>
 <20181102200207.GA17405@dell5510>
 <14316198-1a4b-ad70-5ff3-295b75f5faf9@oracle.com>
 <20181107173615.GA12378@dell5510>
 <855bab25-b1db-87a9-fd0e-3576ce2d8427@oracle.com>
Message-ID: <20181108140110.GA23376@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > I wonder if we want to have a simple helper in tst_net.sh for loading modules on
> > both sides, similar to tst_set_sysctl and tst_net_driver (from my pull request):

> > tst_net_driver()
> > {
> > 	ROD modprobe -a $@
> > 	tst_rhost_run -c "modprobe -a $@"
> > }

> Sure or even more generic, for any commands?
Added here:
https://patchwork.ozlabs.org/patch/994893/

Kind regards,
Petr
