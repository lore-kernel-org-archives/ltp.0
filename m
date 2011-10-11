Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shwetabhgoel@gmail.com>) id 1RDVDK-000632-NE
	for ltp-list@lists.sourceforge.net; Tue, 11 Oct 2011 05:49:18 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1RDVDK-0008MC-08
	for ltp-list@lists.sourceforge.net; Tue, 11 Oct 2011 05:49:18 +0000
Received: by gyg8 with SMTP id 8so7927543gyg.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 10 Oct 2011 22:49:12 -0700 (PDT)
MIME-Version: 1.0
From: "shwetabhgoel@gmail.com" <shwetabhgoel@gmail.com>
Date: Tue, 11 Oct 2011 11:18:52 +0530
Message-ID: <CAFew7vRh3dEFE1FFdfrkcqAw3HpGD9Sj6pggD_T_w9d6xbvdiw@mail.gmail.com>
Subject: [LTP] Ltp-kdump does not execute
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6571458384594966372=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6571458384594966372==
Content-Type: multipart/alternative; boundary=bcaec520ee878920bb04aeff7722

--bcaec520ee878920bb04aeff7722
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am trying to run the LTP's kdump tests on 3.1.0-rc7+ kernel on Rhel6.2
beta target.
The LTP version being used is ltp-full-20110915. When I try to do a make all
for kdump,
I get the following error:

[root@Treadstone kdump]# make all
chmod a+x runkdump.sh lib/*.sh
./runkdump.sh
+ conf=runkdump.conf
+ lib=lib
+ log=log
+ . runkdump.conf
./runkdump.sh: line 174: .: runkdump.conf: file not found
make: *** [all] Error 1

As per the instructions in the README document, I copied
runkdump.BASIC_LKDTM.RHEL from sample
and renamed it to runkdump.conf, but I am not able to proceed further.

Could anyone help me with this?
---
Regards,
Shwetabh

--bcaec520ee878920bb04aeff7722
Content-Type: text/html; charset=ISO-8859-1

Hi,<br><br>I am trying to run the LTP&#39;s kdump tests on 3.1.0-rc7+ kernel on Rhel6.2 beta target.<br>The LTP version being used is ltp-full-20110915. When I try to do a make all for kdump,<br>I get the following error:<br>

<br>[root@Treadstone kdump]# make all<br>chmod a+x runkdump.sh lib/*.sh<br>./runkdump.sh<br>+ conf=runkdump.conf<br>+ lib=lib<br>+ log=log<br>+ . runkdump.conf<br>./runkdump.sh: line 174: .: runkdump.conf: file not found<br>

make: *** [all] Error 1<br><br>As per the instructions in the README document, I copied runkdump.BASIC_LKDTM.RHEL from sample<br>and renamed it to runkdump.conf, but I am not able to proceed further.<br><br>Could anyone help me with this?<br clear="all">

---<br>Regards,<br>Shwetabh<br>

--bcaec520ee878920bb04aeff7722--


--===============6571458384594966372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
--===============6571458384594966372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6571458384594966372==--

