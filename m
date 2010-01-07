Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sds@tycho.nsa.gov>) id 1NSyEc-0002yx-Ie
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 19:41:30 +0000
Received: from msux-gh1-uea01.nsa.gov ([63.239.67.1])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSyEb-0003d8-9F
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 19:41:30 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <20100106185019.GA19647@us.ibm.com>
References: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
	<20100106185019.GA19647@us.ibm.com>
Date: Thu, 07 Jan 2010 14:40:58 -0500
Message-Id: <1262893258.2821.50.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Subject: Re: [LTP] regression:  selinux testsuite broken since October
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>

On Wed, 2010-01-06 at 12:50 -0600, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > It seems the Makefile rewrite last October broke the selinux testsuite.
> > Is it unreasonable to expect that someone who rewrote the Makefile would
> > actually try running the testsuite?
> > 
> > Please, revert the changes or fix them.
> > 
> > See testcases/kernel/security/selinux-testsuite/README for the
> > instructions.
> 
> Frankly I think reverting the Makefiles is best since it doesn't get
> auto-compiled anyway.  The new Makefile is much longer and more complicated
> for no apparent gain.
> 
> The following patch makes policy compilation work on rhel 5, but I doubt
> it'll work anywhere else.

Right, this won't work for Fedora.

> Running the testsuite still fails due to the change to running ltp from
> a different dir (i.e.
> /usr/bin/chcon: /root/ltp-full-20091231/testcases/bin: No such file or directory
> ).
> 
> -serge
> 
> diff -Nrup ltp-full-20091231.orig/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile ltp-full-20091231/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile
> --- ltp-full-20091231.orig/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile	2009-10-10 19:53:29.000000000 -0400
> +++ ltp-full-20091231/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile	2010-01-06 13:43:19.000000000 -0500
> @@ -33,19 +33,16 @@ CHECKPOLICY_VERS	?= $(shell $(CHECKPOLIC
>  
>  CLEAN_TARGETS		:= test_policy.te
>  
> -INSTALL_TARGETS		:= *.te
> +INSTALL_TARGETS		:= $(REDHAT_VERS)/*.te
> +INSTALL_TARGETS_FULL	:= $(builddir)/redhat/$(REDHAT_VERS)/*.te

Using the .te files under redhat/$(REDHAT_VERS) needs to be conditional
on actually running on rhel.   There was logic for that down below but
it looks like it has a typo. 

>  ifeq ($(CHECKPOLICY_VERS),24)
>  INSTALL_TARGETS		:= $(filter-out %/test_bounds.te,$(INSTALL_TARGETS))
> +INSTALL_TARGES_FULL		:= $(filter-out %/test_bounds.te,$(INSTALL_TARGES_FULL))

Typo:  TARGES vs TARGETS

>  endif
>  
>  TE_SRCDIR		:= $(abs_srcdir)
>  
> -ifeq (redhat-release-, $(findstring redhat-release-, $(REDHAT_RELEASE)))
> -ifneq ($(wildcard $(abs_srcdir)/redhat/$(REDHAT_VER)),)
> -TE_SRCDIR		:= $(abs_srcdir)/redhat/$(REDHAT_VER)
> -endif
> -endif

This is what should have pulled in the redhat/5 .te files, but it seems
buggy - there is a typo (VER vs VERS) and I'm not sure why there is the
inner ifneq block - that didn't exist in the original Makefile.
 
>  .PHONY: all clean cleanup install load
>  
> @@ -60,14 +57,18 @@ cleanup:
>  install: all
>  
>  # load remains for backwards compatibility...
> -load: $(builddir)/test_policy.te
> +load:
> +ifeq (redhat-release-, $(findstring redhat-release-, $(REDHAT_RELEASE)))
> +	$(MAKE) -C redhat/$(REDHAT_VERS)
> +else

This reverts to what was in the original Makefile, which takes us back
to just using the makefile down in redhat/5, which wasn't updated.

>  	@if [ -d "$(POLICYDEVEL)" ]; then \
> -	    cp -p $(builddir)/test_policy.* $(INSTALL_TARGETS) $(POLICY_DEVEL); \
> +	    cp -p $(builddir)/test_policy.* $(INSTALL_TARGETS_FULL) $(POLICYDEVEL); \

Only test_policy.* should be copied to $POLICYDEVEL, not the
individual .te files.

>  	    $(MAKE) -C $(POLICYDEVEL) clean test_policy.pp; \
>  	    $(SEMODULE) -i $(POLICYDEVEL)/test_policy.pp; \
>  	else \
>              echo "ERROR: You must have selinux-policy-devel installed."; \
>  	fi
> +endif
>  
>  $(builddir)/test_policy.te:
>  	(cd "$(TE_SRCDIR)" && cat $(INSTALL_TARGETS)) > "$@";
-- 
Stephen Smalley
National Security Agency


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
