From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 13 Dec 2018 18:38:19 +0100
Subject: [LTP] [PATCH v2 5/6] shell: Add tst_security.sh helper
In-Reply-To: <0fabb62a-e758-80f8-79e1-e3d4ccec7ede@oracle.com>
References: <20181207123516.30867-1-pvorel@suse.cz>
 <20181207123516.30867-6-pvorel@suse.cz>
 <0fabb62a-e758-80f8-79e1-e3d4ccec7ede@oracle.com>
Message-ID: <20181213173819.GA26670@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thanks for your review.

> On 07.12.2018 15:35, Petr Vorel wrote:
> > It prints info about AppArmor and SELinux and allows to disable it.
> > This is due some false positives because improper usage or bugs
> > in AppArmor profiles (e.g. traceroute, dnsmasq).

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---

> ...

> > -	if [ "$TST_NEEDS_ROOT" = 1 ]; then
> > +	if [ "$TST_NEEDS_ROOT" = 1 ] || [ "$TST_DISABLE_APPARMOR" = 1 ] || [ "$TST_DISABLE_SELINUX" = 1 ]; then
> >  		if [ "$(id -ru)" != 0 ]; then
> >  			tst_brk TCONF "Must be super/root for this test!"
> >  		fi
> >  	fi

> > +	[ "$TST_DISABLE_APPARMOR" = 1 ] && tst_disable_apparmor
> > +	[ "$TST_DISABLE_SELINUX" = 1 ] && tst_disable_selinux
> > +
> > +	if [ "$TST_SECURITY_WARN" = 1 ]; then
> > +		tst_apparmor_enabled && \
> > +			tst_res TINFO "AppArmor enabled, this may affect test results. Disable it with TST_DISABLE_APPARMOR=1 (requires super/root)"
> > +		tst_selinux_enabled && \
> > +			tst_res TINFO "SELinux enabled, this may affect test results. Disable it with TST_DISABLE_SELINUX=1 (requires super/root)"
> > +	fi
> > +
> >  	tst_test_cmds $TST_NEEDS_CMDS

> Since it may not affect test results, I don't think we should complicate
> the tests with TST_SECURITY_WARN parameter. The usage is not obvious either.
> Whether the test used dnsmasq or ping, for example, can be obtained from
> $TST_NEEDS_CMDS.
I didn't want to add this warning for any test failure when AppArmor/SELinux
enabled. Sometimes it's not obvious, that problem was caused by
AppArmor/SELinux, but this is relevant only for user space tests (networking and
some command tests).
For AppArmor it's easy to list policies (for newer kernels) and by parsing $TST_NEEDS_CMDS
detect detect the relevance of warning. I'll have a look if this is the same for
SELinux. Then TST_SECURITY_WARN flag wouldn't be needed.

> And it's better to write these messages only if the test fails, suggesting
> to change configuration.
This make sense, I'll change it.


Kind regards,
Petr
