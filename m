Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MHdld-0001b7-Hw
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 13:04:29 +0000
Received: from mail-gx0-f207.google.com ([209.85.217.207])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHdlc-00053s-IX
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 13:04:29 +0000
Received: by gxk3 with SMTP id 3so6691596gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 19 Jun 2009 06:04:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090619091317.GA11782@linux.vnet.ibm.com>
References: <f5a7b3810906171318v503b0c77l27a5df2f057fb85c@mail.gmail.com>
	<1245346315.5041.42.camel@subratamodak.linux.ibm.com>
	<20090619091317.GA11782@linux.vnet.ibm.com>
Date: Fri, 19 Jun 2009 18:27:50 +0530
Message-ID: <f5a7b3810906190557u64aa865ew902f75bdf6c45085@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f12846788af046cb31266
Subject: Re: [LTP] [FIX PATCH] ltp-add_key
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
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>, Oleg Nesterov <oleg@redhat.com>, rohit.170309@gmail.com

--001e680f12846788af046cb31266
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your review comments.
I have attached and placed below the latest patch.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/kernel/syscalls/add_key/add_key01.c
b/testcases/kernel/syscalls/add_key/add_key01.c
--- a/testcases/kernel/syscalls/add_key/add_key01.c	2009-05-21
23:39:37.000000000 +0530
+++ b/testcases/kernel/syscalls/add_key/add_key01.c	2009-06-19
17:36:22.000000000 +0530
@@ -109,7 +109,6 @@
 }

 int main(int ac, char **av) {
-        int result;
         int lc;                 /* loop counter */
         char *msg;              /* message returned from parse_opts */
 =09
@@ -125,7 +124,7 @@
         for (lc =3D 0; TEST_LOOPING(lc); ++lc) {
                 Tst_count =3D 0;
                 for (testno =3D 0; testno < TST_TOTAL; ++testno) {
-                     TEST(result =3D syscall(286, "keyring", "wjkey",
NULL, 0, KEY_SPEC_THREAD_KEYRING));     //call add_key()
+                     TEST(syscall(__NR_add_key, "keyring", "wjkey",
NULL, 0, KEY_SPEC_THREAD_KEYRING));     //call add_key()
                      if(TEST_RETURN !=3D -1) {
         		tst_resm(TPASS, "add_key call succeeded");
                         cleanup();
@@ -139,4 +138,3 @@
         }=09
         tst_exit();
 }
-
diff -Naurb a/testcases/kernel/syscalls/add_key/add_key02.c
b/testcases/kernel/syscalls/add_key/add_key02.c
--- a/testcases/kernel/syscalls/add_key/add_key02.c	2009-05-21
23:40:50.000000000 +0530
+++ b/testcases/kernel/syscalls/add_key/add_key02.c	2009-06-19
17:35:55.000000000 +0530
@@ -140,7 +140,7 @@
                 for (testno =3D 0; testno < TST_TOTAL; ++testno) {

 		for(i=3D0; i<test_count; i++) {
-                	TEST(syscall(286, test_cases[i].type,
test_cases[i].desc, test_cases[i].payload, test_cases[i].plen,
KEY_SPEC_USER_KEYRING));    //call add_key()
+                	TEST(syscall(__NR_add_key, test_cases[i].type,
test_cases[i].desc, test_cases[i].payload, test_cases[i].plen,
KEY_SPEC_USER_KEYRING));    //call add_key()
                 	if(TEST_RETURN !=3D -1){
                         	tst_resm(TINFO,"call add_key() with wrong
args succeed, but should fail");
                         	fail++;
@@ -170,4 +170,3 @@
       }=09
         tst_exit();
 }
-


On Fri, Jun 19, 2009 at 2:43 PM, Kamalesh
Babulal<kamalesh@linux.vnet.ibm.com> wrote:
> * Subrata Modak <subrata@linux.vnet.ibm.com> [2009-06-18 23:01:55]:
>
>> Great to see you fix these issues and send across the fixes. However, i
>> remember Kamalesh working on similar type of fixes.
>>
>> Lets hear from Kamalesh, whether he has something additional from this
>> series of patches, or, some other fixes in each patch apart from what
>> you have already provided.
>>
>> Kamalesh,
>>
>> Would you like to say something here ?
>>
>> Another suggestion. Naresh, next time when you send patches pertaining
>> to one particular issue observed in several tests, then no. the patches,
>> like [PATCH 00/N] to [PATCH N/N].
>
> It could be nice to add a section in ltp-howto on sending patch sets.
>
>>
>> Regards--
>> Subrata
>>
>> On Thu, 2009-06-18 at 01:48 +0530, naresh kamboju wrote:
>> > Hi,
>> >
>> > I have noticed following failures and fixed.
>> > 1. add_key01.c
>> > 2. add_key02.c
>> >
>> >
>> > Please find the patch below and as attachment.
>> >
>> > Best regards
>> > Naresh Kamboju
>> >
>> > Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>> > diff -Naurb a/testcases/kernel/syscalls/add_key/add_key01.c
>> > b/testcases/kernel/syscalls/add_key/add_key01.c
>> > --- a/testcases/kernel/syscalls/add_key/add_key01.c 2009-05-21
>> > 23:39:37.000000000 +0530
>> > +++ b/testcases/kernel/syscalls/add_key/add_key01.c 2009-06-17
>> > 23:00:15.000000000 +0530
>> > @@ -125,7 +125,7 @@
>> > =A0 =A0 =A0 =A0 =A0for (lc =3D 0; TEST_LOOPING(lc); ++lc) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Tst_count =3D 0;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (testno =3D 0; testno < TST_TOT=
AL; ++testno) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(286,=
 "keyring", "wjkey",
>> > NULL, 0, KEY_SPEC_THREAD_KEYRING)); =A0 =A0 //call add_key()
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(__NR=
_add_key, "keyring",
>> > "wjkey", NULL, 0, KEY_SPEC_THREAD_KEYRING)); =A0 =A0 //call add_key()
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(TEST_RETURN !=3D -1) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TPASS, "add_key call =
succeeded");
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cleanup();
>> > @@ -139,4 +139,3 @@
>> > =A0 =A0 =A0 =A0 =A0}
>> > =A0 =A0 =A0 =A0 =A0tst_exit();
>> > =A0}
>> > -
>
> Can you remove the result variable from the TEST() and make similar
> changes to add_keys, set_tid_address, set_thread_area syscalls and
> resubmit the patches.
>
> =A0testcases/kernel/syscalls/add_key/add_key01.c | =A0 =A03 +--
> =A01 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/add_key/add_key01.c b/testcases/ke=
rnel/syscalls/add_key/add_key01.c
> index 67a4c2f..56fbe1a 100644
> --- a/testcases/kernel/syscalls/add_key/add_key01.c
> +++ b/testcases/kernel/syscalls/add_key/add_key01.c
> @@ -109,7 +109,6 @@ void setup() {
> =A0}
>
> =A0int main(int ac, char **av) {
> - =A0 =A0 =A0 =A0int result;
> =A0 =A0 =A0 =A0 int lc; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* loop counter *=
/
> =A0 =A0 =A0 =A0 char *msg; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* message returned=
 from parse_opts */
>
> @@ -125,7 +124,7 @@ int main(int ac, char **av) {
> =A0 =A0 =A0 =A0 for (lc =3D 0; TEST_LOOPING(lc); ++lc) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Tst_count =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (testno =3D 0; testno < TST_TOTAL; ++=
testno) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(286, "k=
eyring", "wjkey", NULL, 0, KEY_SPEC_THREAD_KEYRING)); =A0 =A0 //call add_ke=
y()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(syscall(__NR_add_key, "key=
ring", "wjkey", NULL, 0, KEY_SPEC_THREAD_KEYRING)); =A0 =A0 //call add_key(=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN !=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TPASS, "add_key c=
all succeeded");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleanup();
>
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Kamalesh
>

--001e680f12846788af046cb31266
Content-Type: application/octet-stream; name="ltp-fix-add_key.patch"
Content-Disposition: attachment; filename="ltp-fix-add_key.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw4wmgaj0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2FkZF9rZXkvYWRkX2tleTAx
LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2FkZF9rZXkvYWRkX2tleTAxLmMKLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9hZGRfa2V5L2FkZF9rZXkwMS5jCTIwMDktMDUtMjEg
MjM6Mzk6MzcuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
YWRkX2tleS9hZGRfa2V5MDEuYwkyMDA5LTA2LTE5IDE3OjM2OjIyLjAwMDAwMDAwMCArMDUzMApA
QCAtMTA5LDcgKzEwOSw2IEBACiB9CiAKIGludCBtYWluKGludCBhYywgY2hhciAqKmF2KSB7Ci0g
ICAgICAgIGludCByZXN1bHQ7CiAgICAgICAgIGludCBsYzsgICAgICAgICAgICAgICAgIC8qIGxv
b3AgY291bnRlciAqLwogICAgICAgICBjaGFyICptc2c7ICAgICAgICAgICAgICAvKiBtZXNzYWdl
IHJldHVybmVkIGZyb20gcGFyc2Vfb3B0cyAqLwogCQpAQCAtMTI1LDcgKzEyNCw3IEBACiAgICAg
ICAgIGZvciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyArK2xjKSB7CiAgICAgICAgICAgICAg
ICAgVHN0X2NvdW50ID0gMDsKICAgICAgICAgICAgICAgICBmb3IgKHRlc3RubyA9IDA7IHRlc3Ru
byA8IFRTVF9UT1RBTDsgKyt0ZXN0bm8pIHsKLSAgICAgICAgICAgICAgICAgICAgIFRFU1QocmVz
dWx0ID0gc3lzY2FsbCgyODYsICJrZXlyaW5nIiwgIndqa2V5IiwgTlVMTCwgMCwgS0VZX1NQRUNf
VEhSRUFEX0tFWVJJTkcpKTsgICAgIC8vY2FsbCBhZGRfa2V5KCkKKyAgICAgICAgICAgICAgICAg
ICAgIFRFU1Qoc3lzY2FsbChfX05SX2FkZF9rZXksICJrZXlyaW5nIiwgIndqa2V5IiwgTlVMTCwg
MCwgS0VZX1NQRUNfVEhSRUFEX0tFWVJJTkcpKTsgICAgIC8vY2FsbCBhZGRfa2V5KCkKICAgICAg
ICAgICAgICAgICAgICAgIGlmKFRFU1RfUkVUVVJOICE9IC0xKSB7CiAgICAgICAgIAkJdHN0X3Jl
c20oVFBBU1MsICJhZGRfa2V5IGNhbGwgc3VjY2VlZGVkIik7CiAgICAgICAgICAgICAgICAgICAg
ICAgICBjbGVhbnVwKCk7CkBAIC0xMzksNCArMTM4LDMgQEAKICAgICAgICAgfQkKICAgICAgICAg
dHN0X2V4aXQoKTsKIH0KLQpkaWZmIC1OYXVyYiBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
YWRkX2tleS9hZGRfa2V5MDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvYWRkX2tleS9h
ZGRfa2V5MDIuYwotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2FkZF9rZXkvYWRkX2tl
eTAyLmMJMjAwOS0wNS0yMSAyMzo0MDo1MC4wMDAwMDAwMDAgKzA1MzAKKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9hZGRfa2V5L2FkZF9rZXkwMi5jCTIwMDktMDYtMTkgMTc6MzU6NTUu
MDAwMDAwMDAwICswNTMwCkBAIC0xNDAsNyArMTQwLDcgQEAKICAgICAgICAgICAgICAgICBmb3Ig
KHRlc3RubyA9IDA7IHRlc3RubyA8IFRTVF9UT1RBTDsgKyt0ZXN0bm8pIHsKIAogCQlmb3IoaT0w
OyBpPHRlc3RfY291bnQ7IGkrKykgewotICAgICAgICAgICAgICAgIAlURVNUKHN5c2NhbGwoMjg2
LCB0ZXN0X2Nhc2VzW2ldLnR5cGUsIHRlc3RfY2FzZXNbaV0uZGVzYywgdGVzdF9jYXNlc1tpXS5w
YXlsb2FkLCB0ZXN0X2Nhc2VzW2ldLnBsZW4sIEtFWV9TUEVDX1VTRVJfS0VZUklORykpOyAgICAv
L2NhbGwgYWRkX2tleSgpCisgICAgICAgICAgICAgICAgCVRFU1Qoc3lzY2FsbChfX05SX2FkZF9r
ZXksIHRlc3RfY2FzZXNbaV0udHlwZSwgdGVzdF9jYXNlc1tpXS5kZXNjLCB0ZXN0X2Nhc2VzW2ld
LnBheWxvYWQsIHRlc3RfY2FzZXNbaV0ucGxlbiwgS0VZX1NQRUNfVVNFUl9LRVlSSU5HKSk7ICAg
IC8vY2FsbCBhZGRfa2V5KCkKICAgICAgICAgICAgICAgICAJaWYoVEVTVF9SRVRVUk4gIT0gLTEp
ewogICAgICAgICAgICAgICAgICAgICAgICAgCXRzdF9yZXNtKFRJTkZPLCJjYWxsIGFkZF9rZXko
KSB3aXRoIHdyb25nIGFyZ3Mgc3VjY2VlZCwgYnV0IHNob3VsZCBmYWlsIik7CiAgICAgICAgICAg
ICAgICAgICAgICAgICAJZmFpbCsrOwpAQCAtMTcwLDQgKzE3MCwzIEBACiAgICAgICB9CQogICAg
ICAgICB0c3RfZXhpdCgpOwogfQotCg==
--001e680f12846788af046cb31266
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
--001e680f12846788af046cb31266
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f12846788af046cb31266--

