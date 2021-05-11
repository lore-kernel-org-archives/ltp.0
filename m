From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 May 2021 08:19:01 +0200
Subject: [LTP] [PATCH] mkfs: force block size to 1024 for ext3 and ext4
In-Reply-To: <20210510134739.37512-1-cascardo@canonical.com>
References: <20210510134739.37512-1-cascardo@canonical.com>
Message-ID: <YJoh1f4EWtQWlroC@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> ext3 and ext4 filesystems will reserve at least 1024 blocks for the
> journal.  With a blocksize of 4096, this will be 25% of the filesystem size
> without accounting for any other overhead.
Is that any actual problem?

> /etc/mke2fs.conf will use 1024 block size for small filesystems, which are
> between 3M and 512M. However, on recent versions of Ubuntu, this
> configuration has changed and thet default blocksize is 4096 even for small
> filesystems.

> Force the blocksize to 1024 on ext3 and ext4 filesystems, which will lead
> to the expected results, as journals will take only 1M.

IMHO it'd be better to keep the default, because that covers what end users
actually use.

Kind regards,
Petr
