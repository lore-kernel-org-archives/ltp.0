From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Apr 2019 20:58:33 +0200
Subject: [LTP] [PATCH 4/4] syscalls/fanotify15: verify fid for dirent
 events
In-Reply-To: <CAOQ4uxh6VqHKH3Sf0URZPkDUcGAG0yzKrT6bqOiH0LG+43Qnnw@mail.gmail.com>
References: <cover.1554197461.git.mbobrowski@mbobrowski.org>
 <2934be190caaaf4bb75caffd731d34711fbf1c61.1554197461.git.mbobrowski@mbobrowski.org>
 <20190416142959.GC20437@rei>
 <CAOQ4uxiuLd3C0ctx-+fUkAT8XZyY5SOw61-wB8BTdHh0FVPBXg@mail.gmail.com>
 <20190416150015.GA22754@rei.lan>
 <CAOQ4uxh6VqHKH3Sf0URZPkDUcGAG0yzKrT6bqOiH0LG+43Qnnw@mail.gmail.com>
Message-ID: <20190418185832.GD8766@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Is anybody else seeing these errors with all_filesystems?
> 
> tst_test.c:1157: INFO: Testing on xfs
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> mkfs.xfs: Use the -f option to force overwrite.
> tst_mkfs.c:101: BROK: mkfs.xfs:1: tst_test.c failed with 751

That looks strange. If I'm looking at this correctly the 751 is returned
from tst_run_cmd() which basically returns the value from waitpid() but
we call WEXITSTATUS() there before we return the number, which should
return only least significant 8 bits.

So as far as I can tell this output is impossible.

-- 
Cyril Hrubis
chrubis@suse.cz
