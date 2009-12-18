Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NLcTH-0003rs-Vk
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 13:02:15 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLcTC-0008IZ-VC
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 13:02:15 +0000
Message-ID: <4B2B7D8C.3020000@cn.fujitsu.com>
Date: Fri, 18 Dec 2009 21:03:08 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <2118844783.566751261140265463.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2118844783.566751261140265463.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH 2/3] ade: fix the bug of ar01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4872774409598850646=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============4872774409598850646==
Content-Type: multipart/alternative;
	boundary="------------070800050604020308070309"

This is a multi-part message in MIME format.
--------------070800050604020308070309
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/2009 08:44 PM, Caspar Zhang wrote:
> ----- "liubo" <liubo2009@cn.fujitsu.com> wrote: 
>
>   
>> Are you using a 32bit box or not? 
>> I tested on a few 32bit boxes(Ubuntu Fedora), and I think it is the point. 
>>
>> Thanks. 
>> Liu Bo 
>>
>>
>>     
> I tested in x86, x86_64, ppc64, s390x and ia64, all of them has a dot in RHEL6
> also tested in x86 Fedora, no dot.
>
> -Caspar 
>
>
>   
[---@localhost test]$ uname -a
Linux localhost.localdomain 2.6.29.4-167.fc11.x86_64 #1 SMP Wed May 27
17:27:08 EDT 2009 x86_64 x86_64 x86_64 GNU/Linux
[---@localhost test]$ ls -ln --time-style=+%b" "%e" "%H:%M file1.in
file2.in file3.in
-rw-rw-r--. 1 500 500 17 Dec 18 19:14 file1.in
-rw-rw-r--. 1 500 500 17 Dec 18 19:14 file2.in
-rw-rw-r--. 1 500 500 19 Dec 18 19:14 file3.in

  F11 do has the strange dot...I'll investigate it more if it's not my
box's problem.
 
  Liu Bo

--------------070800050604020308070309
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Type=
">
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
On 12/18/2009 08:44 PM, Caspar Zhang wrote:
<blockquote
 cite=3D"mid:2118844783.566751261140265463.JavaMail.root@zmail04.collab.p=
rod.int.phx2.redhat.com"
 type=3D"cite">
  <pre wrap=3D"">----- "liubo" <a class=3D"moz-txt-link-rfc2396E" href=3D=
"mailto:liubo2009@cn.fujitsu.com">&lt;liubo2009@cn.fujitsu.com&gt;</a> wr=
ote:=20

  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">Are you using a 32bit box or not?=20
I tested on a few 32bit boxes(Ubuntu Fedora), and I think it is the point=
.=20

Thanks.=20
Liu Bo=20


    </pre>
  </blockquote>
  <pre wrap=3D""><!---->I tested in x86, x86_64, ppc64, s390x and ia64, a=
ll of them has a dot in RHEL6
also tested in x86 Fedora, no dot.

-Caspar=20


  </pre>
</blockquote>
[---@localhost test]$ uname -a<br>
Linux localhost.localdomain 2.6.29.4-167.fc11.x86_64 #1 SMP Wed May 27
17:27:08 EDT 2009 x86_64 x86_64 x86_64 GNU/Linux<br>
[---@localhost test]$ ls -ln --time-style=3D+%b" "%e" "%H:%M file1.in
file2.in file3.in<br>
-rw-rw-r--. 1 500 500 17 Dec 18 19:14 file1.in<br>
-rw-rw-r--. 1 500 500 17 Dec 18 19:14 file2.in<br>
-rw-rw-r--. 1 500 500 19 Dec 18 19:14 file3.in<br>
<br>
=C2=A0 F11 do has the strange dot...I'll investigate it more if it's not =
my
box's problem.<br>
=C2=A0 <br>
=C2=A0 Liu Bo<br>
</body>
</html>

--------------070800050604020308070309--


--===============4872774409598850646==
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
--===============4872774409598850646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4872774409598850646==--

