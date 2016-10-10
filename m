From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Oct 2016 17:03:52 +0200
Subject: [LTP] [PATCH] readahead02: estimate max readahead size
In-Reply-To: <141170940.52106.1476110506518.JavaMail.zimbra@redhat.com>
References: <04ff8b784a23cb62c1413b0b6575238bd5474ca4.1476098569.git.jstancek@redhat.com>
 <20161010141651.GB1684@rei>
 <141170940.52106.1476110506518.JavaMail.zimbra@redhat.com>
Message-ID: <20161010150352.GC1684@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I've tried this on the /tmp on Btrfs and got max_ra_estimage nearly ten times
> > greater than the sysfs value. But apart from that the measured times are
> > pretty
> > much comparable with the previous version, which suggests that maximal
> > readahead size on Btrfs is set to ~4M and the limit per device is not
> > applicable.
> > 
> > Did you get the estimate close to the value of the sysfs file in your
> > environment?
> 
> I do (on 4.8 x86 KVM guest):
> # cat /sys/devices/virtual/bdi/253:1/read_ahead_kb
> 4096
> readahead02    0  TINFO  :  max ra estimate: 4145152
> 
> Are you using upstream kernel or a patched one?

That is Btrfs on SLES12-SP2 RC with kernel 4.4.21, but it seems to be
pretty much Btrfs specific. If I point TMPDIR to ext3 fs I got estimated
ra 507904 while the read_ahead_kb for the device is set to 512.

-- 
Cyril Hrubis
chrubis@suse.cz
