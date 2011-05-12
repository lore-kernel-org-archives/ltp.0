Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1QKU49-0002ih-VF
	for ltp-list@lists.sourceforge.net; Thu, 12 May 2011 11:28:25 +0000
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QKU47-0007q7-QZ
	for ltp-list@lists.sourceforge.net; Thu, 12 May 2011 11:28:25 +0000
Mime-Version: 1.0 (Apple Message framework v1084)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1305183593-25512-1-git-send-email-lliubbo@gmail.com>
Date: Thu, 12 May 2011 07:28:15 -0400
Message-Id: <5004B0F2-AD73-437F-995E-71B88F329A8E@gmail.com>
References: <1305183593-25512-1-git-send-email-lliubbo@gmail.com>
Subject: Re: [LTP] [PATCH] testcases: syscall: sockioctl: fix except return
	val
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1252706689886878192=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Bob Liu <lliubbo@gmail.com>
Cc: ltp-list@lists.sf.net


--===============1252706689886878192==
Content-Type: multipart/alternative; boundary=Apple-Mail-1-474981298


--Apple-Mail-1-474981298
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 12, 2011, at 2:59 AM, Bob Liu wrote:

> Since new kerenl change, sockioctl01 always fail like this:
>=20
> sockioctl01    4  TFAIL  :  ATMARK on UDP ; returned -1 (expected -1), =
errno
> 25 (expected 22)
>=20
> This patch fix the except return val from EINVAL to ENOTTY.
>=20
> Signed-off-by: Bob Liu <lliubbo@gmail.com>
> ---
> sockioctl01.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c =
b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
> index aa66bc3..6ad7a4a 100644
> --- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
> +++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
> @@ -108,7 +108,7 @@ struct test_case_t {		/* test case =
structure */
> 	{
> 	PF_INET, SOCK_DGRAM, 0, SIOCATMARK, &optval,
> 		    (struct sockaddr *)&fsin1, sizeof(fsin1), -1,
> -		    EINVAL, setup1, cleanup1, "ATMARK on UDP"}
> +		    ENOTTY, setup1, cleanup1, "ATMARK on UDP"}
> 	, {
> 	PF_INET, SOCK_DGRAM, 0, SIOCGIFCONF, &ifc,
> 		    (struct sockaddr *)&fsin1, sizeof(fsin1), 0,
> --=20
> 1.6.3.3

	This will fix the later kernel, but break earlier ones. Could =
you please submit a patch that does a check for the kernel version, a =
data structure, etc and adjusts the expected values accordingly?
Thanks!
-Garrett=

--Apple-Mail-1-474981298
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><div><div>On May 12, 2011, at 2:59 AM, Bob Liu wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div>Since =
new kerenl change, sockioctl01 always fail like this:<br><br>sockioctl01 =
&nbsp;&nbsp;&nbsp;4 &nbsp;TFAIL &nbsp;: &nbsp;ATMARK on UDP ; returned =
-1 (expected -1), errno<br>25 (expected 22)<br><br>This patch fix the =
except return val from EINVAL to ENOTTY.<br><br>Signed-off-by: Bob Liu =
&lt;<a =
href=3D"mailto:lliubbo@gmail.com">lliubbo@gmail.com</a>&gt;<br>---<br> =
sockioctl01.c | &nbsp;&nbsp;&nbsp;2 +-<br> 1 files changed, 1 =
insertions(+), 1 deletions(-)<br><br>diff --git =
a/testcases/kernel/syscalls/sockioctl/sockioctl01.c =
b/testcases/kernel/syscalls/sockioctl/sockioctl01.c<br>index =
aa66bc3..6ad7a4a 100644<br>--- =
a/testcases/kernel/syscalls/sockioctl/sockioctl01.c<br>+++ =
b/testcases/kernel/syscalls/sockioctl/sockioctl01.c<br>@@ -108,7 +108,7 =
@@ struct test_case_t {<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>/* test case structure */<br> =
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>{<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>PF_INET, SOCK_DGRAM, 0, SIOCATMARK, &amp;optval,<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;(struct sockaddr *)&amp;fsin1, sizeof(fsin1), =
-1,<br>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span> &nbsp;&nbsp;&nbsp;EINVAL, setup1, cleanup1, "ATMARK on =
UDP"}<br>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span> &nbsp;&nbsp;&nbsp;ENOTTY, setup1, cleanup1, "ATMARK on UDP"}<br> =
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>, =
{<br> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>PF_INET, SOCK_DGRAM, 0, SIOCGIFCONF, &amp;ifc,<br> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;(struct sockaddr *)&amp;fsin1, sizeof(fsin1), 0,<br>-- =
<br>1.6.3.3<font class=3D"Apple-style-span" color=3D"#000000"><font =
class=3D"Apple-style-span" =
color=3D"#144FAE"><br></font></font></div></blockquote><br></div><div><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>This will =
fix the later kernel, but break earlier ones. Could you please submit a =
patch that does a check for the kernel version, a data structure, etc =
and adjusts the expected values =
accordingly?</div><div>Thanks!</div><div>-Garrett</div></body></html>=

--Apple-Mail-1-474981298--


--===============1252706689886878192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Achieve unprecedented app performance and reliability
What every C/C++ and Fortran developer should know.
Learn how Intel has extended the reach of its next-generation tools
to help boost performance applications - inlcuding clusters.
http://p.sf.net/sfu/intel-dev2devmay
--===============1252706689886878192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1252706689886878192==--

