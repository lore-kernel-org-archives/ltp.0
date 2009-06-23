Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MJ9nv-0006j8-7J
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 17:29:07 +0000
Received: from mail-yx0-f199.google.com ([209.85.210.199])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJ9nl-0007p3-Ab
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 17:29:02 +0000
Received: by yxe37 with SMTP id 37so178699yxe.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Jun 2009 10:28:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810906190601s1e6574bagf8e354628f5b3808@mail.gmail.com>
References: <f5a7b3810906171321n33d0ce4dp3252112a9475449d@mail.gmail.com>
	<f5a7b3810906190601s1e6574bagf8e354628f5b3808@mail.gmail.com>
Date: Tue, 23 Jun 2009 22:58:56 +0530
Message-ID: <f5a7b3810906231028x18342747i84e235d67f1bc2c9@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f12844b5b82046d0753f6
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
Cc: Jiri Palecek <jpalecek@web.de>, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>, Oleg Nesterov <oleg@redhat.com>, rohit.170309@gmail.com

--001e680f12844b5b82046d0753f6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Subrata,

Thanks for your review comments.
please ignore previous patch and consider this latest.
I have attached  and below mail

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
--- a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c	2009-05=
-22
00:00:29.000000000 +0530
+++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c	2009-06=
-23
22:22:38.000000000 +0530
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
+                     TEST(syscall(__NR_set_thread_area, &u_info));
 //call set_thread_area()
                      if(TEST_RETURN =3D=3D 0) {
         		tst_resm(TPASS, "set_thread_area call succeeded");
                      }
diff -Naurb a/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c
b/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c
--- a/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c	2009-05=
-22
00:01:38.000000000 +0530
+++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c	2009-06=
-23
22:20:43.000000000 +0530
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



On Fri, Jun 19, 2009 at 6:31 PM, naresh kamboju<naresh.kernel@gmail.com> wr=
ote:
> Hi,
>
> Thanks for your review comments.
> I have attached and placed below the latest patch.
>
> Best regards
> Naresh Kamboju
>
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>
> diff -Naurb a/testcases/kernel/syscalls/set_thread_area/set_thread_area01=
.c
> b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
> --- a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c =A0 =
=A0 2009-05-22
> 00:00:29.000000000 +0530
> +++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c =A0 =
=A0 2009-06-19
> 17:49:41.000000000 +0530
> @@ -123,7 +123,6 @@
> =A0int main(int ac, char **av) {
>
> =A0 =A0 =A0 =A0struct user_desc u_info;
> - =A0 =A0 =A0 =A0int result;
> =A0 =A0 =A0 =A0 int lc; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* loop counter *=
/
> =A0 =A0 =A0 =A0 char *msg; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* message returned=
 from parse_opts */
>
> @@ -145,7 +144,7 @@
> =A0 =A0 =A0 =A0 =A0* This call to get_thread_area function should be suce=
ssful.
> =A0 =A0 =A0 =A0 =A0*/
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(244, &u=
_info)); =A0 =A0 //call
> get_thread_area()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(syscall(__NR_get_thread_ar=
ea, &u_info));
> =A0//call get_thread_area()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TPASS, "get_threa=
d_area call succeeded");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -160,7 +159,7 @@
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
=A0 2009-06-19
> 17:45:36.000000000 +0530
> @@ -124,7 +124,6 @@
> =A0int main(int ac, char **av) {
>
> =A0 =A0 =A0 =A0struct user_desc u_info;
> - =A0 =A0 =A0 =A0int result;
> =A0 =A0 =A0 =A0 int lc; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* loop counter *=
/
> =A0 =A0 =A0 =A0 char *msg; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* message returned=
 from parse_opts */
>
> @@ -146,7 +145,7 @@
> =A0 =A0 =A0 =A0 =A0* This call to get_thread_area function should be suce=
ssful.
> =A0 =A0 =A0 =A0 =A0*/
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(244, &u=
_info)); =A0 =A0 //call
> get_thread_area()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(syscall(__NR_get_thread_ar=
ea, &u_info));
> =A0//call get_thread_area()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "call=
 get_thraed_area() failed
> with errno =3D %d ", TEST_ERRNO, strerror(TEST_ERRNO));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cleanup();
> @@ -158,13 +157,13 @@
> =A0 =A0 =A0 =A0 =A0* This call to set_thread_area function with invalid
> entry_number should be FAILED.
> =A0 =A0 =A0 =A0 =A0*/
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(243, &u=
_info)); =A0 =A0 //call
> set_thread_area()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(syscall(__NR_set_thread_ar=
ea, &u_info));
> =A0//call set_thread_area()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_ERRNO =3D=3D EINVA=
L){
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TP=
ASS, "Call to set_thread_area call failed with invalid
> entry_number result =3D %d (expected EINVAL)",TEST_ERRNO);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TP=
ASS, "Call to set_thread_area call failed with invalid
> entry_number =A0errno =3D %d (expected EINVAL)",TEST_ERRNO);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_res=
m(TPASS,"Call to set_thread_area with
> invalid entry_number got unexpected result =3D %d (expected
> EINVAL)",TEST_ERRNO);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_res=
m(TFAIL,"Call to set_thread_area with
> invalid entry_number got unexpected errno =3D %d (expected
> EINVAL)",TEST_ERRNO);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> @@ -177,13 +176,13 @@
> =A0 =A0 =A0 =A0 =A0* This call to set_thread_area function with an invali=
d
> pointer should be FAILED with EFAULT.
> =A0 =A0 =A0 =A0 =A0*/
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(243,(st=
ruct user_desc
> *)-9)); =A0 =A0 //call set_thread_area()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(syscall(__NR_set_thread_ar=
ea,(struct
> user_desc *)-9)); =A0 =A0 //call set_thread_area()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_ERRNO =3D=3D EFAUL=
T){
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TP=
ASS, "Call to set_thread_area call with invalid
> entry_number result =3D %d (got expected error EFAULT)",TEST_ERRNO);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TP=
ASS, "Call to set_thread_area call with invalid
> entry_number errno =3D %d (got expected error EFAULT)",TEST_ERRNO);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_res=
m(TPASS,"Call to set_thread_area with
> invalid entry_number got unexpected result =3D %d (expected
> EFAULT)",TEST_ERRNO);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_res=
m(TFAIL,"Call to set_thread_area with
> invalid entry_number got unexpected errno =3D %d (expected
> EFAULT)",TEST_ERRNO);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
>
>
>
> On Thu, Jun 18, 2009 at 1:51 AM, naresh kamboju<naresh.kernel@gmail.com> =
wrote:
>> Hi,
>>
>> I have noticed following failures and fixed.
>> 1. set_tid_address01.c
>> 2. set_tid_address02.c
>>
>>
>> Please find the patch below and as attachment.
>>
>> Best regards
>> Naresh Kamboju
>>
>> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>> diff -Naurb a/testcases/kernel/syscalls/set_thread_area/set_thread_area0=
1.c
>> b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
>> --- a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c =A0 =
=A0 2009-05-22
>> 00:00:29.000000000 +0530
>> +++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c =A0 =
=A0 2009-06-17
>> 23:13:22.000000000 +0530
>> @@ -145,7 +145,7 @@
>> =A0 =A0 =A0 =A0 =A0* This call to get_thread_area function should be suc=
essful.
>> =A0 =A0 =A0 =A0 =A0*/
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(244, &=
u_info)); =A0 =A0 //call
>> get_thread_area()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(__NR_g=
et_thread_area,
>> &u_info)); =A0 =A0 //call get_thread_area()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TPASS, "get_thre=
ad_area call succeeded");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> @@ -160,7 +160,7 @@
>> =A0 =A0 =A0 =A0 =A0* This call to set_thread_area function should be suc=
essful.
>> =A0 =A0 =A0 =A0 =A0*/
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(243, &=
u_info)); =A0 =A0 //call
>> set_thread_area()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(__NR_s=
et_thread_area,
>> &u_info)); =A0 =A0 //call set_thread_area()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TPASS, "set_thre=
ad_area call succeeded");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> diff -Naurb a/testcases/kernel/syscalls/set_thread_area/set_thread_area0=
2.c
>> b/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c
>> --- a/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c =A0 =
=A0 2009-05-22
>> 00:01:38.000000000 +0530
>> +++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c =A0 =
=A0 2009-06-17
>> 23:34:04.000000000 +0530
>> @@ -146,7 +146,7 @@
>> =A0 =A0 =A0 =A0 =A0* This call to get_thread_area function should be suc=
essful.
>> =A0 =A0 =A0 =A0 =A0*/
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(244, &=
u_info)); =A0 =A0 //call
>> get_thread_area()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(__NR_g=
et_thread_area,
>> &u_info)); =A0 =A0 //call get_thread_area()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D -1) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "cal=
l get_thraed_area() failed
>> with errno =3D %d ", TEST_ERRNO, strerror(TEST_ERRNO));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cleanup();
>> @@ -158,7 +158,7 @@
>> =A0 =A0 =A0 =A0 =A0* This call to set_thread_area function with invalid
>> entry_number should be FAILED.
>> =A0 =A0 =A0 =A0 =A0*/
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(243, &=
u_info)); =A0 =A0 //call
>> set_thread_area()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(__NR_s=
et_thread_area,
>> &u_info)); =A0 =A0 //call set_thread_area()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D -1) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_ERRNO =3D=3D EINV=
AL){
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(=
TPASS, "Call to set_thread_area call failed with invalid
>> entry_number result =3D %d (expected EINVAL)",TEST_ERRNO);
>> @@ -177,7 +177,7 @@
>> =A0 =A0 =A0 =A0 =A0* This call to set_thread_area function with an inval=
id
>> pointer should be FAILED with EFAULT.
>> =A0 =A0 =A0 =A0 =A0*/
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(243,(s=
truct user_desc
>> *)-9)); =A0 =A0 //call set_thread_area()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D
>> syscall(__NR_set_thread_area,(struct user_desc *)-9)); =A0 =A0 //call
>> set_thread_area()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D -1) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_ERRNO =3D=3D EFAU=
LT){
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(=
TPASS, "Call to set_thread_area call with invalid
>> entry_number result =3D %d (got expected error EFAULT)",TEST_ERRNO);
>>
>

--001e680f12844b5b82046d0753f6
Content-Type: application/octet-stream; name="ltp-fix-set_thread_area.patch"
Content-Disposition: attachment; filename="ltp-fix-set_thread_area.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwaw1qfg1

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldF90aHJlYWRfYXJlYS9z
ZXRfdGhyZWFkX2FyZWEwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRfdGhyZWFk
X2FyZWEvc2V0X3RocmVhZF9hcmVhMDEuYwotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3NldF90aHJlYWRfYXJlYS9zZXRfdGhyZWFkX2FyZWEwMS5jCTIwMDktMDUtMjIgMDA6MDA6Mjku
MDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0X3RocmVh
ZF9hcmVhL3NldF90aHJlYWRfYXJlYTAxLmMJMjAwOS0wNi0yMyAyMjoyMjozOC4wMDAwMDAwMDAg
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
ZWEoKQorICAgICAgICAgICAgICAgICAgICAgVEVTVChzeXNjYWxsKF9fTlJfc2V0X3RocmVhZF9h
cmVhLCAmdV9pbmZvKSk7ICAgICAvL2NhbGwgc2V0X3RocmVhZF9hcmVhKCkKICAgICAgICAgICAg
ICAgICAgICAgIGlmKFRFU1RfUkVUVVJOID09IDApIHsKICAgICAgICAgCQl0c3RfcmVzbShUUEFT
UywgInNldF90aHJlYWRfYXJlYSBjYWxsIHN1Y2NlZWRlZCIpOwogICAgICAgICAgICAgICAgICAg
ICAgfQpkaWZmIC1OYXVyYiBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0X3RocmVhZF9h
cmVhL3NldF90aHJlYWRfYXJlYTAyLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldF90
aHJlYWRfYXJlYS9zZXRfdGhyZWFkX2FyZWEwMi5jCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvc2V0X3RocmVhZF9hcmVhL3NldF90aHJlYWRfYXJlYTAyLmMJMjAwOS0wNS0yMiAwMDow
MTozOC4wMDAwMDAwMDAgKzA1MzAKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRf
dGhyZWFkX2FyZWEvc2V0X3RocmVhZF9hcmVhMDIuYwkyMDA5LTA2LTIzIDIyOjIwOjQzLjAwMDAw
MDAwMCArMDUzMApAQCAtMTI0LDcgKzEyNCw2IEBACiBpbnQgbWFpbihpbnQgYWMsIGNoYXIgKiph
dikgewogICAgICAgICAKIAlzdHJ1Y3QgdXNlcl9kZXNjIHVfaW5mbzsKLSAgICAgICAgaW50IHJl
c3VsdDsKICAgICAgICAgaW50IGxjOyAgICAgICAgICAgICAgICAgLyogbG9vcCBjb3VudGVyICov
CiAgICAgICAgIGNoYXIgKm1zZzsgICAgICAgICAgICAgIC8qIG1lc3NhZ2UgcmV0dXJuZWQgZnJv
bSBwYXJzZV9vcHRzICovCiAJCkBAIC0xNDYsNyArMTQ1LDcgQEAKICAgICAgICAgICogVGhpcyBj
YWxsIHRvIGdldF90aHJlYWRfYXJlYSBmdW5jdGlvbiBzaG91bGQgYmUgc3VjZXNzZnVsLgogICAg
ICAgICAgKi8KIAotICAgICAgICAgICAgICAgICAgICAgVEVTVChyZXN1bHQgPSBzeXNjYWxsKDI0
NCwgJnVfaW5mbykpOyAgICAgLy9jYWxsIGdldF90aHJlYWRfYXJlYSgpCisgICAgICAgICAgICAg
ICAgICAgICBURVNUKHN5c2NhbGwoX19OUl9nZXRfdGhyZWFkX2FyZWEsICZ1X2luZm8pKTsgICAg
IC8vY2FsbCBnZXRfdGhyZWFkX2FyZWEoKQogICAgICAgICAgICAgICAgICAgICAgaWYoVEVTVF9S
RVRVUk4gPT0gLTEpIHsKICAgICAgICAgICAgICAgICAgCSAgIHRzdF9yZXNtKFRGQUlMLCAiY2Fs
bCBnZXRfdGhyYWVkX2FyZWEoKSBmYWlsZWQgd2l0aCBlcnJubyA9ICVkICIsIFRFU1RfRVJSTk8s
IHN0cmVycm9yKFRFU1RfRVJSTk8pKTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsZWFu
dXAoKTsKQEAgLTE1OCwxMyArMTU3LDEzIEBACiAgICAgICAgICAqIFRoaXMgY2FsbCB0byBzZXRf
dGhyZWFkX2FyZWEgZnVuY3Rpb24gd2l0aCBpbnZhbGlkIGVudHJ5X251bWJlciBzaG91bGQgYmUg
RkFJTEVELgogICAgICAgICAgKi8KIAotICAgICAgICAgICAgICAgICAgICAgVEVTVChyZXN1bHQg
PSBzeXNjYWxsKDI0MywgJnVfaW5mbykpOyAgICAgLy9jYWxsIHNldF90aHJlYWRfYXJlYSgpCisg
ICAgICAgICAgICAgICAgICAgICBURVNUKHN5c2NhbGwoX19OUl9zZXRfdGhyZWFkX2FyZWEsICZ1
X2luZm8pKTsgICAgIC8vY2FsbCBzZXRfdGhyZWFkX2FyZWEoKQogICAgICAgICAgICAgICAgICAg
ICAgaWYoVEVTVF9SRVRVUk4gPT0gLTEpIHsKIAkJCWlmKFRFU1RfRVJSTk8gPT0gRUlOVkFMKXsK
LQkJCQl0c3RfcmVzbShUUEFTUywgIkNhbGwgdG8gc2V0X3RocmVhZF9hcmVhIGNhbGwgZmFpbGVk
IHdpdGggaW52YWxpZCBlbnRyeV9udW1iZXIgcmVzdWx0ID0gJWQgKGV4cGVjdGVkIEVJTlZBTCki
LFRFU1RfRVJSTk8pOworCQkJCXRzdF9yZXNtKFRQQVNTLCAiQ2FsbCB0byBzZXRfdGhyZWFkX2Fy
ZWEgY2FsbCBmYWlsZWQgd2l0aCBpbnZhbGlkIGVudHJ5X251bWJlciAgZXJybm8gPSAlZCAoZXhw
ZWN0ZWQgRUlOVkFMKSIsVEVTVF9FUlJOTyk7CiAJCQkgfQogCQkJIGVsc2UgewotICAgICAgICAg
ICAgICAgICAJICAJICB0c3RfcmVzbShUUEFTUywiQ2FsbCB0byBzZXRfdGhyZWFkX2FyZWEgd2l0
aCBpbnZhbGlkIGVudHJ5X251bWJlciBnb3QgdW5leHBlY3RlZCByZXN1bHQgPSAlZCAoZXhwZWN0
ZWQgRUlOVkFMKSIsVEVTVF9FUlJOTyk7CisgICAgICAgICAgICAgICAgIAkgIAkgIHRzdF9yZXNt
KFRGQUlMLCJDYWxsIHRvIHNldF90aHJlYWRfYXJlYSB3aXRoIGludmFsaWQgZW50cnlfbnVtYmVy
IGdvdCB1bmV4cGVjdGVkIGVycm5vID0gJWQgKGV4cGVjdGVkIEVJTlZBTCkiLFRFU1RfRVJSTk8p
OwogCQkgICAgICAgICAgICAgICB9CiAJCSAgICAgfQogCQkgICAgIGVsc2UgewpAQCAtMTc3LDEz
ICsxNzYsMTMgQEAKICAgICAgICAgICogVGhpcyBjYWxsIHRvIHNldF90aHJlYWRfYXJlYSBmdW5j
dGlvbiB3aXRoIGFuIGludmFsaWQgcG9pbnRlciBzaG91bGQgYmUgRkFJTEVEIHdpdGggRUZBVUxU
LgogICAgICAgICAgKi8KIAotICAgICAgICAgICAgICAgICAgICAgVEVTVChyZXN1bHQgPSBzeXNj
YWxsKDI0Mywoc3RydWN0IHVzZXJfZGVzYyAqKS05KSk7ICAgICAvL2NhbGwgc2V0X3RocmVhZF9h
cmVhKCkKKyAgICAgICAgICAgICAgICAgICAgIFRFU1Qoc3lzY2FsbChfX05SX3NldF90aHJlYWRf
YXJlYSwoc3RydWN0IHVzZXJfZGVzYyAqKS05KSk7ICAgICAvL2NhbGwgc2V0X3RocmVhZF9hcmVh
KCkKICAgICAgICAgICAgICAgICAgICAgIGlmKFRFU1RfUkVUVVJOID09IC0xKSB7CiAJCQlpZihU
RVNUX0VSUk5PID09IEVGQVVMVCl7Ci0JCQkJdHN0X3Jlc20oVFBBU1MsICJDYWxsIHRvIHNldF90
aHJlYWRfYXJlYSBjYWxsIHdpdGggaW52YWxpZCBlbnRyeV9udW1iZXIgcmVzdWx0ID0gJWQgKGdv
dCBleHBlY3RlZCBlcnJvciBFRkFVTFQpIixURVNUX0VSUk5PKTsKKwkJCQl0c3RfcmVzbShUUEFT
UywgIkNhbGwgdG8gc2V0X3RocmVhZF9hcmVhIGNhbGwgd2l0aCBpbnZhbGlkIGVudHJ5X251bWJl
ciBlcnJubyA9ICVkIChnb3QgZXhwZWN0ZWQgZXJyb3IgRUZBVUxUKSIsVEVTVF9FUlJOTyk7CiAJ
CQkgfQogCQkJIGVsc2UgewotICAgICAgICAgICAgICAgICAJICAJICB0c3RfcmVzbShUUEFTUywi
Q2FsbCB0byBzZXRfdGhyZWFkX2FyZWEgd2l0aCBpbnZhbGlkIGVudHJ5X251bWJlciBnb3QgdW5l
eHBlY3RlZCByZXN1bHQgPSAlZCAoZXhwZWN0ZWQgRUZBVUxUKSIsVEVTVF9FUlJOTyk7CisgICAg
ICAgICAgICAgICAgIAkgIAkgIHRzdF9yZXNtKFRGQUlMLCJDYWxsIHRvIHNldF90aHJlYWRfYXJl
YSB3aXRoIGludmFsaWQgZW50cnlfbnVtYmVyIGdvdCB1bmV4cGVjdGVkIGVycm5vID0gJWQgKGV4
cGVjdGVkIEVGQVVMVCkiLFRFU1RfRVJSTk8pOwogCQkgICAgICAgICAgICAgICB9CiAJCSAgICAg
fQogCQkgICAgIGVsc2Ugewo=
--001e680f12844b5b82046d0753f6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--001e680f12844b5b82046d0753f6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f12844b5b82046d0753f6--

