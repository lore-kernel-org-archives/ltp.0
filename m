From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Oct 2019 14:26:28 +0200
Subject: [LTP] [PATCH v2] lsmod01: Add kernel module
In-Reply-To: <c1877802-f006-1c66-ddc3-afdda0b21dea@jv-coder.de>
References: <20190927092024.97928-1-lkml@jv-coder.de>
 <20191004103414.GE1231@rei>
 <c1877802-f006-1c66-ddc3-afdda0b21dea@jv-coder.de>
Message-ID: <20191007122627.GB20170@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > You are missing the GPL license here, without it the module will taint
> > the kernel.
> 
> The kernel will still be tainted, even if the license is set, because of 
> out-of-tree build.
> Do I miss anything?

The taint is actually a bitfield, we cannot do anything with the
out-of-tree one, but the less we turn on the better.

-- 
Cyril Hrubis
chrubis@suse.cz
