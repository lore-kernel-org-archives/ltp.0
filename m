From: Eryu Guan <eguan@redhat.com>
Date: Thu, 15 Jun 2017 14:54:30 +0800
Subject: [LTP] [PATCH] dio: reduce the number of cycles
In-Reply-To: <20170614134939.GB7604@rei.suse.de>
References: <20170614033830.12736-1-liwang@redhat.com>
 <20170614111610.GC17436@eguan.usersys.redhat.com>
 <20170614134939.GB7604@rei.suse.de>
Message-ID: <20170615065430.GE17436@eguan.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 14, 2017 at 03:49:39PM +0200, Cyril Hrubis wrote:
> Hi!
> > I tested diotest30 with 100 iterations and it still could reproduce the
> > bug I was seeing on 4.10 kernel quite reliably (even if not 100%), so
> > 
> > Acked-by: Eryu Guan <eguan@redhat.com>
> 
> What's the reliability after the patch btw? What is the actual
> percentage of undetected failures for at least 10 runs of the test?

I ran diotest30 10 times with "-i 100" and 8 of them failed. IIRC, it
was not 100% reproduced either when I first saw the test failure in
4.10-rc kernel testing. So I think ~80% probability to reproduce is
fine.

Thanks,
Eryu
