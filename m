Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1VonEh-0002Jo-Re
	for ltp-list@lists.sourceforge.net; Fri, 06 Dec 2013 04:41:55 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VonEf-0002wM-Rv
	for ltp-list@lists.sourceforge.net; Fri, 06 Dec 2013 04:41:55 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 5 Dec 2013 23:41:52 -0500
References: <1386248023.1542.10.camel@G08JYZSD130126>
In-Reply-To: <1386248023.1542.10.camel@G08JYZSD130126>
MIME-Version: 1.0
Message-Id: <201312052341.53692.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2 2/4] fallocate/fallocate.h: move inline function
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3598188936709023022=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3598188936709023022==
Content-Type: multipart/signed; boundary="nextPart4090750.PO9OHtD9yd";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4090750.PO9OHtD9yd
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 05 December 2013 07:53:43 zenglg.jy wrote:
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fallocate/fallocate.h
>
> +#include "linux_syscall_numbers.h"
> +static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
> +{
> +#if __WORDSIZE =3D=3D 32
> +	return (long)ltp_syscall(__NR_fallocate, fd, mode,
> +				 __LONG_LONG_PAIR((off_t) (offset >> 32),
> +						  (off_t) offset),
> +				 __LONG_LONG_PAIR((off_t) (len >> 32),
> +						  (off_t) len));
> +#else
> +	return ltp_syscall(__NR_fallocate, fd, mode, offset, len);
> +#endif
> +}

this isn't a new issue, but this code isn't entirely correct.  __WORDSIZE w=
ill=20
fail on ABI's that have 64bit registers but 32bit longs like MIPS n32 and=20
x86_64 x32.  you should at least add a comment above the func noting this=20
breakage.

what is a new issue though is that your inline header must include every=20
header that it needs.  so the things that provide loff_t and off_t and=20
__LONG_LONG_PAIR and ltp_syscall().
=2Dmike

--nextPart4090750.PO9OHtD9yd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSoVWRAAoJEEFjO5/oN/WBg4oQAJ0AtPo72PL6JXXK6sXPSLcK
WmTNCG9AdfMx/A/vQ3qYB/tLsVPYFT2q5SISAXpvgamuQQnZvDs/3KLlcZdMVxpu
ch0Xz6fva0CyNJ3UfZaNf+JSYLK90G1JyyplSW4nXXM/ZzPyxIMSaq28zm+96vt5
Nn++NdlVvC233XUe62ymkc+ZwK/2FUMq2PratU7hB3kqNKnxXT+xL0rTcc3ZZq+t
0ixFx316S53lDgZ3dk2qZWV/l1IevlvmBKdMj6mmFwYuYxLU5dMwcV4VeOCKdvg5
3q6NN9wycZIFITc/EYdYA7Ra9MXWCwWDEhVrazx9D1kBdNnflqwW8j1npUOd68+7
/qkaf9lwNDsOoBkbsemyauK/MQSZy9Wyy3OKJryTJ6DT2VqM72sKeuyvqrDADd6G
Y2pv7RRsisQQEmGZFWGGazu+DPQmQlp6O8NQkHsjnRxkPB8I3xcenNlCnCccF173
qoYGZ5h2T/JPRB5iT1IRODtphZ25Uf+eHvTTI7/hwUAMkquZneUJYVXy5NjXUNEp
oTQ3PNZNZNvH4e00+RLVtGU9YvQhyVPKIDFeRfLwbuKhO0sAjMq/uQ0rzSRfRa/X
dgx8kW3yHB6kvU49AXb0tgZvcUTjlD5tjvpHVAf3oVl9dTEnWbzVYWUbDPOaNc+E
mWYv7futOHZs1dO8a2U3
=TCL0
-----END PGP SIGNATURE-----

--nextPart4090750.PO9OHtD9yd--


--===============3598188936709023022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
--===============3598188936709023022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3598188936709023022==--

