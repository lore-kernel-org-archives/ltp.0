Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NjSxt-0000Oj-DW
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 07:44:25 +0000
Received: from mail-px0-f171.google.com ([209.85.216.171])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NjSxs-0004s3-4f
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 07:44:25 +0000
Received: by pxi1 with SMTP id 1so1372648pxi.23
	for <ltp-list@lists.sourceforge.net>;
	Sun, 21 Feb 2010 23:44:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B822F2E.9030609@cn.fujitsu.com>
References: <4B7BA24F.2010705@linux.vnet.ibm.com>
	<364299f41002170910i336abf6eh72acbcbec9b72e7b@mail.gmail.com>
	<20100218042532.GC13013@rishikesh.in.ibm.com>
	<4B822F2E.9030609@cn.fujitsu.com>
Date: Sun, 21 Feb 2010 23:44:17 -0800
Message-ID: <364299f41002212344v4873843ej986f1b39ec3494df@mail.gmail.com>
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
Cc: LTP <ltp-list@lists.sourceforge.net>

Ok.. one last thing.

On Sun, Feb 21, 2010 at 11:15 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
> at 2010-2-18 12:25, Rishikesh K Rajak wrote:
>> On Wed, Feb 17, 2010 at 09:10:48AM -0800, Garrett Cooper wrote:
>>> On Wed, Feb 17, 2010 at 12:01 AM, Rishikesh <risrajak@linux.vnet.ibm.co=
m> wrote:
>>>> Hi Shi,
>>>>
>>>> Thanks for your patch, still i am finding time to look into your patch.
>>>> Will reply you soon.
>>>>
>>>> http://marc.info/?l=3Dltp-list&m=3D126502355614857&w=3D2
>>>
>>> I looked at the patch finally.
>>
>> Thanks garret.
>>>
>>> Please use TTERRNO instead of strerror(...) for the reported value.
>>> There's no reason why you should use strerror(...) there as that's
>>> already done with tst_res(3).
>>
>> Shi, can you please incorporate changes which garret has suggested and
>> resend the patch again to ltp-list@ .
>
> =A0Ok, i recreated the patch based on garret's suggestion.
>
> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
> ---
> --- testcases/kernel/syscalls/sysctl/sysctl03.c.orig =A0 =A02010-02-22 14=
:38:26.000000000 -0500
> +++ testcases/kernel/syscalls/sysctl/sysctl03.c 2010-02-22 15:08:03.00000=
0000 -0500
> @@ -22,15 +22,18 @@
> =A0* =A0 =A0 sysctl03.c
> =A0*
> =A0* DESCRIPTION
> - * =A0 =A0 Testcase to check that sysctl(2) sets errno to EPERM correctl=
y.
> + * =A0 =A0 Testcase to check that sysctl(2) sets errno to EPERM or EACCES
> + * =A0 =A0 correctly. But it will return EACCES on kernels that are 2.6.=
33-rc1
> + * =A0 =A0 and higher.
> =A0*
> =A0* ALGORITHM
> =A0* =A0 =A0 a. =A0 =A0 =A0Call sysctl(2) as a root user, and attempt to =
write data
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 to the kernel_table[]. Since the table does =
not have write
> - * =A0 =A0 =A0 =A0 =A0 =A0 permissions even for the root, it should fail=
 EPERM.
> + * =A0 =A0 =A0 =A0 =A0 =A0 permissions even for the root, it should fail=
 EPERM or EACCES.
> =A0* =A0 =A0 b. =A0 =A0 =A0Call sysctl(2) as a non-root user, and attempt=
 to write data
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 to the kernel_table[]. Since the table does =
not have write
> - * =A0 =A0 =A0 =A0 =A0 =A0 permission for the regular user, it should fa=
il with EPERM.
> + * =A0 =A0 =A0 =A0 =A0 =A0 permission for the regular user, it should fa=
il with EPERM
> + * =A0 =A0 =A0 =A0 =A0 =A0 or EACCES.
> =A0*
> =A0* USAGE: =A0<for command-line>
> =A0* =A0sysctl03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> @@ -43,6 +46,7 @@
> =A0*
> =A0* HISTORY
> =A0* =A0 =A0 07/2001 Ported by Wayne Boyer
> + * =A0 =A0 02/2010 Updated by shiwh@cn.fujitsu.com
> =A0*
> =A0* RESTRICTIONS
> =A0* =A0 =A0 Test must be run as root.
> @@ -82,6 +86,7 @@ int main(int ac, char **av)
> =A0{
> =A0 =A0 =A0 =A0int lc;
> =A0 =A0 =A0 =A0char *msg;
> + =A0 =A0 =A0 int exp_eno;
>
> =A0 =A0 =A0 =A0char osname[OSNAMESZ];
> =A0 =A0 =A0 =A0int osnamelth, status;
> @@ -96,6 +101,13 @@ int main(int ac, char **av)
>
> =A0 =A0 =A0 =A0setup();
>
> + =A0 =A0 =A0 if ((tst_kvercmp(2, 6, 32)) <=3D 0){
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exp_eno =3D EPERM;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exp_eno =3D EACCES;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exp_enos[0] =3D EACCES;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0TEST_EXP_ENOS(exp_enos);
>
> =A0 =A0 =A0 =A0/* check looping state if -i option is given */
> @@ -114,13 +126,10 @@ int main(int ac, char **av)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST_ERROR_LOG(TEST_ERRNO);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TEST_ERRNO !=3D EPERM) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TF=
AIL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"Expected EPERM (%d), got %d: %s",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0EPERM, TEST_ERRNO,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0strerror(TEST_ERRNO));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TEST_ERRNO !=3D exp_eno=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TF=
AIL|TTERRNO, "Got unxpected error");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TP=
ASS, "Got expected EPERM error");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TP=
ASS|TTERRNO, "Got expected error");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> @@ -147,12 +156,10 @@ int main(int ac, char **av)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST_ERROR=
_LOG(TEST_ERRNO);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TEST_ER=
RNO !=3D EPERM) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tst_resm(TFAIL, "Expected EPERM, got "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0"%d", TEST_ERRNO);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TEST_ER=
RNO !=3D exp_eno) {

Why can't this be exp_enos[0] ?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tst_resm(TFAIL|TTERRNO, "Got unxpected error");

Typo.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tst_resm(TPASS, "Got expected EPERM "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0"error");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tst_resm(TPASS|TTERRNO, "Got expected error");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
>
> Thank you.
> - Shi Weihua

    It always helps to understand what's expected vs unexpected
without having to look at the source code. Could you please revise the
tst_resm format strings to be something like the following?

tst_resm (TPASS | TERRNO, "Got expected error (errno =3D %d, ret_code =3D
%d", exp_errno_blah, exp_ret_code_blah);

OR:

tst_resm (TPASS | TERRNO, "Got unexpected error (expected errno =3D %d,
ret_code =3D %d - got errno =3D %d, ret_code =3D %d", exp_errno_blah,
exp_ret_code_blah, errno_blah, ret_code_blah);

    I've been debating about doing this in a macro out of include/,
but I haven't gotten there yet...

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
