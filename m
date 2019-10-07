From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon,  7 Oct 2019 08:45:33 +0200
Subject: [LTP] (no subject)
Message-ID: <20191007064534.4364-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Added changes suggested by Cyril.
BTW: The kernel is still tainted, even if the license is set, because
of out-of-tree module:
> ltp_lsmod01: loading out-of-tree module taints kernel.


