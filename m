Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1No1ci-0002fj-RO
	for ltp-list@lists.sourceforge.net; Sat, 06 Mar 2010 21:33:24 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1No1ch-0006Jc-WF
	for ltp-list@lists.sourceforge.net; Sat, 06 Mar 2010 21:33:24 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 6 Mar 2010 16:33:00 -0500
References: <20100227075348.GA3077@linux.vnet.ibm.com>
	<201003051635.50233.vapier@gentoo.org>
	<4B922D86.70704@petalogix.com>
In-Reply-To: <4B922D86.70704@petalogix.com>
MIME-Version: 1.0
Message-Id: <201003061633.16026.vapier@gentoo.org>
Subject: Re: [LTP] A note from Maintainer
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6769096304931792891=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: michal.simek@petalogix.com
Cc: sachinp@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net, jburke@redhat.com, ambar.seksena@calsoftinc.com, kamaleshb@in.ibm.com, doug.chapman@hp.com, risrajak@in.ibm.com, Cai Qian <qcai@redhat.com>, Khem Raj <kraj@mvista.com>, aneesh.kumar@linux.vnet.ibm.com, carmelo.amoroso@st.com, Nadia Derbey <Nadia.Derbey@bull.net>, Balbir Singh <balbir@linux.vnet.ibm.com>

--===============6769096304931792891==
Content-Type: multipart/signed; boundary="nextPart1787671.4orvpuuhhU";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1787671.4orvpuuhhU
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 06 March 2010 05:25:10 Michal Simek wrote:
> Mike Frysinger wrote:
> > On Saturday 27 February 2010 02:53:48 Rishikesh K Rajak wrote:
> >> We are in process of changing our sf.net host repository to
> >> GIT from CVS.[ Any input/discussion on this is highly appreciable ].
> >=20
> > the authorship info really should be fixed before anything is finalized=
=2E=20
> > and a git hook added to reject people pushing patches that lack proper
> > author/committer fields.  these commits by "root" are a good example of
> > things that should not be happening.
>=20
> Agree. Do you know about any manual how to fix it by any script or setup
> that conversion? I mean to have any convert table where for example will
> be written conversion:
> vampier -> Mike Frysinger.
> root -> Subrata Modak

i use this script:
#!/bin/bash

tmp=3D$(mktemp)
cat << \EOF > ${tmp}
decode() {
	awk -vid=3D"$1" -vtype=3D"$2" '$1 =3D=3D id {
		print "export GIT_"type"_NAME=3D'\''" $3 " " $4 "'\'';"
		print "export GIT_"type"_EMAIL=3D'\''" $5 "'\'';"
	}' ${author_file}
}
EOF

for x in cvs-authors authors ; do
	export author_file=3D${PWD}/.git/$x
	[ -e ${author_file} ] && break
done
git filter-branch \
	--env-filter ". ${tmp};"' \
		eval `decode "${GIT_AUTHOR_NAME}" AUTHOR`; \
		eval `decode "${GIT_COMMITTER_NAME}" COMMITTER`; \
' "$@"

rm -f $tmp

use a normal authors file in like .git/authors and run it.  the authors for=
mat=20
looks something like:
vapier =3D Mike Frysinger <vapier@gentoo.org>
=2E..
=2Dmike

--nextPart1787671.4orvpuuhhU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAABAgAGBQJLksobAAoJEEFjO5/oN/WBL90QAKgWgV8T6l9KxalDKuNR9VDC
EigZNMRKK73nEuNPfotlUXhs9QadkL1VifbqSLbvSnrW7S723Ag1J6yEVyJqbWOU
6mmJmftOGNwcIETYpfcViVPyYOZ9zM4CxUFhkq9cmKNKeymS6KZ5f8ISazPTKTPb
R/MMU4kKTleCrrkN8ZpdUNLc1Q43oraSQoo6YEdcni54gzhIrCCN8+vq/hk/XEmH
OC3SjRv35QjKAA/nTQobupQJLPLbn1YFWLIP8TE0w+MH/KKRdxfdJISaAEIu+1bZ
8l/mo/7cwqS/8CkVMMdunD1qJJsYZx8siqpXa6ch//f3HP7sVcd1sbyBk+OQRplj
zkw6evAZuract7VlWig3mQiRXiLr6JLcqX1wcgmV9MLogafkHNjTVs1RQ17kyYQS
HnTuLMzRhLuXnQyMN2xtMU7bg3o/wfhfTGpZDn4hSP6XmJviPLnCMaaeddxg8hCp
qAHoS6zzXI30QpvRibCb2GuZ+qj5ZlRcZkbCECcF1Ori1PvLcr6QVtvXxKttJUNq
m5raMisRyZzWtQO9bHz8B2ncf0twWSbye7ZHPv8ItZyV1wD7oY3LLqVklqXeW54h
BYH4MQt1rSVU4vutWH6G70S2Q61eATckMlI7dps1Q3rAXSpNfazW0Q0+G4MiE1Zq
o62Mwz4wjRCr5d9sNT+M
=P+9i
-----END PGP SIGNATURE-----

--nextPart1787671.4orvpuuhhU--


--===============6769096304931792891==
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
--===============6769096304931792891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6769096304931792891==--

