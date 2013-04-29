Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UWbdm-0000XX-Gg
	for ltp-list@lists.sourceforge.net; Mon, 29 Apr 2013 00:08:22 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UWbdl-000840-3s
	for ltp-list@lists.sourceforge.net; Mon, 29 Apr 2013 00:08:22 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 28 Apr 2013 20:08:03 -0400
References: <bc3a8ce458b93dd36e09ea01c3001513f00462c4.1367036468.git.zliu@redhat.com>
	<201304270204.34020.vapier@gentoo.org>
	<1655733918.3290321.1367044489461.JavaMail.root@redhat.com>
In-Reply-To: <1655733918.3290321.1367044489461.JavaMail.root@redhat.com>
MIME-Version: 1.0
Message-Id: <201304282008.05044.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] mem/oom: fixed a cpuset error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3243685090739479676=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Zhouping Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

--===============3243685090739479676==
Content-Type: multipart/signed; boundary="nextPart14875921.UStS426zSA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart14875921.UStS426zSA
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 27 April 2013 02:34:49 Zhouping Liu wrote:
> From: "Mike Frysinger" <vapier@gentoo.org>
> > On Saturday 27 April 2013 00:23:14 Zhouping Liu wrote:
> > > sub-cpuset cgroup only contains CPUs or memory in one node, but
> >=20
> > only contains -> to only contain
>=20
> why 'contain', I think it should be 'contains', isn't it?

when you add the "to", it changes to "contain"

> > > that's not permitted in the special machine. The patch fixed it.
> >=20
> > what is a "special machine" ?
>=20
> the special machine is that it has such nodes(describe above),
> in which there's only CPUs or memory.
>=20
> how about this:
>=20
> "that's not permitted in the such above special machine."

i would use:
that's not permitted in the scenario described above.

> > > +		tst_resm(TINFO, "None CPUs in the node%ld", nd);
> >=20
> > i think you mean "no" instead of "None"
> >=20
> > > +		tst_resm(TINFO, "Only use CPU0 in the cpuset cgroup "
> > > +				"for the special scenario");
> >=20
> > what is "the special scenario" ?
>=20
> the special scenario is "no CPUs in the node%ld", I think it's clear in l=
og
> message.

when you say "Only use", that's a command to the user.  i think you meant t=
o=20
say "Only using".

i think the two messages can be combined into one then:
	tst_resm(TINFO, "No CPUs in node%ld; using only CPU0", nd);

> > >  	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
> > >=20
> > > -	if (is_numa(cleanup) > 0)
> > > -		/* For NUMA system, using the first node for cpuset.mems */
> > > -		write_cpusets(get_a_numa_node(cleanup));
> > > -	else
> > > -		/* For nonNUMA system, using node0 for cpuset.mems */
> > > -		write_cpusets(0);
> > > +
> > > +	/*
> > > +	 * Not any nodes contain memory, so using get_allowed_nodes(NH_MEMS)
> >=20
> > "Not any" -> "No"
>=20
> it's not that meaning, what I meant here is that there's not any nodes
> contain memory in a NUMA system, Some nodes contain memory, but some nodes
> don't.

ok, so i think you want to say instead:
	Some nodes do not contain memory, ....
=2Dmike

--nextPart14875921.UStS426zSA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRfbnkAAoJEEFjO5/oN/WBrd8P/3pGww6HQmizZVQrP0qQB7KH
E35VQX9/yBcuthJI2+m+owj19WIJR3jMzaeOI2IoHXoRg7HVUfmK6gZcIKVECBB0
wpUvi1/UD2xaF3r/2U7pvzjpOsAe3/l3ZHYrut/vI/u3oZrPL0PIkOFK0jyT/HMX
iGxuqZ6eJYXyj2WvnFUwNM+TJngcuEUVfwP1YqMvwgGyDr/JZm+MFToKr6nSLYS+
FvQJqk3B9nr0/xGyfHfNYBJcmtViV2CzBYcrVh6caEv4BBcgQHY/05LitA5Yo7T1
jUdYCKHdCUgdYjpo2iln0SEVgVY5MBMKYQXOGAeyzPmduAW2OCznBU5g0MFQRlA9
ordBk73xVTm3qsFIxrbDFq/cLyNx12bNiL4pCtY0bD43tzO3bNTxxv+ZX0N7Gfbb
4Omjr59LMp5EXY/xC6FRLJbVRm2NE9qgSeaodaqMoOvWyb35xL0DezVOkIrBQxkP
Ws7zEbRYi7ciSS7CQ7uTS89SZOE0UsNHqjl+DgMxzG2VAlUlELIQ5tQDMz9+j49R
nC6eTH9URSEGFz58C5HkI+ITQOansPF5vgEtc1TbMvafpvj+KqZUD33vOGFgN6rl
vFmpLSI3lAYplyW21lvbaVIdpNj8dmmvxr7AsXKUblcznt8V17OsFIXUtZ+8Cc4T
dRJCmcvEoiIJYgmVktcI
=rO1z
-----END PGP SIGNATURE-----

--nextPart14875921.UStS426zSA--


--===============3243685090739479676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
--===============3243685090739479676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3243685090739479676==--

