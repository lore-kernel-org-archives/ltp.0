From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Jul 2019 14:48:45 +0200
Subject: [LTP] [PATCH] syscalls/statx01: loosen the stx_blocks check
In-Reply-To: <75ded79c-da38-b648-fcfd-a423cc5f0e89@google.com>
References: <20190722194439.161904-1-smuckle@google.com>
 <20190723110306.GB22630@rei.lan>
 <1be1f0b8-170a-ac92-b86f-924e2d7f2295@google.com>
 <20190724115735.GC17426@rei.lan>
 <75ded79c-da38-b648-fcfd-a423cc5f0e89@google.com>
Message-ID: <20190725124844.GB11617@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> That would work for ext4, but should this be loosened further to give
> >> some headroom in case some FS preallocates more? Or is it preferable to
> >> keep the test as strict as possible and loosen it when/if failures happen?
> > 
> > That is hard to decide. I would go for the lowest limit that works for
> > everybody.
> > 
> > Also for me ext4 allocates only one block for the file no matter what I
> > do, something has to be tuned differently in your setup.
> > 
> > Isn't it just a difference in the block size and inode size?
> 
> On my platform stx_blocks = 16 (8kb) and stx_blksize = 4096, so two fs 
> blocks are being allocated.
> 
> Interestingly, if I create a 256 byte file on this Android platform in 
> /data, it 4kb:
> 
> vsoc_x86:/data # dd if=/dev/zero of=test_file bs=1 count=256
> 256+0 records in
> 256+0 records out
> 256 bytes (256 B) copied, 0.000926 s, 270 K/s
> vsoc_x86:/data # ls -ls test_file
> 4 -rw-rw-rw- 1 root root 256 2019-07-24 19:28 test_file
> 
> However if I go into the directory specified in TMPDIR, it takes 8kb:
> 
> vsoc_x86:/data/local/tmp # dd if=/dev/zero of=test_file bs=1 count=256
> 256+0 records in
> 256+0 records out
> 256 bytes (256 B) copied, 0.000927 s, 270 K/s
> vsoc_x86:/data/local/tmp # ls -ls
> total 8
> 8 -rw-rw-rw- 1 root root 256 2019-07-24 19:30 test_file
> 
> It is also 8kb if I create it in /data/local, but not if I create a 
> directory at /data/testdir and create the file there.

That is a bit strange, unfortunately I do not have a single Android
device around, otherwise I would try to reproduce it.

> Perhaps the x-attributes are spilling out of the inode in some cases and 
> into a data block? I don't know enough about filesystems to say.

That may be, you can try to list these with getfattr.

-- 
Cyril Hrubis
chrubis@suse.cz
