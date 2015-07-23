Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cristian.valean@live.com>) id 1ZIEtE-0003sy-C0
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2015 11:42:16 +0000
Received: from dub004-omc1s27.hotmail.com ([157.55.0.226])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZIEt2-0005S0-JI
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2015 11:42:16 +0000
Message-ID: <DUB407-EAS81F92E7EF5284309697E5785820@phx.gbl>
From: Cristian Valean <cristian.valean@live.com>
References: <DUB407-EAS338A9D3F666651011BAB67485820@phx.gbl>
In-Reply-To: <DUB407-EAS338A9D3F666651011BAB67485820@phx.gbl>
Date: Thu, 23 Jul 2015 14:41:56 +0300
MIME-Version: 1.0
Content-Language: en-us
Subject: Re: [LTP] OOM messages when running full ltp tests on a Hyper-V VM
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5284852298344110242=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5284852298344110242==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0009_01D0C555.B9244B80"
Content-Language: en-us

------=_NextPart_000_0009_01D0C555.B9244B80
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

My apologies for the incomplete reply, it got sent out before all details
went it.

 

To continue the initial thread:

I'm trying to run a full ltp test run on Ubuntu 14.04.2 as a Hyper-V VM.

The VM is set with 8 or 12GB and 4 vCPUs, however during the tests execution
the syslog records over 30 call traces similar to the one below.

 

Haven't tried vmware or other platforms, but I'm wondering why LTP processes
go over the limit, or what would be a reference system resources that would
accommodate a full run. 

Otherwise, are there are params that can limitor specify the resources that
LTP can use?

 

Sample call trace:

Jul 22 01:17:50 ubuntu kernel: [ 5757.011711] Out of memory: Kill process
5902 (oom01) score 937 or sacrifice child

Jul 22 01:17:50 ubuntu kernel: [ 5757.014099] Killed process 5902 (oom01)
total-vm:15759784kB, anon-rss:7723620kB, file-rss:40kB

Jul 22 01:25:26 ubuntu kernel: [ 6211.981585] min_free_kbytes invoked
oom-killer: gfp_mask=0x280da, order=0, oom_score_adj=0

Jul 22 01:25:26 ubuntu kernel: [ 6211.982662] min_free_kbytes cpuset=/
mems_allowed=0

Jul 22 01:25:26 ubuntu kernel: [ 6211.983723] CPU: 1 PID: 12532 Comm:
min_free_kbytes Not tainted 3.16.0-43-generic #58~14.04.1-Ubuntu

 

Jul 22 01:17:50 ubuntu kernel: [ 5756.531764] Call Trace:

Jul 22 01:17:50 ubuntu kernel: [ 5756.534570]  [<ffffffff81765a91>]
dump_stack+0x45/0x56

Jul 22 01:17:50 ubuntu kernel: [ 5756.537888]  [<ffffffff8175f645>]
dump_header+0x7f/0x1f1

Jul 22 01:17:50 ubuntu kernel: [ 5756.540655]  [<ffffffff811655c5>]
oom_kill_process+0x205/0x360

Jul 22 01:17:50 ubuntu kernel: [ 5756.543361]  [<ffffffff812ebbd5>] ?
security_capable_noaudit+0x15/0x20

Jul 22 01:17:50 ubuntu kernel: [ 5756.554536]  [<ffffffff81165d72>]
out_of_memory+0x492/0x4d0

Jul 22 01:17:50 ubuntu kernel: [ 5756.557160]  [<ffffffff8176019d>]
__alloc_pages_slowpath+0x63e/0x775

Jul 22 01:17:50 ubuntu kernel: [ 5756.559807]  [<ffffffff8116bb23>]
__alloc_pages_nodemask+0x273/0x2a0

Jul 22 01:17:50 ubuntu kernel: [ 5756.563601]  [<ffffffff811ae93a>]
alloc_pages_vma+0x9a/0x150

Jul 22 01:17:50 ubuntu kernel: [ 5756.569377]  [<ffffffff8118f49c>]
handle_mm_fault+0xcfc/0x10c0

Jul 22 01:17:50 ubuntu kernel: [ 5756.574630]  [<ffffffff81769c5f>] ?
__schedule+0x35f/0x7a0

Jul 22 01:17:50 ubuntu kernel: [ 5756.582479]  [<ffffffff8105af5e>]
__do_page_fault+0x19e/0x560

Jul 22 01:17:50 ubuntu kernel: [ 5756.590664]  [<ffffffff810a62e8>] ?
__enqueue_entity+0x78/0x80

Jul 22 01:17:50 ubuntu kernel: [ 5756.597382]  [<ffffffff810a8015>] ?
set_next_entity+0x95/0xb0

Jul 22 01:17:50 ubuntu kernel: [ 5756.608215]  [<ffffffff81011627>] ?
__switch_to+0x167/0x580

Jul 22 01:17:50 ubuntu kernel: [ 5756.614156]  [<ffffffff8105b351>]
do_page_fault+0x31/0x70

Jul 22 01:17:50 ubuntu kernel: [ 5756.616875]  [<ffffffff81770168>]
page_fault+0x28/0x30

 

From: Cristian Valean [mailto:cristian.valean@live.com] 
Sent: Thursday, July 23, 2015 2:34 PM
To: ltp-list@lists.sourceforge.net
Subject: [LTP] OOM messages when running full ltp tests on a Hyper-V VM

 

I'm trying to run a full ltp test run on Ubuntu 14.04.2 as a Hyper-V VM.

 

The VM is set with 8 or 12GB and 4 vCPUs, however during the tests execution
the syslog records over 30 call traces similar to the one below.

 

 


------=_NextPart_000_0009_01D0C555.B9244B80
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US =
link=3D"#0563C1" vlink=3D"#954F72"><div class=3DWordSection1><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>My apologies for the =
incomplete reply, it got sent out before all details&nbsp; went =
it.<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>To continue the initial =
thread:<o:p></o:p></span></p><p class=3DMsoNormal>I&#8217;m trying to =
run a full ltp test run on Ubuntu 14.04.2 as a Hyper-V =
VM.<o:p></o:p></p><p class=3DMsoNormal>The VM is set with 8 or 12GB and =
4 vCPUs, however during the tests execution the syslog records over 30 =
call traces similar to the one below.<o:p></o:p></p><p =
class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Haven&#8217;t tried =
vmware or other platforms, but I&#8217;m wondering why LTP processes go =
over the limit, or what would be a reference system resources that would =
accommodate a full run. <o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'>Otherwise, are there are params that can limitor =
specify the resources that LTP can use?<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Sample call =
trace:<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu kernel: [ 5757.011711] =
Out of memory: Kill process 5902 (oom01) score 937 or sacrifice =
child<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu kernel: [ 5757.014099] =
Killed process 5902 (oom01) total-vm:15759784kB, anon-rss:7723620kB, =
file-rss:40kB<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'>Jul 22 01:25:26 ubuntu kernel: [ 6211.981585] =
min_free_kbytes invoked oom-killer: gfp_mask=3D0x280da, order=3D0, =
oom_score_adj=3D0<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'>Jul 22 01:25:26 ubuntu kernel: [ 6211.982662] =
min_free_kbytes cpuset=3D/ mems_allowed=3D0<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Jul 22 01:25:26 ubuntu =
kernel: [ 6211.983723] CPU: 1 PID: 12532 Comm: min_free_kbytes Not =
tainted 3.16.0-43-generic #58~14.04.1-Ubuntu<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu =
kernel: [ 5756.531764] Call Trace:<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu =
kernel: [ 5756.534570]&nbsp; [&lt;ffffffff81765a91&gt;] =
dump_stack+0x45/0x56<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu kernel: [ =
5756.537888]&nbsp; [&lt;ffffffff8175f645&gt;] =
dump_header+0x7f/0x1f1<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu kernel: [ =
5756.540655]&nbsp; [&lt;ffffffff811655c5&gt;] =
oom_kill_process+0x205/0x360<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu =
kernel: [ 5756.543361]&nbsp; [&lt;ffffffff812ebbd5&gt;] ? =
security_capable_noaudit+0x15/0x20<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu =
kernel: [ 5756.554536]&nbsp; [&lt;ffffffff81165d72&gt;] =
out_of_memory+0x492/0x4d0<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu =
kernel: [ 5756.557160]&nbsp; [&lt;ffffffff8176019d&gt;] =
__alloc_pages_slowpath+0x63e/0x775<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu =
kernel: [ 5756.559807]&nbsp; [&lt;ffffffff8116bb23&gt;] =
__alloc_pages_nodemask+0x273/0x2a0<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu =
kernel: [ 5756.563601]&nbsp; [&lt;ffffffff811ae93a&gt;] =
alloc_pages_vma+0x9a/0x150<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu =
kernel: [ 5756.569377]&nbsp; [&lt;ffffffff8118f49c&gt;] =
handle_mm_fault+0xcfc/0x10c0<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu =
kernel: [ 5756.574630]&nbsp; [&lt;ffffffff81769c5f&gt;] ? =
__schedule+0x35f/0x7a0<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu kernel: [ =
5756.582479]&nbsp; [&lt;ffffffff8105af5e&gt;] =
__do_page_fault+0x19e/0x560<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu =
kernel: [ 5756.590664]&nbsp; [&lt;ffffffff810a62e8&gt;] ? =
__enqueue_entity+0x78/0x80<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu =
kernel: [ 5756.597382]&nbsp; [&lt;ffffffff810a8015&gt;] ? =
set_next_entity+0x95/0xb0<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu =
kernel: [ 5756.608215]&nbsp; [&lt;ffffffff81011627&gt;] ? =
__switch_to+0x167/0x580<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu kernel: [ =
5756.614156]&nbsp; [&lt;ffffffff8105b351&gt;] =
do_page_fault+0x31/0x70<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'>Jul 22 01:17:50 ubuntu kernel: [ =
5756.616875]&nbsp; [&lt;ffffffff81770168&gt;] =
page_fault+0x28/0x30<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><div><div =
style=3D'border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in'><p class=3DMsoNormal><b>From:</b> Cristian Valean =
[mailto:cristian.valean@live.com] <br><b>Sent:</b> Thursday, July 23, =
2015 2:34 PM<br><b>To:</b> =
ltp-list@lists.sourceforge.net<br><b>Subject:</b> [LTP] OOM messages =
when running full ltp tests on a Hyper-V VM<o:p></o:p></p></div></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I&#8217;m =
trying to run a full ltp test run on Ubuntu 14.04.2 as a Hyper-V =
VM.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>The VM is set with 8 or 12GB and 4 vCPUs, however =
during the tests execution the syslog records over 30 call traces =
similar to the one below.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_0009_01D0C555.B9244B80--


--===============5284852298344110242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============5284852298344110242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5284852298344110242==--

