From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Feb 2020 15:08:22 +0100
Subject: [LTP] [PATCH 1/1] syscalls/fsmount01: Add test for new mount
 API v5.2
In-Reply-To: <20200207140404.GA8492@dell5510>
References: <20200206162722.18945-1-pvorel@suse.cz>
 <20200207132001.GC19508@rei.lan> <20200207140404.GA8492@dell5510>
Message-ID: <20200207140821.GA6137@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I do remmeber commenting this that the tst_umount() already prints a
> > WARN which will fail the test anyways, so there is no point in handling
> > the return from tst_umount() here.
> I guess SAFE_UMOUNT(MNTPOINT) will be the best.

Actually no, because unlike the tst_umount() SAFE_UMOUNT() does not
retry, which will make the test faill if there is a background daemon
that is probing newly mounted filesystems.

-- 
Cyril Hrubis
chrubis@suse.cz
