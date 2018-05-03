From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 May 2018 15:25:35 +0200
Subject: [LTP] [PATCH ltp] fs/ext4: enhance logic of
 ext4_nsec_timestamps_test
In-Reply-To: <20180503122928.rjzl22g7i5qoht6y@dell5510>
References: <20180429000213.685-1-yixin.zhang@intel.com>
 <20180503082348.GB29568@rei> <20180503102412.GB13151@rei>
 <20180503122928.rjzl22g7i5qoht6y@dell5510>
Message-ID: <20180503132535.GA27716@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > And I remebered that we already solved this by adding tst_umount
> > function to the shell library. The systemd-udev is not first daemon to
> > probe newly mounted filesystem, we used to have this kind of problems
> > with gvfsd-trash as well.
> 
> > So fixing this should be as easy as replacing the umount with tst_umount
> > function.
> I'm using tst_umount in IMA tests and it works nice :).
> BTW It's just that gvfsd-trash TINFO message is a bit too specific (in my case it was that
> some processes were still using the mounted filesystem - the same issue as Yixin has).

Yes, it is, we may want to reword it, but keep that after the release.

-- 
Cyril Hrubis
chrubis@suse.cz
