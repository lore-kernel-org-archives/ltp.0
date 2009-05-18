Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1M64P6-0004wh-7i
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 15:05:27 +0000
Received: from smtp104.biz.mail.re2.yahoo.com ([206.190.52.173])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1M64P4-0005iG-IP
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 15:05:24 +0000
Date: Mon, 18 May 2009 19:12:43 +0800 (CST)
Message-Id: <20090518.191243.15248034.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
	boundary="--Next_Part(Mon_May_18_19_12_43_2009_530)--"
Content-Transfer-Encoding: 7bit
Subject: [LTP] Fw:  Regarding ht_enable test case failure
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
To: ltp-list@lists.sourceforge.net

----Next_Part(Mon_May_18_19_12_43_2009_530)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Forwarding the patch from Rohit, so someone has an i386 system with HT
capable processors may try it out.

CAI Qian

----Next_Part(Mon_May_18_19_12_43_2009_530)--
Content-Type: Message/Rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

X-Apparently-To: caiqian@cclom.cn via 74.6.114.48;
	Fri, 15 May 2009 05:55:39 -0700
X-Originating-IP: [72.14.220.153]
Authentication-Results: mta107.biz.mail.mud.yahoo.com  from=gmail.com;
	domainkeys=pass (ok); from=gmail.com; dkim=pass (ok)
Received: from 72.14.220.153  (EHLO fg-out-1718.google.com) (72.14.220.153)
	by mta107.biz.mail.mud.yahoo.com with SMTP;
	Fri, 15 May 2009 05:55:37 -0700
Received: by fg-out-1718.google.com with SMTP id e12so108158fga.12
	for <caiqian@cclom.cn>; Fri, 15 May 2009 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:in-reply-to:references
	:date:message-id:subject:from:to:content-type;
	bh=3JMJ8MixIUnWfzvKnEmLcJZrDW/npBXcNmzf7EH+qJc=;
	b=c473qS9/WZphVoq/j/NLFLTPOHKnujRCNPTh+ZXyZoV2RLubiBRJZuNegWUxyf3Guj
	J7F2CLzxG8iB7s/Edaf3+fvobh5igRzklmcoTQ4GA9QpIV6YEN1Y6uuGjRLkT4yYLpLu
	COUa4gxerAB308EuTrFOuBkYTJ39HygdJjCy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:content-type;
	b=jxrqej9+MqgtTUhOS9XRkFkVhrikqYL7xRQLXck0dUPBbKugtsVExQ2picZktGessA
	uNOmUviKiSthKu3aamckXZ+mZY/Fmv4vCluBleZqUr/7kehtitudu+fjRlBghXoSqqRs
	3E60ztNJiqenPo+sNtU6eI0xyzKvJMrw+78cQ=
MIME-Version: 1.0
Received: by 10.86.33.9 with SMTP id g9mr3618199fgg.66.1242392135560; Fri, 15 
	May 2009 05:55:35 -0700 (PDT)
In-Reply-To: <d51f89b0905150450l6506055dr36337f6096d17e9a@mail.gmail.com>
References: <736339.6426.qm@web1112.biz.mail.sk1.yahoo.com>
	<d51f89b0905130233r4e3b5bd4tfc3e4cae549e1194@mail.gmail.com>
	<20090513.234703.112605595.caiqian@cclom.cn>
	<d51f89b0905150450l6506055dr36337f6096d17e9a@mail.gmail.com>
Date: Fri, 15 May 2009 18:25:35 +0530
Message-ID: <d51f89b0905150555t1e3e1822g47d6438ab08058d5@mail.gmail.com>
Subject: Re: [LTP] Regarding ht_enable test case failure
From: rohit verma <rohit.170309@gmail.com>
To: CAI Qian <caiqian@cclom.cn>
Content-Type: multipart/mixed; boundary=000e0cd29b2ce970a80469f2f556

--000e0cd29b2ce970a80469f2f556
Content-Type: multipart/alternative; boundary=000e0cd29b2ce970960469f2f554

--000e0cd29b2ce970960469f2f554
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

 Hi,

As written in the previous mail , I have modify some code.

PFA the patch for HT_affinity.Test is Passed in my system.

Kindly confirm that whether it is working fine on your system also.


Regards,
Rohit

On Fri, May 15, 2009 at 5:20 PM, rohit verma <rohit.170309@gmail.com> wrote:

> Dear CAI Qian,
>
> I am also trying to update HT_affinity also.
>
> Issues:
>
> function: HT_GetAffinity()
>
> Line: mask1=get_porc_affinity(pid);
>
> function, get_porc_affinity() returns error ; No such file or directory.
>
> This is due the that this file eg. /proc/<pid>/affinity is not present in
> my system FC10.
>
> Is it removed/changed?.
>
> Can you pls confirm that.
>
> If it is removed/changed then we can simply compare the values of mask and
> mask2 or modify the the path.
>
> Test is passed on my system after removing the same
>
> One more thing, system call sched_getaffinity returns 4.
>
> It should return 0 or -1.
>
> Is it bug in the kernel?.
>
> Thanks and Regards,
> Rohit
>
>
> On Wed, May 13, 2009 at 9:17 PM, CAI Qian <caiqian@cclom.cn> wrote:
>
>> From: rohit verma <rohit.170309@gmail.com>
>> Subject: Re: [LTP] Regarding ht_enable test case failure
>> Date: Wed, 13 May 2009 15:03:39 +0530
>>
>> > Hi,
>> >
>> > I want to update HT_enable test case in LTP.
>> >
>> > *HT_enabled:*Test for whether HT enabling is the default setting and the
>> > kernel option works as expected.
>> >
>> > *Issue:* Reported as failed in my System. However /proc/cpuinfo shows
>> two
>> > cpu and ht flag.
>> >
>>
>> If HT has been disabled in BIOS, you can still see the ht flag in
>> /proc/cpuinfo, so it is not enough to just look at it there. We have
>> looked at this before, and looks like the proper place to see if HT or
>> more generic term -- symmetrical multithreading (SMT) is sysfs (at least
>> for RHEL 5 kernels). There is a CPU topology information,
>>
>> /sys/devices/system/cpu/cpuX/topology/thread_siblings
>>
>> It looks like this,
>>
>> 00000001
>>
>> 00000002
>>
>> 00000008
>>
>> In all those case, It means there is no HT or SMT.
>>
>> If you see something like this,
>>
>> 00000003
>>
>> This one mean CPU0 and CPU1 are two threads in the same CPU core. This
>> is because the nth CPU id is,
>>
>> 2 raised to n.
>>
>> 3 = CPU0 (1) + CPU1 (2)
>>
>> There is also a tool to find out this information.
>>
>> lscpu from the latest utils-linux-ng package,
>> http://koji.fedoraproject.org/koji/packageinfo?packageID=4906
>>
>> > Can you pls tell me how to enable/disable hyperthreading in linux
>> kernel. I
>> > could not found proper document for the same.
>> >
>>
>> I am not sure if "noht" is still working. At least it has no effect in
>> RHEL5 kernel. Instead, it was suggested to use the following commands to
>> enable/disable it,
>>
>> From a public bug in Red Hat Bugzilla,
>> https://bugzilla.redhat.com/show_bug.cgi?id=440321
>>
>> "RHEL5 ships with CPU_HOTPLUG enabled.  This option allows a user to
>> disable and enable HW or HT cores.
>>
>> For example,
>>
>> I have a 4 cpu system with two HT processors.
>>
>> To disable the HT processors one can do:
>>
>> echo 0 > /sys/devices/system/node/node0/cpu1/online
>> echo 0 > /sys/devices/system/node/node0/cpu3/online
>>
>> You could write a system service script that does something similar to
>> (please note that this code is untested and is just a suggestion):
>>
>> grep noht /proc/cmdline
>>
>> if [ $? -eq 0 ]; then
>>     # noht specified on the command line, disabling HT cpus
>>     echo 0 > /sys/devices/system/node/node0/cpu1/online
>>     echo 0 > /sys/devices/system/node/node0/cpu3/online
>> fi
>> "
>>
>> > I also found that the check for kernel option "noht" is useless by
>> looking
>> > into code(HT_enabled.c).
>> >
>> > I think, we can remove that.
>>
>> I guess we can remove it if it is proved to be a dead option.
>>
>> CAI Qian
>>
>> >
>> > Regards,
>> >
>> > Rohit
>> >
>> > On Sat, Apr 11, 2009 at 2:25 PM, CAI Qian <caiqian@cclom.cn> wrote:
>> >>
>> >> Hi,
>> >>
>> >> --- On Mon, 3/30/09, rohit verma <rohit.170309@gmail.com> wrote:
>> >>
>> >>> From: rohit verma <rohit.170309@gmail.com>
>> >>> Subject: [LTP] Regarding ht_enable test case failure
>> >>> To: ltp-list@lists.sourceforge.net
>> >>> Date: Monday, March 30, 2009, 9:10 PM
>> >>> O/P:
>> >>>
>> >>>
>> >>> ht_enable    0  INFO  :
>> >>> Begin: HyperThreading Enabled
>> >>> ht_enable    0  INFO  :  The kernel boot paramter
>> >>> 'noht' is not set.
>> >>>
>> >>> ht_enable    1  FAIL  :  HT feature is not included
>> >>> in this Linux Kernel.
>> >>> ht_enable    0  INFO  :  End: HyperThreading Enabled
>> >>>
>> >>>
>> >>>
>> >>>
>> >>> but noht is for
>> >>> disabling
>> >>> hyperthreading.
>> >>>
>> >>>
>> >>>
>> >>> Function
>> >>> is_ht_kernel (file:
>> > testcases/kernel/sched/hyperthreading/ht_affinity/HTutils.c) checks for
>> >>> string cpu_package in /proc/cpuinfo
>> >>> .
>> >>>
>> >>>
>> >>>  but
>> >>> cpu_package string
>> >>>  information  does not exist in  /proc/cpuinfo for
>> >>> 2.6.29 kernel
>> >>>
>> >>
>> >> From the page,
>> >>
>> >>
>> >
>> https://lists.linux-foundation.org/pipermail/cgl_discussion/2002-October/002632.html
>> >>
>> >> looks like cpu_package has been added in 2.4.x kernel by HT patches.
>> >> Has this field been removed later? I can't see it with 2.6.18 kernel.
>> >>
>> >> I have copied the author of those tests - Sonic Zhang to see if he has
>> any
>> >> insight of it.
>> >>
>> >> Anyway, this piece of code seems check if the kernel has HT support or
>> > not.
>> >> I am not sure if we'll still need it, because HT support has been added
>> >> to kernel many years ago.
>> >>
>> >> CAI Qian
>> >>
>> >>>
>> >>>
>> >>>
>> >>> Regards,
>> >>> Rohit
>> >>>
>>
>
>

--000e0cd29b2ce970960469f2f554
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>=A0Hi,</div>
<div>=A0</div>
<div>As written in the previous mail , I have modify some code.</div>
<div>=A0</div>
<div>PFA the patch for HT_affinity.Test is=A0Passed in my system.</div>
<div>=A0</div>
<div>Kindly confirm that whether=A0it is working fine on your system also.<=
/div>
<div>=A0</div>
<div>=A0</div>
<div>Regards,</div>
<div>Rohit<br><br></div>
<div class=3D"gmail_quote">On Fri, May 15, 2009 at 5:20 PM, rohit verma <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:rohit.170309@gmail.com">rohit.170309@g=
mail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>Dear CAI Qian,</div>
<div>=A0</div>
<div>I am also trying to=A0update HT_affinity also.</div>
<div>=A0</div>
<div>Issues:</div>
<div>=A0</div>
<div>function: HT_GetAffinity()</div>
<div>=A0</div>
<div>Line:=A0mask1=3Dget_porc_affinity(pid);</div>
<div>=A0</div>
<div>function, get_porc_affinity() returns error ; No such file or director=
y.</div>
<div>=A0</div>
<div>This is due the that this file eg. /proc/&lt;pid&gt;/affinity=A0is not=
 present in my system FC10.</div>
<div>=A0</div>
<div>Is it removed/changed?.</div>
<div>=A0</div>
<div>Can you pls confirm that.</div>
<div>=A0</div>
<div>If it is removed/changed then we can simply compare the values of mask=
 and mask2 or modify the the path.</div>
<div>=A0</div>
<div>Test is passed on my system after removing the same</div>
<div>=A0</div>
<div>One more thing, system call sched_getaffinity returns 4.</div>
<div>=A0</div>
<div>It should return 0 or -1.</div>
<div>=A0</div>
<div>Is it bug in the kernel?.</div>
<div>=A0</div>
<div>Thanks and Regards,</div>
<div>Rohit</div>
<div>
<div></div>
<div class=3D"h5">
<div><br>=A0</div>
<div class=3D"gmail_quote">On Wed, May 13, 2009 at 9:17 PM, CAI Qian <span =
dir=3D"ltr">&lt;<a href=3D"mailto:caiqian@cclom.cn" target=3D"_blank">caiqi=
an@cclom.cn</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>From: rohit verma &lt;<a href=3D"mailto:rohit.170309@gmail.com" target=
=3D"_blank">rohit.170309@gmail.com</a>&gt;<br></div>Subject: Re: [LTP] Rega=
rding ht_enable test case failure<br>
<div>Date: Wed, 13 May 2009 15:03:39 +0530<br><br></div>
<div>&gt; Hi,<br>&gt;<br>&gt; I want to update HT_enable test case in LTP.<=
br>&gt;<br>&gt; *HT_enabled:*Test for whether HT enabling is the default se=
tting and the<br>&gt; kernel option works as expected.<br>&gt;<br>&gt; *Iss=
ue:* Reported as failed in my System. However /proc/cpuinfo shows two<br>
&gt; cpu and ht flag.<br>&gt;<br><br></div>If HT has been disabled in BIOS,=
 you can still see the ht flag in<br>/proc/cpuinfo, so it is not enough to =
just look at it there. We have<br>looked at this before, and looks like the=
 proper place to see if HT or<br>
more generic term -- symmetrical multithreading (SMT) is sysfs (at least<br=
>for RHEL 5 kernels). There is a CPU topology information,<br><br>/sys/devi=
ces/system/cpu/cpuX/topology/thread_siblings<br><br>It looks like this,<br>
<br>00000001<br><br>00000002<br><br>00000008<br><br>In all those case, It m=
eans there is no HT or SMT.<br><br>If you see something like this,<br><br>0=
0000003<br><br>This one mean CPU0 and CPU1 are two threads in the same CPU =
core. This<br>
is because the nth CPU id is,<br><br>2 raised to n.<br><br>3 =3D CPU0 (1) +=
 CPU1 (2)<br><br>There is also a tool to find out this information.<br><br>=
lscpu from the latest utils-linux-ng package,<br><a href=3D"http://koji.fed=
oraproject.org/koji/packageinfo?packageID=3D4906" target=3D"_blank">http://=
koji.fedoraproject.org/koji/packageinfo?packageID=3D4906</a><br>

<div><br>&gt; Can you pls tell me how to enable/disable hyperthreading in l=
inux kernel. I<br>&gt; could not found proper document for the same.<br>&gt=
;<br><br></div>I am not sure if &quot;noht&quot; is still working. At least=
 it has no effect in<br>
RHEL5 kernel. Instead, it was suggested to use the following commands to<br=
>enable/disable it,<br><br>From a public bug in Red Hat Bugzilla,<br><a hre=
f=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D440321" target=3D"_blank=
">https://bugzilla.redhat.com/show_bug.cgi?id=3D440321</a><br>
<br>&quot;RHEL5 ships with CPU_HOTPLUG enabled. =A0This option allows a use=
r to<br>disable and enable HW or HT cores.<br><br>For example,<br><br>I hav=
e a 4 cpu system with two HT processors.<br><br>To disable the HT processor=
s one can do:<br>
<br>echo 0 &gt; /sys/devices/system/node/node0/cpu1/online<br>echo 0 &gt; /=
sys/devices/system/node/node0/cpu3/online<br><br>You could write a system s=
ervice script that does something similar to<br>(please note that this code=
 is untested and is just a suggestion):<br>
<br>grep noht /proc/cmdline<br><br>if [ $? -eq 0 ]; then<br>=A0 =A0 # noht =
specified on the command line, disabling HT cpus<br>=A0 =A0 echo 0 &gt; /sy=
s/devices/system/node/node0/cpu1/online<br>=A0 =A0 echo 0 &gt; /sys/devices=
/system/node/node0/cpu3/online<br>
fi<br>
<div>&quot;<br><br>&gt; I also found that the check for kernel option &quot=
;noht&quot; is useless by looking<br>&gt; into code(HT_enabled.c).<br>&gt;<=
br>&gt; I think, we can remove that.<br><br></div>I guess we can remove it =
if it is proved to be a dead option.<br>
<font color=3D"#888888"><br>CAI Qian<br></font>
<div>
<div></div>
<div><br>&gt;<br>&gt; Regards,<br>&gt;<br>&gt; Rohit<br>&gt;<br>&gt; On Sat=
, Apr 11, 2009 at 2:25 PM, CAI Qian &lt;<a href=3D"mailto:caiqian@cclom.cn"=
 target=3D"_blank">caiqian@cclom.cn</a>&gt; wrote:<br>&gt;&gt;<br>&gt;&gt; =
Hi,<br>
&gt;&gt;<br>&gt;&gt; --- On Mon, 3/30/09, rohit verma &lt;<a href=3D"mailto=
:rohit.170309@gmail.com" target=3D"_blank">rohit.170309@gmail.com</a>&gt; w=
rote:<br>&gt;&gt;<br>&gt;&gt;&gt; From: rohit verma &lt;<a href=3D"mailto:r=
ohit.170309@gmail.com" target=3D"_blank">rohit.170309@gmail.com</a>&gt;<br>
&gt;&gt;&gt; Subject: [LTP] Regarding ht_enable test case failure<br>&gt;&g=
t;&gt; To: <a href=3D"mailto:ltp-list@lists.sourceforge.net" target=3D"_bla=
nk">ltp-list@lists.sourceforge.net</a><br>&gt;&gt;&gt; Date: Monday, March =
30, 2009, 9:10 PM<br>
&gt;&gt;&gt; O/P:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; ht_enable=
 =A0 =A00 =A0INFO =A0:<br>&gt;&gt;&gt; Begin: HyperThreading Enabled<br>&gt=
;&gt;&gt; ht_enable =A0 =A00 =A0INFO =A0: =A0The kernel boot paramter<br>&g=
t;&gt;&gt; &#39;noht&#39; is not set.<br>
&gt;&gt;&gt;<br>&gt;&gt;&gt; ht_enable =A0 =A01 =A0FAIL =A0: =A0HT feature =
is not included<br>&gt;&gt;&gt; in this Linux Kernel.<br>&gt;&gt;&gt; ht_en=
able =A0 =A00 =A0INFO =A0: =A0End: HyperThreading Enabled<br>&gt;&gt;&gt;<b=
r>&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; but noht is for<br>&gt;&gt;&gt=
; disabling<br>&gt;&gt;&gt; hyperthreading.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;=
<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Function<br>&gt;&gt;&gt; is_ht_kernel (fil=
e:<br>
&gt; testcases/kernel/sched/hyperthreading/ht_affinity/HTutils.c) checks fo=
r<br>&gt;&gt;&gt; string cpu_package in /proc/cpuinfo<br>&gt;&gt;&gt; .<br>=
&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; =A0but<br>&gt;&gt;&gt; cpu_pac=
kage string<br>
&gt;&gt;&gt; =A0information =A0does not exist in =A0/proc/cpuinfo for<br>&g=
t;&gt;&gt; 2.6.29 kernel<br>&gt;&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; From the p=
age,<br>&gt;&gt;<br>&gt;&gt;<br>&gt; <a href=3D"https://lists.linux-foundat=
ion.org/pipermail/cgl_discussion/2002-October/002632.html" target=3D"_blank=
">https://lists.linux-foundation.org/pipermail/cgl_discussion/2002-October/=
002632.html</a><br>
&gt;&gt;<br>&gt;&gt; looks like cpu_package has been added in 2.4.x kernel =
by HT patches.<br>&gt;&gt; Has this field been removed later? I can&#39;t s=
ee it with 2.6.18 kernel.<br>&gt;&gt;<br>&gt;&gt; I have copied the author =
of those tests - Sonic Zhang to see if he has any<br>
&gt;&gt; insight of it.<br>&gt;&gt;<br>&gt;&gt; Anyway, this piece of code =
seems check if the kernel has HT support or<br>&gt; not.<br>&gt;&gt; I am n=
ot sure if we&#39;ll still need it, because HT support has been added<br>
&gt;&gt; to kernel many years ago.<br>&gt;&gt;<br>&gt;&gt; CAI Qian<br>&gt;=
&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Regard=
s,<br>&gt;&gt;&gt; Rohit<br>&gt;&gt;&gt;<br></div></div></blockquote></div>
<br></div></div></blockquote></div><br>

--000e0cd29b2ce970960469f2f554--

--000e0cd29b2ce970a80469f2f556
Content-Type: text/plain; charset=US-ASCII; name="ht_affinity1.txt"
Content-Disposition: attachment; filename="ht_affinity1.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fuqw3l5o0

ZGlmZiAtcnV4QiBsdHAtZnVsbC0yMDA5MDQzMF9vcmluL3Rlc3RjYXNlcy9rZXJuZWwvc2NoZWQv
aHlwZXJ0aHJlYWRpbmcvaHRfYWZmaW5pdHkvSFRhZmZpbml0eS5jIGx0cC1mdWxsLTIwMDkwNDMw
L3Rlc3RjYXNlcy9rZXJuZWwvc2NoZWQvaHlwZXJ0aHJlYWRpbmcvaHRfYWZmaW5pdHkvSFRhZmZp
bml0eS5jCi0tLSBsdHAtZnVsbC0yMDA5MDQzMF9vcmluL3Rlc3RjYXNlcy9rZXJuZWwvc2NoZWQv
aHlwZXJ0aHJlYWRpbmcvaHRfYWZmaW5pdHkvSFRhZmZpbml0eS5jCTIwMDktMDUtMTUgMTg6MDA6
NTEuMDAwMDAwMDAwICswNTMwCisrKyBsdHAtZnVsbC0yMDA5MDQzMC90ZXN0Y2FzZXMva2VybmVs
L3NjaGVkL2h5cGVydGhyZWFkaW5nL2h0X2FmZmluaXR5L0hUYWZmaW5pdHkuYwkyMDA5LTA1LTE1
IDE4OjEwOjIwLjAwMDAwMDAwMCArMDUzMApAQCAtMTYxLDcgKzE2MSw3IEBACiAKIGludCBIVF9H
ZXRBZmZpbml0eSgpCiB7Ci0JdW5zaWduZWQgbG9uZyBtYXNrLG1hc2sxLG1hc2syOworCXVuc2ln
bmVkIGxvbmcgbWFzayxtYXNrMjsKIAlwaWRfdCBwaWQ7CiAKIAltYXNrPTB4MTsKQEAgLTE3Mywy
MCArMTczLDIyIEBACiAKIAlzbGVlcCgxKTsKIAotCW1hc2sxPWdldF9wb3JjX2FmZmluaXR5KHBp
ZCk7CisJLy9tYXNrMT1nZXRfcG9yY19hZmZpbml0eShwaWQpOwogCXNjaGVkX2dldGFmZmluaXR5
KHBpZCwgc2l6ZW9mKHVuc2lnbmVkIGludCksICZtYXNrMik7CiAKLQlpZihtYXNrPT0weDEgJiYg
bWFzaz09bWFzazEgJiYgbWFzaz09bWFzazIpCisJLy9pZihtYXNrPT0weDEgJiYgbWFzaz09bWFz
azEgJiYgbWFzaz09bWFzazIpCisJaWYobWFzaz09MHgxICYmIG1hc2s9PW1hc2syKQogCXsKIAkJ
bWFzaz0weDI7CiAJCXNjaGVkX3NldGFmZmluaXR5KHBpZCwgc2l6ZW9mKHVuc2lnbmVkIGxvbmcp
LCAmbWFzayk7CiAKIAkJc2xlZXAoMSk7CiAKLQkJbWFzazE9Z2V0X3BvcmNfYWZmaW5pdHkocGlk
KTsKKwkJLy9tYXNrMT1nZXRfcG9yY19hZmZpbml0eShwaWQpOwogCQlzY2hlZF9nZXRhZmZpbml0
eShwaWQsIHNpemVvZih1bnNpZ25lZCBpbnQpLCAmbWFzazIpOwogCi0JCWlmKG1hc2s9PTB4MiAm
JiBtYXNrPT1tYXNrMSAmJiBtYXNrPT1tYXNrMikKKwkJLy9pZihtYXNrPT0weDIgJiYgbWFzaz09
bWFzazEgJiYgbWFzaz09bWFzazIpCisJCWlmKG1hc2s9PTB4MiAmJiBtYXNrPT1tYXNrMikKIAkJ
CXJldHVybiAxOwogCQllbHNlCiAJCQlyZXR1cm4gMDsKQEAgLTIxNyw3ICsyMTksOCBAQAogCQll
eGl0KDApOwogCX0KIAotCW1hc2s9Z2V0X3BvcmNfYWZmaW5pdHkocGlkKTsKKwkvL21hc2s9Z2V0
X3BvcmNfYWZmaW5pdHkocGlkKTsKKwlzY2hlZF9nZXRhZmZpbml0eShwaWQsIHNpemVvZih1bnNp
Z25lZCBpbnQpLCAmbWFzayk7CiAKIAlpZihtYXNrPT0weDIpCiAJCXJldHVybiAxOwpAQCAtMjMz
LDcgKzIzNiw3IEBACiAjaWZuZGVmIF9faTM4Nl9fCiAJdHN0X2Jya20oVENPTkYsIE5VTEwsICJU
aGlzIHRlc3Qgc3VpdGUgY2FuIG9ubHkgZXhjdXRlIG9uIGkzODYgYXJjaGl0ZWN0dXJlLiIpOwog
I2Vsc2UKLQlpZiAoIWNoZWNrX2h0X2NhcGFiaWxpdHkoKSkKKwkvL2lmICghY2hlY2tfaHRfY2Fw
YWJpbGl0eSgpKQogCXsKIAogCQlpZihIVF9HZXRBZmZpbml0eSgpKQpAQCAtMjU1LDEwICsyNTgs
MTAgQEAKIAkJZWxzZQogCQkJdHN0X3Jlc20oVEZBSUwsICJTeXN0ZW0gY2FsbCBzZXRhZmZpbml0
eSgpIGlzIGVycm9yLiIpOwogCX0KLQllbHNlCisJLyplbHNlCiAJewogCQl0c3RfYnJrbShUQ09O
RiwgTlVMTCwgIkhUIGlzIG5vdCBlbmFibGVkIG9yIG5vdCBzdXBwb3J0ZWQuIik7Ci0JfQorCX0q
LwogI2VuZGlmCiAKIAl0c3RfcmVzbShUSU5GTywgIkVuZDogSHlwZXJUaHJlYWRpbmcgQWZmaW5p
dHkiKTsK
--000e0cd29b2ce970a80469f2f556--

----Next_Part(Mon_May_18_19_12_43_2009_530)--
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
----Next_Part(Mon_May_18_19_12_43_2009_530)--
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----Next_Part(Mon_May_18_19_12_43_2009_530)----

