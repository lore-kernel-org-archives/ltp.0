From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Dec 2019 14:40:02 +0100
Subject: [LTP] [PATCH 1/1] Use real FS block size in fallocate05
In-Reply-To: <0c8a52b4-0c71-4efa-f58a-66524055e32a@suse.cz>
References: <20191128093610.6903-1-mdoucha@suse.cz>
 <20191128093610.6903-2-mdoucha@suse.cz>
 <26933665.14359191.1575028896043.JavaMail.zimbra@redhat.com>
 <0e1a3d0e-a154-8469-6e04-a954740a4a61@suse.cz>
 <1057914729.14405454.1575044248773.JavaMail.zimbra@redhat.com>
 <0c8a52b4-0c71-4efa-f58a-66524055e32a@suse.cz>
Message-ID: <20191213134002.GE20795@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I think it might be better to change the test scenario a bit:
> 1. fallocate(FALLOCATE_BLOCKS * blocksize)
> 2. tst_fill_fs()
> 3. write(FALLOCATE_BLOCKS * blocksize)
> 4. repeat fallocate(blocksize) until we get ENOSPC
> 5. write() into all blocks allocated in step 4
> 6. check that another write() will get ENOSPC
> 7. test fallocate(PUNCH_HOLE | KEEP_SIZE)
> 
> This should get us around the issue with tst_fill_fs() and still
> properly validate that fallocate() handles full FS gracefully.

Looping over the second fallocate until we got ENOSPC sounds reasonable
to me.

> The only remaining issue is whether it's correct for Btrfs to only
> release blocks when you deallocate the whole file. I still haven't heard
> back from our Btrfs dev.

So the punched hole does not free space on Btrfs even if we are FS block
aligned? I was under an impression that it should, but again Btrfs is
copy-on-write filesystem, so it may want to keep a copy of the discarded
blocks anyways.

-- 
Cyril Hrubis
chrubis@suse.cz
