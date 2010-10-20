Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge.hallyn@canonical.com>) id 1P8YCo-0004yD-FO
	for ltp-list@lists.sourceforge.net; Wed, 20 Oct 2010 12:55:46 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P8YCn-0006Wq-F2
	for ltp-list@lists.sourceforge.net; Wed, 20 Oct 2010 12:55:46 +0000
Date: Wed, 20 Oct 2010 07:55:37 -0500
From: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Message-ID: <20101020125537.GA3623@hallyn.com>
References: <AANLkTinR7pDvxfq32hkVSFq-wrkiJk-9O1JPkehpKQw-@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTinR7pDvxfq32hkVSFq-wrkiJk-9O1JPkehpKQw-@mail.gmail.com>
Subject: Re: [LTP] smack testcase
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
To: ARJIT SHARMA <joyarjit@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Quoting ARJIT SHARMA (joyarjit@gmail.com):
> Hi,
> 
>      Inside the smack testcase, the sript "smack_common.sh" has a function
> named "check_onlycap()" , please tell me its functionality  as every time
> this function is reporting that   onlycap is "" not the expected "".
> 
> the log of the testcase is as follows---

Yeah the check seems backward.  Does this patch help?

From efe6116a6b284bb409b7fe9946cf990092183650 Mon Sep 17 00:00:00 2001
From: Serge Hallyn <serge.hallyn@canonical.com>
Date: Wed, 20 Oct 2010 07:54:21 -0500
Subject: [PATCH 1/1] Fix inverted logic testing for string which is NOT empty

Signed-off-by: Serge Hallyn <serge.hallyn@canonical.com>
---
 testcases/kernel/security/smack/smack_common.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/security/smack/smack_common.sh b/testcases/kernel/security/smack/smack_common.sh
index eb339f3..25405fe 100755
--- a/testcases/kernel/security/smack/smack_common.sh
+++ b/testcases/kernel/security/smack/smack_common.sh
@@ -36,7 +36,7 @@ check_mounted() {
 
 check_onlycap() {
 	onlycap=`cat "$smackfsdir/onlycap" 2>/dev/null`
-	if [ -z "$onlycap" ]; then
+	if [ ! -z "$onlycap" ]; then
 		cat <<EOM
 The smack label reported for $smackfsdir/onlycap is "$onlycap", not the expected "".
 EOM
-- 
1.7.1


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
