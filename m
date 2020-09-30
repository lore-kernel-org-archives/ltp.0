From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Sep 2020 10:16:55 +0200
Subject: [LTP] [PATCH] utimensat01: Test all available FS and handle FS
 with no attributes
In-Reply-To: <20200929181152.GD15188@dell5510>
References: <20200929144635.28874-1-rpalethorpe@suse.com>
 <20200929181152.GD15188@dell5510>
Message-ID: <20200930081655.GA6611@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Although this fails on NTFS and exfat and FUSE.
> I don't remember which flag removes these filesystems, there was some
> workaround. Cyril, Li, Jan, do you remember?

That's the:

.dev_fs_flags = TST_FS_SKIP_FUSE,

Which should fix the failures here. Moreover I do wonder if this is a
real bug in the fuse implementation or something that have been left out
intentionally.

-- 
Cyril Hrubis
chrubis@suse.cz
