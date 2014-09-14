Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <taillanchristophe@gmail.com>) id 1XT8tp-000205-J8
	for ltp-list@lists.sourceforge.net; Sun, 14 Sep 2014 12:27:25 +0000
Received: from mail-qa0-f54.google.com ([209.85.216.54])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XT8to-0001Wv-OG
	for ltp-list@lists.sourceforge.net; Sun, 14 Sep 2014 12:27:25 +0000
Received: by mail-qa0-f54.google.com with SMTP id v10so2762389qac.27
	for <ltp-list@lists.sourceforge.net>;
	Sun, 14 Sep 2014 05:27:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOi2z=w4wLnZ_8Uf9226G5n_nXwE4DQKgd=BKqn1PWSnWgdMOg@mail.gmail.com>
References: <CAOi2z=w4wLnZ_8Uf9226G5n_nXwE4DQKgd=BKqn1PWSnWgdMOg@mail.gmail.com>
Date: Sun, 14 Sep 2014 14:27:19 +0200
Message-ID: <CAOi2z=xF76SVQZ+-pGJevr8BiSXVh4O9jVYGnfJ2kOU-Gne6HA@mail.gmail.com>
From: Christophe Taillan <taillanchristophe@gmail.com>
Subject: [LTP] Questions about gcov/lcov and Fortran 90
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3013599192178889138=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3013599192178889138==
Content-Type: multipart/alternative; boundary=001a1133cfe2abd21e050305a327

--001a1133cfe2abd21e050305a327
Content-Type: text/plain; charset=UTF-8

Hi everyone,

I am currently using gcov/lcov to study coverage of a large Fortran 90
code. The goal is to find and erase unused code.
Due to the size of the program, I'm looking for a way to automatize the
process.

But I've got some trouble :
   -  with nested "if": if the main condition is not validated, all the
code in the "if" block should be tagged as "####", in fact, it seems that
other "if" lines are not...
   -  lines read once seems not to be tagged as "1",
   -  lines like "use some_module" are not tagged either.

So my question is, is there any existing tools to manage with these
problems or did I miss any option in gcov?

Thank to all of you,

Christophe

--001a1133cfe2abd21e050305a327
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi everyone,</p>
<p dir=3D"ltr">I am currently using gcov/lcov to study coverage of a large =
Fortran 90 code. The goal is to find and erase unused code.<br>
Due to the size of the program, I&#39;m looking for a way to automatize the=
 process. </p>
<p dir=3D"ltr">But I&#39;ve got some trouble :<br>
=C2=A0=C2=A0 -=C2=A0 with nested &quot;if&quot;: if the main condition is n=
ot validated, all the code in the &quot;if&quot; block should be tagged as =
&quot;####&quot;, in fact, it seems that other &quot;if&quot; lines are not=
...=C2=A0 <br>
=C2=A0=C2=A0 -=C2=A0 lines read once seems not to be tagged as &quot;1&quot=
;,<br>
=C2=A0=C2=A0 -=C2=A0 lines like &quot;use some_module&quot; are not tagged =
either.</p>
<p dir=3D"ltr">So my question is, is there any existing tools to manage wit=
h these problems or did I miss any option in gcov?<br></p>
<p dir=3D"ltr">Thank to all of you,</p>
<p dir=3D"ltr">Christophe </p>

--001a1133cfe2abd21e050305a327--


--===============3013599192178889138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce.
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
--===============3013599192178889138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3013599192178889138==--

