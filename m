From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 31 Oct 2019 14:18:04 +0100
Subject: [LTP] [PATCH] tst_net.sh: Allow execution if xfrm is disabled
In-Reply-To: <20191029143525.GA4187@dell5510>
References: <20191009062300.50219-1-lkml@jv-coder.de>
 <20191029143525.GA4187@dell5510>
Message-ID: <20191031131803.GB28424@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> > From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

> > If the kernel is configured without xfrm support, the setup of the
> > interfaces for communication between local and remote host fails,
> > because it tries to flush xfrm state and policy.
> > There is no need to flush, if the system doesn't even support xfrm.

> > Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks, merged!

Kind regards,
Petr
