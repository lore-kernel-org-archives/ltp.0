Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MHWqX-00030w-1t
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 05:41:05 +0000
Received: from mail-gx0-f207.google.com ([209.85.217.207])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHWqV-0002zj-S9
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 05:41:05 +0000
Received: by gxk3 with SMTP id 3so5950290gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Jun 2009 22:41:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1245346315.5041.42.camel@subratamodak.linux.ibm.com>
References: <f5a7b3810906171318v503b0c77l27a5df2f057fb85c@mail.gmail.com>
	<1245346315.5041.42.camel@subratamodak.linux.ibm.com>
Date: Fri, 19 Jun 2009 11:11:03 +0530
Message-ID: <f5a7b3810906182241m5855b255yf16be6faf4de3238@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>, Oleg Nesterov <oleg@redhat.com>, rohit.170309@gmail.com

Hi Subrata,

I will wait for Kamalesh comments.

Thanks for your suggestion.
I thought that [PATCH 00/N] can be used at the time of new test cases
proposed. I have sent [FIX PATCH] that is the reason.

Can we have a different kind of representation for New Test cases and Fix p=
atch.
Or is it a standard?
Please provide me the link for standard.
Your suggestions are welcome :)

Best regards
Naresh Kamboju


On Thu, Jun 18, 2009 at 11:01 PM, Subrata
Modak<subrata@linux.vnet.ibm.com> wrote:
> Great to see you fix these issues and send across the fixes. However, i
> remember Kamalesh working on similar type of fixes.
>
> Lets hear from Kamalesh, whether he has something additional from this
> series of patches, or, some other fixes in each patch apart from what
> you have already provided.
>
> Kamalesh,
>
> Would you like to say something here ?
>
> Another suggestion. Naresh, next time when you send patches pertaining
> to one particular issue observed in several tests, then no. the patches,
> like [PATCH 00/N] to [PATCH N/N].
>
> Regards--
> Subrata
>
> On Thu, 2009-06-18 at 01:48 +0530, naresh kamboju wrote:
>> Hi,
>>
>> I have noticed following failures and fixed.
>> 1. add_key01.c
>> 2. add_key02.c
>>
>>
>> Please find the patch below and as attachment.
>>
>> Best regards
>> Naresh Kamboju
>>
>> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>> diff -Naurb a/testcases/kernel/syscalls/add_key/add_key01.c
>> b/testcases/kernel/syscalls/add_key/add_key01.c
>> --- a/testcases/kernel/syscalls/add_key/add_key01.c =A0 2009-05-21
>> 23:39:37.000000000 +0530
>> +++ b/testcases/kernel/syscalls/add_key/add_key01.c =A0 2009-06-17
>> 23:00:15.000000000 +0530
>> @@ -125,7 +125,7 @@
>> =A0 =A0 =A0 =A0 =A0for (lc =3D 0; TEST_LOOPING(lc); ++lc) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Tst_count =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (testno =3D 0; testno < TST_TOTAL=
; ++testno) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(286, "=
keyring", "wjkey",
>> NULL, 0, KEY_SPEC_THREAD_KEYRING)); =A0 =A0 //call add_key()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(result =3D syscall(__NR_a=
dd_key, "keyring",
>> "wjkey", NULL, 0, KEY_SPEC_THREAD_KEYRING)); =A0 =A0 //call add_key()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(TEST_RETURN !=3D -1) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TPASS, "add_key cal=
l succeeded");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cleanup();
>> @@ -139,4 +139,3 @@
>> =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0 =A0tst_exit();
>> =A0}
>> -
>> diff -Naurb a/testcases/kernel/syscalls/add_key/add_key02.c
>> b/testcases/kernel/syscalls/add_key/add_key02.c
>> --- a/testcases/kernel/syscalls/add_key/add_key02.c =A0 2009-05-21
>> 23:40:50.000000000 +0530
>> +++ b/testcases/kernel/syscalls/add_key/add_key02.c =A0 2009-06-17
>> 23:47:48.000000000 +0530
>> @@ -140,7 +140,7 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (testno =3D 0; testno < TST_TOTAL=
; ++testno) {
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for(i=3D0; i<test_count; i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(syscall(286, test_cases[i=
].type,
>> test_cases[i].desc, test_cases[i].payload, test_cases[i].plen,
>> KEY_SPEC_USER_KEYRING)); =A0 =A0//call add_key()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(syscall(__NR_add_key, tes=
t_cases[i].type,
>> test_cases[i].desc, test_cases[i].payload, test_cases[i].plen,
>> KEY_SPEC_USER_KEYRING)); =A0 =A0//call add_key()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(TEST_RETURN !=3D -1){
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TIN=
FO,"call add_key() with wrong
>> args succeed, but should fail");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fail++;
>> @@ -170,4 +170,3 @@
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0 =A0tst_exit();
>> =A0}
>> -
>
>

---------------------------------------------------------------------------=
---
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing =

server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
