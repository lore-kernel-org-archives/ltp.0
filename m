Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kdlucas@gmail.com>) id 1NtZzJ-0002S8-3E
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 05:15:41 +0000
Received: from mail-qy0-f201.google.com ([209.85.221.201])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NtZzI-0003Iq-8j
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 05:15:41 +0000
Received: by qyk39 with SMTP id 39so3216820qyk.22
	for <ltp-list@lists.sourceforge.net>;
	Sun, 21 Mar 2010 22:15:34 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 21 Mar 2010 22:15:34 -0700
Message-ID: <b9d696241003212215y57070683g828dd982d2366872@mail.gmail.com>
From: "K.D. Lucas" <kdlucas@gmail.com>
Subject: [LTP] memcg_stress_test.sh hanging system
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3131428483674625788=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP-ML <ltp-list@lists.sourceforge.net>

--===============3131428483674625788==
Content-Type: multipart/alternative; boundary=0016362843aa635e7a04825cc967

--0016362843aa635e7a04825cc967
Content-Type: text/plain; charset=ISO-8859-1

I just downloaded the latest LTP, ltp-full-20100228.1

I'm running it on Linux Mint Helena x64 Edition.
Kernel: 2.6.31-14-generic x86_64

I installed it by running:

./configure
make
sudo make install

My entire system just hangs when it gets to the memcg_stress_test.sh test.

I'm running this on an HP Z600 with 12 gb ram and 2 Intel Xeon E5520 2.27
ghz cpus. These are quad core CPUs with HyperThreading.

What I see in /var/log/syslog is:

Mar 21 20:09:14 daredevil kernel: [17277.016792] Memory cgroup out of
memory: kill process 28223 (memcg_process) score 99 or a child
Mar 21 20:09:14 daredevil kernel: [17277.016836] Killed process 28223
(memcg_process)

Is anyone else seeing this?

kdl

-- 
K.D. Lucas
kdlucas@gmail.com

--0016362843aa635e7a04825cc967
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I just downloaded the latest LTP, ltp-full-20100228.1<br><br>I&#39;m runnin=
g it on Linux Mint Helena x64 Edition.<br>Kernel: 2.6.31-14-generic x86_64<=
br><br>I installed it by running:<br><br>./configure<br>make<br>sudo make i=
nstall<br>
<br>My entire system just hangs when it gets to the memcg_stress_test.sh te=
st.<br clear=3D"all"><br>I&#39;m running this on an HP Z600 with 12 gb ram =
and 2 Intel Xeon E5520 2.27 ghz cpus. These are quad core CPUs with HyperTh=
reading. <br>
<br>What I see in /var/log/syslog is:<br><br>Mar 21 20:09:14 daredevil kern=
el: [17277.016792] Memory cgroup out of memory: kill process 28223 (memcg_p=
rocess) score 99 or a child<br>Mar 21 20:09:14 daredevil kernel: [17277.016=
836] Killed process 28223 (memcg_process)<br>
<br>Is anyone else seeing this?<br><br>kdl<br><br>-- <br>K.D. Lucas<br><a h=
ref=3D"mailto:kdlucas@gmail.com">kdlucas@gmail.com</a><br>

--0016362843aa635e7a04825cc967--


--===============3131428483674625788==
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
--===============3131428483674625788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3131428483674625788==--

