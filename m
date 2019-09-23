From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Sep 2019 12:02:11 +0200
Subject: [LTP] [PATCH v2] cgroup_regression_test.sh: Remove obselte
 test_5
In-Reply-To: <02ed63c6-102d-4aeb-39db-b9ea8f561b9c@cn.fujitsu.com>
References: <20190919094544.GA21345@rei>
 <1568889488-4032-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190919140931.GA14614@x230>
 <02ed63c6-102d-4aeb-39db-b9ea8f561b9c@cn.fujitsu.com>
Message-ID: <20190923100211.GA32293@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> > Merged, with additional note, why it's safe to remove it:

> >      [ pvorel: test_5 is testing 839ec5452ebf ("cgroup: fix root_count when
> >      mount fails due to busy subsystem") from v2.6.29-rc4 which fixes
> >      e5f6a8609bab ("cgroups: make root_list contains active hierarchies
> >      only") from v2.6.24-rc1. While there are still people testing LTP on
> >      2.6.x, nobody should be using -rc version now. ]
> I think your wrote v2.6.24-rc1 unexpectedly. commit e5f6a8609bab fixes the
> bug since v2.6.29-rc1 not v2.6.24-rc1. In addition to this typo, this reason
> looks good to me.
Thanks for info, unfortunately too late, git already has wrong kernel version in
the commit message. Sorry for an error.

Kind regards,
Petr
