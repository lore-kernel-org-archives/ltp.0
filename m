Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eramoto.masaya@jp.fujitsu.com>) id 1OwSOL-0005lO-CE
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 04:17:41 +0000
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OwSOJ-0003wX-IM
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 04:17:41 +0000
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o8H4HWd6026339 for <ltp-list@lists.sourceforge.net> (envelope-from
	eramoto.masaya@jp.fujitsu.com); Fri, 17 Sep 2010 13:17:32 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 3CD3145DD71
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Sep 2010 13:17:32 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (s6.gw.fujitsu.co.jp [10.0.50.96])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 1BDB045DE4F
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Sep 2010 13:17:32 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id F2E7F1DB8015
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Sep 2010 13:17:31 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.249.87.104])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id A83C21DB8013
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Sep 2010 13:17:31 +0900 (JST)
Received: from ml14.css.fujitsu.com (ml14 [127.0.0.1])
	by ml14.s.css.fujitsu.com (Postfix) with ESMTP id 831BA9F6A84
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Sep 2010 13:17:31 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.124.101.175])
	by ml14.s.css.fujitsu.com (Postfix) with ESMTP id 26C319F6A7F
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Sep 2010 13:17:31 +0900 (JST)
Message-ID: <4C92EBBE.8090108@jp.fujitsu.com>
Date: Fri, 17 Sep 2010 13:17:02 +0900
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050104020401090501080207"
Subject: [LTP] Fix warning at cpuset_syscall_test.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050104020401090501080207
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi,

I found the following warning at cpuset_syscall_test.c.

===============
make[5]: Entering directory `/root/ltp/ltp-old/testcases/kernel/controllers/cpuset/cpuset_syscall_test'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I/root/ltp/ltp-old/testcases/kernel/include -I../../../../../include -I../../../../../include
-L/root/ltp/ltp-old/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../cpuset_lib
-L/root/ltp/ltp-old/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../../libcontrollers -L../../../../../lib  cpuset_syscall_test.c   -lltp -lcpu_set
-lcontrollers -lltp -o cpuset_syscall_test
cpuset_syscall_test.c: In function 'main':
cpuset_syscall_test.c:254: warning: control reaches end of non-void function
make[5]: Leaving directory `/root/ltp/ltp-old/testcases/kernel/controllers/cpuset/cpuset_syscall_test'
===============

This warning appears because it doesn't have "return <num>" in main().
The attached patch will fix it.

Signed-off-by: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
===============
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
index 961d0f9..0d4fe87 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
@@ -251,5 +251,6 @@ int main(int argc, char *argv[])
 #else
 int main (void) {
 	printf("System doesn't have required mempolicy support\n");
+	return -1;
 }
 #endif
===============

Thanks,
ERAMOTO


--------------050104020401090501080207
Content-Type: text/plain;
 name="fix_warning_at_cpuset_syscall_test.c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="fix_warning_at_cpuset_syscall_test.c.patch"

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY3B1c2V0L2NwdXNl
dF9zeXNjYWxsX3Rlc3QvY3B1c2V0X3N5c2NhbGxfdGVzdC5jIGIvdGVzdGNhc2VzL2tlcm5l
bC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X3N5c2NhbGxfdGVzdC9jcHVzZXRfc3lzY2Fs
bF90ZXN0LmMKaW5kZXggOTYxZDBmOS4uMGQ0ZmU4NyAxMDA2NDQKLS0tIGEvdGVzdGNhc2Vz
L2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X3N5c2NhbGxfdGVzdC9jcHVzZXRf
c3lzY2FsbF90ZXN0LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVz
ZXQvY3B1c2V0X3N5c2NhbGxfdGVzdC9jcHVzZXRfc3lzY2FsbF90ZXN0LmMKQEAgLTI1MSw1
ICsyNTEsNiBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogI2Vsc2UKIGlu
dCBtYWluICh2b2lkKSB7CiAJcHJpbnRmKCJTeXN0ZW0gZG9lc24ndCBoYXZlIHJlcXVpcmVk
IG1lbXBvbGljeSBzdXBwb3J0XG4iKTsKKwlyZXR1cm4gLTE7CiB9CiAjZW5kaWYK
--------------050104020401090501080207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--------------050104020401090501080207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050104020401090501080207--


