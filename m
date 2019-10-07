From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 7 Oct 2019 08:52:15 +0200
Subject: [LTP] [PATCH v2] lsmod01: Add kernel module
In-Reply-To: <20191004103414.GE1231@rei>
References: <20190927092024.97928-1-lkml@jv-coder.de>
 <20191004103414.GE1231@rei>
Message-ID: <c1877802-f006-1c66-ddc3-afdda0b21dea@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
> You are missing the GPL license here, without it the module will taint
> the kernel.

The kernel will still be tainted, even if the license is set, because of 
out-of-tree build.
Do I miss anything?

 > ltp_lsmod01: loading out-of-tree module taints kernel.

