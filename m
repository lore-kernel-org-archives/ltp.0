Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tosubrata@gmail.com>) id 1PZpOd-00038U-5C
	for ltp-list@lists.sourceforge.net; Mon, 03 Jan 2011 18:44:43 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PZpOb-0005DX-Gw
	for ltp-list@lists.sourceforge.net; Mon, 03 Jan 2011 18:44:43 +0000
Received: by iyj18 with SMTP id 18so12563048iyj.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 03 Jan 2011 10:44:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <DADDA9AB-BA92-477B-B370-6A785933357C@gmail.com>
References: <1294054372.10644.2.camel@subratamodak.linux.ibm.com>
	<DADDA9AB-BA92-477B-B370-6A785933357C@gmail.com>
Date: Tue, 4 Jan 2011 00:14:36 +0530
Message-ID: <AANLkTikxjB3nsKp+OXsaKduRzVdeXK32-HtUJzDr2BdO@mail.gmail.com>
From: Subrata Modak <tosubrata@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============3675766583851309389=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net List" <ltp-list@lists.sourceforge.net>

--===============3675766583851309389==
Content-Type: multipart/alternative; boundary=90e6ba6e82b22dc2360498f58be3

--90e6ba6e82b22dc2360498f58be3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 3, 2011 at 5:32 PM, Garrett Cooper <yanegomi@gmail.com> wrote:

>        There are 200 or so issues remaining with warnings in the sourceba=
se
> on i386 at least. I'm working through them as quickly as I can, but I run
> into roadblocks occasionally that slow me down... Any warnings that exist=
ed
> before will need to be resolved as well before we can continue.
>        I've detailed what can be done to help fix things in a previous
> email -- as long as people follow the lead for the changes I've made, it'=
ll
> be easy to resolve all of the outstanding issues.
>

Should be fine. Lets concentrate and give you enough time to fix them. I
will release LTP in January-end then when things will stabilize to more
extent.

Regards--
Subrata

Thanks,
> -Garrett
>
> On Jan 3, 2011, at 3:32 AM, Subrata Modak wrote:
>
> > Garret,
> >
> > I see them today:
> >
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -Werror
> > -I/root/LTP-GIT/ltp/testcases/kernel/include -I../../../../include
> > -I../../../../include   -L../../../../lib  alarm02.c   -lltp -o alarm02
> > cc1: warnings being treated as errors
> > alarm02.c: In function =E2=80=98main=E2=80=99:
> > alarm02.c:169: error: control reaches end of non-void function
> > make[4]: *** [alarm02] Error 1
> > make[4]: Leaving directory
> > `/root/LTP-GIT/ltp/testcases/kernel/syscalls/alarm'
> > make[3]: *** [all] Error 2
> > make[3]: Leaving directory `/root/LTP-GIT/ltp/testcases/kernel/syscalls=
'
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
>
>


--=20
Regards & Thanks--
Subrata

--90e6ba6e82b22dc2360498f58be3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Jan 3, 2011 at 5:32 PM, Garrett Cooper <=
span dir=3D"ltr">&lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-l=
eft: 1ex;">
 =C2=A0 =C2=A0 =C2=A0 =C2=A0There are 200 or so issues remaining with warni=
ngs in the sourcebase on i386 at least. I&#39;m working through them as qui=
ckly as I can, but I run into roadblocks occasionally that slow me down... =
Any warnings that existed before will need to be resolved as well before we=
 can continue.<br>

 =C2=A0 =C2=A0 =C2=A0 =C2=A0I&#39;ve detailed what can be done to help fix =
things in a previous email -- as long as people follow the lead for the cha=
nges I&#39;ve made, it&#39;ll be easy to resolve all of the outstanding iss=
ues.<br></blockquote>
<div><br>Should be fine. Lets concentrate and give you enough time to fix t=
hem. I will release LTP in January-end then when things will stabilize to m=
ore extent.<br><br>Regards--<br>Subrata<br><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(=
204, 204, 204); padding-left: 1ex;">

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
&gt; -I/root/LTP-GIT/ltp/testcases/kernel/include -I../../../../include<br>
&gt; -I../../../../include =C2=A0 -L../../../../lib =C2=A0alarm02.c =C2=A0 =
-lltp -o alarm02<br>
&gt; cc1: warnings being treated as errors<br>
&gt; alarm02.c: In function =E2=80=98main=E2=80=99:<br>
&gt; alarm02.c:169: error: control reaches end of non-void function<br>
&gt; make[4]: *** [alarm02] Error 1<br>
&gt; make[4]: Leaving directory<br>
&gt; `/root/LTP-GIT/ltp/testcases/kernel/syscalls/alarm&#39;<br>
&gt; make[3]: *** [all] Error 2<br>
&gt; make[3]: Leaving directory `/root/LTP-GIT/ltp/testcases/kernel/syscall=
s&#39;<br>
&gt; make[2]: *** [all] Error 2<br>
&gt; make[2]: Leaving directory `/root/LTP-GIT/ltp/testcases/kernel&#39;<br=
>
&gt; make[1]: *** [all] Error 2<br>
&gt; make[1]: Leaving directory `/root/LTP-GIT/ltp/testcases&#39;<br>
&gt; make: *** [testcases-all] Error 2<br>
&gt;<br>
&gt; Regards--<br>
&gt; Subrata<br>
&gt;<br>
&gt;<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards &am=
p; Thanks--<br>Subrata<br>

--90e6ba6e82b22dc2360498f58be3--


--===============3675766583851309389==
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
--===============3675766583851309389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3675766583851309389==--

