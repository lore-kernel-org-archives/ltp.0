From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 May 2021 15:17:44 +0200
Subject: [LTP] [PATCH] mkfs: force block size to 1024 for ext3 and ext4
In-Reply-To: <20210511103622.GC12149@mussarela>
References: <20210510134739.37512-1-cascardo@canonical.com>
 <YJoh1f4EWtQWlroC@pevik> <20210511103622.GC12149@mussarela>
Message-ID: <YJvVeOpV2Zt6B31X@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > /etc/mke2fs.conf will use 1024 block size for small filesystems, which are
> > > between 3M and 512M. However, on recent versions of Ubuntu, this
> > > configuration has changed and thet default blocksize is 4096 even for small
> > > filesystems.
> > 
> > > Force the blocksize to 1024 on ext3 and ext4 filesystems, which will lead
> > > to the expected results, as journals will take only 1M.
> > 
> > IMHO it'd be better to keep the default, because that covers what end users
> > actually use.
> 
> One alternative to forcing the block size is accouting for the journal blocks,
> but, then, that needs to consider the block size. I think my approach is more
> simple. We could restrict it to the smaller 16M filesystem, though.
> 
> What do you think?

I guess that we should merge your fix in order to have the test working
for the upcomming release. Then we can discuss if this should be fixed
differently or not.

-- 
Cyril Hrubis
chrubis@suse.cz
