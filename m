Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NnFtc-0000ak-B2
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 18:35:40 +0000
Received: from mail-pz0-f194.google.com ([209.85.222.194])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NnFtb-0003rg-7x
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 18:35:40 +0000
Received: by pzk32 with SMTP id 32so836289pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 04 Mar 2010 10:35:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B8F716E.5070207@cn.fujitsu.com>
References: <4B7BA24F.2010705@linux.vnet.ibm.com>
	<364299f41002170910i336abf6eh72acbcbec9b72e7b@mail.gmail.com>
	<20100218042532.GC13013@rishikesh.in.ibm.com>
	<4B822F2E.9030609@cn.fujitsu.com>
	<364299f41002212344v4873843ej986f1b39ec3494df@mail.gmail.com>
	<4B8333ED.5080709@cn.fujitsu.com>
	<364299f41002241718g4be216d1pbec918821b7027b0@mail.gmail.com>
	<4B8F716E.5070207@cn.fujitsu.com>
Date: Thu, 4 Mar 2010 10:35:33 -0800
Message-ID: <364299f41003041035q16412dc7r83e0ecd1cedfb47e@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] sysctl03: sysctl returns EACCES after 2.6.33-rc1
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, ebiederm@xmission.com

On Thu, Mar 4, 2010 at 12:38 AM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
> at 2010-2-25 9:18, Garrett Cooper wrote:
>> On Mon, Feb 22, 2010 at 5:48 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
>>> at 2010-2-22 15:44, Garrett Cooper wrote:
>>>> Ok.. one last thing.
>>>>
>>>> On Sun, Feb 21, 2010 at 11:15 PM, Shi Weihua <shiwh@cn.fujitsu.com> wr=
ote:
>>>>> at 2010-2-18 12:25, Rishikesh K Rajak wrote:
>>>>>> On Wed, Feb 17, 2010 at 09:10:48AM -0800, Garrett Cooper wrote:
>>>>>>> On Wed, Feb 17, 2010 at 12:01 AM, Rishikesh <risrajak@linux.vnet.ib=
m.com> wrote:
>>>>>>>> Hi Shi,
>>>>>>>>
>>>>>>>> Thanks for your patch, still i am finding time to look into your p=
atch.
>>>>>>>> Will reply you soon.
>>>>>>>>
>>>>>>>> http://marc.info/?l=3Dltp-list&m=3D126502355614857&w=3D2
>>>>>>>
>>>>>>> I looked at the patch finally.
>>>>>>
>>>>>> Thanks garret.
>>>>>>>
>>>>>>> Please use TTERRNO instead of strerror(...) for the reported value.
>>>>>>> There's no reason why you should use strerror(...) there as that's
>>>>>>> already done with tst_res(3).
>>>>>>
>>>>>> Shi, can you please incorporate changes which garret has suggested a=
nd
>>>>>> resend the patch again to ltp-list@ .
>>>>>
>>>>> =A0Ok, i recreated the patch based on garret's suggestion.
>>>>>
>>>>> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
>>>>> ---
>>>>> --- testcases/kernel/syscalls/sysctl/sysctl03.c.orig =A0 =A02010-02-2=
2 14:38:26.000000000 -0500
>>>>> +++ testcases/kernel/syscalls/sysctl/sysctl03.c 2010-02-22 15:08:03.0=
00000000 -0500
>>>>> @@ -22,15 +22,18 @@
>>>>> =A0* =A0 =A0 sysctl03.c
>>>>> =A0*
>>>>> =A0* DESCRIPTION
>>>>> - * =A0 =A0 Testcase to check that sysctl(2) sets errno to EPERM corr=
ectly.
>>>>> + * =A0 =A0 Testcase to check that sysctl(2) sets errno to EPERM or E=
ACCES
>>>>> + * =A0 =A0 correctly. But it will return EACCES on kernels that are =
2.6.33-rc1
>>>>> + * =A0 =A0 and higher.
>>>>> =A0*
>>>>> =A0* ALGORITHM
>>>>> =A0* =A0 =A0 a. =A0 =A0 =A0Call sysctl(2) as a root user, and attempt=
 to write data
>>>>> =A0* =A0 =A0 =A0 =A0 =A0 =A0 to the kernel_table[]. Since the table d=
oes not have write
>>>>> - * =A0 =A0 =A0 =A0 =A0 =A0 permissions even for the root, it should =
fail EPERM.
>>>>> + * =A0 =A0 =A0 =A0 =A0 =A0 permissions even for the root, it should =
fail EPERM or EACCES.
>>>>> =A0* =A0 =A0 b. =A0 =A0 =A0Call sysctl(2) as a non-root user, and att=
empt to write data
>>>>> =A0* =A0 =A0 =A0 =A0 =A0 =A0 to the kernel_table[]. Since the table d=
oes not have write
>>>>> - * =A0 =A0 =A0 =A0 =A0 =A0 permission for the regular user, it shoul=
d fail with EPERM.
>>>>> + * =A0 =A0 =A0 =A0 =A0 =A0 permission for the regular user, it shoul=
d fail with EPERM
>>>>> + * =A0 =A0 =A0 =A0 =A0 =A0 or EACCES.
>>>>> =A0*
>>>>> =A0* USAGE: =A0<for command-line>
>>>>> =A0* =A0sysctl03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
>>>>> @@ -43,6 +46,7 @@
>>>>> =A0*
>>>>> =A0* HISTORY
>>>>> =A0* =A0 =A0 07/2001 Ported by Wayne Boyer
>>>>> + * =A0 =A0 02/2010 Updated by shiwh@cn.fujitsu.com
>>>>> =A0*
>>>>> =A0* RESTRICTIONS
>>>>> =A0* =A0 =A0 Test must be run as root.
>>>>> @@ -82,6 +86,7 @@ int main(int ac, char **av)
>>>>> =A0{
>>>>> =A0 =A0 =A0 =A0int lc;
>>>>> =A0 =A0 =A0 =A0char *msg;
>>>>> + =A0 =A0 =A0 int exp_eno;
>>>>>
>>>>> =A0 =A0 =A0 =A0char osname[OSNAMESZ];
>>>>> =A0 =A0 =A0 =A0int osnamelth, status;
>>>>> @@ -96,6 +101,13 @@ int main(int ac, char **av)
>>>>>
>>>>> =A0 =A0 =A0 =A0setup();
>>>>>
>>>>> + =A0 =A0 =A0 if ((tst_kvercmp(2, 6, 32)) <=3D 0){
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exp_eno =3D EPERM;
>>>>> + =A0 =A0 =A0 } else {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exp_eno =3D EACCES;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exp_enos[0] =3D EACCES;
>>>>> + =A0 =A0 =A0 }
>>>>> +
>>>>> =A0 =A0 =A0 =A0TEST_EXP_ENOS(exp_enos);
>>>>>
>>>>> =A0 =A0 =A0 =A0/* check looping state if -i option is given */
>>>>> @@ -114,13 +126,10 @@ int main(int ac, char **av)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST_ERROR_LOG(TEST_ER=
RNO);
>>>>>
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TEST_ERRNO !=3D EPE=
RM) {
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_res=
m(TFAIL,
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0"Expected EPERM (%d), got %d: %s",
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0EPERM, TEST_ERRNO,
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0strerror(TEST_ERRNO));
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TEST_ERRNO !=3D exp=
_eno) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_res=
m(TFAIL|TTERRNO, "Got unxpected error");
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_res=
m(TPASS, "Got expected EPERM error");
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_res=
m(TPASS|TTERRNO, "Got expected error");
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>>>
>>>>> @@ -147,12 +156,10 @@ int main(int ac, char **av)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST_E=
RROR_LOG(TEST_ERRNO);
>>>>>
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TES=
T_ERRNO !=3D EPERM) {
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 tst_resm(TFAIL, "Expected EPERM, got "
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%d", TEST_ERRNO);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TES=
T_ERRNO !=3D exp_eno) {
>>>>
>>>> Why can't this be exp_enos[0] ?
>>>
>>> Using exp_enos[0] is ok. pls check the latest patch in this mail.
>>>
>>>>
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 tst_resm(TFAIL|TTERRNO, "Got unxpected error");
>>>>
>>>> Typo.
>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else=
 {
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 tst_resm(TPASS, "Got expected EPERM "
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0"error");
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 tst_resm(TPASS|TTERRNO, "Got expected error");
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>>>
>>>>>
>>>>> Thank you.
>>>>> - Shi Weihua
>>>>
>>>> =A0 =A0 It always helps to understand what's expected vs unexpected
>>>> without having to look at the source code. Could you please revise the
>>>> tst_resm format strings to be something like the following?
>>>>
>>>> tst_resm (TPASS | TERRNO, "Got expected error (errno =3D %d, ret_code =
=3D
>>>> %d", exp_errno_blah, exp_ret_code_blah);
>>>>
>>>> OR:
>>>>
>>>> tst_resm (TPASS | TERRNO, "Got unexpected error (expected errno =3D %d,
>>>> ret_code =3D %d - got errno =3D %d, ret_code =3D %d", exp_errno_blah,
>>>> exp_ret_code_blah, errno_blah, ret_code_blah);
>>>
>>> ret_code has not been defined in sysctl03.c, i think it's unnecessarily=
 to
>>> import a new parameter. maybe, we can use your macro when it created. ;=
-)
>>>
>>> --- testcases/kernel/syscalls/sysctl/sysctl03.c.orig =A0 =A02010-02-22 =
14:38:26.000000000 -0500
>>> +++ testcases/kernel/syscalls/sysctl/sysctl03.c 2010-02-23 09:35:20.000=
000000 -0500
>>> @@ -22,15 +22,18 @@
>>> =A0* =A0 =A0 sysctl03.c
>>> =A0*
>>> =A0* DESCRIPTION
>>> - * =A0 =A0 Testcase to check that sysctl(2) sets errno to EPERM correc=
tly.
>>> + * =A0 =A0 Testcase to check that sysctl(2) sets errno to EPERM or EAC=
CES
>>> + * =A0 =A0 correctly. But it will return EACCES on kernels that are 2.=
6.33-rc1
>>> + * =A0 =A0 and higher.
>>> =A0*
>>> =A0* ALGORITHM
>>> =A0* =A0 =A0 a. =A0 =A0 =A0Call sysctl(2) as a root user, and attempt t=
o write data
>>> =A0* =A0 =A0 =A0 =A0 =A0 =A0 to the kernel_table[]. Since the table doe=
s not have write
>>> - * =A0 =A0 =A0 =A0 =A0 =A0 permissions even for the root, it should fa=
il EPERM.
>>> + * =A0 =A0 =A0 =A0 =A0 =A0 permissions even for the root, it should fa=
il EPERM or EACCES.
>>> =A0* =A0 =A0 b. =A0 =A0 =A0Call sysctl(2) as a non-root user, and attem=
pt to write data
>>> =A0* =A0 =A0 =A0 =A0 =A0 =A0 to the kernel_table[]. Since the table doe=
s not have write
>>> - * =A0 =A0 =A0 =A0 =A0 =A0 permission for the regular user, it should =
fail with EPERM.
>>> + * =A0 =A0 =A0 =A0 =A0 =A0 permission for the regular user, it should =
fail with EPERM
>>> + * =A0 =A0 =A0 =A0 =A0 =A0 or EACCES.
>>> =A0*
>>> =A0* USAGE: =A0<for command-line>
>>> =A0* =A0sysctl03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
>>> @@ -43,6 +46,7 @@
>>> =A0*
>>> =A0* HISTORY
>>> =A0* =A0 =A0 07/2001 Ported by Wayne Boyer
>>> + * =A0 =A0 02/2010 Updated by shiwh@cn.fujitsu.com
>>> =A0*
>>> =A0* RESTRICTIONS
>>> =A0* =A0 =A0 Test must be run as root.
>>> @@ -96,6 +100,12 @@ int main(int ac, char **av)
>>>
>>> =A0 =A0 =A0 =A0setup();
>>>
>>> + =A0 =A0 =A0 if ((tst_kvercmp(2, 6, 32)) <=3D 0){
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exp_enos[0] =3D EPERM;
>>> + =A0 =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exp_enos[0] =3D EACCES;
>>> + =A0 =A0 =A0 }
>>> +
>>> =A0 =A0 =A0 =A0TEST_EXP_ENOS(exp_enos);
>>>
>>> =A0 =A0 =A0 =A0/* check looping state if -i option is given */
>>> @@ -114,13 +124,12 @@ int main(int ac, char **av)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST_ERROR_LOG(TEST_ERRN=
O);
>>>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TEST_ERRNO !=3D EPERM=
) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(=
TFAIL,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0"Expected EPERM (%d), got %d: %s",
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0EPERM, TEST_ERRNO,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0strerror(TEST_ERRNO));
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TEST_ERRNO !=3D exp_e=
nos[0]) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(=
TFAIL|TTERRNO, "Got unxpected error "
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "(expected error =3D %d)", exp_enos[0]);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(=
TPASS, "Got expected EPERM error");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(=
TPASS|TTERRNO, "Got expected error "
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "(errno =3D %d)", exp_enos[0]);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>
>>> @@ -147,12 +156,12 @@ int main(int ac, char **av)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST_ERR=
OR_LOG(TEST_ERRNO);
>>>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TEST_=
ERRNO !=3D EPERM) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 tst_resm(TFAIL, "Expected EPERM, got "
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0"%d", TEST_ERRNO);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TEST_=
ERRNO !=3D exp_enos[0]) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 tst_resm(TFAIL|TTERRNO, "Got unxpected error "
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 "(expected error =3D %d)", exp_enos[0]);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 tst_resm(TPASS, "Got expected EPERM "
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0"error");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 tst_resm(TPASS|TTERRNO, "Got expected error "
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0"(errno =3D %d)", =A0exp_enos[0]);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> Ok, before I go and commit this, there are two things I need to know
>> (because trusty Google didn't turn up any results for this behavioral
>> change):
>>
>> 1. The change is legitimate.
>> 2. The documentation is up to date, or a bug has been filed for the
>> documentation change.
>>
>> If you can provide these two things, I'll commit the change.
>
> At this time of day, I can not find any documentation about EPERM->EACCES.
> But, i caught the kernel commit which caused ltp bug:
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmitdiff;h=3D26a7034b40ba80f82f64fa251a2cbf49f9971c6a
> Maybe it can help you to judge.

Wow... that's a fair amount of code refactoring and additions to the syscal=
l.

Yes, all of the issues with opening a directory and reading/writing
now apply to sysctl(2), especially if someone attempts to read from a
write-only descriptor, or vice versa.

I hate to do this in such a reactive manner as this should have been
done up front, but the 1) documentation and 2) test need to be
updated. 1) is more key today because I'm not sure how much testing
the developer did before he committed to kernel.org, but without
updated documentation and requirements we can't write proper tests.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
