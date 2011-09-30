Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <joshiplns@gmail.com>) id 1R9Ypt-0007UN-KV
	for ltp-list@lists.sourceforge.net; Fri, 30 Sep 2011 08:52:49 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1R9Ypp-00069W-TZ
	for ltp-list@lists.sourceforge.net; Fri, 30 Sep 2011 08:52:49 +0000
Received: by bke11 with SMTP id 11so2006777bke.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 30 Sep 2011 01:52:39 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 30 Sep 2011 14:22:39 +0530
Message-ID: <CADfK0X7-VwdyCDMZe5VJfv+KchEKqRRw6e-9dv4=ine+36rDzQ@mail.gmail.com>
From: "Josh!" <joshiplns@gmail.com>
Subject: [LTP] ltp-pan: cannot execute binary file
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6011485108232523796=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6011485108232523796==
Content-Type: multipart/alternative; boundary=0015174c11de5dd55e04ae24bfe9

--0015174c11de5dd55e04ae24bfe9
Content-Type: text/plain; charset=ISO-8859-1

Hi folks ,

I am running 3.0 Kernel for armv7a on *Beagle Board* target.

Meanwhile I'm testing kernel with ltp-full-20110915. I did the Make and Make
Install properly.
But while running ./runltp script I am facing following issue.

{{{

./runltp: line 824: /mnt/HDD/ltp-full-20110915/Joshi_LTP/bin/ltp-pan: cannot
execute binary file
INFO: ltp-pan reportedAIL

}}}

Could anyone can share knowledge on this issue ?

Kindly
Joshi

--0015174c11de5dd55e04ae24bfe9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi folks ,<br><br>I am running 3.0 Kernel for armv7a on *B=
eagle Board* target.<br><br>Meanwhile I&#39;m testing kernel with ltp-full-=
20110915. I did the Make and Make Install properly.<br>But while running ./=
runltp script I am facing following issue.<br>
<br>{{{<br><br>./runltp: line 824: /mnt/HDD/ltp-full-20110915/Joshi_LTP/bin=
/ltp-pan: cannot execute binary file<br>INFO: ltp-pan reportedAIL<br><br>}}=
}<br><br>Could anyone can share knowledge on this issue ?<br><br>Kindly<br>
Joshi<br><br>
</div>

--0015174c11de5dd55e04ae24bfe9--


--===============6011485108232523796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security
threats, fraudulent activity, and more. Splunk takes this data and makes
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2dcopy2
--===============6011485108232523796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6011485108232523796==--

