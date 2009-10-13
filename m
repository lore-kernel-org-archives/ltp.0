Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1Mxhxo-0002x0-Mk
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:02:56 +0000
Received: from mail-pz0-f196.google.com ([209.85.222.196])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mxhxk-0004D1-DM
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:02:56 +0000
Received: by pzk34 with SMTP id 34so2637754pzk.11
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Oct 2009 07:02:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40910121912j5f36d912idab5477daec48e65@mail.gmail.com>
References: <364299f40910121908y47554fabgbda2f5411c720f92@mail.gmail.com>
	<364299f40910121912j5f36d912idab5477daec48e65@mail.gmail.com>
Date: Tue, 13 Oct 2009 19:32:42 +0530
Message-ID: <f5a7b3810910130702rf204c1ck72bd99bb944fc73b@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [PATCH] Fix genhtml.pl (was "Re: HTML not reporting
	number of Failed test cases")
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, rohit.170309@gmail.com

Thank you very much Garrett.
Its working at my end.

Best regards,
Naresh Kamboju


On Tue, Oct 13, 2009 at 7:42 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Mon, Oct 12, 2009 at 7:08 PM, Garrett Cooper <yanegomi@gmail.com> wrot=
e:
>> On Fri, Oct 9, 2009 at 3:00 AM, rohit verma <rohit.170309@gmail.com> wro=
te:
>>> Hi,
>>>
>>> Thanks Naresh for pointing out the issue in the HTML report. I had
>>> also noticed the issue in my test reports.
>>>
>>> However, I wish to confirm that the issue being mentioned is not a
>>> side-effect of the fix that I had posted for the pan driver.
>>> If you compare the HTML reports from the previous releases and the
>>> recent one, you can notice all the tags - FAIL, WARN, BROK, PASS,CONF
>>> & RETR are now prefixed by ' T ' for reasons not known to me
>>> (resulting in - TFAIL, TPASS etc).
>>>
>>> Now, if you check ltp-full-20090831/tools/genhtml.pl file you can see
>>> all that old tags (FAIL, WARN, etc) are used instead of the new
>>> ones(tags). As a result the numbers are not updated in the summary in
>>> HTML report. Also FAIL/WARN/BROK test-cases are not uniquely colored
>>> like in the old versions of LTP.
>>>
>>> Please check the same.
>>> If possible I will generate a patch and submit the same.
>>>
>>> On Wed, Oct 7, 2009 at 4:43 PM, naresh kamboju <naresh.kernel@gmail.com=
> wrote:
>>>> Hi,
>>>>
>>>> I think you have noticed difference in the HTML file generation.
>>>> HTML file is not reporting number of failure test cases
>>>> in summary and failed column with different color.
>>>> Some changes are made by Rohit recently.
>>>>
>>>> Rohit,
>>>> Please investigate the changes made to HTML file generator.
>>>>
>>>> You can refer the results logs share in LTP release in the below link =
for
>>>> X86
>>>> (ltp-full-20090930_results_kernel-2.6.31_architecture-i386.tgz)
>>>> Ia64
>>>> (ltp-full-20090930_results_kernel-2.6.23.13_architecture-ia64.tgz)
>>
>> Try this.
>>
>> Fix genhtml.pl so that it functions with the new T-prefixing in the
>> lib/tst_res.c result codes.
>>
>> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>>
>> Index: contrib/ltp/src/tools/genhtml.pl
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- src/tools/.CC/cache/genhtml.pl@@/main/ltp-upgrade/1 2009-10-12
>> 19:08:28.000000000 -0700
>> +++ src/tools/genhtml.pl =A0 =A0 =A0 =A02009-10-12 19:08:18.000000000 -0=
700
>> @@ -179,31 +179,31 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ( $flag2 =3D=3D 1 ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$row_line =3D $ro=
w_line . "$line \n";
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($line =3D~ /\ =
FAIL\ / ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($line =3D~ /\ =
TFAIL\ / ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$detected=
_fail =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ( $fai=
led_test_counter_flag =3D=3D 0 ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$=
failed_test_counter++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$=
failed_test_counter_flag=3D1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ BROK\ / ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ TBROK\ / ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$detected=
_brok =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ( $bro=
k_test_counter_flag =3D=3D 0 ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$=
brok_test_counter++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$=
brok_test_counter_flag=3D1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ WARN\ / ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ TWARN\ / ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$detected=
_warn =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ( $war=
n_test_counter_flag =3D=3D 0 ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$=
warn_test_counter++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$=
warn_test_counter_flag=3D1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ RETR\ / ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ TRETR\ / ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$detected=
_retr =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ( $ret=
r_test_counter_flag =3D=3D 0 ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$=
retr_test_counter++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$=
retr_test_counter_flag=3D1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ CONF\ / ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ TCONF\ / ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$detected=
_conf =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ( $con=
f_test_counter_flag =3D=3D 0 ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$=
conf_test_counter++;
>> @@ -251,3 +251,5 @@
>> =A0print "<tr><td><strong>Hostname</strong> =A0</td> <td><strong>";
>> =A0$hostname=3Dsystem("uname -n"); =A0 =A0 =A0 =A0 =A0 =A0 chop($hostnam=
e);
>> =A0print " $hostname </strong></td></tr></tbody></table></div></body></h=
tml>\n";
>> +
>> +# vim: syntax=3Dperl
>
> =A0 =A0This was the checkin that changed the output format, BTW:
> Cheers,
> -Garrett
>
> -------------------------------------------------------------------------=
---------------------------------
>
> Update of /cvsroot/ltp/ltp/lib
> In directory ddv4jf1.ch3.sourceforge.com:/tmp/cvs-serv24617/lib
>
> Modified Files:
> =A0 =A0 =A0 tst_res.c
> Log Message:
> extend the test result to a bit field so we can extend the output further
>
> Index: tst_res.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/lib/tst_res.c,v
> retrieving revision 1.8
> retrieving revision 1.9
> diff -C2 -d -r1.8 -r1.9
> *** tst_res.c =A0 9 Jun 2009 16:01:20 -0000 =A0 =A0 =A0 1.8
> --- tst_res.c =A0 20 Jul 2009 02:42:32 -0000 =A0 =A0 =A01.9
> ***************
> *** 116,119 ****
> --- 116,120 ----
> =A0#include <unistd.h>
> =A0#include "test.h"
> + #include "usctest.h"
>

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
