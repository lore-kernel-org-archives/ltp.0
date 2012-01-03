Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RiAyf-0003l8-B0
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:28:57 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiAye-0000LO-KP
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:28:57 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Jan 2012 15:29:03 -0500
References: <4F02CD36.2010600@imgtec.com>
In-Reply-To: <4F02CD36.2010600@imgtec.com>
MIME-Version: 1.0
Message-Id: <201201031529.03842.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 04/21] syscalls: Use %zu modifier to print
	variables of type size_t
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5361628512356676579=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============5361628512356676579==
Content-Type: multipart/signed; boundary="nextPart2803843.dZuRkusAWQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2803843.dZuRkusAWQ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tuesday 03 January 2012 04:41:10 Markos Chandras wrote:
> Hi, please review the attached patch

using %zu for size_t is good
-mike

--nextPart2803843.dZuRkusAWQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPA2UPAAoJEEFjO5/oN/WBqAAQAI3SsNrhDj/EUmBIpwFlmdhY
OmW9axGXUFuAdFxRdIIrlb7BtljscPE0EAQ3aoPxMGRG1EI4QhYdqLANDepSczp2
W8vrzsfBtaYIGeoMgM1Q2Qqy6ESVJHx8MRPqtBv410hHIm0W3oJFmk+TXqgwMCw1
h6l2KC8eEuO/n0QKXVguokUjDMBgeLoFnKV+v8SDZ+pr6u5kB8JnL9ksd4UFvb+X
YRNiAS93aSn7eQ0WF/BkdIXMF3OPYf0brFQkaTGMwTC/1auNvAgo/2f/mq8ROcNp
7KZaeCIn0FYNyQjE4n4y2AWYsXnoF5TWOvaDhn8ERy70baiqduua2H6vq/bZKVt+
agnkmO4T72tdrniXoX3WsrGZPyyYgZbuweKPOwtFdK8gCJ8gVbjf9Gl3U3xyHvH9
Pbb+06P7TO3VUrJs0JgopJEvgK9OiEBMh0vL/CuOwtkfHeZCyjXPdccZTe/XAB4j
Kwpofv8pI3Y9NcutsioPPPesgUE0PSFw+CD+3w4pb4slhWD9ZDMg/BSeveOpxBBx
2T4d3sSVmLtrt/Xpe6mQTI9tZ3VvKFOGgyWmx1I1FIZjAnh9sR9i2BWZsdS5AF+i
ArPSlgkhAuRcRwErBXeGwOwPZsVwz4sjtqw5DB1tM8p5gfCfq0H1hEJcIWw3CcmN
2M4VvwTw39QWw7LtpYEw
=7thY
-----END PGP SIGNATURE-----

--nextPart2803843.dZuRkusAWQ--


--===============5361628512356676579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--===============5361628512356676579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5361628512356676579==--

