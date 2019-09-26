From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Sep 2019 17:56:08 +0200
Subject: [LTP] copy_file_range() errno changes introduced in v5.3-rc1
Message-ID: <20190926155608.GC23296@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

I'm going to fix LTP test copy_file_range02 before upcoming LTP release.
There are some returning errno changes introduced in v5.3-rc1, part of commit 40f06c799539
("Merge tag 'copy-file-range-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux").
These changes looks pretty obvious as wanted, but can you please confirm it they were intentional?

* 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") started to return -EXDEV.
* 96e6e8f4a68d ("vfs: add missing checks to copy_file_range") started to return -EPERM, -ETXTBSY, -EOVERFLOW.

Thanks for info.

Kind regards,
Petr
