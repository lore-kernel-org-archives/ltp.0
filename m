Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <saileshcv@gmail.com>) id 1NnnIB-0003S0-T5
	for ltp-list@lists.sourceforge.net; Sat, 06 Mar 2010 06:15:15 +0000
Received: from mail-iw0-f202.google.com ([209.85.223.202])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NnnIA-0008Kv-VX
	for ltp-list@lists.sourceforge.net; Sat, 06 Mar 2010 06:15:15 +0000
Received: by iwn40 with SMTP id 40so835226iwn.1
	for <ltp-list@lists.sourceforge.net>;
	Fri, 05 Mar 2010 22:15:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41003050251y2faacc92i1ae46f702c3b9ac6@mail.gmail.com>
References: <41c7690d1003032130i6b61968bjc175698937dc0051@mail.gmail.com>
	<20100304125514.GA21634@linux.vnet.ibm.com>
	<41c7690d1003042154s68cd8416hf6ebf17f96e50a8b@mail.gmail.com>
	<364299f41003042214g5501130bj114db6695e762044@mail.gmail.com>
	<41c7690d1003042254w301c8056nd553b46c970ee473@mail.gmail.com>
	<364299f41003042304p1ddc6a2cy5769aaaeb7bd729c@mail.gmail.com>
	<41c7690d1003050034g3459cc50rd6ae43b162df10c7@mail.gmail.com>
	<364299f41003050251y2faacc92i1ae46f702c3b9ac6@mail.gmail.com>
Date: Sat, 6 Mar 2010 11:45:09 +0530
Message-ID: <41c7690d1003052215x19bd0763y5ed5f474c55e739a@mail.gmail.com>
From: Silesh C V <saileshcv@gmail.com>
Subject: Re: [LTP] [PATCH-v3] RTC Device Driver Tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7245832234853336420=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

--===============7245832234853336420==
Content-Type: multipart/alternative; boundary=0016e64980fe03484804811bc1df

--0016e64980fe03484804811bc1df
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 5, 2010 at 4:21 PM, Garrett Cooper <yanegomi@gmail.com> wrote:

> On Fri, Mar 5, 2010 at 12:34 AM, Silesh C V <saileshcv@gmail.com> wrote:
> > On 3/5/10, Garrett Cooper <yanegomi@gmail.com> wrote:
> >> On Thu, Mar 4, 2010 at 10:54 PM, Silesh C V <saileshcv@gmail.com>
> wrote:
> >>> On 3/5/10, Garrett Cooper <yanegomi@gmail.com> wrote:
> >>>> On Thu, Mar 4, 2010 at 9:54 PM, Silesh C V <saileshcv@gmail.com>
> wrote:
> >>>>> On 3/4/10, Rishikesh K Rajak <risrajak@linux.vnet.ibm.com> wrote:
> >>>>>>>Rishi,
> >>>>>>
> >>>>>>>Can you test this patch on the machine on which the tests got stuc=
k
> >>>>>>>earlier?
> >>>>>>
> >>>>>> Yes i tested and found that, it is failing.
> >>>>>
> >>>>> It is supposed to fail :) . What we  wanted was a way to come out o=
f
> >>>>> the tests if the
> >>>>> alarm fails to ring.
> >>>>>
> >>>>>
> >>>>>>
> >>>>>> [root@x335a rtc]# ./rtc-test /dev/rtc
> >>>>>> rtc01       0  TINFO  :  RTC READ TEST:
> >>>>>> rtc01       1  TPASS  :  RTC READ TEST Passed
> >>>>>> rtc01       0  TINFO  :  Current Date/time is  03/03/10 12:38:26 P=
M
> >>>>>> rtc01       0  TINFO  :  RTC ALARM TEST :
> >>>>>> rtc01       0  TINFO  :  Alarm time set to 12:38:31.
> >>>>>> rtc01       0  TINFO  :  Waiting 5 seconds for the alarm...
> >>>>>> rtc01       2  TFAIL  :  Timed out waiting for the alarm
> >>>>>> rtc01       0  TINFO  :  RTC UPDATE INTERRUPTS TEST :
> >>>>>> rtc01       0  TINFO  :  Waiting for  5 update interrupts...
> >>>>>> rtc01       0  TINFO  :  Update interrupt 1
> >>>>>> rtc01       0  TINFO  :  Update interrupt 2
> >>>>>> rtc01       0  TINFO  :  Update interrupt 3
> >>>>>> rtc01       0  TINFO  :  Update interrupt 4
> >>>>>> rtc01       0  TINFO  :  Update interrupt 5
> >>>>>> rtc01       3  TPASS  :  RTC UPDATE INTERRUPTS TEST Passed
> >>>>>> rtc01       0  TINFO  :  RTC Tests Done!
> >>>>>> [root@x335a rtc]# ls -l /dev/rtc*
> >>>>>> crw-r--r-- 1 root root 10, 135 Feb 20 13:51 /dev/rtc
> >>>>>> [root@x335a rtc]#
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> In fact while compiling there is some warning also.
> >>>>>> [root@x335a rtc]# make
> >>>>>> cc rtc-test.c -O2 -Wall -I ../../../../include/ -L ../../../../lib=
/
> >>>>>> -lltp  -o rtc-test
> >>>>>> rtc-test.c: In function =91read_alarm_test=92:
> >>>>>> rtc-test.c:64: warning: dereferencing type-punned pointer will bre=
ak
> >>>>>> strict-aliasing rules
> >>>>>
> >>>>> I did not get this warning on gcc-4.3.0 . Anyways I think we can ge=
t
> rid
> >>>>> of this
> >>>>> warning by using -fno-strict-aliasing option at the cost of some
> >>>>> optimizations.
> >>>>> I will send you another patch.
> >>>>>
> >>>>
> >>>> Or maybe just fix the code to not type-pun by converting everything =
to
> >>>> struct tm on the fly?
> >>>>
> >>>> Let's look at the difference between the two structures:
> >>>>
> >>>> struct rtc_time {
> >>>>         int tm_sec;
> >>>>         int tm_min;
> >>>>         int tm_hour;
> >>>>         int tm_mday;
> >>>>         int tm_mon;
> >>>>         int tm_year;
> >>>>         int tm_wday;
> >>>>         int tm_yday;
> >>>>         int tm_isdst;
> >>>> };
> >>>>
> >>>> struct tm
> >>>> {
> >>>>   int tm_sec;                   /* Seconds.     [0-60] (1 leap secon=
d)
> */
> >>>>   int tm_min;                   /* Minutes.     [0-59] */
> >>>>   int tm_hour;                  /* Hours.       [0-23] */
> >>>>   int tm_mday;                  /* Day.         [1-31] */
> >>>>   int tm_mon;                   /* Month.       [0-11] */
> >>>>   int tm_year;                  /* Year - 1900.  */
> >>>>   int tm_wday;                  /* Day of week. [0-6] */
> >>>>   int tm_yday;                  /* Days in year.[0-365] */
> >>>>   int tm_isdst;                 /* DST.         [-1/0/1]*/
> >>>>
> >>>> #ifdef  __USE_BSD
> >>>>   long int tm_gmtoff;           /* Seconds east of UTC.  */
> >>>>   __const char *tm_zone;        /* Timezone abbreviation.  */
> >>>> #else
> >>>>   long int __tm_gmtoff;         /* Seconds east of UTC.  */
> >>>>   __const char *__tm_zone;      /* Timezone abbreviation.  */
> >>>> #endif
> >>>> };
> >>>>
> >>>> Note the extra fields down below -- they increase the structure size
> >>>> by a non-trivial amount (12 bytes on 32-bit, 16 bytes on 64-bit),
> >>>> which means that if one of the following two cases are made in
> >>>> strftime tomorrow:
> >>>>
> >>>> 1. They use one of the timezone fields and it isn't properly cleared
> >>>> (not the case today, but it could be on some older versions of Linux=
).
> >>>> 2. They make assumptions about the size of the memory allocated and
> >>>> thus go out of bounds.
> >>>>
> >>>> BOOM! Segfault... could worse happen in this case after the ioctl is
> >>>> written out to /dev/rtc ?
> >>>
> >>> OK. Can we drop strftime then ?
> >>
> >> Why couldn't you memset ( , 0, ) the value and set the individual
> >> fields?
> >
> >
> > Sorry . But I could not understand what you meant by setting the
> > individual fields.
>
> struct tm thetime;
>
> memset(&thetime, 0, sizeof(thetime));
> thetime.tm_sec =3D rtc_tm.tm_sec;
> /* ... */
>

I think doing this just for formatting and printing the time is a slight
overhead.
The  better approach would be to  print the time by accessing
the individual fields so that we can avoid all the conversion and type
casting
from rtc_tm to tm . Although we will miss some of the great features of
sfrtime,
this will save the code from being unnecessarily complex.I will send anothe=
r
patch
omitting sfrtime.


Thanks,
Silesh


>
> >  One of the awesome things about strftime is that it's
> >> localization aware if you use the right format strings (I know -- a
> >> functional nice to have, not necessarily a need to have).
> >>
> >> Unfortunately one of 'em is American friendly only :/ :
> >>
> >>        %D     Equivalent  to  %m/%d/%y.  (Yecch -- for Americans only.
> >> Ameri-
> >>               cans should note that in other countries %d/%m/%y is
> rather
> >> com-
> >>               mon.   This  means  that in international context this
> format
> >> is
> >>               ambiguous and should not be used.) (SU)
> >>
> >>>>>> Please solve these problems and please send me a revised patch.
> >>
> >> Thanks,
> >> -Garrett
> >>
> > Thanks,
> > Silesh
> >
> > --
> > Silesh
> >
>



--=20
Silesh

--0016e64980fe03484804811bc1df
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Mar 5, 2010 at 4:21 PM, Garrett =
Cooper <span dir=3D"ltr">&lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi=
@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
<div><div></div><div class=3D"h5">On Fri, Mar 5, 2010 at 12:34 AM, Silesh C=
 V &lt;<a href=3D"mailto:saileshcv@gmail.com">saileshcv@gmail.com</a>&gt; w=
rote:<br>
&gt; On 3/5/10, Garrett Cooper &lt;<a href=3D"mailto:yanegomi@gmail.com">ya=
negomi@gmail.com</a>&gt; wrote:<br>
&gt;&gt; On Thu, Mar 4, 2010 at 10:54 PM, Silesh C V &lt;<a href=3D"mailto:=
saileshcv@gmail.com">saileshcv@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt; On 3/5/10, Garrett Cooper &lt;<a href=3D"mailto:yanegomi@gmail=
.com">yanegomi@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt; On Thu, Mar 4, 2010 at 9:54 PM, Silesh C V &lt;<a href=3D"=
mailto:saileshcv@gmail.com">saileshcv@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt; On 3/4/10, Rishikesh K Rajak &lt;<a href=3D"mailto:ris=
rajak@linux.vnet.ibm.com">risrajak@linux.vnet.ibm.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;Rishi,<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;Can you test this patch on the machine on which=
 the tests got stuck<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;earlier?<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Yes i tested and found that, it is failing.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; It is supposed to fail :) . What we =A0wanted was a wa=
y to come out of<br>
&gt;&gt;&gt;&gt;&gt; the tests if the<br>
&gt;&gt;&gt;&gt;&gt; alarm fails to ring.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; [root@x335a rtc]# ./rtc-test /dev/rtc<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0RTC READ TEST=
:<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 1 =A0TPASS =A0: =A0RTC READ TEST=
 Passed<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Current Date/=
time is =A003/03/10 12:38:26 PM<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0RTC ALARM TES=
T :<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Alarm time se=
t to 12:38:31.<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Waiting 5 sec=
onds for the alarm...<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 2 =A0TFAIL =A0: =A0Timed out wai=
ting for the alarm<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0RTC UPDATE IN=
TERRUPTS TEST :<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Waiting for =
=A05 update interrupts...<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interr=
upt 1<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interr=
upt 2<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interr=
upt 3<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interr=
upt 4<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interr=
upt 5<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 3 =A0TPASS =A0: =A0RTC UPDATE IN=
TERRUPTS TEST Passed<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0RTC Tests Don=
e!<br>
&gt;&gt;&gt;&gt;&gt;&gt; [root@x335a rtc]# ls -l /dev/rtc*<br>
&gt;&gt;&gt;&gt;&gt;&gt; crw-r--r-- 1 root root 10, 135 Feb 20 13:51 /dev/r=
tc<br>
&gt;&gt;&gt;&gt;&gt;&gt; [root@x335a rtc]#<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; In fact while compiling there is some warning also=
.<br>
&gt;&gt;&gt;&gt;&gt;&gt; [root@x335a rtc]# make<br>
&gt;&gt;&gt;&gt;&gt;&gt; cc rtc-test.c -O2 -Wall -I ../../../../include/ -L=
 ../../../../lib/<br>
&gt;&gt;&gt;&gt;&gt;&gt; -lltp =A0-o rtc-test<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc-test.c: In function =91read_alarm_test=92:<br>
&gt;&gt;&gt;&gt;&gt;&gt; rtc-test.c:64: warning: dereferencing type-punned =
pointer will break<br>
&gt;&gt;&gt;&gt;&gt;&gt; strict-aliasing rules<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I did not get this warning on gcc-4.3.0 . Anyways I th=
ink we can get rid<br>
&gt;&gt;&gt;&gt;&gt; of this<br>
&gt;&gt;&gt;&gt;&gt; warning by using -fno-strict-aliasing option at the co=
st of some<br>
&gt;&gt;&gt;&gt;&gt; optimizations.<br>
&gt;&gt;&gt;&gt;&gt; I will send you another patch.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Or maybe just fix the code to not type-pun by converting e=
verything to<br>
&gt;&gt;&gt;&gt; struct tm on the fly?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Let&#39;s look at the difference between the two structure=
s:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; struct rtc_time {<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 int tm_sec;<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 int tm_min;<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 int tm_hour;<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 int tm_mday;<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 int tm_mon;<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 int tm_year;<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 int tm_wday;<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 int tm_yday;<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 int tm_isdst;<br>
&gt;&gt;&gt;&gt; };<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; struct tm<br>
&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt; =A0 int tm_sec; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Sec=
onds. =A0 =A0 [0-60] (1 leap second) */<br>
&gt;&gt;&gt;&gt; =A0 int tm_min; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Min=
utes. =A0 =A0 [0-59] */<br>
&gt;&gt;&gt;&gt; =A0 int tm_hour; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Hou=
rs. =A0 =A0 =A0 [0-23] */<br>
&gt;&gt;&gt;&gt; =A0 int tm_mday; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Day=
. =A0 =A0 =A0 =A0 [1-31] */<br>
&gt;&gt;&gt;&gt; =A0 int tm_mon; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Mon=
th. =A0 =A0 =A0 [0-11] */<br>
&gt;&gt;&gt;&gt; =A0 int tm_year; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Yea=
r - 1900. =A0*/<br>
&gt;&gt;&gt;&gt; =A0 int tm_wday; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Day=
 of week. [0-6] */<br>
&gt;&gt;&gt;&gt; =A0 int tm_yday; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Day=
s in year.[0-365] */<br>
&gt;&gt;&gt;&gt; =A0 int tm_isdst; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DST. =
=A0 =A0 =A0 =A0 [-1/0/1]*/<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; #ifdef =A0__USE_BSD<br>
&gt;&gt;&gt;&gt; =A0 long int tm_gmtoff; =A0 =A0 =A0 =A0 =A0 /* Seconds eas=
t of UTC. =A0*/<br>
&gt;&gt;&gt;&gt; =A0 __const char *tm_zone; =A0 =A0 =A0 =A0/* Timezone abbr=
eviation. =A0*/<br>
&gt;&gt;&gt;&gt; #else<br>
&gt;&gt;&gt;&gt; =A0 long int __tm_gmtoff; =A0 =A0 =A0 =A0 /* Seconds east =
of UTC. =A0*/<br>
&gt;&gt;&gt;&gt; =A0 __const char *__tm_zone; =A0 =A0 =A0/* Timezone abbrev=
iation. =A0*/<br>
&gt;&gt;&gt;&gt; #endif<br>
&gt;&gt;&gt;&gt; };<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Note the extra fields down below -- they increase the stru=
cture size<br>
&gt;&gt;&gt;&gt; by a non-trivial amount (12 bytes on 32-bit, 16 bytes on 6=
4-bit),<br>
&gt;&gt;&gt;&gt; which means that if one of the following two cases are mad=
e in<br>
&gt;&gt;&gt;&gt; strftime tomorrow:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; 1. They use one of the timezone fields and it isn&#39;t pr=
operly cleared<br>
&gt;&gt;&gt;&gt; (not the case today, but it could be on some older version=
s of Linux).<br>
&gt;&gt;&gt;&gt; 2. They make assumptions about the size of the memory allo=
cated and<br>
&gt;&gt;&gt;&gt; thus go out of bounds.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; BOOM! Segfault... could worse happen in this case after th=
e ioctl is<br>
&gt;&gt;&gt;&gt; written out to /dev/rtc ?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; OK. Can we drop strftime then ?<br>
&gt;&gt;<br>
&gt;&gt; Why couldn&#39;t you memset ( , 0, ) the value and set the individ=
ual<br>
&gt;&gt; fields?<br>
&gt;<br>
&gt;<br>
&gt; Sorry . But I could not understand what you meant by setting the<br>
&gt; individual fields.<br>
<br>
</div></div>struct tm thetime;<br>
<br>
memset(&amp;thetime, 0, sizeof(thetime));<br>
thetime.tm_sec =3D rtc_tm.tm_sec;<br>
/* ... */<br></blockquote><div><br>I think doing this just for formatting a=
nd printing the time is a slight overhead.<br>The=A0 better approach would =
be to=A0 print the time by accessing <br>the individual fields so that we c=
an avoid all the conversion and type casting<br>
from rtc_tm to tm . Although we will miss some of the great features of sfr=
time,<br>this will save the code from being unnecessarily complex.I will se=
nd another patch<br>omitting sfrtime.<br><br><br>Thanks,<br>Silesh<br>=A0</=
div>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5"><br>
&gt; =A0One of the awesome things about strftime is that it&#39;s<br>
&gt;&gt; localization aware if you use the right format strings (I know -- =
a<br>
&gt;&gt; functional nice to have, not necessarily a need to have).<br>
&gt;&gt;<br>
&gt;&gt; Unfortunately one of &#39;em is American friendly only :/ :<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0 =A0 =A0%D =A0 =A0 Equivalent =A0to =A0%m/%d/%y. =A0(Yecch =
-- for Americans only.<br>
&gt;&gt; Ameri-<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 cans should note that in other countri=
es %d/%m/%y is rather<br>
&gt;&gt; com-<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 mon. =A0 This =A0means =A0that in inte=
rnational context this format<br>
&gt;&gt; is<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ambiguous and should not be used.) (SU=
)<br>
&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Please solve these problems and please send me a r=
evised patch.<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; -Garrett<br>
&gt;&gt;<br>
&gt; Thanks,<br>
&gt; Silesh<br>
&gt;<br>
&gt; --<br>
&gt; Silesh<br>
&gt;<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Silesh<br>

--0016e64980fe03484804811bc1df--


--===============7245832234853336420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============7245832234853336420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7245832234853336420==--

