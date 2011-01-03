Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PZpe4-0003u1-IR
	for ltp-list@lists.sourceforge.net; Mon, 03 Jan 2011 19:00:40 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PZpe2-0002eO-8J
	for ltp-list@lists.sourceforge.net; Mon, 03 Jan 2011 19:00:40 +0000
Received: by pwi8 with SMTP id 8so1845941pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 03 Jan 2011 11:00:32 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <AANLkTikxjB3nsKp+OXsaKduRzVdeXK32-HtUJzDr2BdO@mail.gmail.com>
Date: Mon, 3 Jan 2011 11:00:27 -0800
Message-Id: <66666685-C474-4FE4-A194-D05BED2F9323@gmail.com>
References: <1294054372.10644.2.camel@subratamodak.linux.ibm.com>
	<DADDA9AB-BA92-477B-B370-6A785933357C@gmail.com>
	<AANLkTikxjB3nsKp+OXsaKduRzVdeXK32-HtUJzDr2BdO@mail.gmail.com>
Subject: Re: [LTP] Build failures as of today
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0397873496512224161=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Subrata Modak <tosubrata@gmail.com>
Cc: "ltp-list@lists.sourceforge.net List" <ltp-list@lists.sourceforge.net>


--===============0397873496512224161==
Content-Type: multipart/alternative; boundary=Apple-Mail-4-93931473


--Apple-Mail-4-93931473
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

	Thanks :)... almost a month of soak time should produce a sane =
release. FWIW, I'm solving other issues that I find along the way too. =
I've found about 10-20 bugs that existed prior to my tipping the apple =
cart back when I did the Makefile stuff too.
	There are other things with file descriptor flushing that need =
to be worked out though because I'm seeing issues with forked processes =
and printing to stdout/stderr (it wasn't printing out debug messages =
after I called FORK_OR_VFORK in chmod04), so I might need to come up =
with a more complete solution to FORK_OR_VFORK that properly handles =
file descriptor duping, error trapping, etc. I was also seeing weird =
issues last night with some tests (chmod04 again) where it wasn't =
properly unregistering the signal handler on my copy of Fedora 13, and =
it kept on calling the tst_sig handler in the spawned child process =
which wasn't desired. So there's a Linux bug or (more likely) an LTP bug =
with tst_sig that needs to be fixed somewhere. I need to instrument =
signal / sigaction code up that I know works on BSD and a stable linux =
release to tie down the issue to Fedora 13 or LTP.
	I also need to run the container tests because I did a =
relatively blind commit (it built and didn't blow up when I invoked it =
was all I really did last night). If someone else would do that for me =
that would free up some of my time -- that stuff will compile without =
failures so you can do a make all / install of that section of the tree =
and things will work. If not, please let me know.
Thanks,
-Garrett

On Jan 3, 2011, at 10:44 AM, Subrata Modak wrote:

> On Mon, Jan 3, 2011 at 5:32 PM, Garrett Cooper <yanegomi@gmail.com> =
wrote:
>        There are 200 or so issues remaining with warnings in the =
sourcebase on i386 at least. I'm working through them as quickly as I =
can, but I run into roadblocks occasionally that slow me down... Any =
warnings that existed before will need to be resolved as well before we =
can continue.
>        I've detailed what can be done to help fix things in a previous =
email -- as long as people follow the lead for the changes I've made, =
it'll be easy to resolve all of the outstanding issues.
>=20
> Should be fine. Lets concentrate and give you enough time to fix them. =
I will release LTP in January-end then when things will stabilize to =
more extent.
>=20
> Regards--
> Subrata
>=20
> Thanks,
> -Garrett
>=20
> On Jan 3, 2011, at 3:32 AM, Subrata Modak wrote:
>=20
> > Garret,
> >
> > I see them today:
> >
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -Werror
> > -I/root/LTP-GIT/ltp/testcases/kernel/include -I../../../../include
> > -I../../../../include   -L../../../../lib  alarm02.c   -lltp -o =
alarm02
> > cc1: warnings being treated as errors
> > alarm02.c: In function =91main=92:
> > alarm02.c:169: error: control reaches end of non-void function
> > make[4]: *** [alarm02] Error 1
> > make[4]: Leaving directory
> > `/root/LTP-GIT/ltp/testcases/kernel/syscalls/alarm'
> > make[3]: *** [all] Error 2
> > make[3]: Leaving directory =
`/root/LTP-GIT/ltp/testcases/kernel/syscalls'
> > make[2]: *** [all] Error 2
> > make[2]: Leaving directory `/root/LTP-GIT/ltp/testcases/kernel'
> > make[1]: *** [all] Error 2
> > make[1]: Leaving directory `/root/LTP-GIT/ltp/testcases'
> > make: *** [testcases-all] Error 2
> >
> > Regards--
> > Subrata
> >
> >
>=20
>=20
>=20
>=20
> --=20
> Regards & Thanks--
> Subrata


--Apple-Mail-4-93931473
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; "><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>Thanks =
:)... almost a month of soak time should produce a sane release. FWIW, =
I'm solving other issues that I find along the way too. I've found about =
10-20 bugs that existed prior to my tipping the apple cart back when I =
did the Makefile stuff too.<div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>There are other things with file =
descriptor flushing that need to be worked out though because I'm seeing =
issues with forked processes and printing to stdout/stderr (it wasn't =
printing out debug messages after I called FORK_OR_VFORK in chmod04), so =
I might need to come up with a more complete solution to FORK_OR_VFORK =
that properly handles file descriptor duping, error trapping, etc. I was =
also seeing weird issues last night with some tests (chmod04 again) =
where it wasn't properly unregistering the signal handler on my copy of =
Fedora 13, and it kept on calling the tst_sig handler in the spawned =
child process which wasn't desired. So there's a Linux bug or (more =
likely) an LTP bug with tst_sig that needs to be fixed somewhere. I need =
to instrument signal / sigaction code up that I know works on BSD and a =
stable linux release to tie down the issue to Fedora 13 or =
LTP.</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>I also need to run the container tests because I did a relatively =
blind commit (it built and didn't blow up when I invoked it was all I =
really did last night). If someone else would do that for me that would =
free up some of my time -- that stuff will compile without failures so =
you can do a make all / install of that section of the tree and things =
will work. If not, please let me =
know.<br><div>Thanks,</div><div>-Garrett</div><div><br><div><div>On Jan =
3, 2011, at 10:44 AM, Subrata Modak wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div =
class=3D"gmail_quote">On Mon, Jan 3, 2011 at 5:32 PM, Garrett Cooper =
<span dir=3D"ltr">&lt;<a =
href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.com</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt =
0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
 &nbsp; &nbsp; &nbsp; &nbsp;There are 200 or so issues remaining with =
warnings in the sourcebase on i386 at least. I'm working through them as =
quickly as I can, but I run into roadblocks occasionally that slow me =
down... Any warnings that existed before will need to be resolved as =
well before we can continue.<br>

 &nbsp; &nbsp; &nbsp; &nbsp;I've detailed what can be done to help fix =
things in a previous email -- as long as people follow the lead for the =
changes I've made, it'll be easy to resolve all of the outstanding =
issues.<br></blockquote>
<div><br>Should be fine. Lets concentrate and give you enough time to =
fix them. I will release LTP in January-end then when things will =
stabilize to more =
extent.<br><br>Regards--<br>Subrata<br><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: =
1px solid rgb(204, 204, 204); padding-left: 1ex;">

Thanks,<br>
<font color=3D"#888888">-Garrett<br>
</font><div><div></div><div class=3D"h5"><br>
On Jan 3, 2011, at 3:32 AM, Subrata Modak wrote:<br>
<br>
&gt; Garret,<br>
&gt;<br>
&gt; I see them today:<br>
&gt;<br>
&gt; gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -Werror<br>
&gt; -I/root/LTP-GIT/ltp/testcases/kernel/include =
-I../../../../include<br>
&gt; -I../../../../include &nbsp; -L../../../../lib &nbsp;alarm02.c =
&nbsp; -lltp -o alarm02<br>
&gt; cc1: warnings being treated as errors<br>
&gt; alarm02.c: In function =91main=92:<br>
&gt; alarm02.c:169: error: control reaches end of non-void function<br>
&gt; make[4]: *** [alarm02] Error 1<br>
&gt; make[4]: Leaving directory<br>
&gt; `/root/LTP-GIT/ltp/testcases/kernel/syscalls/alarm'<br>
&gt; make[3]: *** [all] Error 2<br>
&gt; make[3]: Leaving directory =
`/root/LTP-GIT/ltp/testcases/kernel/syscalls'<br>
&gt; make[2]: *** [all] Error 2<br>
&gt; make[2]: Leaving directory `/root/LTP-GIT/ltp/testcases/kernel'<br>
&gt; make[1]: *** [all] Error 2<br>
&gt; make[1]: Leaving directory `/root/LTP-GIT/ltp/testcases'<br>
&gt; make: *** [testcases-all] Error 2<br>
&gt;<br>
&gt; Regards--<br>
&gt; Subrata<br>
&gt;<br>
&gt;<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards =
&amp; Thanks--<br>Subrata<br>
</blockquote></div><br></div></div></body></html>=

--Apple-Mail-4-93931473--


--===============0397873496512224161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============0397873496512224161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0397873496512224161==--

