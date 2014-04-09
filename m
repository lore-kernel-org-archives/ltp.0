Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shinto.john@smartplayin.com>) id 1WXsBC-0007l3-NJ
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 13:04:38 +0000
Received: from smtp86.iad3a.emailsrvr.com ([173.203.187.86])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WXsBB-0005EE-7o
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 13:04:38 +0000
Date: Wed, 9 Apr 2014 18:34:31 +0530 (IST)
From: shinto.john@smartplayin.com
MIME-Version: 1.0
In-Reply-To: <53453D96.3070109@linux.vnet.ibm.com>
References: <CA+G9fYuQi1+C0Mkhc0SVLKm8E9iEEF8rZ_62qAFZZcUaD9CLQQ@mail.gmail.com>
	<1397035115.64792188@apps.rackspace.com> 
	<53453D96.3070109@linux.vnet.ibm.com>
Message-ID: <1397048671.53348062@apps.rackspace.com>
Subject: Re: [LTP] [Ltp-coverage] running LCOV/LTP on Beagle Bone Black -
	Cannot Allocate Memory Error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4831321333245306539=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Naresh Kamboju <naresh.kamboju@linaro.org>, ltp-coverage@lists.sourceforge.net

--===============4831321333245306539==
Content-Type: multipart/alternative;
	boundary="----=_20140409183431000000_56126"

------=_20140409183431000000_56126
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=0AHi Peter,=0A =0AThis got resolved when i tried this in KERNEL/mm/Makefil=
e=0AGCOV_PROFILE :=3D n=0A =0ASo basically some issue with KERNEL/mm/vmstat=
.gcno... right?=0A =0ANow i am able to do a complete kernel run.=0A =0AThan=
ks & Regards,=0AShinto=0A =0A-----Original Message-----=0AFrom: "Peter Ober=
parleiter" <oberpar@linux.vnet.ibm.com>=0ASent: Wednesday, April 9, 2014 6:=
01pm=0ATo: shinto.john@smartplayin.com, "Naresh Kamboju" <naresh.kamboju@li=
naro.org>=0ACc: ltp-coverage@lists.sourceforge.net, "ltp-list" <ltp-list@li=
sts.sourceforge.net>=0ASubject: Re: [Ltp-coverage] running LCOV/LTP on Beag=
le Bone Black - Cannot Allocate Memory Error=0A=0A=0A=0AOn 09.04.2014 11:18=
, shinto.john@smartplayin.com wrote:=0A> now while running "lcov -c -o cove=
rage.info", this runs for ~5 minutes=0A> without any issues and then is stu=
ck at this below*red *point for long=0A> time and never exits.=0A> =0A> So =
i did ctrl-C and tried the "genhtml coverage.info -o out" and it worked.=0A=
> =0A> I could see the LCOV report(Attached index.html) in "out" folder.=0A=
> =0A> But looks like complete kernel folders are not there in the LCOV rep=
ort=0A> as it was stuck at below point.=0A> =0A> Any comments?=0A> =0A> inc=
lude/asm-generic/bitops/arch_hweight.h:source file is newer than=0A> graph =
file '/home/mallikarjun.bc/LTP/Download/linux-dev/KERNEL/mm/vmstat.gc'=0A> =
/home/mallikarjun.bc/LTP/Download/linux-dev/KERNEL/arch/arm/include/asm/bit=
ops.h:source=0A> file is newer than graph file '/home/mallikarjun.bc/LTP'=
=0A> include/linux/workqueue.h:source file is newer than graph file=0A> '/h=
ome/mallikarjun.bc/LTP/Download/linux-dev/KERNEL/mm/vmstat.gcno'=0A> includ=
e/linux/nodemask.h:source file is newer than graph file=0A> '/home/mallikar=
jun.bc/LTP/Download/linux-dev/KERNEL/mm/vmstat.gcno'=0A> *include/linux/ker=
nel.h:source file is newer than graph file=0A> '/home/mallikarjun.bc/LTP/Do=
wnload/linux-dev/KERNEL/mm/vmstat.gcno'*=0A=0ATry running top while lcov is=
 stuck and see if there's a process using=0Aup a lot of CPU time. It might =
be that you are affected by a gcov bug.=0A=0A-- =0APeter Oberparleiter=0ALi=
nux on System z Development - IBM Germany=0A=0A
------=_20140409183431000000_56126
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<font face=3D"arial" size=3D"3"><p style=3D"margin:0;padding:0;">Hi Peter,<=
/p>=0A<p style=3D"margin:0;padding:0;">&nbsp;</p>=0A<p style=3D"margin:0;pa=
dding:0;">This got resolved when i tried this in KERNEL/mm/Makefile</p>=0A<=
p style=3D"margin:0;padding:0;">GCOV_PROFILE :=3D n</p>=0A<p style=3D"margi=
n:0;padding:0;">&nbsp;</p>=0A<p style=3D"margin:0;padding:0;">So basically =
some issue with KERNEL/mm/vmstat.gcno... right?</p>=0A<p style=3D"margin:0;=
padding:0;">&nbsp;</p>=0A<p style=3D"margin:0;padding:0;">Now i am able to =
do a complete kernel run.</p>=0A<p style=3D"margin:0;padding:0;">&nbsp;</p>=
=0A<p style=3D"margin:0;padding:0;">Thanks &amp; Regards,</p>=0A<p style=3D=
"margin:0;padding:0;">Shinto</p>=0A<p style=3D"margin:0;padding:0;">&nbsp;<=
/p>=0A<p style=3D"margin:0;padding:0;">-----Original Message-----<br />From=
: "Peter Oberparleiter" &lt;oberpar@linux.vnet.ibm.com&gt;<br />Sent: Wedne=
sday, April 9, 2014 6:01pm<br />To: shinto.john@smartplayin.com, "Naresh Ka=
mboju" &lt;naresh.kamboju@linaro.org&gt;<br />Cc: ltp-coverage@lists.source=
forge.net, "ltp-list" &lt;ltp-list@lists.sourceforge.net&gt;<br />Subject: =
Re: [Ltp-coverage] running LCOV/LTP on Beagle Bone Black - Cannot Allocate =
Memory Error<br /><br /></p>=0A<div id=3D"SafeStyles1397047945">=0A<p style=
=3D"margin:0;padding:0;">On 09.04.2014 11:18, shinto.john@smartplayin.com w=
rote:<br />&gt; now while running "lcov -c -o coverage.info", this runs for=
 ~5 minutes<br />&gt; without any issues and then is stuck at this below*re=
d *point for long<br />&gt; time and never exits.<br />&gt; <br />&gt; So i=
 did ctrl-C and tried the "genhtml coverage.info -o out" and it worked.<br =
/>&gt; <br />&gt; I could see the LCOV report(Attached index.html) in "out"=
 folder.<br />&gt; <br />&gt; But looks like complete kernel folders are no=
t there in the LCOV report<br />&gt; as it was stuck at below point.<br />&=
gt; <br />&gt; Any comments?<br />&gt; <br />&gt; include/asm-generic/bitop=
s/arch_hweight.h:source file is newer than<br />&gt; graph file '/home/mall=
ikarjun.bc/LTP/Download/linux-dev/KERNEL/mm/vmstat.gc'<br />&gt; /home/mall=
ikarjun.bc/LTP/Download/linux-dev/KERNEL/arch/arm/include/asm/bitops.h:sour=
ce<br />&gt; file is newer than graph file '/home/mallikarjun.bc/LTP'<br />=
&gt; include/linux/workqueue.h:source file is newer than graph file<br />&g=
t; '/home/mallikarjun.bc/LTP/Download/linux-dev/KERNEL/mm/vmstat.gcno'<br /=
>&gt; include/linux/nodemask.h:source file is newer than graph file<br />&g=
t; '/home/mallikarjun.bc/LTP/Download/linux-dev/KERNEL/mm/vmstat.gcno'<br /=
>&gt; *include/linux/kernel.h:source file is newer than graph file<br />&gt=
; '/home/mallikarjun.bc/LTP/Download/linux-dev/KERNEL/mm/vmstat.gcno'*<br /=
><br />Try running top while lcov is stuck and see if there's a process usi=
ng<br />up a lot of CPU time. It might be that you are affected by a gcov b=
ug.<br /><br />-- <br />Peter Oberparleiter<br />Linux on System z Developm=
ent - IBM Germany<br /><br /></p>=0A</div></font>
------=_20140409183431000000_56126--



--===============4831321333245306539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
--===============4831321333245306539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4831321333245306539==--


