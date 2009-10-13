Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MxWsQ-0003Lx-Lg
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 02:12:38 +0000
Received: from mail-px0-f201.google.com ([209.85.216.201])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MxWsK-0000NR-Vz
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 02:12:38 +0000
Received: by pxi39 with SMTP id 39so9467253pxi.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Oct 2009 19:12:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40910121908y47554fabgbda2f5411c720f92@mail.gmail.com>
References: <364299f40910121908y47554fabgbda2f5411c720f92@mail.gmail.com>
Date: Mon, 12 Oct 2009 19:12:26 -0700
Message-ID: <364299f40910121912j5f36d912idab5477daec48e65@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: rohit verma <rohit.170309@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, naresh kamboju <naresh.kernel@gmail.com>

On Mon, Oct 12, 2009 at 7:08 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Fri, Oct 9, 2009 at 3:00 AM, rohit verma <rohit.170309@gmail.com> wrot=
e:
>> Hi,
>>
>> Thanks Naresh for pointing out the issue in the HTML report. I had
>> also noticed the issue in my test reports.
>>
>> However, I wish to confirm that the issue being mentioned is not a
>> side-effect of the fix that I had posted for the pan driver.
>> If you compare the HTML reports from the previous releases and the
>> recent one, you can notice all the tags - FAIL, WARN, BROK, PASS,CONF
>> & RETR are now prefixed by ' T ' for reasons not known to me
>> (resulting in - TFAIL, TPASS etc).
>>
>> Now, if you check ltp-full-20090831/tools/genhtml.pl file you can see
>> all that old tags (FAIL, WARN, etc) are used instead of the new
>> ones(tags). As a result the numbers are not updated in the summary in
>> HTML report. Also FAIL/WARN/BROK test-cases are not uniquely colored
>> like in the old versions of LTP.
>>
>> Please check the same.
>> If possible I will generate a patch and submit the same.
>>
>> On Wed, Oct 7, 2009 at 4:43 PM, naresh kamboju <naresh.kernel@gmail.com>=
 wrote:
>>> Hi,
>>>
>>> I think you have noticed difference in the HTML file generation.
>>> HTML file is not reporting number of failure test cases
>>> in summary and failed column with different color.
>>> Some changes are made by Rohit recently.
>>>
>>> Rohit,
>>> Please investigate the changes made to HTML file generator.
>>>
>>> You can refer the results logs share in LTP release in the below link f=
or
>>> X86
>>> (ltp-full-20090930_results_kernel-2.6.31_architecture-i386.tgz)
>>> Ia64
>>> (ltp-full-20090930_results_kernel-2.6.23.13_architecture-ia64.tgz)
>
> Try this.
>
> Fix genhtml.pl so that it functions with the new T-prefixing in the
> lib/tst_res.c result codes.
>
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> Index: contrib/ltp/src/tools/genhtml.pl
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- src/tools/.CC/cache/genhtml.pl@@/main/ltp-upgrade/1 2009-10-12
> 19:08:28.000000000 -0700
> +++ src/tools/genhtml.pl =A0 =A0 =A0 =A02009-10-12 19:08:18.000000000 -07=
00
> @@ -179,31 +179,31 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ( $flag2 =3D=3D 1 ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$row_line =3D $row=
_line . "$line \n";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($line =3D~ /\ F=
AIL\ / ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($line =3D~ /\ T=
FAIL\ / ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$detected_=
fail =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ( $fail=
ed_test_counter_flag =3D=3D 0 ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$f=
ailed_test_counter++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$f=
ailed_test_counter_flag=3D1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D~=
 /\ BROK\ / ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D~=
 /\ TBROK\ / ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$detected_=
brok =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ( $brok=
_test_counter_flag =3D=3D 0 ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$b=
rok_test_counter++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$b=
rok_test_counter_flag=3D1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D~=
 /\ WARN\ / ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D~=
 /\ TWARN\ / ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$detected_=
warn =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ( $warn=
_test_counter_flag =3D=3D 0 ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$w=
arn_test_counter++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$w=
arn_test_counter_flag=3D1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D~=
 /\ RETR\ / ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D~=
 /\ TRETR\ / ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$detected_=
retr =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ( $retr=
_test_counter_flag =3D=3D 0 ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$r=
etr_test_counter++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$r=
etr_test_counter_flag=3D1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D~=
 /\ CONF\ / ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D~=
 /\ TCONF\ / ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$detected_=
conf =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ( $conf=
_test_counter_flag =3D=3D 0 ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$c=
onf_test_counter++;
> @@ -251,3 +251,5 @@
> =A0print "<tr><td><strong>Hostname</strong> =A0</td> <td><strong>";
> =A0$hostname=3Dsystem("uname -n"); =A0 =A0 =A0 =A0 =A0 =A0 chop($hostname=
);
> =A0print " $hostname </strong></td></tr></tbody></table></div></body></ht=
ml>\n";
> +
> +# vim: syntax=3Dperl

    This was the checkin that changed the output format, BTW:
Cheers,
-Garrett

---------------------------------------------------------------------------=
-------------------------------

Update of /cvsroot/ltp/ltp/lib
In directory ddv4jf1.ch3.sourceforge.com:/tmp/cvs-serv24617/lib

Modified Files:
       tst_res.c
Log Message:
extend the test result to a bit field so we can extend the output further

Index: tst_res.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/lib/tst_res.c,v
retrieving revision 1.8
retrieving revision 1.9
diff -C2 -d -r1.8 -r1.9
*** tst_res.c   9 Jun 2009 16:01:20 -0000       1.8
--- tst_res.c   20 Jul 2009 02:42:32 -0000      1.9
***************
*** 116,119 ****
--- 116,120 ----
 #include <unistd.h>
 #include "test.h"
+ #include "usctest.h"

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
