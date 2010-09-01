Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Feng.Gao@windriver.com>) id 1OqfUT-0002CU-4y
	for ltp-list@lists.sourceforge.net; Wed, 01 Sep 2010 05:04:05 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OqfUP-0005cG-NJ
	for ltp-list@lists.sourceforge.net; Wed, 01 Sep 2010 05:04:05 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 1 Sep 2010 07:03:51 +0200
Message-ID: <52CF90264091A14888078A031D780F430111B8E7@ism-mail03.corp.ad.wrs.com>
References: <52CF90264091A14888078A031D780F430111B8E4@ism-mail03.corp.ad.wrs.com>
	<AANLkTi=RhCp1zfX4=CcONBysQ2O04gMakYiJpXZi_9RU@mail.gmail.com>
From: "Gao, Feng" <Feng.Gao@windriver.com>
Subject: Re: [LTP] [PATCH]Modify the cacheflush01 test case
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0479114828357191821=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.

--===============0479114828357191821==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB4993.117A6D85"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB4993.117A6D85
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

Hi,

I have tested cacheflush01 testcase in Linux 2.6.27.45 kernel, if the =
cache of sys_cacheflush is 0, return value also is Success. It is same =
with the Linux 2.6.34.1.

I have check the kernel code, from the Linux 2.6.11, sys_cacheflush =
function began to ignore the cache argument and never return EINVAL.
The function of cacheflush01 is checking if the sys_cacheflush's return =
value is correct. if there is no EINVAL as the return value in the =
kernel code, it is unnecessary to checking it. Otherwise the case will =
fail, tester will waste time to recheck this case and sys_cacheflush =
function.

BR,
Feng Gao

-----Original Message-----
From: Garrett Cooper [mailto:yanegomi@gmail.com]
Sent: 2010-8-31  23:46
To: Gao, Feng
Cc: ltp-list
Subject: Re: [LTP] [PATCH]Modify the cacheflush01 test case
=20
2010/8/31 Gao, Feng <Feng.Gao@windriver.com>:
> Hi,
>
> The cacheflush system call does not return EINVAL in the latest Linux
> kernel. see the link:
> A related patch about the cacheflush function:
> http://lkml.org/lkml/2009/4/9/203
> But Ralf had refused this patch:
> http://www.spinics.net/lists/linux-man/msg00906.html
> cacheflush01 testcase checks if the return value is EINVAL when the =
cache
> argument is not one of ICACHE, BCACHE or DCACHE. So it will fail in =
all
> boards.
>
> In this modification, checking return value SUCCESS will be added, =
instead
> of checking EINVAL

I got the first email :).

I am always hesitant committing patches like these because unless
there is documentation that clearly states "these are the requirements
for syscall/libcall foo", it can change at a later day without notice
and we'll work ourselves into this funk again.

Also, what happens when you execute this code on earlier kernels? I
hate getting emails from other users stating "the commit you did for
the test is broke my architecture foo on distro bar -- here's a patch
to fix it!".

The syscall needs to be fixed. If the cache argument is ignored, it
needs to be removed. Period. And the syscall needs to be renamed to
something else to avoid breaking backwards compatibility (which is
essentially what happened here).

FWIW we lack positive tests for this syscall, and we really should
have some (other than just nuking the entire contents of the syscall
directory).

Thanks,
-Garrett


------_=_NextPart_001_01CB4993.117A6D85
Content-Type: text/html;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dgb2312">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RE: [LTP] [PATCH]Modify the cacheflush01 test case</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
I have tested cacheflush01 testcase in Linux 2.6.27.45 kernel, if the =
cache of sys_cacheflush is 0, return value also is Success. It is same =
with the Linux 2.6.34.1.<BR>
<BR>
I have check the kernel code, from the Linux 2.6.11, sys_cacheflush =
function began to ignore the cache argument and never return EINVAL.<BR>
The function of cacheflush01 is checking if the sys_cacheflush's return =
value is correct. if there is no EINVAL as the return value in the =
kernel code, it is unnecessary to checking it. Otherwise the case will =
fail, tester will waste time to recheck this case and sys_cacheflush =
function.<BR>
<BR>
BR,<BR>
Feng Gao<BR>
<BR>
-----Original Message-----<BR>
From: Garrett Cooper [<A =
HREF=3D"mailto:yanegomi@gmail.com">mailto:yanegomi@gmail.com</A>]<BR>
Sent: 2010-8-31&nbsp; 23:46<BR>
To: Gao, Feng<BR>
Cc: ltp-list<BR>
Subject: Re: [LTP] [PATCH]Modify the cacheflush01 test case<BR>
<BR>
2010/8/31 Gao, Feng &lt;Feng.Gao@windriver.com&gt;:<BR>
&gt; Hi,<BR>
&gt;<BR>
&gt; The cacheflush system call does not return EINVAL in the latest =
Linux<BR>
&gt; kernel. see the link:<BR>
&gt; A related patch about the cacheflush function:<BR>
&gt; <A =
HREF=3D"http://lkml.org/lkml/2009/4/9/203">http://lkml.org/lkml/2009/4/9/=
203</A><BR>
&gt; But Ralf had refused this patch:<BR>
&gt; <A =
HREF=3D"http://www.spinics.net/lists/linux-man/msg00906.html">http://www.=
spinics.net/lists/linux-man/msg00906.html</A><BR>
&gt; cacheflush01 testcase checks if the return value is EINVAL when the =
cache<BR>
&gt; argument is not one of ICACHE, BCACHE or DCACHE. So it will fail in =
all<BR>
&gt; boards.<BR>
&gt;<BR>
&gt; In this modification, checking return value SUCCESS will be added, =
instead<BR>
&gt; of checking EINVAL<BR>
<BR>
I got the first email :).<BR>
<BR>
I am always hesitant committing patches like these because unless<BR>
there is documentation that clearly states &quot;these are the =
requirements<BR>
for syscall/libcall foo&quot;, it can change at a later day without =
notice<BR>
and we'll work ourselves into this funk again.<BR>
<BR>
Also, what happens when you execute this code on earlier kernels? I<BR>
hate getting emails from other users stating &quot;the commit you did =
for<BR>
the test is broke my architecture foo on distro bar -- here's a =
patch<BR>
to fix it!&quot;.<BR>
<BR>
The syscall needs to be fixed. If the cache argument is ignored, it<BR>
needs to be removed. Period. And the syscall needs to be renamed to<BR>
something else to avoid breaking backwards compatibility (which is<BR>
essentially what happened here).<BR>
<BR>
FWIW we lack positive tests for this syscall, and we really should<BR>
have some (other than just nuking the entire contents of the syscall<BR>
directory).<BR>
<BR>
Thanks,<BR>
-Garrett<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CB4993.117A6D85--


--===============0479114828357191821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
--===============0479114828357191821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0479114828357191821==--

