From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Nov 2019 01:16:45 -0500 (EST)
Subject: [LTP] [xfs] 73e5fff98b: kmsg.dev/zero:Can't_open_blockdev
In-Reply-To: <e38bc7a8505571bbb750fc0198ec85c892ac7b3a.camel@themaw.net>
References: <20191111010022.GH29418@shao2-debian>
 <3fb8b1b04dd7808b45caf5262ee629c09c71e0b6.camel@themaw.net>
 <1108442397.11662343.1573560143066.JavaMail.zimbra@redhat.com>
 <20191112120818.GA8858@lst.de>
 <5f758be455bb8f761d028ea078b3e2a618dfd4b1.camel@themaw.net>
 <e38bc7a8505571bbb750fc0198ec85c892ac7b3a.camel@themaw.net>
Message-ID: <975334005.11814790.1573625805426.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> > > > # mount -t xfs /dev/zero /mnt/xfs
> > 
> > Assuming that is what is being done ...
> 
> Arrrh, of course, a difference between get_tree_bdev() and
> mount_bdev() is that get_tree_bdev() prints this message when
> blkdev_get_by_path() fails whereas mount_bdev() doesn't.
> 
> Both however do return an error in this case so the behaviour
> is the same.
> 
> So I'm calling this not a problem with the subject patch.
> 
> What needs to be done to resolve this in ltp I don't know?

I think that's question for kernel test robot, which has this extra
check built on top. ltp itself doesn't treat this extra message as FAIL.

Jan

