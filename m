From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Sep 2021 09:33:25 +0200
Subject: [LTP] [PATCH ltp] IMA: Add tests for uid, gid, fowner,
 and fgroup options
In-Reply-To: <20210909183545.a33cb2c25f13eb2a1d7b64ac@vpitech.com>
References: <20210909165111.51038-1-alexh@vpitech.com>
 <20210909165111.51038-2-alexh@vpitech.com> <YTpswsqlDS5tI7NC@pevik>
 <20210909183545.a33cb2c25f13eb2a1d7b64ac@vpitech.com>
Message-ID: <YTsKRfSj7lAxKfQH@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alex,

> On Thu, 9 Sep 2021 22:21:22 +0200
> Petr Vorel <pvorel@suse.cz> wrote:

> > > Requires "ima: add gid support".
> > I haven't test the patch yet, but LTP supports (unlike kselftest) various kernel
> > versions. Thus there should be some check to prevent old kernels failing.
> > You could certainly wrap new things with if tst_kvcmp. If there is a chance new
> > functionality can be detected, we prefer it because various features are
> > sometimes backported to enterprise distros' kernels.

> > Also, adding new test ima_measurements02.sh with TST_MIN_KVER would also work,
> > although for IMA tests I usually kept everything in a single file.

> I'll add a tst_kvcmp check under the assumption that this feature will
> be added before Linux 5.15.
+1. Please let me know when you manage to get this mainlined (merged into Mimi's
tree is enough), we should also add the commit hash of this feature.

> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> > > @@ -8,6 +8,7 @@

> > >  TST_NEEDS_CMDS="awk cut sed"
> > You should add sudo:

> > TST_NEEDS_CMDS="awk cut sed sudo"

> Will do.
+1

> > >  TST_SETUP="setup"
> > > +TST_CLEANUP="cleanup"
> > >  TST_CNT=3
> > >  TST_NEEDS_DEVICE=1

> > > @@ -20,6 +21,13 @@ setup()
> > >  	TEST_FILE="$PWD/test.txt"
> > >  	POLICY="$IMA_DIR/policy"
> > >  	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
> > > +
> > > +	cat $IMA_POLICY > policy-original
> > This might not work if CONFIG_IMA_READ_POLICY is not set. There is
> > check_policy_readable() helper in ima_setup.sh. Is it really needed anyway?

> It looks like CONFIG_IMA_WRITE_POLICY only makes it possible to add new
> rules at runtime, not remove them, so the cleanup code didn't actually
> work. I'll remove it.

FYI I have on my TODO list loading policy before testing [1].

> > > +}
> > > +
> > > +cleanup()
> > > +{
> > > +	cat policy-original > $IMA_POLICY
> > Again, this will not work if CONFIG_IMA_WRITE_POLICY not set.
> > And this is very likely not to be set.

> The new tests require the policy to be writable. I'll move the
> check_policy_writable function from ima_policy.sh to ima_setup.sh and
> use it in ima_measurements.sh as well.

+1.

FYI there is IMA specific README.md [2], in case anything needs to be updated.

> Thanks for the feedback,
yw. Thanks for taking care about testing!

Kind regards,
Petr

> -Alex

[1] https://github.com/linux-test-project/ltp/issues/720
[2] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/integrity/ima/README.md
