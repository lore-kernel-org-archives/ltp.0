Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1OTKeg-0004fu-Gv
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 20:10:10 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OTKef-0001oZ-Ew
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 20:10:10 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 28 Jun 2010 15:44:12 -0400
References: <20100628115217.23913.32352.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100628115217.23913.32352.sendpatchset@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <201006281544.13666.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Remove files which does not have a dmesg entry
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0806999948189148826=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP List Members <ltp-list@lists.sf.net>

--===============0806999948189148826==
Content-Type: multipart/signed; boundary="nextPart14069830.8oetnviXLA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart14069830.8oetnviXLA
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday, June 28, 2010 07:52:18 Subrata Modak wrote:
> +	if [ $ALT_DMESG_OUT -eq 1 ] ; then
> +		PWD=3D`pwd`
> +		cd $DMESG_DIR
> +		for dmesg_file in `ls`
> +		do
> +			dmesg_file_size=3D`wc -c $dmesg_file | cut -d ' ' -f1 | tr -d=20
'\n'`
> +			if [ $dmesg_file_size -eq 0 ]; then
> +				rm -rf $dmesg_file
> +			fi
> +		done
> +		cd $PWD
> +	fi

ugh.  what's wrong with simply executing:
	find "$DMESG_DIR" -size 0 -exec rm {} +

> +	if [ `ls -l $DMESG_DIR | wc -l` -ge 1 ]; then

if [ -n "$(ls "$DMESG_DIR")" ] ; then
=2Dmike

--nextPart14069830.8oetnviXLA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iQIcBAABAgAGBQJMKPuNAAoJEEFjO5/oN/WBzIUP/1rHaPN8VN6joybpyWoDZsVA
HIa9ywJTCe/N1EyJ5xM3dMZiuAKIAjnyClOa30I5kv0dq2S5Li/y/oGFQHMIPon0
t4bVdXUNDPSJlET3cBFRCRD7za99bVmM/w5wppdPXN5pXomYleIbTinm/y6vZi+r
+r0aVQjuvRaI8uyELU1ug0L03bfqCJE05+DhVnDlIw6BcI+e6A3VD+62Uw02W14x
pcUi4hnxjd57R0DHH/B5wcxW1661b7yEkpslyYenLefm6XDpOx2JckBL4D4FAk/V
e6Nj2gyp2HAFRhCjOIQk2uj49weguTtLiUqovnKnrpmL+twHlht7lcK5Ltf6NGeI
2v2K6PUogpkabd43Nc/ImphSS8EtwYw/VGasfgZxLixAB1jaey4PNXNrfnfANQWf
tEhqyLvLpH5hOr9fofal1dHS+d7ve+zaP7CDzlqyB0AE+q8r9tlZy00+zESH6383
cwbxrrDsD8HGR0u/2vRn20GNJjP6MMZSf6Pp7EzHwBXXcrczdTZHB0aCQCiROxsO
IVC7HqppIIYAy6w5THVymYOnkzkppWhBjVCMjtDgUxHgS3JBd5/s2X/yRDiNpQ2F
OOwBTPp2F/uu1c5Y2jcsi0gfBFzs+MehG9MM2evWaSdXYpAG5pAl3gDjRdqNaNhG
A18NpCEi3+6k8T9Neu/b
=ue8e
-----END PGP SIGNATURE-----

--nextPart14069830.8oetnviXLA--


--===============0806999948189148826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--===============0806999948189148826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0806999948189148826==--

