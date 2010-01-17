Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NWOPs-0005MT-QF
	for ltp-list@lists.sourceforge.net; Sun, 17 Jan 2010 06:15:16 +0000
Received: from mail-yx0-f202.google.com ([209.85.210.202])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NWOPr-0008Aw-Sz
	for ltp-list@lists.sourceforge.net; Sun, 17 Jan 2010 06:15:16 +0000
Received: by yxe40 with SMTP id 40so1601271yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 16 Jan 2010 22:15:10 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1077)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <201001151727.40629.vapier@gentoo.org>
Date: Sat, 16 Jan 2010 22:14:36 -0800
Message-Id: <6AF99736-0DB7-4F96-B50A-ABF98BAFD74C@gmail.com>
References: <364299f41001151349i4e7067fbu68994eaf719b46de@mail.gmail.com>
	<364299f41001151407s3e486c68rc8bd90db9898e20d@mail.gmail.com>
	<201001151727.40629.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Add make 3.80 $(abspath ) and $(realpath )
	emulation scripts
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7877246173679624002=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Jiri Palecek <jirka@debian.org>, Andi Kleen <andi@firstfloor.org>, =?utf-8?B?56We6LC35pyL56+E?= <mitani@ryobi.co.jp>


--===============7877246173679624002==
Content-Type: multipart/alternative; boundary=Apple-Mail-5--213648923


--Apple-Mail-5--213648923
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 15, 2010, at 2:27 PM, Mike Frysinger wrote:

> On Friday 15 January 2010 17:07:48 Garrett Cooper wrote:
>> Shortly after I sent out this email, I received some helpful replies
>> as to why my code wasn't working. It turns out that the curly bracket
>> regexp quantifier operators available in many other popular
>> implementations of regexps (perl, python, tcl) isn't supported in =
awk.
>> Here's the new patch with less bloat.
>=20
> the patch itself is word wrapped in the e-mail though :(

:\

>> +_abspath() {
>> +	echo "$@" | awk '{ sub(/\/$/, ""); while (gsub(/\/\//, "/")) { =
};
>> while (gsub(/\/[^\/]+\/\.\.\/?/, "/")) { }; while (gsub(/\/\.\//,
>> "/")) { } print }'
>> +}
>=20
> it's easy to line wrap awk scripts, and this sucker really needs it

Fixed.

> btw, this doesnt quite handle:
> /a/b/c/.././

Resolved in the latest version.

> how about this (largely untested) sed:
> sed -r -e 's:/+[.]/+:/:g' -e 's:(^|/+[^/]*)/+[.][.]/+:/:g' -e =
's:/+$::'

I'm not sure if it's just me, but I prefer awk to sed because the =
regular expressions and operations are a lot easier to follow than =
sed's.

>> --- /dev/null	1 Jan 1970 00:00:00 -0000
>> +++ tests/test_abspath.sh	15 Jan 2010 22:04:59 -0000
>> +# NOTE (garrcoop): I usually don't use bashisms, but it was just =
easier to
>> +# express these values as an array of values instead of one whacky =
long
>> +# string.
>> +test_strings=3D(     foo/bar /foo/bar /foo/../bar /foo/bar/../baz
>> /foo/bar/../baz/ /foo/../bar/ /foo/../bar/.. /foo/../bar/../
>> /foo/bar/../baz /foo/./bar /./foo/./bar /foo//bar //foo/bar
>> //////foo/bar /foo/////bar )
>> +expected_strings=3D( foo/bar /foo/bar /bar        /foo/baz
>> /foo/baz         /bar         /              /               /foo/baz
>>      /foo/bar   /foo/bar     /foo/bar  /foo/bar  /foo/bar
>> /foo/bar )
>=20
> probably be good if the source were better wrapped
>=20
> however, two parallel arrays makes it hard to correlate the =
input/expected=20
> values.  how about something like:
> set -- \
> 	foo/bar:foo/bar \
> 	/foo/bar:/foo/bar \
> 	/foo/../bar:/bar \
> 	...........
>=20
> then you can easily do:
> for test in "$@" ; do
> 	input=3D${test%:*}
> 	expect=3D${test#*:}
> 	...
> done

Sure -- I was looking for the possibility of testcases with spaces in =
them, but with the number of testcases, it may be a good idea to just =
move to another method of defining the testcase, like with python [// =
nose?].

Thanks!
-Garrett=

--Apple-Mail-5--213648923
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><div><div>On Jan 15, 2010, at 2:27 PM, Mike Frysinger wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div>On =
Friday 15 January 2010 17:07:48 Garrett Cooper wrote:<br><blockquote =
type=3D"cite">Shortly after I sent out this email, I received some =
helpful replies<br></blockquote><blockquote type=3D"cite">as to why my =
code wasn't working. It turns out that the curly =
bracket<br></blockquote><blockquote type=3D"cite">regexp quantifier =
operators available in many other popular<br></blockquote><blockquote =
type=3D"cite">implementations of regexps (perl, python, tcl) isn't =
supported in awk.<br></blockquote><blockquote type=3D"cite">Here's the =
new patch with less bloat.<br></blockquote><br>the patch itself is word =
wrapped in the e-mail though :(<font class=3D"Apple-style-span" =
color=3D"#000000"><font class=3D"Apple-style-span" =
color=3D"#144FAE"><br></font></font></div></blockquote><div><br></div>:\<b=
r><br><blockquote type=3D"cite"><div><blockquote type=3D"cite">+_abspath()=
 {<br></blockquote><blockquote type=3D"cite">+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>echo "$@" =
| awk '{ sub(/\/$/, ""); while (gsub(/\/\//, "/")) { =
};<br></blockquote><blockquote type=3D"cite">while =
(gsub(/\/[^\/]+\/\.\.\/?/, "/")) { }; while =
(gsub(/\/\.\//,<br></blockquote><blockquote type=3D"cite">"/")) { } =
print }'<br></blockquote><blockquote =
type=3D"cite">+}<br></blockquote><br>it's easy to line wrap awk scripts, =
and this sucker really needs =
it<br></div></blockquote><div><br></div>Fixed.<br><br><blockquote =
type=3D"cite"><div>btw, this doesnt quite =
handle:<br>/a/b/c/.././<br></div></blockquote><div><br></div><div>Resolved=
 in the latest version.</div><br><blockquote type=3D"cite"><div>how =
about this (largely untested) sed:<br>sed -r -e 's:/+[.]/+:/:g' -e =
's:(^|/+[^/]*)/+[.][.]/+:/:g' -e 's:/+$::'<font class=3D"Apple-style-span"=
 color=3D"#000000"><font class=3D"Apple-style-span" =
color=3D"#144FAE"><br></font></font></div></blockquote><div><br></div>I'm =
not sure if it's just me, but I prefer awk to sed because the regular =
expressions and operations are a lot easier to follow than =
sed's.<br><br><blockquote type=3D"cite"><div><blockquote type=3D"cite">---=
 /dev/null<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>1 Jan 1970 00:00:00 -0000<br></blockquote><blockquote =
type=3D"cite">+++ tests/test_abspath.sh<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>15 Jan 2010 22:04:59 =
-0000<br></blockquote><blockquote type=3D"cite">+# NOTE (garrcoop): I =
usually don't use bashisms, but it was just easier =
to<br></blockquote><blockquote type=3D"cite">+# express these values as =
an array of values instead of one whacky =
long<br></blockquote><blockquote type=3D"cite">+# =
string.<br></blockquote><blockquote type=3D"cite">+test_strings=3D( =
&nbsp;&nbsp;&nbsp;&nbsp;foo/bar /foo/bar /foo/../bar =
/foo/bar/../baz<br></blockquote><blockquote type=3D"cite">/foo/bar/../baz/=
 /foo/../bar/ /foo/../bar/.. /foo/../bar/../<br></blockquote><blockquote =
type=3D"cite">/foo/bar/../baz /foo/./bar /./foo/./bar /foo//bar =
//foo/bar<br></blockquote><blockquote type=3D"cite">//////foo/bar =
/foo/////bar )<br></blockquote><blockquote =
type=3D"cite">+expected_strings=3D( foo/bar /foo/bar /bar =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/foo/baz<br></blockquote><blockq=
uote type=3D"cite">/foo/baz =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/bar =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;/ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;/foo/baz<br></blockquote><blockquote type=3D"cite"> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/foo/bar &nbsp;&nbsp;/foo/bar =
&nbsp;&nbsp;&nbsp;&nbsp;/foo/bar &nbsp;/foo/bar =
&nbsp;/foo/bar<br></blockquote><blockquote type=3D"cite">/foo/bar =
)<br></blockquote><br>probably be good if the source were better =
wrapped<br><br>however, two parallel arrays makes it hard to correlate =
the input/expected <br>values. &nbsp;how about something like:<br>set -- =
\<br><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>foo/bar:foo/bar \<br><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>/foo/bar:/foo/bar \<br><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>/foo/../bar:/bar \<br><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>...........<br><br>then you can =
easily do:<br>for test in "$@" ; do<br><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>input=3D${test%:*}<br><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>expect=3D${test#*:}<br><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>...<br>done<br></div></blockquote><div><br></div>Sure -- I was =
looking for the possibility of testcases with spaces in them, but with =
the number of testcases, it may be a good idea to just move to another =
method of defining the testcase, like with python [// =
nose?].<br><br></div><div>Thanks!</div><div>-Garrett</div></body></html>=

--Apple-Mail-5--213648923--


--===============7877246173679624002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
--===============7877246173679624002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7877246173679624002==--

