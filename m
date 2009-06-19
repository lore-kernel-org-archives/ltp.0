Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1MHdse-0004Yg-QN
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 13:11:44 +0000
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127])
	by 29vjzd1.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHdsY-0005Ew-Aw
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 13:11:39 +0000
Message-ID: <4A3B823C.8020009@st.com>
Date: Fri, 19 Jun 2009 14:19:08 +0200
From: Francesco RUNDO <francesco.rundo@st.com>
MIME-Version: 1.0
References: <f5a7b3810906171317j40473a95y5dfc1b89d9e25950@mail.gmail.com>	
	<4A3A049B.2000002@st.com>	
	<f5a7b3810906180808l19d1889bn5575cf00de28d801@mail.gmail.com>	
	<4A3B542E.708@st.com>
	<f5a7b3810906190312l75735199k43df06045d6264be@mail.gmail.com>
In-Reply-To: <f5a7b3810906190312l75735199k43df06045d6264be@mail.gmail.com>
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>, Oleg Nesterov <oleg@redhat.com>, rohit.170309@gmail.com

Hi Naresh,

naresh kamboju wrote:

>Hi Francesco,
>
>Thanks for your comments.
>
>I have few questions
>1. Are you compiling LTP on Host Machine and running on target boards?
>
Yes, precisely, I cross-build LTP on the HOST and run it on a different =

TARGET machine.

>
>2. Is it cross complication with different tool chains?
>
Yes. I cross-compile for SH based platforms. See =

http://www.stlinux.com/drupal for more details.

>3. Do you export KERNEL_VERSION and MACHINE_ARCHITECTURE on Host or target?
>
On the HOST when I process the LTP-log to generate the corresponding =

HTML file.

>
>At my end I am compile with cross tool chains and copy the LTP
>complied source on target and executing the =93runltp=94.
>In my case I don=92t get any variables from Host.
>I am not exporting Any Macros on target.
>
>I guess. Most of our LTP users do same.
>

I'm not sure about LTP users use the above approach, but what I think =

should be taken into account is """what is better for all the LTP users""".
Do you agree ?
Now, can I do an advantages/disadavantages analysis of the methods (mine =

and yours) ?

Yours (with usage of "uname -x"):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ADVANTAGES:
*) Automatic generation of information (of course, more safe!).
DISADVANTAGES:
*) Need PERL on the TARGET machine;
*) No flexible (I can't modify the info by adding more info....I have to =

keep what "uname -x" provides);
*) Can be executed only on the TARGET (on the HOST it provides wrong =

information);

Mine(with usage of "env variables"):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ADVANTAGES:
*) No PERL is needed on the TARGET;
*) Flexible (I could use the output provided by "uname -x" executed on =

the TARGET or I can add more info if needed);
*) Can be run both on the HOST and on the TARGET;
DISADVANTAGES:
*) Is not automatic as the user can properly define/export the relaetd =

env variables.

Now, from above analysis I think should be taken a final decision.

>
>Thanks for your info.
>
No problem.

Best Regards
Francesco Rundo


---------------------------------------------------------------------------=
---
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing =

server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
