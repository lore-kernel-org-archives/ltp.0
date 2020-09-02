From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 2 Sep 2020 12:39:59 +0200
Subject: [LTP] [PATCH 1/1] ima_keys.sh: Fix umount on tmpfs
In-Reply-To: <20200831155953.10899-1-pvorel@suse.cz>
References: <20200831155953.10899-1-pvorel@suse.cz>
Message-ID: <20200902103959.GA18662@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> write policy.txt always to $TST_TMPDIR otherwise tst_umount will fail on
> /tmp being tmpfs, for which we mount loop device and cd into it:

> umount: /tmp/LTP_ima_keys.hPVaEbz34L/mntpoint: target is busy.
> ima_keys 1 TINFO: umount(/dev/loop0) failed, try 1 ...
> ima_keys 1 TINFO: Likely gvfsd-trash is probing newly mounted  fs, kill it to speed up tests.
> umount: /tmp/LTP_ima_keys.hPVaEbz34L/mntpoint: target is busy.
> ...
> rm: cannot remove '/tmp/LTP_ima_keys.cNyaxGHAQI/mntpoint': Device or resource busy

> Fixes: a277498c0 ("IMA/ima_keys.sh: Enhance policy checks")

Fix merged.

Kind regards,
Petr
