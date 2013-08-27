Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VEH4X-0003Vf-Nc
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 11:04:29 +0000
Date: Tue, 27 Aug 2013 13:04:34 +0200
From: chrubis@suse.cz
Message-ID: <20130827110434.GA10995@rei.Home>
References: <20130711110014.GB6142@rei.suse.cz>
	<201308242143.45598.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201308242143.45598.vapier@gentoo.org>
Subject: Re: [LTP] RFC add _FORTIFY_SOURCE to default LTP CFLAGS
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Recently just another open(.., O_CREAT) without mode_t flags slipped in
> > the git, which would have been easily catched early by glibc
> > _FORTIFY_SOURCE feature. If _FORTIFY_SOURCE is set additional checks for
> > unused return values, buffer overflows etc. are done. Some distros eable
> > it even by default...
> > 
> > Does anybody oposse against adding -D_FORTIFY_SOURCE=2 to the default
> > LTP CFLAGS?
> 
> i have a hard time coming up with a scenario where having the flags enabled 
> would cause a problem for us.  i.e. trying to test C library behavior by 
> violating fortify.  if that does actually come up, we could just easily put at 
> the top of the test:
> 	/* We actually want test verify XXX */
> 	#undef _FORTIFY_SOURCE
> 
> Gentoo has had this enabled by default in the toolchain for years and don't 
> recall running into a problem thus far.
> 
> nit though: this should be CPPFLAGS, not CFLAGS.

Ok, CPPFLAGS is better. What would be the best place for it, I came up
with simple:

diff --git a/configure.ac b/configure.ac
index f0fc6b0..afc998c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -30,6 +30,8 @@ AC_PROG_YACC
 
 AC_PREFIX_DEFAULT(/opt/ltp)
 
+CPPFLAGS="$CPPFLAGS -D_FORTIFY_SOURCE=2"
+
 AC_CHECK_HEADERS([ \
     dmapi.h \
     ifaddrs.h \
diff --git a/include/mk/config.mk.default b/include/mk/config.mk.default
index 953747c..dae9cb7 100644
--- a/include/mk/config.mk.default
+++ b/include/mk/config.mk.default
@@ -54,7 +54,7 @@ mandir			:= ${datarootdir}/man
 
 RPMBUILD		?= rpmbuild
 
-CPPFLAGS		:=
+CPPFLAGS		:= -D_FORTIFY_SOURCE=2
 CFLAGS			:= -g -O2
 LDLIBS			:=
 LDFLAGS			:=


Which should IMHO work as having defined unrecognized macro should not
break anything, or is there a need how to test for _FORTIFY_SOURCE libc
support?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
