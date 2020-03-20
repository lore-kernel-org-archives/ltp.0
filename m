From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Mar 2020 12:50:48 +0100
Subject: [LTP] [PATCH v3] syscalls/add_key05: add maxbytes/maxkeys test
 under unprivileged user
In-Reply-To: <c65a46ee-3355-d9b8-dd27-905962384af9@cn.fujitsu.com>
References: <20200317123203.GA21921@dell5510>
 <1584527574-28177-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200319112332.GB440@dell5510>
 <c65a46ee-3355-d9b8-dd27-905962384af9@cn.fujitsu.com>
Message-ID: <20200320115048.GA27677@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> > > This case is designed to test whether we can reach maxbytes/maxkeys
> > > quota exactly under unprivileged users. It is a regression test for
> > > commit a08bf91ce28e ("KEYS: allow reaching the keys quotas exactly").
> > > But this kenrel commit is a incomplete fix, it still fails on lastest
> > nit: typos: kenrel, lastest (will be fixed during merge).
> > > upstream kernel. Fix patch[1] is on linux-next branch.

> > > [1]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2e356101e72a
> > I guess this commit get's preserved when merged in mainline, so we don't have to
> > wait for it.
> This morning, I got email about this patch[1](change subject"keys: Fix the
> keys quotas limit check"). I'm not sure whether they will recycle and modify
> this.

> [1]https://patchwork.kernel.org/patch/11411507/

Although the maintainers were discussing commit message change, in the end
Jarkko has sent it:
https://lkml.org/lkml/2020/3/15/314
Well, if the commit hash changes, we'll just fix it.

> > > +struct passwd *ltpuser;
> > ...
> > > +static void add_user(void)
> > > +{
> > > +	if (user_added)
> > > +		return;
> > > +
> > > +	const char *const cmd_useradd[] = {"useradd", username, NULL};
> > > +	int rc;
> > > +
> > > +	switch ((rc = tst_run_cmd(cmd_useradd, NULL, NULL, 1))) {
> > > +	case 0:
> > > +		user_added = 1;
> > > +		ltpuser = SAFE_GETPWNAM(username);
> > > +		break;
> > > +	case 1:
> > > +	case 255:
> > > +		break;
> > > +	default:
> > > +		tst_brk(TBROK, "Useradd failed (%d)", rc);
> > > +	}
> > > +	sprintf(fmt, "%5u: %%*5d %%*d/%%*d %%d/%%d %%d/%%d", ltpuser->pw_uid);
> > > +}
> > ltpuser is undefined for 1 and 255, therefore it gets SIGSEGV. It should either
> > require tst_run_cmd to exit 0 or use 0 as UID (root UID).
> Oh, sorry for this obvious mistake, thanks for pointing out it.
> Yes, I prefer to exit when running into 0 or 255.

Fine :). I'm going to merge with handling specially only 255:

Kind regards,
Petr

index a0c8c00cc..a39bfa0b7 100644
--- testcases/kernel/syscalls/add_key/add_key05.c
+++ testcases/kernel/syscalls/add_key/add_key05.c
@@ -43,11 +43,11 @@ static void add_user(void)
                user_added = 1;
                ltpuser = SAFE_GETPWNAM(username);
                break;
-       case 1:
        case 255:
+               tst_brk(TCONF, "useradd not found");
                break;
        default:
-               tst_brk(TBROK, "Useradd failed (%d)", rc);
+               tst_brk(TBROK, "useradd failed (%d)", rc);
        }
        sprintf(fmt, "%5u: %%*5d %%*d/%%*d %%d/%%d %%d/%%d", ltpuser->pw_uid);
 }
