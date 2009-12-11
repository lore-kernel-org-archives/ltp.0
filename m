Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NJ3hM-000257-CC
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 11:30:12 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NJ3hH-0004gP-H1
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 11:30:12 +0000
Received: from int-mx08.intmail.prod.int.phx2.redhat.com
	(int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBBBU1vi021837
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Dec 2009 06:30:01 -0500
Received: from mail04.corp.redhat.com (zmail04.collab.prod.int.phx2.redhat.com
	[10.5.5.44])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id nBBBU1DH006360
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Dec 2009 06:30:01 -0500
Date: Fri, 11 Dec 2009 06:30:01 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1114676463.211401260531001515.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <733784191.211351260530878824.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8107_432322952.1260531001514"
Subject: [LTP] [PATCH] fix compiling error on ia64 platform
	(ltp-full-20091130)
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
To: ltp-list@lists.sourceforge.net

------=_Part_8107_432322952.1260531001514
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi all,

  Here are two patches to fix compiling error in ia64,
I tested only in version ltp-full-20091130, please check
your own version. They are for work well on my system.
See the attachment.

Thanks,
Caspar
------=_Part_8107_432322952.1260531001514
Content-Type: application/octet-stream; name=ia64-fpreg_redef-compile-err.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=ia64-fpreg_redef-compile-err.patch

T24gaWE2NCBtYWNoaW5lcywgdGhlIGNvbXBpbGF0aW9uIGNhbid0IHBhc3MuIFRoZSBlcnJvciBt
ZXNzYWdlczoKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3IvaW5jbHVkZS9hc20vcHRyYWNlLmg6
NTgsCiAgICAgICAgICAgICAgICAgZnJvbSAuLi8uLi9zeXNjYWxscy9wdHJhY2UvcHRyYWNlLmg6
MTcsCiAgICAgICAgICAgICAgICAgZnJvbSB2Zm9yay5jOjQ0OgovdXNyL2luY2x1ZGUvYXNtL2Zw
dS5oOjU3OiBlcnJvcjogcmVkZWZpbml0aW9uIG9mIOKAmHN0cnVjdCBpYTY0X2ZwcmVn4oCZCklu
IGZpbGUgaW5jbHVkZWQgZnJvbSAuLi8uLi9zeXNjYWxscy9wdHJhY2UvcHRyYWNlLmg6MTcsCiAg
ICAgICAgICAgICAgICAgZnJvbSB2Zm9yay5jOjQ0OgovdXNyL2luY2x1ZGUvYXNtL3B0cmFjZS5o
OjIwODogZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiDigJhzdHJ1Y3QgcHRfYWxsX3VzZXJfcmVnc+KA
mQptYWtlWzVdOiAqKiogW3Zmb3JrXSBFcnJvciAxCgpBZnRlciBpbnZlc3RpZ2F0aW5nLCBJIGZv
dW5kIGluIGlhNjQgcGxhdGZvcm0sIHRoZSBmaWxlIGFzbS9wdHJhY2UuaCBjb25mbGljdHMKd2l0
aCBzeXMvcHRyYWNlLmggYW5kIGxpbnV4L3B0cmFjZS5oLCBzbyBJIGRpZCBzb21lIHRyaWNrcyBv
biBwdHJhY2UuaCBpbiAKdGVzdGNhc2Uva2VybmVsL3N5c2NhbGwvcHRyYWNlOiBpZiBpdCBpcyBp
biBhIGlhNjQgbWFjaGluZSwgZG9uJ3QgaW5jbHVkZQogPGFzbS9wdHJhY2UuaD4uIEkgdGhpbmsg
aXQncyBhbiB1Z2x5IGZpeCBiZWNhdXNlIGl0IG1heSBub3QgbWVldCB0aGUgZGV2J3MKbmVlZCwg
YnV0IGl0IHdvcmtzIG9uIG15IHN5c3RlbS4KCiBTaWduZWQtb2ZmLWJ5OiBDYXNwYXIgWmhhbmcg
PGN6aGFuZ0ByZWRoYXQuY29tPgoKZGlmZiAtTmF1ciBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvcHRyYWNlL3B0cmFjZS5oIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wdHJhY2UvcHRy
YWNlLmgKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wdHJhY2UvcHRyYWNlLmgJMjAw
OS0xMS0yOCAwNzowNDo0NS4wMDAwMDAwMDAgKzA4MDAKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9wdHJhY2UvcHRyYWNlLmgJMjAwOS0xMi0xMSAxODozNjo0NC41MTkwNzcyNDkgKzA4
MDAKQEAgLTEzLDkgKzEzLDEzIEBACiAjaWZkZWYgSEFWRV9TWVNfUkVHX0gKICMgaW5jbHVkZSA8
c3lzL3JlZy5oPgogI2VuZGlmCisvKiBmaXggY29tcGlsZSBlcnJvciBvbiBpYTY0LAorICogRklY
TUU6IGl0J3MgYW4gdWdseSBmaXggbWF5IG5vdCBtZWV0IHRoZSBkZXZlbG9wZXIncyBuZWVkcyAq
LworI2lmICEgZGVmaW5lZChfX2lhNjRfXykKICNpZiBkZWZpbmVkKEhBVkVfQVNNX1BUUkFDRV9I
KQogIyBpbmNsdWRlIDxhc20vcHRyYWNlLmg+CiAjZW5kaWYKKyNlbmRpZgogLyogaWE2NCdzIGEg
cmVhbCBwYWluLi4gKi8KICNpZiBkZWZpbmVkKF9faWE2NF9fKQogI3VuZGVmIEZVX2lhNjRfZnBy
ZWcK
------=_Part_8107_432322952.1260531001514
Content-Type: application/octet-stream;
	name=ptrace04-no_cleanup-compile-err.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=ptrace04-no_cleanup-compile-err.patch

on some system without HAVE_STRUCT_PT_REGS and HAVE_STRUCT_USER_REGS_STRUCT 
defined, ptrace04.c will not pass the compiling due to the missing of
cleanup() function. 

  Signed-off-by: Caspar Zhang <czhang@redhat.com>

diff -Naur a/testcases/kernel/syscalls/ptrace/ptrace04.c b/testcases/kernel/syscalls/ptrace/ptrace04.c
--- a/testcases/kernel/syscalls/ptrace/ptrace04.c	2009-11-28 07:04:45.000000000 +0800
+++ b/testcases/kernel/syscalls/ptrace/ptrace04.c	2009-12-11 18:28:34.903140324 +0800
@@ -46,6 +46,23 @@
 
 int TST_TOTAL = 2;
 
+/*
+ *cleanup() -  performs all ONE TIME cleanup for this test at
+ *		completion or premature exit.
+ */
+void cleanup()
+{
+
+	/*
+	 * print timing stats if that option was specified.
+	 * print errno log if that option was specified.
+	 */
+	TEST_CLEANUP;
+
+	/* exit with return code appropriate for results */
+	tst_exit();
+}				/* End cleanup() */
+
 void compare_registers(unsigned char poison)
 {
 #ifdef HAVE_STRUCT_PTRACE_REGS

------=_Part_8107_432322952.1260531001514
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev

------=_Part_8107_432322952.1260531001514
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_8107_432322952.1260531001514--

