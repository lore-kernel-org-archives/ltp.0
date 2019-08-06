From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Aug 2019 14:23:01 +0200
Subject: [LTP] [PATCH 2/2] syscalls/copy_file_range02: Add test
 description
In-Reply-To: <5D4955F4.40204@cn.fujitsu.com>
References: <20190806091040.26448-1-pvorel@suse.cz>
 <20190806091040.26448-2-pvorel@suse.cz>
 <5D4955F4.40204@cn.fujitsu.com>
Message-ID: <20190806122301.GA13459@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu, Murphy,

...
> > +	{&fd_dup,       0,   EINVAL,     0,     CONTSIZE/2, "overlaping"},
> overlaping range
> > +	{&fd_blkdev,    0,   EINVAL,     0,     CONTSIZE, "block device"},
> > +	{&fd_chrdev,    0,   EINVAL,     0,     CONTSIZE, "charr device"},
> char device

Thanks for your review. Fixed and merged with your ack.

Kind regards,
Petr
