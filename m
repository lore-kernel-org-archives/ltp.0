Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <nikola.ciprich@linuxbox.cz>) id 1RVVlt-0006dM-LG
	for ltp-list@lists.sourceforge.net; Tue, 29 Nov 2011 22:03:25 +0000
Received: from gwu.lbox.cz ([62.245.111.132])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RVVlp-0003ZD-2v
	for ltp-list@lists.sourceforge.net; Tue, 29 Nov 2011 22:03:25 +0000
Date: Tue, 29 Nov 2011 23:03:08 +0100
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Message-ID: <20111129220308.GA3953@nik-comp.lan>
References: <20111127201232.GB2268@nik-comp.lan>
	<4ED480A4.2000003@linux.vnet.ibm.com>
MIME-Version: 1.0
In-Reply-To: <4ED480A4.2000003@linux.vnet.ibm.com>
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
Content-Type: multipart/mixed; boundary="===============2840562151578763031=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Shubham Goyal <shubham@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net


--===============2840562151578763031==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I have also seen some hangs with memcg_stress test on some of my x =20
> machines. But this is not consistent for me as the same set of tests =20
> works fine on one machine and hangs on other. Yes this is not expected =
=20
> behavior and ideally tests should complete. Can you please give a try =20
> after changing swap space to twice the size of RAM? Also can you paste =
=20
> here the the exact process which is hanging for you i.e. paste the =20
> output of 'ps -ef | grep ltp' during the system hang state.

Hello Shubham,

I tried setting swap to 8GB, but the result is the same... the box gets int=
o state
that I can't login to it even after few hours, so hard reset is needed..
When I have top started, I see a lot of memcg_process_stress processes.
What is strange, when I start the test with swap disabled, memcg_process_st=
ress processes
just seem to eat all physical memory and then just sleep. OOM killer doesn'=
t kill anything,
but the box doesn't hang..
weird..
I'm wondering whether to report this to kernel list?
or do You have any idea on where to look?
cheers
nik

>
> Thanks,
> Shubham
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

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7VVpsACgkQ3xdJJrLygV5JzwCfb0ZJx166V2RrdgArLY5h60Wh
xmgAoIhjzu6d9W3wUs3snCuQO0T332ps
=lXWi
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--


--===============2840562151578763031==
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
--===============2840562151578763031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2840562151578763031==--

