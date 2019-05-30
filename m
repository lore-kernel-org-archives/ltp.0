From: Murphy Zhou <xzhou@redhat.com>
Date: Thu, 30 May 2019 23:02:35 +0800
Subject: [LTP] [PATCH 1/2] lib/tst_test: introduce
	tst_test->some_filesystems
In-Reply-To: <20190530105140.GB31468@rei.lan>
References: <20190530102336.10898-1-xzhou@redhat.com>
 <20190530105140.GB31468@rei.lan>
Message-ID: <20190530150235.yulxh7i7vsjtvgmx@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 30, 2019 at 12:51:40PM +0200, Cyril Hrubis wrote:
> Hi!
> > Like all_filesystems, some_filesystems option let tcase to run on
> > specific filesystems.
> > In order to implement this, change run_tcases_per_fs to accept a
> > parameter indicating which filesystems need to test.
> > 
> > To let tcase use this option, we need some other flags set
> > Eg:
> > static char *some_filesystems[] = {"ext4", "xfs", "btrfs"};
> > 
> >   .mount_device = 0,
> >   .needs_device = 1,
> >   .format_device = 1,
> >   .mntpoint = MNTPOINT,
> >   .some_filesystems = some_filesystems,
> 
> Can't we just change the dev_fs_type to dev_fs_types array instead?

Sure. That's a much better name! My naming taste needs much improvement...

Thanks!

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
