From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Jan 2020 13:41:01 +0100
Subject: [LTP] [PATCH v1 3/4] syscalls/capset03: add new EPERM error
 test without CAP_SETPCAP
In-Reply-To: <cb1878f7-a00a-f5d1-c55f-6f80ff01cb6b@cn.fujitsu.com>
References: <1576577571-3668-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1576577571-3668-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200107133913.GE26408@rei.lan>
 <e6cada30-fb4e-a2e0-72e9-cdfc796361cb@cn.fujitsu.com>
 <20200108110343.GA3318@rei.lan>
 <cb1878f7-a00a-f5d1-c55f-6f80ff01cb6b@cn.fujitsu.com>
Message-ID: <20200109124101.GE31981@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also the CAP_DROP in the tst_test structure seems to be useless to me.
> > 
> > 
> > Looking at man 7 capabilities, there are also transitions defined for
> > what is supposed to happen when we change user id. It would make sense
> > to write tests that capabilities are correctly dropped when UID changes
> > from 0 to nonzero. Which is what this test is testing when executed as
> > non-root, since the transition from 0 to nonzero must have happened
> > somewhere when user has logged in.
> In man 7 capabilities " Effect of user ID changes on capabilities",
> I see transitions between 0 and nonzero user IDs. But it is about 
> capabilities??not about capset syscall. I think we should add these 
> cases(user ID changes on capabilities) into kernel/security (such as 
> cap_bound or filecaps). In capset, we can only test capset various EPERM 
> error as kernel sercurity/commoncap.c  cap_capset function.
> ---------------------------------
>       if (cap_inh_is_capped() &&
>              !cap_issubset(*inheritable,
>                            cap_combine(old->cap_inheritable,
>                                        old->cap_permitted)))
>                  /* incapable of using this inheritable set */
>                  return -EPERM;
> 
>          if (!cap_issubset(*inheritable,
>                            cap_combine(old->cap_inheritable,
>                                        old->cap_bset)))
>                  /* no new pI capabilities outside bounding set */
>                  return -EPERM;
> 
>          /* verify restrictions on target's new Permitted set */
>          if (!cap_issubset(*permitted, old->cap_permitted))
>                  return -EPERM;
> 
>          /* verify the _new_Effective_ is a subset of the _new_Permitted_ */
>          if (!cap_issubset(*effective, *permitted))
>                  return -EPERM;
> ---------------------------------

Indeed these does not belog under setcap(). Maybe we could add these
checks under setuid tests, since we are testing side efect of setuid.
But having these under security/ would work as well.

> Also, if we only run under root, CAP_DROP(CAP_SETPCAP) is needed  to 
> reproduce this EPERM error.

Isn't the first thing that the test does to remove all capabilities but
CAP_KILL? Why do we need to drop anything beforehand?

-- 
Cyril Hrubis
chrubis@suse.cz
