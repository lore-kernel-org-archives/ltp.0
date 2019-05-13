From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 May 2019 15:14:51 +0200
Subject: [LTP] [PATCH] ltp-cap.m4: add libcap version detection && fix
 compiler error
In-Reply-To: <1557732392-7049-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1557732392-7049-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190513131451.GA22761@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,


> Current ltp-cap.m4 defines cap_libs when libcap has
> cap_compare function.  This function was introduced by
> libcap-2. It is only used for the two places, and another
> places work fines with libcap-1. So add libcap version
> detection.

Can't we just fix these possible compiler errors for old distros and require
libcap v2?  TCONF for very old distros looks OK for me.
libcap-2.00 was released 12 years ago (2007), these distros does not have it:
SLES 10 SP3 [1], RHEL-4.8 [2], Debian 4.0 [3]. Do we really want to care about
these old distros (it looks like only RHEL is supported)?
We also dropped libnuma v1 support (in 2c98cbbaf), v2 was released at similar
date (2008).

Kind regards,
Petr

[1] https://distrowatch.com/table.php?distribution=sle&pkglist=true&version=10-sp3#pkglist
[2] https://distrowatch.com/table.php?distribution=redhat&pkglist=true&version=rhel-4.8#pkglist
[3] https://distrowatch.com/table.php?distribution=debian&pkglist=true&version=4.0#pkglist
