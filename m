Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PLAIP-0006sI-5G
	for ltp-list@lists.sourceforge.net; Wed, 24 Nov 2010 08:01:41 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PLAIN-0000MR-BI
	for ltp-list@lists.sourceforge.net; Wed, 24 Nov 2010 08:01:41 +0000
Message-ID: <4CECC662.2080103@cn.fujitsu.com>
Date: Wed, 24 Nov 2010 16:01:38 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
References: <000001cb8a0d$cd4fad30$67ef0790$@co.jp>
In-Reply-To: <000001cb8a0d$cd4fad30$67ef0790$@co.jp>
Subject: Re: [LTP] About "configure" failure
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net



Mitani wrote:
> Hi,
> 
> I reported failure of "configure" on the other day.
>     http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg11137.html
> 
> But I think that it's hard to notice because my report is contributed to 
> the report of "realtime" failure. It's my clumsiness.
> Therefore, I report about "configure" again with  the recent git.
> 
> 

Hi mitani-san, 

  Please try the following patch.

-----------------------
fix configure error.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 m4/ltp-quota.m4 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/m4/ltp-quota.m4 b/m4/ltp-quota.m4
index af1212a..5a367e9 100644
--- a/m4/ltp-quota.m4
+++ b/m4/ltp-quota.m4
@@ -29,7 +29,7 @@ int main(void) {
 	struct dqblk dq;
 	return quotactl(QCMD(Q_GETINFO, USRQUOTA), (const char *) "/dev/null",
 			geteuid(), (caddr_t) &dq);
-}],[has_quotav2="yes"],[dnl END quota v2 check
+}])],[has_quotav2="yes"],[dnl END quota v2 check
 AC_LINK_IFELSE([AC_LANG_SOURCE([
 #define _LINUX_QUOTA_VERSION 1
 #include <sys/types.h>
@@ -46,4 +46,4 @@ if test "x$has_quotav1" = "xyes"; then
 elif test "x$has_quotav2" = "xyes"; then
 	AC_DEFINE(HAVE_QUOTAV2,1,[Define to 1 if you have quota v2])
 fi
-])])
+])
-- 
1.7.0.4



> ---
> 
> "configure" failed with git "ltp-7d2055e.tar.gz":
> ------------<RHEL4.8 - x86>
> ./configure: line 8228: syntax error near unexpected token `elif'
> ./configure: line 8228: `elif test "x$has_quotav2" = "xyes"; then'
> ------------
> 
> Environmants are RHEL5.5/4.8 -- x86/x86_64/ia64.
> 
> 
> "${LTPROOT}/configure" file of "ltp-7d2055e.tar.gz" is following:
> 
> ------------< RHEL4.8 - x86>
> [...]
> 
> cat >conftest.$ac_ext <<_ACEOF
> /* confdefs.h.  */
> _ACEOF
> cat confdefs.h >>conftest.$ac_ext
> cat >>conftest.$ac_ext <<_ACEOF						---
> LINE 8210
> /* end confdefs.h.  */
> 
> #define _LINUX_QUOTA_VERSION 2
> #include <sys/types.h>
> #include <sys/quota.h>
> #include <unistd.h>
> int main(void) {
>         struct dqblk dq;
>         return quotactl(QCMD(Q_GETINFO, USRQUOTA), (const char *)
> "/dev/null",
>                         geteuid(), (caddr_t) &dq);
> }
> --- LINE 8221
> if test "x$has_quotav1" = "xyes"; then
> 
> cat >>confdefs.h <<\_ACEOF
> --- LINE 8224
> #define HAVE_QUOTAV1 1
> _ACEOF
> 
> elif test "x$has_quotav2" = "xyes"; then
> 
> cat >>confdefs.h <<\_ACEOF
> #define HAVE_QUOTAV2 1
> _ACEOF
> 
> fi
> 
> _ACEOF
> --- LINE 8236
> rm -f conftest.$ac_objext conftest$ac_exeext
> if { (ac_try="$ac_link"
> [...]
> ------------
> 
> 
> The line 8210 ("  8210  cat >>conftest.$ac_ext <<_ACEOF") is the "here
> document".
> First "_ACEOF" which appears after this line is the line 8224.
> But the line 8224 is "here document", too.
> 
> I think that it is syntax error.
> 
> In the line 8236, there is "_ACEOF".
> This "_ACEOF" may be just after line 8221, I think.
> 
> I tried to execute "configure" after above revision, and it succeeded.
> After this, "make" and "make install" succeeded, too.
> 
> 
> Regards--
> 
> -Tomonori Mitani
> 
> 
> 
> ------------------------------------------------------------------------------
> Beautiful is writing same markup. Internet Explorer 9 supports
> standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
> Spend less time writing and  rewriting code and more time creating great
> experiences on the web. Be a part of the beta today
> http://p.sf.net/sfu/msIE9-sfdev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 

-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
