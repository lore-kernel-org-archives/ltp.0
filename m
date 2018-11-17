From: Pengfei Xu <pengfei.xu@intel.com>
Date: Sat, 17 Nov 2018 13:41:13 +0800
Subject: [LTP] [PATCH] lib: Add library function for parsing kernel
	config
In-Reply-To: <20181116140034.GG29013@rei.lan>
References: <20181115134441.27359-1-chrubis@suse.cz>
 <20181116035401.z2o67pjhxtutap6x@xpf-desktop>
 <20181116140034.GG29013@rei.lan>
Message-ID: <20181117054112.ntrmroymxnax5gc3@xpf-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018-11-16 at 15:00:35 +0100, Cyril Hrubis wrote:
> > > +	int abort_test = 0;
> > > +
> > > +	for (i = 0; i < conf_cnt; i++) {
> > > +		if (!conf_match[i]) {
> > > +			abort_test = 1;
> > > +			tst_res(TINFO, "Kernel is missing %s", kconfigs[i]);
> >    Could change TINFO above to TCONF?
> 
> What's the point? We do exit with TCONF below anyway.
> 
  All right, thanks.

> -- 
> Cyril Hrubis
> chrubis@suse.cz
