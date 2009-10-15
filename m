Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MyVLn-0000Gm-Sw
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 18:46:59 +0000
Received: from mail-px0-f181.google.com ([209.85.216.181])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyVLg-0005It-UK
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 18:46:59 +0000
Received: by pxi11 with SMTP id 11so302198pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Oct 2009 11:46:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1255618282.5869.19.camel@subratamodak.linux.ibm.com>
References: <364299f40910121908y47554fabgbda2f5411c720f92@mail.gmail.com>
	<1255618282.5869.19.camel@subratamodak.linux.ibm.com>
Date: Thu, 15 Oct 2009 11:46:47 -0700
Message-ID: <364299f40910151146uf5036f3hc7e9b282fe0c6761@mail.gmail.com>
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
To: subrata@linux.vnet.ibm.com
Cc: rohit verma <rohit.170309@gmail.com>, naresh kamboju <naresh.kernel@gmail.com>, ltp-list <ltp-list@lists.sourceforge.net>

On Thu, Oct 15, 2009 at 7:51 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Mon, 2009-10-12 at 19:08 -0700, Garrett Cooper wrote:
>> On Fri, Oct 9, 2009 at 3:00 AM, rohit verma <rohit.170309@gmail.com> wro=
te:
>> > Hi,
>> >
>> > Thanks Naresh for pointing out the issue in the HTML report. I had
>> > also noticed the issue in my test reports.
>> >
>> > However, I wish to confirm that the issue being mentioned is not a
>> > side-effect of the fix that I had posted for the pan driver.
>> > If you compare the HTML reports from the previous releases and the
>> > recent one, you can notice all the tags - FAIL, WARN, BROK, PASS,CONF
>> > & RETR are now prefixed by ' T ' for reasons not known to me
>> > (resulting in - TFAIL, TPASS etc).
>> >
>> > Now, if you check ltp-full-20090831/tools/genhtml.pl file you can see
>> > all that old tags (FAIL, WARN, etc) are used instead of the new
>> > ones(tags). As a result the numbers are not updated in the summary in
>> > HTML report. Also FAIL/WARN/BROK test-cases are not uniquely colored
>> > like in the old versions of LTP.
>> >
>> > Please check the same.
>> > If possible I will generate a patch and submit the same.
>> >
>> > On Wed, Oct 7, 2009 at 4:43 PM, naresh kamboju <naresh.kernel@gmail.co=
m> wrote:
>> >> Hi,
>> >>
>> >> I think you have noticed difference in the HTML file generation.
>> >> HTML file is not reporting number of failure test cases
>> >> in summary and failed column with different color.
>> >> Some changes are made by Rohit recently.
>> >>
>> >> Rohit,
>> >> Please investigate the changes made to HTML file generator.
>> >>
>> >> You can refer the results logs share in LTP release in the below link=
 for
>> >> X86
>> >> (ltp-full-20090930_results_kernel-2.6.31_architecture-i386.tgz)
>> >> Ia64
>> >> (ltp-full-20090930_results_kernel-2.6.23.13_architecture-ia64.tgz)
>>
>> Try this.
>>
>> Fix genhtml.pl so that it functions with the new T-prefixing in the
>> lib/tst_res.c result codes.
>>
>> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> Directly checkin this as well:
>
> patching file tools/genhtml.pl
> Hunk #1 FAILED at 179.
> Hunk #2 succeeded at 251 with fuzz 2.
> 1 out of 2 hunks FAILED -- saving rejects to file tools/genhtml.pl.rej
>
> Regards--
> Subrata
>
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
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ( $flag2 =3D=3D 1 =
) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $row_line =3D $r=
ow_line . "$line \n";
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($line =3D~ /\ =
FAIL\ / ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($line =3D~ /\ =
TFAIL\ / ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $detecte=
d_fail =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ( $fa=
iled_test_counter_flag =3D=3D 0 ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
$failed_test_counter++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
$failed_test_counter_flag=3D1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ BROK\ / ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ TBROK\ / ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $detecte=
d_brok =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ( $br=
ok_test_counter_flag =3D=3D 0 ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
$brok_test_counter++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
$brok_test_counter_flag=3D1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ WARN\ / ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ TWARN\ / ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $detecte=
d_warn =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ( $wa=
rn_test_counter_flag =3D=3D 0 ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
$warn_test_counter++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
$warn_test_counter_flag=3D1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ RETR\ / ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ TRETR\ / ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $detecte=
d_retr =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ( $re=
tr_test_counter_flag =3D=3D 0 ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
$retr_test_counter++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
$retr_test_counter_flag=3D1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ CONF\ / ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif ($line =3D=
~ /\ TCONF\ / ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $detecte=
d_conf =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ( $co=
nf_test_counter_flag =3D=3D 0 ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
$conf_test_counter++;
>> @@ -251,3 +251,5 @@
>> =A0print "<tr><td><strong>Hostname</strong> =A0</td> <td><strong>";
>> =A0$hostname=3Dsystem("uname -n"); =A0 =A0 =A0 =A0 =A0 =A0 chop($hostnam=
e);
>> =A0print " $hostname </strong></td></tr></tbody></table></div></body></h=
tml>\n";
>> +
>> +# vim: syntax=3Dperl

Subrata,
    This was already checked into CVS because I was 100% sure that my
change was correct (sorry ><).
Thanks,
-Garrett

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
