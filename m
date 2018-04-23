From: Yong Sun <yosun@suse.com>
Date: Sun, 22 Apr 2018 21:06:34 -0600
Subject: [LTP] [PATCH] *.py : convert python2 to python3
In-Reply-To: <20180420100931.farsd4cquqzjgp5p@dell5510>
References: <20180419101038.22451-1-yosun@suse.com>
 <20180419160135.GB13045@rei> <20180420100931.farsd4cquqzjgp5p@dell5510>
Message-ID: <5ADD4DBA020000B100003C96@prv1-mh.provo.novell.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > Looks good but shouldn't we update hashbangs to python3 since these
> > changes effectively make the code python3 only?
> I wonder whether we should use env shebang, which is portable (#!/usr/bin/env python3) or
> standard shebang using in distros (#!/usr/bin/python3). I've seen both in various
> projects, some of them even use no shebang at all.
> 

I'm going to update/add all shebang to standard shebang (#!/usr/bin/python3)

> > Also there is execltp.in that is written in python, have you looked at
> > that source? Is that one python3 compatible?
> OK, 21 python scripts (some of the scripts doesn't have shebang).
> 

All these 21 python scripts will have the same shebang. Thank you both for reviewing :)


Best Wishes,
Yong


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180422/7fd2bd07/attachment.html>
