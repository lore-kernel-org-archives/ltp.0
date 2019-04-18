From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Apr 2019 21:42:47 +0200
Subject: [LTP] [PATCH 4/4] syscalls/fanotify15: verify fid for dirent
 events
In-Reply-To: <CAOQ4uxhYwfE+oCHcWHCK++bqjy_gyda55Put2PD=Ui7OUua-KA@mail.gmail.com>
References: <cover.1554197461.git.mbobrowski@mbobrowski.org>
 <2934be190caaaf4bb75caffd731d34711fbf1c61.1554197461.git.mbobrowski@mbobrowski.org>
 <20190416142959.GC20437@rei>
 <CAOQ4uxiuLd3C0ctx-+fUkAT8XZyY5SOw61-wB8BTdHh0FVPBXg@mail.gmail.com>
 <20190416150015.GA22754@rei.lan>
 <CAOQ4uxh6VqHKH3Sf0URZPkDUcGAG0yzKrT6bqOiH0LG+43Qnnw@mail.gmail.com>
 <20190418185832.GD8766@rei>
 <CAOQ4uxhYwfE+oCHcWHCK++bqjy_gyda55Put2PD=Ui7OUua-KA@mail.gmail.com>
Message-ID: <20190418194247.GF8766@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Don't know about that, but the fact is that mkfs.xfs refuses to format
> a device that has an existing filesystem on it without the -f flag.
> 
> Does that ring a bell?

It does, but we clean up first 512kB of the block device prior to call
to mkfs.xfs exactly to avoid that.

> I think it may be because I upgraded xfsprogs to v4.20.

Quite likely.

> Maybe that's a mkfs.xfs bug.

Possibly.

-- 
Cyril Hrubis
chrubis@suse.cz
