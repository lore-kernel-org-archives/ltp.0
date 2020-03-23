From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Mar 2020 10:04:46 +0100
Subject: [LTP] [PATCH 2/2] Use SAFE_RUNCMD()
In-Reply-To: <c0ab47c6-cc59-03e5-d474-e4efd68844a2@cn.fujitsu.com>
References: <20200320134937.16616-1-pvorel@suse.cz>
 <20200320134937.16616-2-pvorel@suse.cz>
 <c0ab47c6-cc59-03e5-d474-e4efd68844a2@cn.fujitsu.com>
Message-ID: <20200323090446.GA6282@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> This patch looks good to me, just a small nit
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   testcases/kernel/syscalls/add_key/add_key05.c   | 15 ++-------------
> >   testcases/kernel/syscalls/quotactl/quotactl01.c | 14 ++------------
> >   testcases/kernel/syscalls/quotactl/quotactl06.c | 12 +-----------
> >   3 files changed, 5 insertions(+), 36 deletions(-)

> > diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
> > index a39bfa0b7..6a4e20564 100644
> > --- a/testcases/kernel/syscalls/add_key/add_key05.c
> > +++ b/testcases/kernel/syscalls/add_key/add_key05.c
> > @@ -36,19 +36,8 @@ static void add_user(void)
> >   		return;
> >   	const char *const cmd_useradd[] = {"useradd", username, NULL};
> > -	int rc;
> > -
> > -	switch ((rc = tst_run_cmd(cmd_useradd, NULL, NULL, 1))) {
> > -	case 0:
> > -		user_added = 1;
> > -		ltpuser = SAFE_GETPWNAM(username);
> > -		break;
> > -	case 255:
> > -		tst_brk(TCONF, "useradd not found");
> > -		break;
> > -	default:
> > -		tst_brk(TBROK, "useradd failed (%d)", rc);
> > -	}
> > +
> > +	SAFE_RUNCMD(cmd_useradd, NULL, NULL);
> We should keep ltpuser and user_added assignment.

Oh, thanks for a reminder, sure.
+ there is an error in in safe_run_cmd() (used rc instead of rval).
I'll send v2.

Kind regards,
Petr
