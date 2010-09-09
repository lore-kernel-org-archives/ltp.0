Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Otb0L-0003AV-C8
	for ltp-list@lists.sourceforge.net; Thu, 09 Sep 2010 06:53:05 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Otb0K-0006YO-IL
	for ltp-list@lists.sourceforge.net; Thu, 09 Sep 2010 06:53:05 +0000
Received: by pvg6 with SMTP id 6so425299pvg.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Sep 2010 23:52:59 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1081)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4C887D32.60608@windriver.com>
Date: Wed, 8 Sep 2010 23:52:53 -0700
Message-Id: <6AA0EB8D-1C22-4BFD-BC94-BB687B5C08CD@gmail.com>
References: <4C887D32.60608@windriver.com>
Subject: Re: [LTP] [PATCH]mktemp command in runltp version issue
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1826234934089025009=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "lina.zhao" <lina.zhao@windriver.com>
Cc: ltp-list@lists.sourceforge.net


--===============1826234934089025009==
Content-Type: multipart/alternative; boundary=Apple-Mail-9-765295582


--Apple-Mail-9-765295582
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 8, 2010, at 11:22 PM, lina.zhao wrote:

> Hi,
>=20
> In runltp:
>=20
> if [ -n "$DEVICE" ]; then
>      mnt_pnt=3D`mktemp -d --tmpdir=3D${TMP} mnt_pnt.XXXXXX`
>=20
> --tmpdir is a invalid option for mktemp version 1.5, which is used
> widely. The valid option to specify a directory for version 1.5 is
> -p directory.

Or just remove --tmpdir=3D<blah> altogether? If $TMPDIR is defined in =
the environment, then it is the fallback if --tmpdir / -p isn't =
specified (please see the manpage for more details)... OR... just do:

mnt_pnt=3D`mktemp -d $TMP/mnt_pnt.XXXXXX`

The same change will probably need to be applied to the runltp lite =
script.

Cheers,
-Garrett


--Apple-Mail-9-765295582
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><div><div>On Sep 8, 2010, at 11:22 PM, lina.zhao wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite">Hi,<br><br>In runltp:<br><br>if [ -n "$DEVICE" ]; then<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mnt_pnt=3D`mktemp -d --tmpdir=3D${TMP} =
mnt_pnt.XXXXXX`<br><br>--tmpdir is a invalid option for mktemp version =
1.5, which is used<br>widely. The valid option to specify a directory =
for version 1.5 is<br>-p directory.<font class=3D"Apple-style-span" =
color=3D"#000000"><font class=3D"Apple-style-span" =
color=3D"#144FAE"><br></font></font></blockquote><br></div><div>Or just =
remove --tmpdir=3D&lt;blah&gt; altogether? If $TMPDIR is defined in the =
environment, then it is the fallback if --tmpdir / -p isn't specified =
(please see the manpage for more details)... OR... just =
do:</div><div><br></div><div>mnt_pnt=3D`mktemp -d =
$TMP/mnt_pnt.XXXXXX`</div><div><br></div><div>The same change will =
probably need to be applied to the runltp lite =
script.</div><div><br></div><div>Cheers,</div><div>-Garrett</div><br></bod=
y></html>=

--Apple-Mail-9-765295582--


--===============1826234934089025009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
--===============1826234934089025009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1826234934089025009==--

