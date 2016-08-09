From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Aug 2016 15:14:20 +0200
Subject: [LTP] [PATCH 1/2] syscalls/access04: reconstruct and convert to
 new API
In-Reply-To: <57A465A3.8020306@cn.fujitsu.com>
References: <1469698729-5860-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20160804165028.GD3367@rei.lan> <57A465A3.8020306@cn.fujitsu.com>
Message-ID: <20160809131420.GB31315@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Once we remote the directory the accessfile is in this is just the same
> > as access01.c.
> > 
> 
> Sorry, do you mean once we "remote" the directory? or "remove" the directory?
> And I think access04 does a little more: checks if the file exists actually
> via stat(), maybe I should add this part(check existence) to access02?

Yep, I typed remote instead of remove instead of remove twice in this
email.

-- 
Cyril Hrubis
chrubis@suse.cz
