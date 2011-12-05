Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <nikola.ciprich@linuxbox.cz>) id 1RXXEh-0003J4-F7
	for ltp-list@lists.sourceforge.net; Mon, 05 Dec 2011 12:01:31 +0000
Received: from gwu.lbox.cz ([62.245.111.132])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RXXEf-0002ei-Vm
	for ltp-list@lists.sourceforge.net; Mon, 05 Dec 2011 12:01:31 +0000
Date: Mon, 5 Dec 2011 13:01:18 +0100
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Message-ID: <20111205120118.GK988@pcnci.linuxbox.cz>
References: <20111127201232.GB2268@nik-comp.lan>
	<4ED480A4.2000003@linux.vnet.ibm.com>
	<20111129220308.GA3953@nik-comp.lan>
	<4ED90B1C.8000204@linux.vnet.ibm.com>
MIME-Version: 1.0
In-Reply-To: <4ED90B1C.8000204@linux.vnet.ibm.com>
Subject: Re: [LTP] LTP: memcg_stress_test hanging whole box
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1571734765820014676=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Shubham Goyal <shubham@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net


--===============1571734765820014676==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSVNCtZB1QZ8vhj+"
Content-Disposition: inline


--VSVNCtZB1QZ8vhj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Nikola,
Hello Shubham,

>
> What I recently noticed was the controller test hang problem is coming =
=20
> with old versions of LTP. I tried with latest release of LTP on the same =
=20
> affected machine and I did not observed any test case or system hang. I =
=20
> hope you are using latest LTP downloaded from 'ltp.sourceforge.net'?
yes, I'm using 20110915.

>
> There might be a issue with oom that it is not able to kill the memory =
=20
> intensive process but you need to gather more information about the =20
> hanging process first. You might want to run only the hanging test i.e. =
=20
> memcg_stress and not complete LTP to narrow down the issue. Just check =
=20
> whether you are able to reproduce the issue when only memcg_stress test =
=20
> is running There are chances that test case itself has some issues.
yup, it's possible to reproduce just with this one test..
so do You want me to collect OOM traces and report here? or directly to
LKML?

thanks
n.


>
> Thanks,
> Shubham
>
>

--=20
-------------------------------------
Ing. Nikola CIPRICH
LinuxBox.cz, s.r.o.
28. rijna 168, 709 01 Ostrava

tel.:   +420 596 603 142
fax:    +420 596 621 273
mobil:  +420 777 093 799
www.linuxbox.cz

mobil servis: +420 737 238 656
email servis: servis@linuxbox.cz
-------------------------------------

--VSVNCtZB1QZ8vhj+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7cso4ACgkQ3xdJJrLygV7TAACfWhblH1Nmh7uLi9HpHlH1ibX+
e30An1GYwYQZpBqtpR08lqERfyBvsg8l
=OxfT
-----END PGP SIGNATURE-----

--VSVNCtZB1QZ8vhj+--


--===============1571734765820014676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
--===============1571734765820014676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1571734765820014676==--

