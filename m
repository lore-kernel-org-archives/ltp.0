From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Tue, 11 May 2021 07:36:22 -0300
Subject: [LTP] [PATCH] mkfs: force block size to 1024 for ext3 and ext4
In-Reply-To: <YJoh1f4EWtQWlroC@pevik>
References: <20210510134739.37512-1-cascardo@canonical.com>
 <YJoh1f4EWtQWlroC@pevik>
Message-ID: <20210511103622.GC12149@mussarela>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 11, 2021 at 08:19:01AM +0200, Petr Vorel wrote:
> Hi,
> 
> > ext3 and ext4 filesystems will reserve at least 1024 blocks for the
> > journal.  With a blocksize of 4096, this will be 25% of the filesystem size
> > without accounting for any other overhead.
> Is that any actual problem?

It causes the test to fail.
     mkfs01 2 TFAIL: 'mkfs -t ext4  /dev/loop0 16000' failed, unexpected size.

The filesystem size is very small, 16K 1k blocks, and we test that there are at
least 80% of that available. As I said, the journal takes at least 1024 blocks,
and with 4k blocks, that is too much overhead.

> 
> > /etc/mke2fs.conf will use 1024 block size for small filesystems, which are
> > between 3M and 512M. However, on recent versions of Ubuntu, this
> > configuration has changed and thet default blocksize is 4096 even for small
> > filesystems.
> 
> > Force the blocksize to 1024 on ext3 and ext4 filesystems, which will lead
> > to the expected results, as journals will take only 1M.
> 
> IMHO it'd be better to keep the default, because that covers what end users
> actually use.

One alternative to forcing the block size is accouting for the journal blocks,
but, then, that needs to consider the block size. I think my approach is more
simple. We could restrict it to the smaller 16M filesystem, though.

What do you think?

Thanks.
Cascardo.

> 
> Kind regards,
> Petr
