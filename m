From: Leo Liang <ycliang@andestech.com>
Date: Tue, 6 Jul 2021 11:27:48 +0800
Subject: [LTP] [PATCH 1/1] cgroup/cgroup_regression_test: Fix umount
 failure
In-Reply-To: <YNnJ18Q+cqb8zM5K@yuki>
References: <20210628033002.GA1469@andestech.com>
 <caf1bb46-5212-3c3d-f180-e722ef2cf8dd@jv-coder.de>
 <YNnJ18Q+cqb8zM5K@yuki>
Message-ID: <20210706032748.GA16346@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Sorry for the late response and thanks for all the replies and suggestions.

I am running on a rather new RISC-V platform (Andes/AE350) and with 5.4.0 off-tree kernel.
The umount in cgroup_regression_test mostly failed at test_2 and test_3, 
so it would show FAIL result (mount not successfully executed) at test_3 and test_5 (test_4 shows TCONF on my platform).

On Mon, Jun 28, 2021 at 03:08:39PM +0200, Cyril Hrubis wrote:
> Hi!
> > I would like a short comment close to the syncs. When I converted 
> > cpuset_regression_test.sh, I would have removed the sync in there, if 
> > there wouldn't have been any comment.
> > Most of the time syncs are not required and just added by paranoid 
> > developers, but if there is a real reason, I think it should be stated 
> > in a comment.
>
> Sounds reasonable to me, can we please add a comment there?

Hi Cyril and Joerg,

Sounds reasonable to me as well,
will send a v2 patch with comment.

> -- 
> Cyril Hrubis
> chrubis@suse.cz


> Agree with this. Are all these sync really needed? Or just some?

Hi Petr,

I've written a script containing only the following sequence
	" mount 'cgroup mntpoint' "
	" mkdir 'under cgroup mntpoint' "
	" rmdir 'under cgroup mntpoint' "
	" umount 'cgroup mntpoint' "
	" mount 'cgroup mntpoint' "
and it could trigger the fail.

But only bumped into the umount fail when doing test_2 and test_3 in the cgroup_regression_test.

I am adding syncs in every sub-tests that execute the above sequence now.
Should them be added only at the places where umount failure did occur ?

> Kind regards,
> Petr


> IMO, Even we call sync, this umount may fail because sync ensures 
> nothing.  Why not use tst_umount?

Hi Yang,

I think this might be a timing issue and a little delay could fix this problem. (e.g. 'sleep 1')
Using 'sync' here IMHO would be more descriptive and has a semantic meaning.

Speaking of tst_umount, do you mean to convert this test to C code ?

> Best Regards
> Yang Xu

Best regards,
Leo
