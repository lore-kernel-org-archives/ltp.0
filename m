Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NUySN-0007y3-B0
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 08:19:59 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUySK-0006GW-Kh
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 08:19:59 +0000
Received: by pxi38 with SMTP id 38so11134466pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Jan 2010 00:19:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001ca93f5$9edf5ef0$dc9e1cd0$@co.jp>
References: <000601ca8de1$64d04810$2e70d830$@co.jp>
	<1262862378.12213.22.camel@subratamodak.linux.ibm.com>
	<000001ca93f5$9edf5ef0$dc9e1cd0$@co.jp>
Date: Wed, 13 Jan 2010 00:19:50 -0800
Message-ID: <364299f41001130019h337b1fb6q8101997a22a45808@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] quotactl01 testcases problem
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Tue, Jan 12, 2010 at 6:10 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Garrett, Subrata,
>
> I confirmed that "quotactl01" test is finished in "PASS" (TCONF)
> in my system.
>
> Thank you for your revision.
>
>
> -Tomonori Mitani
>
> -----Original Message-----
> From: Subrata Modak [mailto:subrata@linux.vnet.ibm.com]
> Sent: Thursday, January 07, 2010 8:06 PM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] quotactl01 testcases problem
>
> Hello Mitani-San,
>
> Did this get resolved for you ?
>
> Regards--
> Subrata
>
> On Tue, 2010-01-05 at 17:30 +0900, Mitani wrote:
>> Hi,
>>
>> I tried "quotactl01" testcases, and found two problems.
>> Second one occurred after first one's revise.
>>
>> 1) In the result of "quotactl01", "Success" are displayed in spite of
>> =A0 =A0failing in the test:
>>
>> ------------
>> quotactl01 =A0 =A01 =A0TFAIL =A0: =A0cmd=3D0x800002: TEST_ERRNO=3D???(0)=
: Success
>> quotactl01 =A0 =A02 =A0TFAIL =A0: =A0cmd=3D0x800003: TEST_ERRNO=3D???(0)=
: Success
>> quotactl01 =A0 =A03 =A0TFAIL =A0: =A0cmd=3D0x800007: TEST_ERRNO=3D???(0)=
: Success
>> quotactl01 =A0 =A04 =A0TFAIL =A0: =A0cmd=3D0x800008: TEST_ERRNO=3D???(0)=
: Success
>> quotactl01 =A0 =A05 =A0TFAIL =A0: =A0cmd=3D0x800005: TEST_ERRNO=3D???(0)=
: Success
>> quotactl01 =A0 =A06 =A0TFAIL =A0: =A0cmd=3D0x800006: TEST_ERRNO=3D???(0)=
: Success
>> quotactl01 =A0 =A07 =A0TFAIL =A0: =A0cmd=3D0x800004: TEST_ERRNO=3D???(0)=
: Success
>> quotactl01 =A0 =A08 =A0TFAIL =A0: =A0cmd=3D0x800001: TEST_ERRNO=3D???(0)=
: Success
>> ------------
>>
>> This problem occurred because the return value of system-call
>> "(syscall(__NR_quotactl, cmd[i], ...))" is not judged correctly
>> in "${LTPROOT}/testcases/kernel/syscalls/quotactl/quotactl01.c".
>> Above errors are caused by TFAIL and messages are printed by TTERRNO.
>> And there is only one place (Line 206) which uses TFAIL in "quotactl01.c"
>>
>> The following patch can fix this problem:
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- quotactl01.c =A0 =A0 =A02009-12-20 09:36:35.000000000 +0900
>> +++ quotactl01.c.new =A02010-01-04 17:11:17.000000000 +0900
>> @@ -177,7 +177,6 @@
>> =A0 =A0 =A0 int id =3D getuid();
>> =A0 =A0 =A0 int newtid =3D -1;
>> =A0 =A0 =A0 int result;
>> - =A0 =A0 int ret;
>> =A0 =A0 =A0 int i;
>> =A0 =A0 =A0 int lc; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/=
* loop counter */
>> =A0 =A0 =A0 char *msg; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*=
 message returned from
>> parse_opts */
>> @@ -199,10 +198,10 @@
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i <=3D 7; i++){
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D syscal=
l(__NR_quotactl, cmd[i],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(syscall(_=
_NR_quotactl, cmd[i],
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (const char *)NULL, id,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (caddr_t)NULL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0=
) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (caddr_t)NULL));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TEST_RETUR=
N !=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 tst_resm(TFAIL|TTERRNO, "cmd=3D0x%x",
>> cmd[i]);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 tst_resm(TPASS, "quotactl call
>> succeeded");
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>
>> However, new problem occurred after applying above patch.
>>
>> 2) The test failed with the following error in my system:
>>
>> ------------
>> quotactl01 =A0 =A01 =A0TFAIL =A0: =A0cmd=3D0x800002: TEST_ERRNO=3DEFAULT=
(14): Bad
> address
>> quotactl01 =A0 =A02 =A0TFAIL =A0: =A0cmd=3D0x800003: TEST_ERRNO=3DEFAULT=
(14): Bad
> address
>> quotactl01 =A0 =A03 =A0TFAIL =A0: =A0cmd=3D0x800007: TEST_ERRNO=3DEFAULT=
(14): Bad
> address
>> quotactl01 =A0 =A04 =A0TFAIL =A0: =A0cmd=3D0x800008: TEST_ERRNO=3DEFAULT=
(14): Bad
> address
>> quotactl01 =A0 =A05 =A0TFAIL =A0: =A0cmd=3D0x800005: TEST_ERRNO=3DEFAULT=
(14): Bad
> address
>> quotactl01 =A0 =A06 =A0TFAIL =A0: =A0cmd=3D0x800006: TEST_ERRNO=3DEFAULT=
(14): Bad
> address
>> quotactl01 =A0 =A07 =A0TFAIL =A0: =A0cmd=3D0x800004: TEST_ERRNO=3DEFAULT=
(14): Bad
> address
>> quotactl01 =A0 =A08 =A0TFAIL =A0: =A0cmd=3D0x800001: TEST_ERRNO=3DEFAULT=
(14): Bad
> address
>> ------------
>>
>> "EFAULT" means that there is an error in "addr".
>> The format of "quotactl" is following:
>> ------------
>> int quotactl(int cmd, const char *special, int id, caddr_t addr);
>> ------------
>>
>> Therefore, "EFAULT" means that 4th argument of "quotactl()" has problem.
>>
>> In "${LTPROOT}/testcases/kernel/syscalls/quotactl/quotactl01.c", 4th
>> argument of "quotactl()" is "NULL":
>> Is it right?
>>
>>
>> I'm glad if I get your help.

    It's not completely fixed; the test was broken in the first place.
I'll need to create a script which will generate a tempfs filesystem,
enable quota on it, then jettison it after the test is done; otherwise
$TMP could have quotas enabled or disabled (nondeterministic)...
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
