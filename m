Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MHJEU-0006tJ-12
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 15:08:54 +0000
Received: from mail-gx0-f207.google.com ([209.85.217.207])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHJES-0002KI-KJ
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 15:08:53 +0000
Received: by gxk3 with SMTP id 3so4227008gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Jun 2009 08:08:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A3A049B.2000002@st.com>
References: <f5a7b3810906171317j40473a95y5dfc1b89d9e25950@mail.gmail.com>
	<4A3A049B.2000002@st.com>
Date: Thu, 18 Jun 2009 20:38:46 +0530
Message-ID: <f5a7b3810906180808l19d1889bn5575cf00de28d801@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f11d8d3e795046ca0c85c
Subject: Re: [LTP] [FIX HTML PATCH] ltp-genhtml
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
To: Francesco RUNDO <francesco.rundo@st.com>
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>, Oleg Nesterov <oleg@redhat.com>, rohit.170309@gmail.com

--001e680f11d8d3e795046ca0c85c
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Francesco,

>I'm not sure about your patch.

>I've introduced the usage of such env variables to support cross-build of =
LTP.
Yes I have reviewed your patch.

>In fact, in case the results of LTP session was related to cross-execution=
, the >infiormation about KERNEL_VERSION and MACHINE_ARCHITECTURE have to >=
be referred to the target and not to the host. Do you agree ?
Yes.
I agree with you.
I have been using LTP for Target Board executions not on Host Machine.
As per my understating KERNEL_VERSION and MACHINE_ARCHITECTURE are
should come from env right?
But I could not print these variables in HTML file.
Please refer the results published in LTP download page for 31-May-2009 rel=
ease.
http://sourceforge.net/project/platformdownload.php?group_id=3D3382


LTP Results:

ltp-full-20090531_results_kernel-2.6.18-128.el5_architecture-ppc64.tgz
ltp-full-20090531_results_kernel-2.6.18-128.el5_architecture-x86_64.tgz
ltp-full-20090531_results_kernel-2.6.18-128.el5PAE_architecture-i386.tgz
ltp-full-20090531_results_kernel-2.6.23.13_architecture-ia64.tgz
ltp-full-20090531_results_kernel-2.6.27.19-5-default_architecture-i386.tgz

None of the above results got printed these two KERNEL_VERSION and
MACHINE_ARCHITECTURE variables in HTML.


>With your fix, by using "uname -r" and "uname -m", to avoid to report wron=
g >information, you have to run the "genhtml.pl" script over the target sys=
tem because if >you run the genhtml.pl on the host, you will get wrong info=
rmation about the kernel >version and machine architecture.
No.
As per my understanding to make generic script =93uname -r" and "uname
-m" are best way of use. All the target Machines are wont have full
=93env=94 support to extract KERNEL_VERSION and MACHINE_ARCHITECTURE info.
Ofcourse my target Machine can not extract these variables.

"uname -r" and "uname -m" are from target not from Host I guess.
Because runltp script will runs on target so obviously genhtml.pl will
run when =96g option is  specified. =93 #sh runltp =96g
ltp-full-results-file.html=94


>Moreover, the assumption to run genhtml.pl over the target is not safe as =
often the target >systems are embedded systems which do not support PERL.

Yes. That is true.
When we run runltp with =96g option to create HTML file the person using
this option should have knowledge that this script will use PERL
script if there is no PERL no HTML file will generate right?

>With the fix I've proposed and accepted, the LTP-user by means of the simp=
le env >variables, can define the right information to be reported on the L=
TP results table about >kernel version and machine architecture.
I have attached my HTML output file after and before patch.
Please share your commands for ltp executions and results HTML file
and other files.
Before and after your patch.

if i miss something please let me know.

Best regards,
Naresh

>Now, by taking into account what above mentioned, I've to suggest to do no=
t apply your >proposal patch.

>Best Regards,
>Francesco


On Thu, Jun 18, 2009 at 2:40 PM, Francesco RUNDO<francesco.rundo@st.com> wr=
ote:
> Hi,
>
> I'm not sure about your patch.
>
> I've introduced the usage of such env variables to support cross-build of
> LTP.
>
> In fact, in case the results of LTP session was related to cross-executio=
n,
> the infiormation about KERNEL_VERSION and MACHINE_ARCHITECTURE have to be
> referred to the target and not to the host. Do you agree ?
>
> With your fix, by using "uname -r" and "uname -m", to avoid to report wro=
ng
> information, you have to run the "genhtml.pl" script over the target syst=
em
> because if you run the genhtml.pl on the host, you will get wrong
> information about the kernel version and machine architecture.
>
> Moreover, the assumption to run genhtml.pl over the target is not safe as
> often the target systems are embedded systems which do not support PERL.
>
> With the fix I've proposed and accepted, the LTP-user by means of the sim=
ple
> env variables, can define the right information to be reported on the LTP
> results table about kernel version and machine architecture.
>
> Now, by taking into account what above mentioned, I've to suggest =A0to d=
o not
> apply your proposal patch.
>
> Best Regards,
> Francesco
>
> naresh kamboju wrote:
>
>> Hi,
>>
>> I have noticed following issue and fixed.
>> 1. =A0 Kernel Version
>> 2. =A0 Machine Architecture.
>>
>> Please find the patch below and as attachment.
>>
>> Best regards
>> Naresh Kamboju
>>
>> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>>
>> diff -Naurb a/tools/genhtml.pl b/tools/genhtml.pl
>> --- a/tools/genhtml.pl =A02009-04-02 12:07:28.000000000 +0530
>> +++ b/tools/genhtml.pl =A02009-06-18 00:33:46.000000000 +0530
>> @@ -246,8 +246,12 @@
>> print "<tr><td><strong>Total Test TWARN</strong></td><td><strong>
>> $warn_test_counter </strong></td></tr>\n";
>> print "<tr><td><strong>Total Test TRETR</strong></td><td><strong>
>> $retr_test_counter </strong></td></tr>\n";
>> print "<tr><td><strong>Total Test TCONF</strong></td><td><strong>
>> $conf_test_counter </strong></td></tr>\n";
>> -print "<tr><td><strong>Kernel Version</strong></td><td><strong>
>> $ENV{KERNEL_VERSION} =A0</strong></td></tr>\n";
>> -print "<tr><td><strong>Machine Architecture</strong></td><td><strong>
>> $ENV{MACHINE_ARCH} </strong></td></tr>\n";
>> +print "<tr><td><strong>Kernel_Version</strong> =A0</td> <td><strong>";
>> +$kernel_version=3Dsystem("uname -r"); =A0 =A0 =A0 =A0 =A0 =A0 chop($ker=
nel_version);
>> +print " $kernel_version </strong></td></tr>\n";
>> +print "<tr><td><strong>Machine_Arch</strong> =A0</td> <td><strong>";
>> +$machine_arch=3Dsystem("uname -m"); =A0 =A0 =A0 =A0 =A0 =A0 chop($machi=
ne_arch);
>> +print " $machine_arch </strong></td></tr>\n";
>> print "<tr><td><strong>Hostname</strong> =A0</td> <td><strong>";
>> $hostname=3Dsystem("uname -n"); =A0 =A0 =A0 =A0 =A0 =A0 chop($hostname);
>> print " $hostname
>> </strong></td></tr></tbody></table></div></body></html>\n";
>>
>
>

--001e680f11d8d3e795046ca0c85c
Content-Type: text/html; charset=US-ASCII; 
	name="After_LTP-armv6l-2.6.29.1-alp_nl-kzm-arm11-2009_Jun_18-20h_26m_17s.html"
Content-Disposition: attachment; 
	filename="After_LTP-armv6l-2.6.29.1-alp_nl-kzm-arm11-2009_Jun_18-20h_26m_17s.html"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw3ltuxt0

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMDEgVHJhbnNpdGlvbmFs
Ly9FTiIgImh0dHA6Ly93d3cudzMub3JnL1RSL2h0bWw0L2xvb3NlLmR0ZCI+DQo8aHRtbCB4bWxu
cz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgeG1sOmxhbmc9ImVuLVVTIj4NCjxoZWFk
Pg0KICA8dGl0bGU+TGludXggVGVzdCBQcm9qZWN0IC0gUmVzdWx0czwvdGl0bGU+DQo8L2hlYWQ+
DQo8Ym9keT4NCg0KPGgxPkxUUCBPdXRwdXQvTG9nIChSZXBvcnQgR2VuZXJhdGVkIG9uIEZyaSBK
dW4gMTkgMDU6MjY6MjggSlNUIDIwMDkpIDwvaDE+DQo8dGFibGUgYm9yZGVyPSIxIiBjZWxsc3Bh
Y2luZz0iMyI+DQogIDx0Ym9keT4NCiAgICA8dHI+DQogICAgICA8dGQgYmdjb2xvcj0iIzY2ZmY2
NiI+PGI+Jm5ic3A7UEFTU0VEJm5ic3A7PC9iPjwvdGQ+DQogICAgICA8dGQgYmdjb2xvcj0iI2Zm
MDAwMCI+PGI+Jm5ic3A7RkFJTEVEJm5ic3A7PC9iPjwvdGQ+DQogICAgICA8dGQgYmdjb2xvcj0i
RnVjaHNpYSI+PGI+Jm5ic3A7V0FSTklORyZuYnNwOzwvYj48L3RkPg0KICAgICAgPHRkIGJnY29s
b3I9IlllbGxvdyI+PGI+Jm5ic3A7QlJPS0VOJm5ic3A7PC9iPjwvdGQ+DQogICAgICA8dGQgYmdj
b2xvcj0iIzhkYzk5NyI+PGI+Jm5ic3A7UkVUSVJFRCZuYnNwOzwvYj48L3RkPg0KICAgICAgPHRk
IGJnY29sb3I9IkFxdWEiPjxiPiZuYnNwO0NPTkZJRy1FUlJPUiZuYnNwOzwvYj48L3RkPg0KICAg
IDwvdHI+DQogIDwvdGJvZHk+DQo8L3RhYmxlPg0KPGJyPg0KPGI+TWVhbmluZyBvZiB0aGUgZm9s
bG93aW5nIEtFWVdPUkRTIGluIHRlc3QgcmVzdWx0cy9sb2dzOjwvYj4NCjxocj4NCjxsaT48Yj5U
UEFTUyAtPC9iPiBJbmRpY2F0ZXMgdGhhdCB0aGUgdGVzdCBjYXNlIGhhZCB0aGUgZXhwZWN0ZWQg
cmVzdWx0IGFuZCBwYXNzZWQ8L2xpPg0KPGxpPjxiPlRGQUlMIC08L2I+IEluZGljYXRlcyB0aGF0
IHRoZSB0ZXN0IGNhc2UgaGFkIGFuIHVuZXhwZWN0ZWQgcmVzdWx0IGFuZCBmYWlsZWQuPC9saT4N
CjxsaT48Yj5UQlJPSyAtPC9iPiBJbmRpY2F0ZXMgdGhhdCB0aGUgcmVtYWluaW5nIHRlc3QgY2Fz
ZXMgYXJlIGJyb2tlbiBhbmQgd2lsbCBub3QgZXhlY3V0ZSBjb3JyZWN0bHksIGJlY2F1c2Ugc29t
ZSBwcmVjb25kaXRpb24gbm90IG1ldCwgc3VjaCBhcyBhIHJlc291cmNlIG5vdCBiZWluZyBhdmFp
bGFibGUuPC9saT4NCjxsaT48Yj5UQ09ORiAtPC9iPiBJbmRpY2F0ZXMgdGhhdCB0aGUgdGVzdCBj
YXNlIHdhcyBub3Qgd3JpdHRlbiB0byBydW4gb24gdGhlIGN1cnJlbnQgaGFyd2FyZSBvciBzb2Z0
d2FyZSBjb25maWd1cmF0aW9uIHN1Y2ggYXMgbWFjaGluZSB0eXBlLCBvciwga2VybmVsIHZlcnNp
b24uPC9saT4NCjxsaT48Yj5UUkVUUiAtPC9iPiBJbmRpY2F0ZXMgdGhhdCB0aGUgdGVzdCBjYXNl
cyBoYXMgYmVlbiByZXRpcmVkIGFuZCBzaG91bGQgbm90IGJlIGV4ZWN1dGVkIGFueSBsb25nZXIu
PC9saT4NCjxsaT48Yj5UV0FSTiAtPC9iPiBJbmRpY2F0ZXMgdGhhdCB0aGUgdGVzdCBjYXNlIGV4
cGVyaWVuY2VkIGFuIHVuZXhwZWN0ZWQgb3IgdW5kZXNpcmFibGUgZXZlbnQgdGhhdCBzaG91bGQg
bm90IGFmZmVjdCB0aGUgdGVzdCBpdHNlbGYgc3VjaCBhcyBiZWluZyB1bmFibGUgdG8gY2xlYW51
cCByZXNvdXJjZXMgYWZ0ZXIgdGhlIHRlc3QgZmluaXNoZWQuPC9saT4NCjxsaT48Yj5USU5GTyAt
PC9iPiBTcGVjaWZpZXMgdXNlZnVsIGluZm9ybWF0aW9uIGFib3V0IHRoZSBzdGF0dXMgb2YgdGhl
IHRlc3QgdGhhdCBkb2VzIG5vdCBhZmZlY3QgdGhlIHJlc3VsdCBhbmQgZG9lcyBub3QgaW5kaWNh
dGUgYSBwcm9ibGVtLjwvbGk+DQo8aHI+DQoNCjxicj4NCjxsaT48YSBocmVmPSIjXzEiPkNsaWNr
IEhlcmUgZm9yIERldGFpbGVkIFJlcG9ydDwvYT48L2xpPg0KPGxpPjxhIGhyZWY9IiNfMiI+Q2xp
Y2sgSGVyZSBmb3IgU3VtbWFyeSBSZXBvcnQ8L2E+PC9saT4NCjxicj4NCg0KPGgyIGlkPSJfMSI+
RGV0YWlsZWQgUmVwb3J0PC9oMj4NCjxkaXY+DQo8dGFibGUgYm9yZGVyPSIxIiBjZWxsc3BhY2lu
Zz0iMyI+IA0KPHRib2R5Pg0KICAgIDx0cj4NCiAgICAgIDx0ZCBiZ2NvbG9yPSJTaWx2ZXIiPjxz
dHJvbmc+Tm88L3N0cm9uZz48L3RkPg0KICAgICAgPHRkIGJnY29sb3I9IlNpbHZlciI+PHN0cm9u
Zz5UZXN0LU5hbWU8L3N0cm9uZz48L3RkPg0KICAgICAgPHRkIGJnY29sb3I9IlNpbHZlciI+PHN0
cm9uZz5TdGFydC1UaW1lPC9zdHJvbmc+PC90ZD4NCiAgICAgIDx0ZCBiZ2NvbG9yPSJTaWx2ZXIi
PjxzdHJvbmc+Q29tbWFuZC1MaW5lPC9zdHJvbmc+PC90ZD4NCiAgICAgIDx0ZCBiZ2NvbG9yPSJT
aWx2ZXIiPjxzdHJvbmc+Q29udGFjdHM8L3N0cm9uZz48L3RkPg0KICAgICAgPHRkIGJnY29sb3I9
IlNpbHZlciI+PHN0cm9uZz5BbmFseXNpczwvc3Ryb25nPjwvdGQ+DQogICAgICA8dGQgYmdjb2xv
cj0iU2lsdmVyIj48c3Ryb25nPkluaXRpYXRpb24tU3RhdHVzPC9zdHJvbmc+PC90ZD4NCiAgICAg
IDx0ZCBiZ2NvbG9yPSJTaWx2ZXIiPjxzdHJvbmc+VGVzdC1PdXRwdXQ8L3N0cm9uZz48L3RkPg0K
ICAgICAgPHRkIGJnY29sb3I9IlNpbHZlciI+PHN0cm9uZz5EdXJhdGlvbjwvc3Ryb25nPjwvdGQ+
DQogICAgICA8dGQgYmdjb2xvcj0iU2lsdmVyIj48c3Ryb25nPlRlcm1pbmF0aW9uLXR5cGU8L3N0
cm9uZz48L3RkPg0KICAgICAgPHRkIGJnY29sb3I9IlNpbHZlciI+PHN0cm9uZz5UZXJtaW5hdGlv
bi1pZDwvc3Ryb25nPjwvdGQ+DQogICAgICA8dGQgYmdjb2xvcj0iU2lsdmVyIj48c3Ryb25nPkNv
cmUtRmlsZTwvc3Ryb25nPjwvdGQ+DQogICAgICA8dGQgYmdjb2xvcj0iU2lsdmVyIj48c3Ryb25n
PmN1dGltZTwvc3Ryb25nPjwvdGQ+DQogICAgICA8dGQgYmdjb2xvcj0iU2lsdmVyIj48c3Ryb25n
PmNzdGltZTwvc3Ryb25nPjwvdGQ+DQogICAgPC90cj4NCjx0ciBiZ2NvbG9yPSM2NmZmNjY+PHRk
PjxwPjxzdHJvbmc+MTwvc3Ryb25nPjwvcD48L3RkPg0KPHRkPjxwPjxzdHJvbmc+YWNjZXB0MDE8
L3N0cm9uZz48L3A+PC90ZD4NCjx0ZD48cD48cHJlPjxzdHJvbmc+RnJpIEp1biAxOSAwNToyNjoy
OCAyMDA5PC9zdHJvbmc+PC9wcmU+PC9wPjwvdGQ+DQo8dGQ+PHA+PHN0cm9uZz4gImFjY2VwdDAx
IiA8L3N0cm9uZz48L3A+PC90ZD4NCjx0ZD48cD48c3Ryb25nPiIiPC9zdHJvbmc+PC9wPjwvdGQ+
DQo8dGQ+PHA+PHN0cm9uZz5leGl0PC9zdHJvbmc+PC9wPjwvdGQ+DQo8dGQ+PHA+PHN0cm9uZz4i
b2siPC9zdHJvbmc+PC9wPjwvdGQ+DQo8dGQ+PHByZT48c3Ryb25nPmFjY2VwdDAxICAgIDEgIFBB
U1MgIDogIGJhZCBmaWxlIGRlc2NyaXB0b3Igc3VjY2Vzc2Z1bCANCmFjY2VwdDAxICAgIDIgIFBB
U1MgIDogIGJhZCBmaWxlIGRlc2NyaXB0b3Igc3VjY2Vzc2Z1bCANCmFjY2VwdDAxICAgIDMgIFBB
U1MgIDogIGludmFsaWQgc29ja2V0IGJ1ZmZlciBzdWNjZXNzZnVsIA0KYWNjZXB0MDEgICAgNCAg
UEFTUyAgOiAgaW52YWxpZCBzYWxlbiBzdWNjZXNzZnVsIA0KYWNjZXB0MDEgICAgNSAgUEFTUyAg
OiAgaW52YWxpZCBzYWxlbiBzdWNjZXNzZnVsIA0KYWNjZXB0MDEgICAgNiAgUEFTUyAgOiAgbm8g
cXVldWVkIGNvbm5lY3Rpb25zIHN1Y2Nlc3NmdWwgDQphY2NlcHQwMSAgICA3ICBQQVNTICA6ICBV
RFAgYWNjZXB0IHN1Y2Nlc3NmdWwgDQppbmNyZW1lbnRpbmcgc3RvcCANCjwvc3Ryb25nPjwvcHJl
PjwvdGQ+PHRkPjxwPjxzdHJvbmc+MDwvc3Ryb25nPjwvcD48L3RkPg0KPHRkPjxwPjxzdHJvbmc+
ZXhpdGVkPHN0cm9uZz48L3A+PC90ZD4NCjx0ZD48cD48c3Ryb25nPjA8L3N0cm9uZz48L3A+PC90
ZD4NCjx0ZD48cD48c3Ryb25nPm5vPC9zdHJvbmc+PC9wPjwvdGQ+DQo8dGQ+PHA+PHN0cm9uZz4x
PC9zdHJvbmc+PC9wPjwvdGQ+DQo8dGQ+PHA+PHN0cm9uZz4wPC9zdHJvbmc+PC9wPjwvdGQ+PC90
cj4NCjwvdGJvZHk+PC90YWJsZT48L2Rpdj4gDQoNCjxoMiBpZD0iXzIiPlN1bW1hcnkgUmVwb3J0
PC9oMj4NCg0KPGRpdj4NCg0KPHRhYmxlIGJvcmRlcj0iMSIgY2VsbHNwYWNpbmc9IjMiPjx0Ym9k
eT4NCjx0cj4NCjx0ZCBiZ2NvbG9yPSIjNjZmZjY2Ij4gPHN0cm9uZz5UZXN0IFN1bW1hcnk8L3N0
cm9uZz48L3A+PC90ZD48dGQgYmdjb2xvcj0iIzY2ZmY2NiI+PHN0cm9uZz5QYW4gcmVwb3J0ZWQg
YWxsIFRlc3QgUGFzczwvc3Ryb25nPjwvcD48L3RkPjwvdHI+DQo8dHI+PHRkPjxzdHJvbmc+TFRQ
IFZlcnNpb248L3N0cm9uZz4gPC90ZD48dGQ+PHN0cm9uZz4gTFRQLTIwMDkwNTMxICAgICA8L3N0
cm9uZz48L3RkPjwvdHI+DQo8dHI+PHRkPjxzdHJvbmc+U3RhcnQgVGltZTwvc3Ryb25nPiAgPC90
ZD48dGQ+PHN0cm9uZz4gRnJpIEp1biAxOSAwNToyNjoyOCBKU1QgMjAwOSA8L3N0cm9uZz48L3Rk
PjwvdHI+DQo8dHI+PHRkPjxzdHJvbmc+RW5kIFRpbWU8L3N0cm9uZz4gICAgPC90ZD48dGQ+PHN0
cm9uZz4gRnJpIEp1biAxOSAwNToyNjoyOCBKU1QgMjAwOSAgIDwvc3Ryb25nPjwvdGQ+PC90cj4N
Cjx0cj48dGQ+PHN0cm9uZz5Mb2cgUmVzdWx0PC9zdHJvbmc+ICA8L3RkPjx0ZD48YSBocmVmPSJm
aWxlOi8vL21udC9sdHAtZnVsbC0yMDA5MDUzMS9yZXN1bHRzLyI+ICAgICAgPHN0cm9uZz4vbW50
L2x0cC1mdWxsLTIwMDkwNTMxL3Jlc3VsdHM8L3N0cm9uZz48L2E+PC90ZD48L3RyPg0KPHRyPjx0
ZD48c3Ryb25nPk91dHB1dC9GYWlsZWQgUmVzdWx0PC9zdHJvbmc+PC90ZD48dGQ+PGEgaHJlZj0i
ZmlsZTovLy9tbnQvbHRwLWZ1bGwtMjAwOTA1MzEvb3V0cHV0LyI+IDxzdHJvbmc+L21udC9sdHAt
ZnVsbC0yMDA5MDUzMS9vdXRwdXQ8L3N0cm9uZz48L2E+PC90ZD48L3RyPg0KPHRyPjx0ZD48c3Ry
b25nPlRvdGFsIFRlc3RzPC9zdHJvbmc+PC90ZD48dGQ+PHN0cm9uZz4xICAgICAgICAgICAgICAg
ICAgICAgICAgIDwvc3Ryb25nPjwvdGQ+PC90cj4NCjx0cj48dGQ+PHN0cm9uZz5Ub3RhbCBUZXN0
IFRQQVNTOjwvc3Ryb25nPjwvdGQ+PHRkPjxzdHJvbmc+IDEgPC9zdHJvbmc+PC90ZD48L3RyPg0K
PHRyPjx0ZD48c3Ryb25nPlRvdGFsIFRlc3QgVEZBSUw6PC9zdHJvbmc+PC90ZD48dGQ+PHN0cm9u
Zz4gMCA8L3N0cm9uZz48L3RkPjwvdHI+DQo8dHI+PHRkPjxzdHJvbmc+VG90YWwgVGVzdCBUQlJP
Szwvc3Ryb25nPjwvdGQ+PHRkPjxzdHJvbmc+IDAgPC9zdHJvbmc+PC90ZD48L3RyPg0KPHRyPjx0
ZD48c3Ryb25nPlRvdGFsIFRlc3QgVFdBUk48L3N0cm9uZz48L3RkPjx0ZD48c3Ryb25nPiAwIDwv
c3Ryb25nPjwvdGQ+PC90cj4NCjx0cj48dGQ+PHN0cm9uZz5Ub3RhbCBUZXN0IFRSRVRSPC9zdHJv
bmc+PC90ZD48dGQ+PHN0cm9uZz4gMCA8L3N0cm9uZz48L3RkPjwvdHI+DQo8dHI+PHRkPjxzdHJv
bmc+VG90YWwgVGVzdCBUQ09ORjwvc3Ryb25nPjwvdGQ+PHRkPjxzdHJvbmc+IDAgPC9zdHJvbmc+
PC90ZD48L3RyPg0KPHRyPjx0ZD48c3Ryb25nPktlcm5lbF9WZXJzaW9uPC9zdHJvbmc+ICA8L3Rk
PiA8dGQ+PHN0cm9uZz4yLjYuMjkuMS1hbHBfbmwta3ptLWFybTExDQogIDwvc3Ryb25nPjwvdGQ+
PC90cj4NCjx0cj48dGQ+PHN0cm9uZz5NYWNoaW5lX0FyY2g8L3N0cm9uZz4gIDwvdGQ+IDx0ZD48
c3Ryb25nPmFybXY2bA0KICA8L3N0cm9uZz48L3RkPjwvdHI+DQo8dHI+PHRkPjxzdHJvbmc+SG9z
dG5hbWU8L3N0cm9uZz4gIDwvdGQ+IDx0ZD48c3Ryb25nPjQzLjg4LjEwMS4yMDcNCiAgPC9zdHJv
bmc+PC90ZD48L3RyPjwvdGJvZHk+PC90YWJsZT48L2Rpdj48L2JvZHk+PC9odG1sPg0K
--001e680f11d8d3e795046ca0c85c
Content-Type: text/html; charset=US-ASCII; 
	name="Before_LTP-armv6l-2.6.29.1-alp_nl-kzm-arm11-2009_Jun_18-20h_22m_29s.html"
Content-Disposition: attachment; 
	filename="Before_LTP-armv6l-2.6.29.1-alp_nl-kzm-arm11-2009_Jun_18-20h_22m_29s.html"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw3ltuxz1

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMDEgVHJhbnNpdGlvbmFs
Ly9FTiIgImh0dHA6Ly93d3cudzMub3JnL1RSL2h0bWw0L2xvb3NlLmR0ZCI+DQo8aHRtbCB4bWxu
cz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbCIgeG1sOmxhbmc9ImVuLVVTIj4NCjxoZWFk
Pg0KICA8dGl0bGU+TGludXggVGVzdCBQcm9qZWN0IC0gUmVzdWx0czwvdGl0bGU+DQo8L2hlYWQ+
DQo8Ym9keT4NCg0KPGgxPkxUUCBPdXRwdXQvTG9nIChSZXBvcnQgR2VuZXJhdGVkIG9uIEZyaSBK
dW4gMTkgMDU6MjI6NDAgSlNUIDIwMDkpIDwvaDE+DQo8dGFibGUgYm9yZGVyPSIxIiBjZWxsc3Bh
Y2luZz0iMyI+DQogIDx0Ym9keT4NCiAgICA8dHI+DQogICAgICA8dGQgYmdjb2xvcj0iIzY2ZmY2
NiI+PGI+Jm5ic3A7UEFTU0VEJm5ic3A7PC9iPjwvdGQ+DQogICAgICA8dGQgYmdjb2xvcj0iI2Zm
MDAwMCI+PGI+Jm5ic3A7RkFJTEVEJm5ic3A7PC9iPjwvdGQ+DQogICAgICA8dGQgYmdjb2xvcj0i
RnVjaHNpYSI+PGI+Jm5ic3A7V0FSTklORyZuYnNwOzwvYj48L3RkPg0KICAgICAgPHRkIGJnY29s
b3I9IlllbGxvdyI+PGI+Jm5ic3A7QlJPS0VOJm5ic3A7PC9iPjwvdGQ+DQogICAgICA8dGQgYmdj
b2xvcj0iIzhkYzk5NyI+PGI+Jm5ic3A7UkVUSVJFRCZuYnNwOzwvYj48L3RkPg0KICAgICAgPHRk
IGJnY29sb3I9IkFxdWEiPjxiPiZuYnNwO0NPTkZJRy1FUlJPUiZuYnNwOzwvYj48L3RkPg0KICAg
IDwvdHI+DQogIDwvdGJvZHk+DQo8L3RhYmxlPg0KPGJyPg0KPGI+TWVhbmluZyBvZiB0aGUgZm9s
bG93aW5nIEtFWVdPUkRTIGluIHRlc3QgcmVzdWx0cy9sb2dzOjwvYj4NCjxocj4NCjxsaT48Yj5U
UEFTUyAtPC9iPiBJbmRpY2F0ZXMgdGhhdCB0aGUgdGVzdCBjYXNlIGhhZCB0aGUgZXhwZWN0ZWQg
cmVzdWx0IGFuZCBwYXNzZWQ8L2xpPg0KPGxpPjxiPlRGQUlMIC08L2I+IEluZGljYXRlcyB0aGF0
IHRoZSB0ZXN0IGNhc2UgaGFkIGFuIHVuZXhwZWN0ZWQgcmVzdWx0IGFuZCBmYWlsZWQuPC9saT4N
CjxsaT48Yj5UQlJPSyAtPC9iPiBJbmRpY2F0ZXMgdGhhdCB0aGUgcmVtYWluaW5nIHRlc3QgY2Fz
ZXMgYXJlIGJyb2tlbiBhbmQgd2lsbCBub3QgZXhlY3V0ZSBjb3JyZWN0bHksIGJlY2F1c2Ugc29t
ZSBwcmVjb25kaXRpb24gbm90IG1ldCwgc3VjaCBhcyBhIHJlc291cmNlIG5vdCBiZWluZyBhdmFp
bGFibGUuPC9saT4NCjxsaT48Yj5UQ09ORiAtPC9iPiBJbmRpY2F0ZXMgdGhhdCB0aGUgdGVzdCBj
YXNlIHdhcyBub3Qgd3JpdHRlbiB0byBydW4gb24gdGhlIGN1cnJlbnQgaGFyd2FyZSBvciBzb2Z0
d2FyZSBjb25maWd1cmF0aW9uIHN1Y2ggYXMgbWFjaGluZSB0eXBlLCBvciwga2VybmVsIHZlcnNp
b24uPC9saT4NCjxsaT48Yj5UUkVUUiAtPC9iPiBJbmRpY2F0ZXMgdGhhdCB0aGUgdGVzdCBjYXNl
cyBoYXMgYmVlbiByZXRpcmVkIGFuZCBzaG91bGQgbm90IGJlIGV4ZWN1dGVkIGFueSBsb25nZXIu
PC9saT4NCjxsaT48Yj5UV0FSTiAtPC9iPiBJbmRpY2F0ZXMgdGhhdCB0aGUgdGVzdCBjYXNlIGV4
cGVyaWVuY2VkIGFuIHVuZXhwZWN0ZWQgb3IgdW5kZXNpcmFibGUgZXZlbnQgdGhhdCBzaG91bGQg
bm90IGFmZmVjdCB0aGUgdGVzdCBpdHNlbGYgc3VjaCBhcyBiZWluZyB1bmFibGUgdG8gY2xlYW51
cCByZXNvdXJjZXMgYWZ0ZXIgdGhlIHRlc3QgZmluaXNoZWQuPC9saT4NCjxsaT48Yj5USU5GTyAt
PC9iPiBTcGVjaWZpZXMgdXNlZnVsIGluZm9ybWF0aW9uIGFib3V0IHRoZSBzdGF0dXMgb2YgdGhl
IHRlc3QgdGhhdCBkb2VzIG5vdCBhZmZlY3QgdGhlIHJlc3VsdCBhbmQgZG9lcyBub3QgaW5kaWNh
dGUgYSBwcm9ibGVtLjwvbGk+DQo8aHI+DQoNCjxicj4NCjxsaT48YSBocmVmPSIjXzEiPkNsaWNr
IEhlcmUgZm9yIERldGFpbGVkIFJlcG9ydDwvYT48L2xpPg0KPGxpPjxhIGhyZWY9IiNfMiI+Q2xp
Y2sgSGVyZSBmb3IgU3VtbWFyeSBSZXBvcnQ8L2E+PC9saT4NCjxicj4NCg0KPGgyIGlkPSJfMSI+
RGV0YWlsZWQgUmVwb3J0PC9oMj4NCjxkaXY+DQo8dGFibGUgYm9yZGVyPSIxIiBjZWxsc3BhY2lu
Zz0iMyI+IA0KPHRib2R5Pg0KICAgIDx0cj4NCiAgICAgIDx0ZCBiZ2NvbG9yPSJTaWx2ZXIiPjxz
dHJvbmc+Tm88L3N0cm9uZz48L3RkPg0KICAgICAgPHRkIGJnY29sb3I9IlNpbHZlciI+PHN0cm9u
Zz5UZXN0LU5hbWU8L3N0cm9uZz48L3RkPg0KICAgICAgPHRkIGJnY29sb3I9IlNpbHZlciI+PHN0
cm9uZz5TdGFydC1UaW1lPC9zdHJvbmc+PC90ZD4NCiAgICAgIDx0ZCBiZ2NvbG9yPSJTaWx2ZXIi
PjxzdHJvbmc+Q29tbWFuZC1MaW5lPC9zdHJvbmc+PC90ZD4NCiAgICAgIDx0ZCBiZ2NvbG9yPSJT
aWx2ZXIiPjxzdHJvbmc+Q29udGFjdHM8L3N0cm9uZz48L3RkPg0KICAgICAgPHRkIGJnY29sb3I9
IlNpbHZlciI+PHN0cm9uZz5BbmFseXNpczwvc3Ryb25nPjwvdGQ+DQogICAgICA8dGQgYmdjb2xv
cj0iU2lsdmVyIj48c3Ryb25nPkluaXRpYXRpb24tU3RhdHVzPC9zdHJvbmc+PC90ZD4NCiAgICAg
IDx0ZCBiZ2NvbG9yPSJTaWx2ZXIiPjxzdHJvbmc+VGVzdC1PdXRwdXQ8L3N0cm9uZz48L3RkPg0K
ICAgICAgPHRkIGJnY29sb3I9IlNpbHZlciI+PHN0cm9uZz5EdXJhdGlvbjwvc3Ryb25nPjwvdGQ+
DQogICAgICA8dGQgYmdjb2xvcj0iU2lsdmVyIj48c3Ryb25nPlRlcm1pbmF0aW9uLXR5cGU8L3N0
cm9uZz48L3RkPg0KICAgICAgPHRkIGJnY29sb3I9IlNpbHZlciI+PHN0cm9uZz5UZXJtaW5hdGlv
bi1pZDwvc3Ryb25nPjwvdGQ+DQogICAgICA8dGQgYmdjb2xvcj0iU2lsdmVyIj48c3Ryb25nPkNv
cmUtRmlsZTwvc3Ryb25nPjwvdGQ+DQogICAgICA8dGQgYmdjb2xvcj0iU2lsdmVyIj48c3Ryb25n
PmN1dGltZTwvc3Ryb25nPjwvdGQ+DQogICAgICA8dGQgYmdjb2xvcj0iU2lsdmVyIj48c3Ryb25n
PmNzdGltZTwvc3Ryb25nPjwvdGQ+DQogICAgPC90cj4NCjx0ciBiZ2NvbG9yPSM2NmZmNjY+PHRk
PjxwPjxzdHJvbmc+MTwvc3Ryb25nPjwvcD48L3RkPg0KPHRkPjxwPjxzdHJvbmc+YWNjZXB0MDE8
L3N0cm9uZz48L3A+PC90ZD4NCjx0ZD48cD48cHJlPjxzdHJvbmc+RnJpIEp1biAxOSAwNToyMjo0
MCAyMDA5PC9zdHJvbmc+PC9wcmU+PC9wPjwvdGQ+DQo8dGQ+PHA+PHN0cm9uZz4gImFjY2VwdDAx
IiA8L3N0cm9uZz48L3A+PC90ZD4NCjx0ZD48cD48c3Ryb25nPiIiPC9zdHJvbmc+PC9wPjwvdGQ+
DQo8dGQ+PHA+PHN0cm9uZz5leGl0PC9zdHJvbmc+PC9wPjwvdGQ+DQo8dGQ+PHA+PHN0cm9uZz4i
b2siPC9zdHJvbmc+PC9wPjwvdGQ+DQo8dGQ+PHByZT48c3Ryb25nPmFjY2VwdDAxICAgIDEgIFBB
U1MgIDogIGJhZCBmaWxlIGRlc2NyaXB0b3Igc3VjY2Vzc2Z1bCANCmFjY2VwdDAxICAgIDIgIFBB
U1MgIDogIGJhZCBmaWxlIGRlc2NyaXB0b3Igc3VjY2Vzc2Z1bCANCmFjY2VwdDAxICAgIDMgIFBB
U1MgIDogIGludmFsaWQgc29ja2V0IGJ1ZmZlciBzdWNjZXNzZnVsIA0KYWNjZXB0MDEgICAgNCAg
UEFTUyAgOiAgaW52YWxpZCBzYWxlbiBzdWNjZXNzZnVsIA0KYWNjZXB0MDEgICAgNSAgUEFTUyAg
OiAgaW52YWxpZCBzYWxlbiBzdWNjZXNzZnVsIA0KYWNjZXB0MDEgICAgNiAgUEFTUyAgOiAgbm8g
cXVldWVkIGNvbm5lY3Rpb25zIHN1Y2Nlc3NmdWwgDQphY2NlcHQwMSAgICA3ICBQQVNTICA6ICBV
RFAgYWNjZXB0IHN1Y2Nlc3NmdWwgDQppbmNyZW1lbnRpbmcgc3RvcCANCjwvc3Ryb25nPjwvcHJl
PjwvdGQ+PHRkPjxwPjxzdHJvbmc+MDwvc3Ryb25nPjwvcD48L3RkPg0KPHRkPjxwPjxzdHJvbmc+
ZXhpdGVkPHN0cm9uZz48L3A+PC90ZD4NCjx0ZD48cD48c3Ryb25nPjA8L3N0cm9uZz48L3A+PC90
ZD4NCjx0ZD48cD48c3Ryb25nPm5vPC9zdHJvbmc+PC9wPjwvdGQ+DQo8dGQ+PHA+PHN0cm9uZz4w
PC9zdHJvbmc+PC9wPjwvdGQ+DQo8dGQ+PHA+PHN0cm9uZz4wPC9zdHJvbmc+PC9wPjwvdGQ+PC90
cj4NCjwvdGJvZHk+PC90YWJsZT48L2Rpdj4gDQoNCjxoMiBpZD0iXzIiPlN1bW1hcnkgUmVwb3J0
PC9oMj4NCg0KPGRpdj4NCg0KPHRhYmxlIGJvcmRlcj0iMSIgY2VsbHNwYWNpbmc9IjMiPjx0Ym9k
eT4NCjx0cj4NCjx0ZCBiZ2NvbG9yPSIjNjZmZjY2Ij4gPHN0cm9uZz5UZXN0IFN1bW1hcnk8L3N0
cm9uZz48L3A+PC90ZD48dGQgYmdjb2xvcj0iIzY2ZmY2NiI+PHN0cm9uZz5QYW4gcmVwb3J0ZWQg
YWxsIFRlc3QgUGFzczwvc3Ryb25nPjwvcD48L3RkPjwvdHI+DQo8dHI+PHRkPjxzdHJvbmc+TFRQ
IFZlcnNpb248L3N0cm9uZz4gPC90ZD48dGQ+PHN0cm9uZz4gTFRQLTIwMDkwNTMxICAgICA8L3N0
cm9uZz48L3RkPjwvdHI+DQo8dHI+PHRkPjxzdHJvbmc+U3RhcnQgVGltZTwvc3Ryb25nPiAgPC90
ZD48dGQ+PHN0cm9uZz4gRnJpIEp1biAxOSAwNToyMjo0MCBKU1QgMjAwOSA8L3N0cm9uZz48L3Rk
PjwvdHI+DQo8dHI+PHRkPjxzdHJvbmc+RW5kIFRpbWU8L3N0cm9uZz4gICAgPC90ZD48dGQ+PHN0
cm9uZz4gRnJpIEp1biAxOSAwNToyMjo0MCBKU1QgMjAwOSAgIDwvc3Ryb25nPjwvdGQ+PC90cj4N
Cjx0cj48dGQ+PHN0cm9uZz5Mb2cgUmVzdWx0PC9zdHJvbmc+ICA8L3RkPjx0ZD48YSBocmVmPSJm
aWxlOi8vL21udC9sdHAtZnVsbC0yMDA5MDUzMS9yZXN1bHRzLyI+ICAgICAgPHN0cm9uZz4vbW50
L2x0cC1mdWxsLTIwMDkwNTMxL3Jlc3VsdHM8L3N0cm9uZz48L2E+PC90ZD48L3RyPg0KPHRyPjx0
ZD48c3Ryb25nPk91dHB1dC9GYWlsZWQgUmVzdWx0PC9zdHJvbmc+PC90ZD48dGQ+PGEgaHJlZj0i
ZmlsZTovLy9tbnQvbHRwLWZ1bGwtMjAwOTA1MzEvb3V0cHV0LyI+IDxzdHJvbmc+L21udC9sdHAt
ZnVsbC0yMDA5MDUzMS9vdXRwdXQ8L3N0cm9uZz48L2E+PC90ZD48L3RyPg0KPHRyPjx0ZD48c3Ry
b25nPlRvdGFsIFRlc3RzPC9zdHJvbmc+PC90ZD48dGQ+PHN0cm9uZz4xICAgICAgICAgICAgICAg
ICAgICAgICAgIDwvc3Ryb25nPjwvdGQ+PC90cj4NCjx0cj48dGQ+PHN0cm9uZz5Ub3RhbCBUZXN0
IFRQQVNTOjwvc3Ryb25nPjwvdGQ+PHRkPjxzdHJvbmc+IDEgPC9zdHJvbmc+PC90ZD48L3RyPg0K
PHRyPjx0ZD48c3Ryb25nPlRvdGFsIFRlc3QgVEZBSUw6PC9zdHJvbmc+PC90ZD48dGQ+PHN0cm9u
Zz4gMCA8L3N0cm9uZz48L3RkPjwvdHI+DQo8dHI+PHRkPjxzdHJvbmc+VG90YWwgVGVzdCBUQlJP
Szwvc3Ryb25nPjwvdGQ+PHRkPjxzdHJvbmc+IDAgPC9zdHJvbmc+PC90ZD48L3RyPg0KPHRyPjx0
ZD48c3Ryb25nPlRvdGFsIFRlc3QgVFdBUk48L3N0cm9uZz48L3RkPjx0ZD48c3Ryb25nPiAwIDwv
c3Ryb25nPjwvdGQ+PC90cj4NCjx0cj48dGQ+PHN0cm9uZz5Ub3RhbCBUZXN0IFRSRVRSPC9zdHJv
bmc+PC90ZD48dGQ+PHN0cm9uZz4gMCA8L3N0cm9uZz48L3RkPjwvdHI+DQo8dHI+PHRkPjxzdHJv
bmc+VG90YWwgVGVzdCBUQ09ORjwvc3Ryb25nPjwvdGQ+PHRkPjxzdHJvbmc+IDAgPC9zdHJvbmc+
PC90ZD48L3RyPg0KPHRyPjx0ZD48c3Ryb25nPktlcm5lbCBWZXJzaW9uPC9zdHJvbmc+PC90ZD48
dGQ+PHN0cm9uZz4gICA8L3N0cm9uZz48L3RkPjwvdHI+DQo8dHI+PHRkPjxzdHJvbmc+TWFjaGlu
ZSBBcmNoaXRlY3R1cmU8L3N0cm9uZz48L3RkPjx0ZD48c3Ryb25nPiAgPC9zdHJvbmc+PC90ZD48
L3RyPg0KPHRyPjx0ZD48c3Ryb25nPkhvc3RuYW1lPC9zdHJvbmc+ICA8L3RkPiA8dGQ+PHN0cm9u
Zz40My44OC4xMDEuMjA3DQogIDwvc3Ryb25nPjwvdGQ+PC90cj48L3Rib2R5PjwvdGFibGU+PC9k
aXY+PC9ib2R5PjwvaHRtbD4NCg==
--001e680f11d8d3e795046ca0c85c
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
--001e680f11d8d3e795046ca0c85c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f11d8d3e795046ca0c85c--

