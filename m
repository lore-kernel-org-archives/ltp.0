Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UVyFQ-0007PK-UU
	for ltp-list@lists.sourceforge.net; Sat, 27 Apr 2013 06:04:36 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UVyFP-0002pG-LP
	for ltp-list@lists.sourceforge.net; Sat, 27 Apr 2013 06:04:36 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 27 Apr 2013 02:04:32 -0400
References: <bc3a8ce458b93dd36e09ea01c3001513f00462c4.1367036468.git.zliu@redhat.com>
In-Reply-To: <bc3a8ce458b93dd36e09ea01c3001513f00462c4.1367036468.git.zliu@redhat.com>
MIME-Version: 1.0
Message-Id: <201304270204.34020.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============6379411247778980547=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6379411247778980547==
Content-Type: multipart/signed; boundary="nextPart2695591.Egq0KCfjLQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2695591.Egq0KCfjLQ
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 27 April 2013 00:23:14 Zhouping Liu wrote:
> The reason is that node0 only contains all CPUs, no any memory,

no any memory -> no memory

> and node1 contains all memory, but no CPUs, in the previous codes,

change "CPUs, in" to "CPUs. In"

> we only do cpuset testing on a independent node, which caused the

a -> an

> sub-cpuset cgroup only contains CPUs or memory in one node, but

only contains -> to only contain

> that's not permitted in the special machine. The patch fixed it.

what is a "special machine" ?

also, generally there's no need to say "The patch fixed it".  the fact that=
=20
you've described a bug and have a patch implies that this fixes things.

> +		tst_resm(TINFO, "None CPUs in the node%ld", nd);

i think you mean "no" instead of "None"

> +		tst_resm(TINFO, "Only use CPU0 in the cpuset cgroup "
> +				"for the special scenario");

what is "the special scenario" ?

>  	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
> -	if (is_numa(cleanup) > 0)
> -		/* For NUMA system, using the first node for cpuset.mems */
> -		write_cpusets(get_a_numa_node(cleanup));
> -	else
> -		/* For nonNUMA system, using node0 for cpuset.mems */
> -		write_cpusets(0);
> +
> +	/*
> +	 * Not any nodes contain memory, so using get_allowed_nodes(NH_MEMS)

"Not any" -> "No"

"using" -> "use"

> +	 * to get a memory node, the operation also applies to Non-NUMA

change the ", the" to ". This".

> +	 * system.

systems.

> +        /*

looks like you mixed spaces & tabs.  only use tabs.

> +	 * Not any nodes contain memory, so using get_allowed_nodes(NH_MEMS)
> +	 * to get a memory node, the operation also applies to Non-NUMA
> +	 * system.

same comments about the grammar here as above
=2Dmike

--nextPart2695591.Egq0KCfjLQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRe2pxAAoJEEFjO5/oN/WBC1IQAIy38VA0NSagQlFkNOwLFEIH
559oEqicP2vWt1QAShr4PjFteC2MBJF1Nohql718kxPkTGGhDcVaNEWjCI4RvD4N
YiGzGQeC7P/fJAaPMlNB2FzNZkQ3lGSKvwrhVuo52Tv8aT3JEWzXuzr0PWhzOTx4
7fpWd8l7DwWLXlgm27cBaUVzkScPp0UNDQ2QxWDPDWuRUiYj3sR8V85rNayaUGot
1bFLGVh5N3QF2Y5wB1nztBTMh/R/n4/R9FWIB3yt3wouNNGcLfdyUXbSENfiJ9s0
ptPFEdNXuT1bPMUbYUX6xojsTNaweGmKqIZqhrXQYwz6r4QipyNFoTF78zHvh44x
lQfyRraVJQGyQDRBwPOqnPKnfEdHpdfA9l+oRZENWGZRIv/JGk2cdw1LcRnMT4YO
K7nkuZeeSwFQpDz84gY5K6YjpfImYxazVCYYI3L4qQfbpbf+0krfeLMwItwXVaC/
CRnYHNxlRDuWTuWTP8NBHkJGXYkU/05Ae+vAvLKFrYQrOSOh6a/SOZ86RW5iExnB
NmLDLo+lKzsJXLkXLYKZieLadvAhbY4eGYrHSR50Fb9TZGcMoXHflwphU5oWNPns
LdIUJmaERL7lRtfNzEUPbwaHBT1hCh7GlmJ7Fpy0DEB/idc9AEAbeONLK1jOBkI6
s1B/sAFzhgjbKnmz65Gi
=65g6
-----END PGP SIGNATURE-----

--nextPart2695591.Egq0KCfjLQ--


--===============6379411247778980547==
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
--===============6379411247778980547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6379411247778980547==--

