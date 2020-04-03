From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 3 Apr 2020 12:05:11 +0200
Subject: [LTP] LIBTIRPC Error
In-Reply-To: <5E86F92F.9080200@cn.fujitsu.com>
References: <MAXPR0101MB14688E4E7604C8BD9D17CB40EEC70@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
 <5E86F92F.9080200@cn.fujitsu.com>
Message-ID: <20200403100511.GA23296@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Pankaj, Xiao,

> > Hi,
> > I am trying to run ltp on 5.4.3 kernel with our custom yocto distro but
> > i am facing following issue , i have installed

> > pkg-config libtirpc-dev libtirpc1 but still the same error is getting
> > encountered,can someone help us to solve it??

> > .*/configure: line 6794: syntax error near unexpected token `LIBTIRPC,'
> > **./configure: line 6794: ` PKG_CHECK_MODULES(LIBTIRPC, libtirpc >*

> It seems that pkg-config package(it provides pkg-config command) is not
> installed on your enviroment.
+1
You need to have pkg.m4 (usually /usr/share/aclocal/pkg.m4).

Distros might have it in different packages than pkg-config or pkgconf,
but they usually install it as a dependency.
openSUSE have it in pkgconf-m4, but installed as dependency with pkg-config.
Debian have it in pkg-config and pkgconf.

Yes, this has been documented on usual places:
https://github.com/linux-test-project/ltp/#quick-guide-to-running-the-tests
If you have git, autoconf, automake, m4 and pkg-config, the linux headers and
the common developer packages installed ...

https://github.com/linux-test-project/ltp/blob/master/INSTALL
If you want to use auto configuration you also need autoconf-2.61+, automake-1.10+
and pkg-config.

(+ also in travis scripts (in travis/ directory) and also in the commit, but
both aren't that much visible for users).

But apparently that's not enough (you mentioned pkg-config, so you have read the
docs. Maybe I should state that the dependency is on pkg-config autotools
integration (pkg.m4).

Kind regards,
Petr
