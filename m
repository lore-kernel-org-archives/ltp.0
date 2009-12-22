Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NN4W7-0005bP-QT
	for ltp-list@lists.sourceforge.net; Tue, 22 Dec 2009 13:11:11 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NN4W0-0002xw-NM
	for ltp-list@lists.sourceforge.net; Tue, 22 Dec 2009 13:11:11 +0000
Message-ID: <4B30C5BE.203@cn.fujitsu.com>
Date: Tue, 22 Dec 2009 21:12:30 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <4B1F52FD.4010305@cn.fujitsu.com>	
	<1261152185.8993.23.camel@subratamodak.linux.ibm.com>
	<364299f40912211851w3aaf2ab4t9ea3342dcf6b12f7@mail.gmail.com>
In-Reply-To: <364299f40912211851w3aaf2ab4t9ea3342dcf6b12f7@mail.gmail.com>
Subject: Re: [LTP] [PATCH] syscalls: fix some failure on arch X86_64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4201895269506447785=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============4201895269506447785==
Content-Type: multipart/alternative;
	boundary="------------060009080402040308020806"

This is a multi-part message in MIME format.
--------------060009080402040308020806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 12/22/2009 10:51 AM, Garrett Cooper wrote:
> On Fri, Dec 18, 2009 at 8:03 AM, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
>   
>> Garret,
>>
>> Not sure if you applied this :-(
>>
>> Regards--
>> Subrata
>>
>> On Wed, 2009-12-09 at 15:34 +0800, liubo wrote:
>>     
>>> Here is the patch, which contains lots of adjustments
>>> on style, so it might be a bit huge.
>>>
>>> Testcase 1. rt_sigaction01
>>> On arch x86_64, if we directly get to call syscall
>>> rt_sigaction, there will be "segment fault".
>>> 1) One reason is that we must supply the flag of
>>> "SA_RESTORER" and the correct pointer to the fuction
>>> "restorer", according to the kernel code.
>>> 2) The other reason is that default syscall rt_sigaction
>>> use kernel "sigaction" structure, which is different
>>> with normal "sigaction" structure.
>>>
>>> So,
>>> 1) We manage to find the address of the function
>>> "restorer" by using glibc function "sigaction",
>>> which might be something tricky. Then we add these
>>> arguments to make test run correctly.
>>> 2) We also use kernel "sigaction" structure to fit
>>> realtime syscall __NR_rt_sigaction.
>>>
>>> Testcase 2. rt_sigprocmask01
>>> First, there exsits the same problem as rt_sigaction01.
>>> Second, this testcase uses a unchanged signal number 33,
>>> which may diff among different archs and lead to error
>>> "unknown signal".
>>>
>>> So, we use a macro TEST_SIG which refers to SIGRTMIN
>>> to replace 33.
>>>
>>> Testcase 3. rt_sigsuspend01
>>> There exists the same problem as rt_sigaction01.
>>>
>>> This patch fixed these failure.
>>>       
>
>     No, I didn't commit this because it's long, and I'm not sure if
> it's doing the right thing as per my research over the past couple of
> weeks. These tests are tricky because it requires a particular formula
> of preset variables and structures in order to properly use
> rt_sigaction, and that's where we're running into issues with them on
> x86_64 -- because the syscall implementers decided to remain sort of
> backwards compatible with x86, and that's why it's such a mess to deal
> with.
>     I will look at the diff and pick out which parts are of value, but
> a lot of this diff's contents are basically reverting the changes that
> I made this month.
> Thanks,
> -Garrett
>
>
>   
Hi, Garrett,
    In my patch, I adopted a kind of method which is different from
your previous changes about this.
    I try to find the address of "restore_rt" which is needed by
syscall rt_sigaction, and I managed to get this address by
tracing glibc function "sigaction".
    After doing these, I also found rt_sigaction's "sigaction" struct is
different from normal "sigaction" struct, so when copy from normal
"sigaction" struct to rt_sigaction's kernel "sigaction" struct, some
kind of segmental fault will ocurr to us.
    So, I did some changes to revert your previous changes and directly
adopted the function "restore_rt" and kernel "sigaction" struct to fix
these bugs.
    Hope these are helpful to you.

Thanks,
-Liu Bo

--------------060009080402040308020806
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
On 12/22/2009 10:51 AM, Garrett Cooper wrote:
<blockquote
 cite="mid:364299f40912211851w3aaf2ab4t9ea3342dcf6b12f7@mail.gmail.com"
 type="cite">
  <pre wrap="">On Fri, Dec 18, 2009 at 8:03 AM, Subrata Modak
<a class="moz-txt-link-rfc2396E" href="mailto:subrata@linux.vnet.ibm.com">&lt;subrata@linux.vnet.ibm.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Garret,

Not sure if you applied this :-(

Regards--
Subrata

On Wed, 2009-12-09 at 15:34 +0800, liubo wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Here is the patch, which contains lots of adjustments
on style, so it might be a bit huge.

Testcase 1. rt_sigaction01
On arch x86_64, if we directly get to call syscall
rt_sigaction, there will be "segment fault".
1) One reason is that we must supply the flag of
"SA_RESTORER" and the correct pointer to the fuction
"restorer", according to the kernel code.
2) The other reason is that default syscall rt_sigaction
use kernel "sigaction" structure, which is different
with normal "sigaction" structure.

So,
1) We manage to find the address of the function
"restorer" by using glibc function "sigaction",
which might be something tricky. Then we add these
arguments to make test run correctly.
2) We also use kernel "sigaction" structure to fit
realtime syscall __NR_rt_sigaction.

Testcase 2. rt_sigprocmask01
First, there exsits the same problem as rt_sigaction01.
Second, this testcase uses a unchanged signal number 33,
which may diff among different archs and lead to error
"unknown signal".

So, we use a macro TEST_SIG which refers to SIGRTMIN
to replace 33.

Testcase 3. rt_sigsuspend01
There exists the same problem as rt_sigaction01.

This patch fixed these failure.
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
    No, I didn't commit this because it's long, and I'm not sure if
it's doing the right thing as per my research over the past couple of
weeks. These tests are tricky because it requires a particular formula
of preset variables and structures in order to properly use
rt_sigaction, and that's where we're running into issues with them on
x86_64 -- because the syscall implementers decided to remain sort of
backwards compatible with x86, and that's why it's such a mess to deal
with.
    I will look at the diff and pick out which parts are of value, but
a lot of this diff's contents are basically reverting the changes that
I made this month.
Thanks,
-Garrett


  </pre>
</blockquote>
Hi, Garrett,<br>
&nbsp;&nbsp;&nbsp; In my patch, I adopted a kind of method which is different from <br>
your previous changes about this.<br>
&nbsp;&nbsp;&nbsp; I try to find the address of "restore_rt" which is needed by <br>
syscall rt_sigaction, and I managed to get this address by <br>
tracing glibc function "sigaction".<br>
&nbsp;&nbsp;&nbsp; After doing these, I also found rt_sigaction's "sigaction" struct
is <br>
different from normal "sigaction" struct, so when copy from normal <br>
"sigaction" struct to rt_sigaction's kernel "sigaction" struct, some <br>
kind of segmental fault will ocurr to us. <br>
&nbsp;&nbsp;&nbsp; So, I did some changes to revert your previous changes and directly
<br>
adopted the function "restore_rt" and kernel "sigaction" struct to fix <br>
these bugs.<br>
&nbsp;&nbsp;&nbsp; Hope these are helpful to you.<br>
<br>
Thanks,<br>
-Liu Bo<br>
</body>
</html>

--------------060009080402040308020806--


--===============4201895269506447785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============4201895269506447785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4201895269506447785==--

