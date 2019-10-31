From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 31 Oct 2019 15:10:33 +0100
Subject: [LTP] [PATCH v2 3/6] syscalls/quotactl01.c: Add Q_GETNEXQUOTA
 test
In-Reply-To: <20191024082525.GK31271@quack2.suse.cz>
References: <1571821231-3846-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1571821231-3846-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191024082525.GK31271@quack2.suse.cz>
Message-ID: <20191031141032.GB6011@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> On Wed 23-10-19 17:00:28, Yang Xu wrote:
> > Q_GETNEXTQUOTA was introduced since linux 4.6, this operation is the
> > same as Q_GETQUOTA, but it returns quota information for the next ID
> > greater than or equal to id that has a quota set.

> > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

> I was thinking about how much these tests are actually needed. The thing is
> that fstests have also quota tests. And as part of these tests we do run
> e.g. repquota(8) and verify its output and that uses Q_GETNEXTQUOTA inside.
> So Q_GETNEXTQUOTA gets testing as part of fstests. On the other hand
> fstests are focused on testing the general quota functionality as user
> would use it so we don't really try to make sure all quotactl calls are
> covered. So there's still some value in low level testing of each
> quotactl like you do here.

Agree that testing quotactl as syscall in LTP makes sense (unlike testing
filesystem features or performance, that was the reason why we deleted "New
ext4 features" tests).

Thank you for the review!

Kind regards,
Petr
