From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Jun 2021 13:29:45 +0200
Subject: [LTP] [BUG] btrfs potential failure on 32 core LTP test
 (fallocate05)
In-Reply-To: <YNxTr43lvviG0GOn@pevik>
References: <a3b42abc-6996-ab06-ea9f-238e7c6f08d7@canonical.com>
 <e4c71c01-ed70-10a6-be4d-11966d1fcb75@toxicpanda.com>
 <b5c6779b-f11d-661e-18c5-569a07f6fd8e@canonical.com>
 <YNxTr43lvviG0GOn@pevik>
Message-ID: <YNxVqca+WeQcBmzA@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

...
> > >> Reproduction steps:
> > >> git clone https://github.com/linux-test-project/ltp.git
> > >> cd ltp
> > >> ./build.sh && make install -j8
> > >> cd ../ltp-install
> > >> sudo ./runltp -f syscalls -s fallocate05

NOTE: you can also be a bit faster if you test just single test, see
https://github.com/linux-test-project/ltp#shortcut-to-running-a-single-test
(not compiling and installing whole LTP)

$ cd testcases/kernel/syscalls/fallocate/
$ make -j`nproc`
$ sudo ./fallocate05

> > > This thing keeps trying to test ext2, how do I make it only test btrfs?  Thanks,

> > It tests all available file systems, just wait till it gets to btrfs. I
> > don't know how to limit it only to one file system.
> In the future we can add environment variable to specify the only fs to be
> tested. There is LTP_DEV_FS_TYPE, but that does not work when .all_filesystems
> flag is enabled. Thus just patch the file:

NOTE: It detect kernel filesystem support and presence of mkfs.xxx.
Thus other way to limit filesystem is to rename mkfs.xxx of other filesystems
(in case you test LTP from package and don't want / cannot compile and can
modify root filesystem).

Kind regards,
Petr
