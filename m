From: Leo Liang <ycliang@andestech.com>
Date: Mon, 12 Jul 2021 15:28:40 +0800
Subject: [LTP] [PATCH 1/1] cgroup/cgroup_regression_test: Fix umount
 failure
In-Reply-To: <60E3EE1D.2090800@fujitsu.com>
References: <20210628033002.GA1469@andestech.com>
 <caf1bb46-5212-3c3d-f180-e722ef2cf8dd@jv-coder.de>
 <YNnJ18Q+cqb8zM5K@yuki> <20210706032748.GA16346@andestech.com>
 <60E3EE1D.2090800@fujitsu.com>
Message-ID: <20210712072840.GA9612@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

On Tue, Jul 06, 2021 at 05:45:32AM +0000, xuyang2018.jy@fujitsu.com wrote:
> Hi Leo
> >
> >> IMO, Even we call sync, this umount may fail because sync ensures
> >> nothing.  Why not use tst_umount?
> >
> > Hi Yang,
> >
> > I think this might be a timing issue and a little delay could fix this problem. (e.g. 'sleep 1')
> > Using 'sync' here IMHO would be more descriptive and has a semantic meaning.
> Yes, it is a timing issue.
> I also met a similar problem because of sync to lead EBUSY error in 
> xfstests log time ago.
> 
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=b536de2a042484bb241cca120ce55c974309513a
> 
> So, I don't think using sync is a good idea because sync will make 
> metadata into disk but no ensure it. So if we have other io work, then 
> sync may push other's metadata into disk firstly instead of here's data.
> 
> Since we have tst_umount api to avoid EBUSY error, why not to use it in 
> here to avoid your problem?
> >
> > Speaking of tst_umount, do you mean to convert this test to C code ?
> No, we also have shell api  for tst_umount.

Thanks for the suggestion.
I've tested the cgroup_regression_test with the tst_umount api
and it works fine!

I will convert "add sync" patch to this!
Thanks again.

> >
> >> Best Regards
> >> Yang Xu
> >
> > Best regards,
> > Leo

Best regards,
Leo
