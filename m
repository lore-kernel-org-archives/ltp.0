From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 May 2019 17:27:37 +0200
Subject: [LTP] [PATCH 2/2] syscalls: update tcases using dev_fs_type to
 use some_filesystems
In-Reply-To: <20190530150500.j2wkehkf5fopt2nw@XZHOUW.usersys.redhat.com>
References: <20190530102336.10898-1-xzhou@redhat.com>
 <20190530102336.10898-2-xzhou@redhat.com>
 <20190530111030.GC31468@rei.lan>
 <20190530150500.j2wkehkf5fopt2nw@XZHOUW.usersys.redhat.com>
Message-ID: <20190530152736.GB25602@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I guess that we can enable the this test for all filesystems, there is
> > in-kernel fallback for filesystems that does not support the syscall so
> > it should work on all filesystems and the fallback code should be tested
> > as well.
> > 
> > >  testcases/kernel/syscalls/getxattr/getxattr04.c           | 7 +++++--
> > 
> > Well I would be slightly in favor of enabling this test for all
> > filesystems as well.
> > 
> > If we ever want to maintain list of filesystems that support extended
> > attributes there should be only one somewhere in the test library so
> > that we don't have to change thousand testcases later on.
> 
> Hmm.. So we actually don't need this array. Just enable some proper
> tests for all filesystems.

Looks like that, I've checked the fgetxattr01.c test and we only skip
fat and vfat when the test is executed, all the other filesystems do
support extended attributes. Disabling fat and vfat does not seem to
speed up the test at all, I guess that the mkfs + mount is fast enough
so that the difference is not measureable.

-- 
Cyril Hrubis
chrubis@suse.cz
