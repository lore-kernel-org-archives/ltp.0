Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MHdio-0001MB-D9
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 13:01:34 +0000
Received: from mail-gx0-f207.google.com ([209.85.217.207])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHdik-0001C7-IT
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 13:01:34 +0000
Received: by gxk3 with SMTP id 3so6685066gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 19 Jun 2009 06:01:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810906171321n33d0ce4dp3252112a9475449d@mail.gmail.com>
References: <f5a7b3810906171321n33d0ce4dp3252112a9475449d@mail.gmail.com>
Date: Fri, 19 Jun 2009 18:31:30 +0530
Message-ID: <f5a7b3810906190601s1e6574bagf8e354628f5b3808@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f12987d37e5046cb31f87
Subject: Re: [LTP] [FIX PATCH] ltp-set_thread_area
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

--001e680f12987d37e5046cb31f87
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your review comments.
I have attached and placed below the latest patch.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
--- a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c	2009-05=
-22
00:00:29.000000000 +0530
+++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c	2009-06=
-19
17:49:41.000000000 +0530
@@ -123,7 +123,6 @@
 int main(int ac, char **av) {

 	struct user_desc u_info;
-        int result;
         int lc;                 /* loop counter */
         char *msg;              /* message returned from parse_opts */
 =09
@@ -145,7 +144,7 @@
          * This call to get_thread_area function should be sucessful.
          */

-                     TEST(result =3D syscall(244, &u_info));     //call
get_thread_area()
+                     TEST(syscall(__NR_get_thread_area, &u_info));
 //call get_thread_area()
                      if(TEST_RETURN =3D=3D 0) {
         		tst_resm(TPASS, "get_thread_area call succeeded");
                      }
@@ -160,7 +159,7 @@
          * This call to set_thread_area function should be sucessful.
          */

-                     TEST(result =3D syscall(243, &u_info));     //call
set_thread_area()
+                     TEST(result =3D syscall(__NR_set_thread_area,
&u_info));     //call set_thread_area()
                      if(TEST_RETURN =3D=3D 0) {
         		tst_resm(TPASS, "set_thread_area call succeeded");
                      }
diff -Naurb a/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c
b/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c
--- a/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c	2009-05=
-22
00:01:38.000000000 +0530
+++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c	2009-06=
-19
17:45:36.000000000 +0530
@@ -124,7 +124,6 @@
 int main(int ac, char **av) {

 	struct user_desc u_info;
-        int result;
         int lc;                 /* loop counter */
         char *msg;              /* message returned from parse_opts */
 =09
@@ -146,7 +145,7 @@
          * This call to get_thread_area function should be sucessful.
          */

-                     TEST(result =3D syscall(244, &u_info));     //call
get_thread_area()
+                     TEST(syscall(__NR_get_thread_area, &u_info));
 //call get_thread_area()
                      if(TEST_RETURN =3D=3D -1) {
                  	   tst_resm(TFAIL, "call get_thraed_area() failed
with errno =3D %d ", TEST_ERRNO, strerror(TEST_ERRNO));
                            cleanup();
@@ -158,13 +157,13 @@
          * This call to set_thread_area function with invalid
entry_number should be FAILED.
          */

-                     TEST(result =3D syscall(243, &u_info));     //call
set_thread_area()
+                     TEST(syscall(__NR_set_thread_area, &u_info));
 //call set_thread_area()
                      if(TEST_RETURN =3D=3D -1) {
 			if(TEST_ERRNO =3D=3D EINVAL){
-				tst_resm(TPASS, "Call to set_thread_area call failed with invalid
entry_number result =3D %d (expected EINVAL)",TEST_ERRNO);
+				tst_resm(TPASS, "Call to set_thread_area call failed with invalid
entry_number  errno =3D %d (expected EINVAL)",TEST_ERRNO);
 			 }
 			 else {
-                 	  	  tst_resm(TPASS,"Call to set_thread_area with
invalid entry_number got unexpected result =3D %d (expected
EINVAL)",TEST_ERRNO);
+                 	  	  tst_resm(TFAIL,"Call to set_thread_area with
invalid entry_number got unexpected errno =3D %d (expected
EINVAL)",TEST_ERRNO);
 		               }
 		     }
 		     else {
@@ -177,13 +176,13 @@
          * This call to set_thread_area function with an invalid
pointer should be FAILED with EFAULT.
          */

-                     TEST(result =3D syscall(243,(struct user_desc
*)-9));     //call set_thread_area()
+                     TEST(syscall(__NR_set_thread_area,(struct
user_desc *)-9));     //call set_thread_area()
                      if(TEST_RETURN =3D=3D -1) {
 			if(TEST_ERRNO =3D=3D EFAULT){
-				tst_resm(TPASS, "Call to set_thread_area call with invalid
entry_number result =3D %d (got expected error EFAULT)",TEST_ERRNO);
+				tst_resm(TPASS, "Call to set_thread_area call with invalid
entry_number errno =3D %d (got expected error EFAULT)",TEST_ERRNO);
 			 }
 			 else {
-                 	  	  tst_resm(TPASS,"Call to set_thread_area with
invalid entry_number got unexpected result =3D %d (expected
EFAULT)",TEST_ERRNO);
+                 	  	  tst_resm(TFAIL,"Call to set_thread_area with
invalid entry_number got unexpected errno =3D %d (expected
EFAULT)",TEST_ERRNO);
 		               }
 		     }
 		     else {



On Thu, Jun 18, 2009 at 1:51 AM, naresh kamboju<naresh.kernel@gmail.com> wr=
ote:
> Hi,
>
> I have noticed following failures and fixed.
> 1. set_tid_address01.c
> 2. set_tid_address02.c
>
>
> Please find the patch below and as attachment.
>
> Best regards
> Naresh Kamboju
>
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
> diff -Naurb a/testcases/kernel/syscalls/set_thread_area/set_thread_area01=
.c
> b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
> --- a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c =A0 =
=A0 2009-05-22
> 00:00:29.000000000 +0530
> +++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c =A0 =
=A0 2009-06-17
> 23:13:22.000000000 +0530
> @@ -145,7 +145,7 @@
> =A0 =A0 =A0 =A0 =A0* This call to get_thread_area function should be suce=
ssful.
> =A0 =A0 =A0 =A0 =A0*/
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(244, &u=
_info)); =A0 =A0 //call
> get_thread_area()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(__NR_ge=
t_thread_area,
> &u_info)); =A0 =A0 //call get_thread_area()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TPASS, "get_threa=
d_area call succeeded");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -160,7 +160,7 @@
> =A0 =A0 =A0 =A0 =A0* This call to set_thread_area function should be suce=
ssful.
> =A0 =A0 =A0 =A0 =A0*/
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(243, &u=
_info)); =A0 =A0 //call
> set_thread_area()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(__NR_se=
t_thread_area,
> &u_info)); =A0 =A0 //call set_thread_area()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TPASS, "set_threa=
d_area call succeeded");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> diff -Naurb a/testcases/kernel/syscalls/set_thread_area/set_thread_area02=
.c
> b/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c
> --- a/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c =A0 =
=A0 2009-05-22
> 00:01:38.000000000 +0530
> +++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c =A0 =
=A0 2009-06-17
> 23:34:04.000000000 +0530
> @@ -146,7 +146,7 @@
> =A0 =A0 =A0 =A0 =A0* This call to get_thread_area function should be suce=
ssful.
> =A0 =A0 =A0 =A0 =A0*/
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(244, &u=
_info)); =A0 =A0 //call
> get_thread_area()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(__NR_ge=
t_thread_area,
> &u_info)); =A0 =A0 //call get_thread_area()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "call=
 get_thraed_area() failed
> with errno =3D %d ", TEST_ERRNO, strerror(TEST_ERRNO));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cleanup();
> @@ -158,7 +158,7 @@
> =A0 =A0 =A0 =A0 =A0* This call to set_thread_area function with invalid
> entry_number should be FAILED.
> =A0 =A0 =A0 =A0 =A0*/
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(243, &u=
_info)); =A0 =A0 //call
> set_thread_area()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(__NR_se=
t_thread_area,
> &u_info)); =A0 =A0 //call set_thread_area()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_ERRNO =3D=3D EINVA=
L){
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(T=
PASS, "Call to set_thread_area call failed with invalid
> entry_number result =3D %d (expected EINVAL)",TEST_ERRNO);
> @@ -177,7 +177,7 @@
> =A0 =A0 =A0 =A0 =A0* This call to set_thread_area function with an invali=
d
> pointer should be FAILED with EFAULT.
> =A0 =A0 =A0 =A0 =A0*/
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(243,(st=
ruct user_desc
> *)-9)); =A0 =A0 //call set_thread_area()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D
> syscall(__NR_set_thread_area,(struct user_desc *)-9)); =A0 =A0 //call
> set_thread_area()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_ERRNO =3D=3D EFAUL=
T){
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(T=
PASS, "Call to set_thread_area call with invalid
> entry_number result =3D %d (got expected error EFAULT)",TEST_ERRNO);
>

--001e680f12987d37e5046cb31f87
Content-Type: application/octet-stream; name="ltp-fix-set_thread_area.patch"
Content-Disposition: attachment; filename="ltp-fix-set_thread_area.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw4wt9nz1

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldF90aHJlYWRfYXJlYS9z
ZXRfdGhyZWFkX2FyZWEwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRfdGhyZWFk
X2FyZWEvc2V0X3RocmVhZF9hcmVhMDEuYwotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3NldF90aHJlYWRfYXJlYS9zZXRfdGhyZWFkX2FyZWEwMS5jCTIwMDktMDUtMjIgMDA6MDA6Mjku
MDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0X3RocmVh
ZF9hcmVhL3NldF90aHJlYWRfYXJlYTAxLmMJMjAwOS0wNi0xOSAxNzo0OTo0MS4wMDAwMDAwMDAg
KzA1MzAKQEAgLTEyMyw3ICsxMjMsNiBAQAogaW50IG1haW4oaW50IGFjLCBjaGFyICoqYXYpIHsK
ICAgICAgICAgCiAJc3RydWN0IHVzZXJfZGVzYyB1X2luZm87Ci0gICAgICAgIGludCByZXN1bHQ7
CiAgICAgICAgIGludCBsYzsgICAgICAgICAgICAgICAgIC8qIGxvb3AgY291bnRlciAqLwogICAg
ICAgICBjaGFyICptc2c7ICAgICAgICAgICAgICAvKiBtZXNzYWdlIHJldHVybmVkIGZyb20gcGFy
c2Vfb3B0cyAqLwogCQpAQCAtMTQ1LDcgKzE0NCw3IEBACiAgICAgICAgICAqIFRoaXMgY2FsbCB0
byBnZXRfdGhyZWFkX2FyZWEgZnVuY3Rpb24gc2hvdWxkIGJlIHN1Y2Vzc2Z1bC4KICAgICAgICAg
ICovCiAKLSAgICAgICAgICAgICAgICAgICAgIFRFU1QocmVzdWx0ID0gc3lzY2FsbCgyNDQsICZ1
X2luZm8pKTsgICAgIC8vY2FsbCBnZXRfdGhyZWFkX2FyZWEoKQorICAgICAgICAgICAgICAgICAg
ICAgVEVTVChzeXNjYWxsKF9fTlJfZ2V0X3RocmVhZF9hcmVhLCAmdV9pbmZvKSk7ICAgICAvL2Nh
bGwgZ2V0X3RocmVhZF9hcmVhKCkKICAgICAgICAgICAgICAgICAgICAgIGlmKFRFU1RfUkVUVVJO
ID09IDApIHsKICAgICAgICAgCQl0c3RfcmVzbShUUEFTUywgImdldF90aHJlYWRfYXJlYSBjYWxs
IHN1Y2NlZWRlZCIpOwogICAgICAgICAgICAgICAgICAgICAgfQpAQCAtMTYwLDcgKzE1OSw3IEBA
CiAgICAgICAgICAqIFRoaXMgY2FsbCB0byBzZXRfdGhyZWFkX2FyZWEgZnVuY3Rpb24gc2hvdWxk
IGJlIHN1Y2Vzc2Z1bC4KICAgICAgICAgICovCiAKLSAgICAgICAgICAgICAgICAgICAgIFRFU1Qo
cmVzdWx0ID0gc3lzY2FsbCgyNDMsICZ1X2luZm8pKTsgICAgIC8vY2FsbCBzZXRfdGhyZWFkX2Fy
ZWEoKQorICAgICAgICAgICAgICAgICAgICAgVEVTVChyZXN1bHQgPSBzeXNjYWxsKF9fTlJfc2V0
X3RocmVhZF9hcmVhLCAmdV9pbmZvKSk7ICAgICAvL2NhbGwgc2V0X3RocmVhZF9hcmVhKCkKICAg
ICAgICAgICAgICAgICAgICAgIGlmKFRFU1RfUkVUVVJOID09IDApIHsKICAgICAgICAgCQl0c3Rf
cmVzbShUUEFTUywgInNldF90aHJlYWRfYXJlYSBjYWxsIHN1Y2NlZWRlZCIpOwogICAgICAgICAg
ICAgICAgICAgICAgfQpkaWZmIC1OYXVyYiBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0
X3RocmVhZF9hcmVhL3NldF90aHJlYWRfYXJlYTAyLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3NldF90aHJlYWRfYXJlYS9zZXRfdGhyZWFkX2FyZWEwMi5jCi0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvc2V0X3RocmVhZF9hcmVhL3NldF90aHJlYWRfYXJlYTAyLmMJMjAwOS0w
NS0yMiAwMDowMTozOC4wMDAwMDAwMDAgKzA1MzAKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9zZXRfdGhyZWFkX2FyZWEvc2V0X3RocmVhZF9hcmVhMDIuYwkyMDA5LTA2LTE5IDE3OjQ1
OjM2LjAwMDAwMDAwMCArMDUzMApAQCAtMTI0LDcgKzEyNCw2IEBACiBpbnQgbWFpbihpbnQgYWMs
IGNoYXIgKiphdikgewogICAgICAgICAKIAlzdHJ1Y3QgdXNlcl9kZXNjIHVfaW5mbzsKLSAgICAg
ICAgaW50IHJlc3VsdDsKICAgICAgICAgaW50IGxjOyAgICAgICAgICAgICAgICAgLyogbG9vcCBj
b3VudGVyICovCiAgICAgICAgIGNoYXIgKm1zZzsgICAgICAgICAgICAgIC8qIG1lc3NhZ2UgcmV0
dXJuZWQgZnJvbSBwYXJzZV9vcHRzICovCiAJCkBAIC0xNDYsNyArMTQ1LDcgQEAKICAgICAgICAg
ICogVGhpcyBjYWxsIHRvIGdldF90aHJlYWRfYXJlYSBmdW5jdGlvbiBzaG91bGQgYmUgc3VjZXNz
ZnVsLgogICAgICAgICAgKi8KIAotICAgICAgICAgICAgICAgICAgICAgVEVTVChyZXN1bHQgPSBz
eXNjYWxsKDI0NCwgJnVfaW5mbykpOyAgICAgLy9jYWxsIGdldF90aHJlYWRfYXJlYSgpCisgICAg
ICAgICAgICAgICAgICAgICBURVNUKHN5c2NhbGwoX19OUl9nZXRfdGhyZWFkX2FyZWEsICZ1X2lu
Zm8pKTsgICAgIC8vY2FsbCBnZXRfdGhyZWFkX2FyZWEoKQogICAgICAgICAgICAgICAgICAgICAg
aWYoVEVTVF9SRVRVUk4gPT0gLTEpIHsKICAgICAgICAgICAgICAgICAgCSAgIHRzdF9yZXNtKFRG
QUlMLCAiY2FsbCBnZXRfdGhyYWVkX2FyZWEoKSBmYWlsZWQgd2l0aCBlcnJubyA9ICVkICIsIFRF
U1RfRVJSTk8sIHN0cmVycm9yKFRFU1RfRVJSTk8pKTsKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNsZWFudXAoKTsKQEAgLTE1OCwxMyArMTU3LDEzIEBACiAgICAgICAgICAqIFRoaXMgY2Fs
bCB0byBzZXRfdGhyZWFkX2FyZWEgZnVuY3Rpb24gd2l0aCBpbnZhbGlkIGVudHJ5X251bWJlciBz
aG91bGQgYmUgRkFJTEVELgogICAgICAgICAgKi8KIAotICAgICAgICAgICAgICAgICAgICAgVEVT
VChyZXN1bHQgPSBzeXNjYWxsKDI0MywgJnVfaW5mbykpOyAgICAgLy9jYWxsIHNldF90aHJlYWRf
YXJlYSgpCisgICAgICAgICAgICAgICAgICAgICBURVNUKHN5c2NhbGwoX19OUl9zZXRfdGhyZWFk
X2FyZWEsICZ1X2luZm8pKTsgICAgIC8vY2FsbCBzZXRfdGhyZWFkX2FyZWEoKQogICAgICAgICAg
ICAgICAgICAgICAgaWYoVEVTVF9SRVRVUk4gPT0gLTEpIHsKIAkJCWlmKFRFU1RfRVJSTk8gPT0g
RUlOVkFMKXsKLQkJCQl0c3RfcmVzbShUUEFTUywgIkNhbGwgdG8gc2V0X3RocmVhZF9hcmVhIGNh
bGwgZmFpbGVkIHdpdGggaW52YWxpZCBlbnRyeV9udW1iZXIgcmVzdWx0ID0gJWQgKGV4cGVjdGVk
IEVJTlZBTCkiLFRFU1RfRVJSTk8pOworCQkJCXRzdF9yZXNtKFRQQVNTLCAiQ2FsbCB0byBzZXRf
dGhyZWFkX2FyZWEgY2FsbCBmYWlsZWQgd2l0aCBpbnZhbGlkIGVudHJ5X251bWJlciAgZXJybm8g
PSAlZCAoZXhwZWN0ZWQgRUlOVkFMKSIsVEVTVF9FUlJOTyk7CiAJCQkgfQogCQkJIGVsc2Ugewot
ICAgICAgICAgICAgICAgICAJICAJICB0c3RfcmVzbShUUEFTUywiQ2FsbCB0byBzZXRfdGhyZWFk
X2FyZWEgd2l0aCBpbnZhbGlkIGVudHJ5X251bWJlciBnb3QgdW5leHBlY3RlZCByZXN1bHQgPSAl
ZCAoZXhwZWN0ZWQgRUlOVkFMKSIsVEVTVF9FUlJOTyk7CisgICAgICAgICAgICAgICAgIAkgIAkg
IHRzdF9yZXNtKFRGQUlMLCJDYWxsIHRvIHNldF90aHJlYWRfYXJlYSB3aXRoIGludmFsaWQgZW50
cnlfbnVtYmVyIGdvdCB1bmV4cGVjdGVkIGVycm5vID0gJWQgKGV4cGVjdGVkIEVJTlZBTCkiLFRF
U1RfRVJSTk8pOwogCQkgICAgICAgICAgICAgICB9CiAJCSAgICAgfQogCQkgICAgIGVsc2UgewpA
QCAtMTc3LDEzICsxNzYsMTMgQEAKICAgICAgICAgICogVGhpcyBjYWxsIHRvIHNldF90aHJlYWRf
YXJlYSBmdW5jdGlvbiB3aXRoIGFuIGludmFsaWQgcG9pbnRlciBzaG91bGQgYmUgRkFJTEVEIHdp
dGggRUZBVUxULgogICAgICAgICAgKi8KIAotICAgICAgICAgICAgICAgICAgICAgVEVTVChyZXN1
bHQgPSBzeXNjYWxsKDI0Mywoc3RydWN0IHVzZXJfZGVzYyAqKS05KSk7ICAgICAvL2NhbGwgc2V0
X3RocmVhZF9hcmVhKCkKKyAgICAgICAgICAgICAgICAgICAgIFRFU1Qoc3lzY2FsbChfX05SX3Nl
dF90aHJlYWRfYXJlYSwoc3RydWN0IHVzZXJfZGVzYyAqKS05KSk7ICAgICAvL2NhbGwgc2V0X3Ro
cmVhZF9hcmVhKCkKICAgICAgICAgICAgICAgICAgICAgIGlmKFRFU1RfUkVUVVJOID09IC0xKSB7
CiAJCQlpZihURVNUX0VSUk5PID09IEVGQVVMVCl7Ci0JCQkJdHN0X3Jlc20oVFBBU1MsICJDYWxs
IHRvIHNldF90aHJlYWRfYXJlYSBjYWxsIHdpdGggaW52YWxpZCBlbnRyeV9udW1iZXIgcmVzdWx0
ID0gJWQgKGdvdCBleHBlY3RlZCBlcnJvciBFRkFVTFQpIixURVNUX0VSUk5PKTsKKwkJCQl0c3Rf
cmVzbShUUEFTUywgIkNhbGwgdG8gc2V0X3RocmVhZF9hcmVhIGNhbGwgd2l0aCBpbnZhbGlkIGVu
dHJ5X251bWJlciBlcnJubyA9ICVkIChnb3QgZXhwZWN0ZWQgZXJyb3IgRUZBVUxUKSIsVEVTVF9F
UlJOTyk7CiAJCQkgfQogCQkJIGVsc2UgewotICAgICAgICAgICAgICAgICAJICAJICB0c3RfcmVz
bShUUEFTUywiQ2FsbCB0byBzZXRfdGhyZWFkX2FyZWEgd2l0aCBpbnZhbGlkIGVudHJ5X251bWJl
ciBnb3QgdW5leHBlY3RlZCByZXN1bHQgPSAlZCAoZXhwZWN0ZWQgRUZBVUxUKSIsVEVTVF9FUlJO
Tyk7CisgICAgICAgICAgICAgICAgIAkgIAkgIHRzdF9yZXNtKFRGQUlMLCJDYWxsIHRvIHNldF90
aHJlYWRfYXJlYSB3aXRoIGludmFsaWQgZW50cnlfbnVtYmVyIGdvdCB1bmV4cGVjdGVkIGVycm5v
ID0gJWQgKGV4cGVjdGVkIEVGQVVMVCkiLFRFU1RfRVJSTk8pOwogCQkgICAgICAgICAgICAgICB9
CiAJCSAgICAgfQogCQkgICAgIGVsc2Ugewo=
--001e680f12987d37e5046cb31f87
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
--001e680f12987d37e5046cb31f87
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f12987d37e5046cb31f87--

