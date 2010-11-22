Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PKPob-00036V-Pw
	for ltp-list@lists.sourceforge.net; Mon, 22 Nov 2010 06:23:49 +0000
Received: from out16.sjc.mx.trendmicro.com ([216.99.131.73])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PKPoa-0003N2-6B
	for ltp-list@lists.sourceforge.net; Mon, 22 Nov 2010 06:23:49 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.26])
	by out16.sjc.mx.trendmicro.com (Postfix) with ESMTP id AEE63980415
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Nov 2010 06:23:41 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 09FDA114B83F
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Nov 2010 06:23:40 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Nov 2010 15:23:39 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Mon, 22 Nov 2010 15:23:39 +0900
Message-ID: <000001cb8a0d$cd4fad30$67ef0790$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] About "configure" failure
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
To: ltp-list@lists.sourceforge.net

Hi,

I reported failure of "configure" on the other day.
    http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg11137.html

But I think that it's hard to notice because my report is contributed to 
the report of "realtime" failure. It's my clumsiness.
Therefore, I report about "configure" again with  the recent git.


---

"configure" failed with git "ltp-7d2055e.tar.gz":
------------<RHEL4.8 - x86>
./configure: line 8228: syntax error near unexpected token `elif'
./configure: line 8228: `elif test "x$has_quotav2" = "xyes"; then'
------------

Environmants are RHEL5.5/4.8 -- x86/x86_64/ia64.


"${LTPROOT}/configure" file of "ltp-7d2055e.tar.gz" is following:

------------< RHEL4.8 - x86>
[...]

cat >conftest.$ac_ext <<_ACEOF
/* confdefs.h.  */
_ACEOF
cat confdefs.h >>conftest.$ac_ext
cat >>conftest.$ac_ext <<_ACEOF						---
LINE 8210
/* end confdefs.h.  */

#define _LINUX_QUOTA_VERSION 2
#include <sys/types.h>
#include <sys/quota.h>
#include <unistd.h>
int main(void) {
        struct dqblk dq;
        return quotactl(QCMD(Q_GETINFO, USRQUOTA), (const char *)
"/dev/null",
                        geteuid(), (caddr_t) &dq);
}
--- LINE 8221
if test "x$has_quotav1" = "xyes"; then

cat >>confdefs.h <<\_ACEOF
--- LINE 8224
#define HAVE_QUOTAV1 1
_ACEOF

elif test "x$has_quotav2" = "xyes"; then

cat >>confdefs.h <<\_ACEOF
#define HAVE_QUOTAV2 1
_ACEOF

fi

_ACEOF
--- LINE 8236
rm -f conftest.$ac_objext conftest$ac_exeext
if { (ac_try="$ac_link"
[...]
------------


The line 8210 ("  8210  cat >>conftest.$ac_ext <<_ACEOF") is the "here
document".
First "_ACEOF" which appears after this line is the line 8224.
But the line 8224 is "here document", too.

I think that it is syntax error.

In the line 8236, there is "_ACEOF".
This "_ACEOF" may be just after line 8221, I think.

I tried to execute "configure" after above revision, and it succeeded.
After this, "make" and "make install" succeeded, too.


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
