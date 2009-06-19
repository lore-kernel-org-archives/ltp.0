Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MHdiT-00069N-EY
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 13:01:13 +0000
Received: from mail-yx0-f202.google.com ([209.85.210.202])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHdiN-0000uH-3J
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 13:01:13 +0000
Received: by yxe40 with SMTP id 40so286308yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 19 Jun 2009 06:00:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810906171321m79953178gd0505c6deb5dc3d3@mail.gmail.com>
References: <f5a7b3810906171321m79953178gd0505c6deb5dc3d3@mail.gmail.com>
Date: Fri, 19 Jun 2009 18:29:42 +0530
Message-ID: <f5a7b3810906190559o6a8e665bt4408bf9d06bc635a@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd403fa11cd68046cb31965
Subject: Re: [LTP] [FIX PATCH] ltp-set_tid_address
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
Cc: maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>, Oleg Nesterov <oleg@redhat.com>, rohit.170309@gmail.com

--000e0cd403fa11cd68046cb31965
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your review comments.
I have attached and placed below the latest patch.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
diff -Naurb a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
--- a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c	2009-05=
-22
00:03:24.000000000 +0530
+++ b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c	2009-06=
-19
17:56:46.000000000 +0530
@@ -109,7 +109,6 @@

 int main(int ac, char **av) {
         int newtid =3D -1;
-        int result;
         int lc;                 /* loop counter */
         char *msg;              /* message returned from parse_opts */
 =09
@@ -125,9 +124,9 @@
         for (lc =3D 0; TEST_LOOPING(lc); ++lc) {
                 Tst_count =3D 0;
                 for (testno =3D 0; testno < TST_TOTAL; ++testno) {
-                     TEST(result =3D syscall(258, &newtid));     //call
set_tid_address()
+                     TEST(syscall(__NR_set_tid_address, &newtid));
 //call set_tid_address()
                      if(TEST_RETURN =3D=3D getpid()) {
-        		tst_resm(TPASS, "set_tid_address call succeeded: result =3D
%d (expected %d)",TEST_RETURN, result);
+        		tst_resm(TPASS, "set_tid_address call succeeded:  as
expected %d",TEST_RETURN);
                      }
                      else {
                  	   tst_resm(TFAIL, "%s failed - errno =3D %d : %s",
TCID, TEST_ERRNO, strerror(TEST_ERRNO));





On Thu, Jun 18, 2009 at 1:51 AM, naresh kamboju<naresh.kernel@gmail.com> wr=
ote:
> Hi,
>
> I have noticed fail and fixed.
> 1. set_tid_address01.c
>
>
> Please find the patch below and as attachment.
>
> Best regards
> Naresh Kamboju
>
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>
>
> diff -Naurb a/testcases/kernel/syscalls/set_tid_address/set_tid_address01=
.c
> b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
> --- a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c =A0 =
=A0 2009-05-22
> 00:03:24.000000000 +0530
> +++ b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c =A0 =
=A0 2009-06-17
> 23:18:57.000000000 +0530
> @@ -125,7 +125,7 @@
> =A0 =A0 =A0 =A0 for (lc =3D 0; TEST_LOOPING(lc); ++lc) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Tst_count =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (testno =3D 0; testno < TST_TOTAL; ++=
testno) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(258, &n=
ewtid)); =A0 =A0 //call
> set_tid_address()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(__NR_se=
t_tid_address,
> &newtid)); =A0 =A0 //call set_tid_address()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D getpid()=
) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TPASS, "set_tid_a=
ddress call succeeded: result =3D
> %d (expected %d)",TEST_RETURN, result);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>

--000e0cd403fa11cd68046cb31965
Content-Type: application/octet-stream; name="ltp-fix-set_tid_address.patch"
Content-Disposition: attachment; filename="ltp-fix-set_tid_address.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw4wqohg1

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldF90aWRfYWRkcmVzcy9z
ZXRfdGlkX2FkZHJlc3MwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRfdGlkX2Fk
ZHJlc3Mvc2V0X3RpZF9hZGRyZXNzMDEuYwotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3NldF90aWRfYWRkcmVzcy9zZXRfdGlkX2FkZHJlc3MwMS5jCTIwMDktMDUtMjIgMDA6MDM6MjQu
MDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0X3RpZF9h
ZGRyZXNzL3NldF90aWRfYWRkcmVzczAxLmMJMjAwOS0wNi0xOSAxNzo1Njo0Ni4wMDAwMDAwMDAg
KzA1MzAKQEAgLTEwOSw3ICsxMDksNiBAQAogCiBpbnQgbWFpbihpbnQgYWMsIGNoYXIgKiphdikg
ewogICAgICAgICBpbnQgbmV3dGlkID0gLTE7Ci0gICAgICAgIGludCByZXN1bHQ7CiAgICAgICAg
IGludCBsYzsgICAgICAgICAgICAgICAgIC8qIGxvb3AgY291bnRlciAqLwogICAgICAgICBjaGFy
ICptc2c7ICAgICAgICAgICAgICAvKiBtZXNzYWdlIHJldHVybmVkIGZyb20gcGFyc2Vfb3B0cyAq
LwogCQpAQCAtMTI1LDkgKzEyNCw5IEBACiAgICAgICAgIGZvciAobGMgPSAwOyBURVNUX0xPT1BJ
TkcobGMpOyArK2xjKSB7CiAgICAgICAgICAgICAgICAgVHN0X2NvdW50ID0gMDsKICAgICAgICAg
ICAgICAgICBmb3IgKHRlc3RubyA9IDA7IHRlc3RubyA8IFRTVF9UT1RBTDsgKyt0ZXN0bm8pIHsK
LSAgICAgICAgICAgICAgICAgICAgIFRFU1QocmVzdWx0ID0gc3lzY2FsbCgyNTgsICZuZXd0aWQp
KTsgICAgIC8vY2FsbCBzZXRfdGlkX2FkZHJlc3MoKQorICAgICAgICAgICAgICAgICAgICAgVEVT
VChzeXNjYWxsKF9fTlJfc2V0X3RpZF9hZGRyZXNzLCAmbmV3dGlkKSk7ICAgICAvL2NhbGwgc2V0
X3RpZF9hZGRyZXNzKCkKICAgICAgICAgICAgICAgICAgICAgIGlmKFRFU1RfUkVUVVJOID09IGdl
dHBpZCgpKSB7Ci0gICAgICAgIAkJdHN0X3Jlc20oVFBBU1MsICJzZXRfdGlkX2FkZHJlc3MgY2Fs
bCBzdWNjZWVkZWQ6IHJlc3VsdCA9ICVkIChleHBlY3RlZCAlZCkiLFRFU1RfUkVUVVJOLCByZXN1
bHQpOworICAgICAgICAJCXRzdF9yZXNtKFRQQVNTLCAic2V0X3RpZF9hZGRyZXNzIGNhbGwgc3Vj
Y2VlZGVkOiAgYXMgZXhwZWN0ZWQgJWQiLFRFU1RfUkVUVVJOKTsKICAgICAgICAgICAgICAgICAg
ICAgIH0KICAgICAgICAgICAgICAgICAgICAgIGVsc2UgewogICAgICAgICAgICAgICAgICAJICAg
dHN0X3Jlc20oVEZBSUwsICIlcyBmYWlsZWQgLSBlcnJubyA9ICVkIDogJXMiLCBUQ0lELCBURVNU
X0VSUk5PLCBzdHJlcnJvcihURVNUX0VSUk5PKSk7Cg==
--000e0cd403fa11cd68046cb31965
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--000e0cd403fa11cd68046cb31965
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd403fa11cd68046cb31965--

