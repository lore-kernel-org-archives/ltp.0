From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 Sep 2018 11:52:47 +0200
Subject: [LTP] [PATCH 2/2] syscalls/statx05: Fix test on ppc64le
In-Reply-To: <831588265.47297951.1536741222106.JavaMail.zimbra@redhat.com>
References: <20180911153013.2609-1-chrubis@suse.cz>
 <20180911153013.2609-2-chrubis@suse.cz>
 <831588265.47297951.1536741222106.JavaMail.zimbra@redhat.com>
Message-ID: <20180912095247.GA29460@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It's not easy to guess what role library plays, when only needs_device is
> used, but you set also dev_fs_type and mntpoint. If you dropped both,
> then all needed would be to MKDIR/RMDIR(mntpoint), correct?

I also use the tst_device->fs_type instead of doing #define FSTYPE
"ext4".

And in a case that some other filesystem gains encryption support we
will need a way how generate the mkfs options dynamically based on the
filesystem type anyway, so I suppose that the extra opts in tst_test
will end up being a callback that will generate the data just before we
do mkfs. However I wanted to make minimal amount of changes to fix the
test for now as we are approaching the release. I can redesign the mkfs
options later on.

> Anyway, ACK to both patches.

Both pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
