From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 May 2018 12:24:12 +0200
Subject: [LTP] [PATCH ltp] fs/ext4: enhance logic of
 ext4_nsec_timestamps_test
In-Reply-To: <20180503082348.GB29568@rei>
References: <20180429000213.685-1-yixin.zhang@intel.com>
 <20180503082348.GB29568@rei>
Message-ID: <20180503102412.GB13151@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > 2. Add "sleep 1" between mount and umount, to avoid umount failed due to
> >    device busy (accessed by system service like systemd-udev)
> 
> NACK to this.
> 
> In a case that we need to wait for something like this we are supposed
> to retry in a loop with exponential backoff, which is usually faster
> than hardcoded sleep but also more robust.
> 
> There is a in-flight patch for adding TST_RETRY_FUNC function to the
> shell library "[PATCH] tst_test.sh: achieve TST_RETRY_FUNC function in shell"
> which should make this really easy but we would have to add it to the
> old shell test library as well so that we can reuse it here.

And I remebered that we already solved this by adding tst_umount
function to the shell library. The systemd-udev is not first daemon to
probe newly mounted filesystem, we used to have this kind of problems
with gvfsd-trash as well.

So fixing this should be as easy as replacing the umount with tst_umount
function.

-- 
Cyril Hrubis
chrubis@suse.cz
