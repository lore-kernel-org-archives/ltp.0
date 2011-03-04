Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <cristian@regolo.cc>) id 1PvXZr-0006IL-L4
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 16:10:03 +0000
Received: from aiolia.regolo.cc ([178.79.135.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PvXZq-00081a-OX
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 16:10:03 +0000
Received: from regolo (85-18-251-172.ip.fastwebnet.it [85.18.251.172])
	by aiolia.regolo.cc (Postfix) with ESMTPSA id DED2064
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Mar 2011 17:09:56 +0100 (CET)
Date: Fri, 4 Mar 2011 17:09:32 +0100
From: Cristian Greco <cristian@regolo.cc>
Message-ID: <20110304170932.19819907@regolo>
Mime-Version: 1.0
Subject: [LTP] [PATCH] kill05: fix regression
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4379084151952127048=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4379084151952127048==
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/7U1h5ONWtNvYQ1b.FP8y21R";
	protocol="application/pgp-signature"

--Sig_/7U1h5ONWtNvYQ1b.FP8y21R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

this should fix a regression in kill05.

Why did tst_resm/tst_exit get replaced by perror/exit in 84f181fd?


Signed-off-by: Cristian Greco <cristian@regolo.cc>
---
 testcases/kernel/syscalls/kill/kill05.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/kill/kill05.c
b/testcases/kernel/syscalls/kill/kill05.c index 0193100..ac5dc86 100644
--- a/testcases/kernel/syscalls/kill/kill05.c
+++ b/testcases/kernel/syscalls/kill/kill05.c
@@ -121,11 +121,12 @@ int main(int ac, char **av)
 		tst_brkm(TBROK, cleanup, "Fork failed");
 	else if (pid =3D=3D 0)
 		do_master_child(av);
-
+  else {
 	if (waitpid(pid, &status, 0) =3D=3D -1)
 		tst_resm(TBROK|TERRNO, "waitpid failed");
 	else if (!WIFEXITED(status) || WEXITSTATUS(status) !=3D 0)
 		tst_resm(TFAIL, "child exited abnormally");
+  }
 	cleanup();
 	tst_exit();
 }
--=20
1.7.4.1


Thanks,
--
Cristian Greco
GPG key ID: 0xCF4D32E4

--Sig_/7U1h5ONWtNvYQ1b.FP8y21R
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNcQ68AAoJEID329zPTTLkD7MP/0cAkcmFZ6jTXQgu3mJIXsvS
nrEnV66BiRP8h/KSah+vmI/M8NNisehtD/PjZPK0yy/4L7OpuIWfwmrOrXbXIxTs
yN5pOjWf1NfgLxbZMLSfk4Detnz+2fOYUMQZ2h08/HbUrA7pLBZckdpL1s4fphhX
sJqTkB/l2QE8q4HTJH+8leMJwk3DyMApgQj27hhc5UyzJeuSmTRJ2bbf7c/N5D/7
zdg/5PCuJbxNJF/bHYJgMc+fhJyYkD51BTXaRF4Xmcq0jblqMmbi50nhBPc22nL5
0fsdoHgVwXp6GukKebMnPTaUieeiCfxYf2jcK6554XVTKhBBKbQFt3BXHngTKEGI
0koGJy00/gPF8eA6b4F7boQo+WVRagXAxvpNDbAFZzVRPKGDBi06KOovcnetOZAt
Lh4KVn8zWVVB8ul3bDJXkEr6thJaN4MuRpLH1LfrjbJaPlJl9P+lExbjepNvowrD
gfHkCwU/aR42Il6lCtM6G79AuLVbvMSmQe0sQuzuDh889KQUOfdHSDZDDlgkr7lU
aAQD3KR3dqazUJVdcl4i0+GQt8OUiBsoSN382hUIZNrnvjuCkW+1zSn6WdwExlJ/
70AMfaaePTHOHW63zwjDbDvqm0MvWROi7Eu5vrNY7GXLLFC8/NGOxpNsD2fdb5DD
46DaSIdV9dJTtpkkjjqI
=GvjT
-----END PGP SIGNATURE-----

--Sig_/7U1h5ONWtNvYQ1b.FP8y21R--


--===============4379084151952127048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
--===============4379084151952127048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4379084151952127048==--

