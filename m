From: Zhang, Yixin <yixin.zhang@intel.com>
Date: Wed, 16 May 2018 18:05:29 +0800
Subject: [LTP] A new API to get distro name?
In-Reply-To: <20180515104952.GD7220@rei>
References: <F8498D2F03F2CF40823E11B9D93AD69F3A4DB22C@SHSMSX101.ccr.corp.intel.com>
 <20180515104952.GD7220@rei>
Message-ID: <20180516100529.h2plcuzbsyjkrj2e@silo>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018-05-15 at 12:49:52 +0200, Cyril Hrubis wrote:
> Hi!
> > I see that some shell tests are sensitive to distro, but not well managed currently.
> > Here are some examples I find:
> > In test "su01" in scenario "admin_tools", here is the way how it determine the distro (which is incorrect)
> >   41 tvar=${MACHTYPE%-*}
> >   42 tvar=${tvar#*-}
> >   43
> >   44 # need to export tvar for su01_s1
> >   45 export tvar
> >   46 printf "Machine type is: $tvar\n\n"
> >   47
> >   48 if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ]
> >   49 # Need to also set group for TEST_USER2
> > Similar for cron/at tests in "admin_tools" (the location of deny/allow file is not at the default location for Ubuntu)
> 
> There has been a recent discussion about what command testcases should
> be kept in LTP. Since LTP primary focus is on kernel testing, it does
> not make much sense to keep broken test for userspace commands.
> 
> So we may as well get rid of these three testcases instead of rewriting
> them unless somebody really wants to keep them. The whole admin_tools
> runtest file consists of broken tests that are at least partially
> outside of the focus of LTP.

Understood.

> 
> > Also in test cpuhotplug07, the folder "/usr/src/linux" doesn't exits on Ubuntu, so some modification based on distro is needed.
> 
> This should be fixed, the test expects the Linux kernel sources to be
> present at /usr/src/linux/ in order to generate system load.

I'll submit a patch for it, using "/usr/src/linux-`uname -r`" in case there is
no "/usr/src/linux/"

> 
> > I'd like to fix them, and need some suggestion: should we add a common
> > API in test.sh or should I just fix them in the test cases derectly?
> > If we plan to add a common API in the test.sh I may need some help as
> > here I don't have all the distro in hand.
> 
> Just FYI the test.sh is the old and deprecated test library, the new one
> is called tst_test.sh.

Got it.

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
