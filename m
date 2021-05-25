From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 May 2021 17:17:10 +0200
Subject: [LTP] [PATCH 2/2] syscalls/sendfile: Convert sendfile09 to the
 new API
In-Reply-To: <YKY+y/KgdpeppaYx@yuki>
References: <20210519084655.52780-1-xieziyao@huawei.com>
 <20210519084655.52780-3-xieziyao@huawei.com>
 <YKTcWhMGotujEYLK@yuki>
 <e17ffbb2-2c2a-bd15-9e8c-cd2795e566cd@huawei.com>
 <YKY+y/KgdpeppaYx@yuki>
Message-ID: <YK0U9hubBBXDEEkL@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > >> + * Testcase copied from sendfile02.c to test the basic functionality of
> > >> + * the sendfile(2) system call on large file. There is a kernel bug which
> > >> + * introduced by commit 8f9c0119d7ba and fixed by commit 5d73320a96fcc.
> > >                              ^
> > > 	Here as well the commit that introduced the bug should go to
> > > 	.tags.

> And I made a mistake here, we put the commit that fixes the bug into the
> tags, so the second one should be in the metadata, but I can fix that
> before the patches are applied. Sorry for the confusion.
Yep I noticed that and discussed that and fixed it.
But I haven't noticed you reviewed v1, thus didn't put your tags.
Anyway, I merged fixed v1 version. Now I noticed v2, which was still including
some headers which were not needed.

Kind regards,
Petr
