From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Nov 2016 17:17:29 +0100
Subject: [LTP] Porting create_sig_proc() to new API
Message-ID: <20161115161729.kncclfxux2pos3he@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

few syscall related tests depends on create_sig_proc(unsigned long usec, int sig,
unsigned count) defined in testcases/kernel/syscalls/utils/common_j_h.c
and other things from the old API.
I suppose it's still waiting for porting, isn't it?

Petr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161115/2cd73baa/attachment.sig>
