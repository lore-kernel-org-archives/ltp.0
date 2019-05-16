From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 May 2019 09:38:27 +0200
Subject: [LTP] Oldest still supported kernel
Message-ID: <20190516073826.GA14532@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

do we declare oldest still supported kernel version?
According to distrowatch [1] still supported RHEL-6.9 is using v2.6.32.
Is it the oldest version we want to support or even something older?
Latest still supported stable kernel is 3.16, which is obviously too new for
enterprise distros.

It'd be nice to specify latest supported kernel (and glibc) version in docs
and remove old autotools checks (we have some checks for v2.6.25).

Kind regards,
Petr

[1] https://distrowatch.com/table.php?distribution=redhat
