Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kdlucas@gmail.com>) id 1NI86B-0007fO-NJ
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 21:59:59 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NI866-0003Kf-P1
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 21:59:59 +0000
Received: by pxi27 with SMTP id 27so777688pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 08 Dec 2009 13:59:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1260241019.1107.17.camel@plars-t500>
References: <1260241019.1107.17.camel@plars-t500>
Date: Tue, 8 Dec 2009 13:59:48 -0800
Message-ID: <b9d696240912081359p57e3bfdck6b76d88cfe7e2852@mail.gmail.com>
From: "K.D. Lucas" <kdlucas@gmail.com>
Subject: Re: [LTP] make install... doesn't
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6204326135890372109=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Paul Larson <paul.larson@canonical.com>
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

--===============6204326135890372109==
Content-Type: multipart/alternative; boundary=000e0cd147f851aa3d047a3eb10d

--000e0cd147f851aa3d047a3eb10d
Content-Type: text/plain; charset=ISO-8859-1

I've noticed the same. It used to be that I could easily build and run LTP,
but now I build fine, but running has become an issue. I've typically ran
the LTP suite against every kernel that our [my company] various project
teams create; however, with the last few releases I've tended not to use it.


It used to be that when I built LTP, I could run it from the same directory,
but that is no longer true. With November's release I can't run it period.

kdl

On Mon, Dec 7, 2009 at 6:56 PM, Paul Larson <paul.larson@canonical.com>wrote:

> Was trying to build ltp today, which sadly, seems to be a bit more
> complicated than it once was.  The make install completed without
> errors, but noticed at the end that I didn't even have a testcases/bin
> directory!  As I watched the make install output I noticed that
> everything in testcases was getting built with the 'all' target, but
> never install.
>
> My make-foo is quite rusty, but I'm guessing that this change from
> changeset b2e46ed73e9601ecad1044d37a85c97ba0ca42ce (if you are following
> git, It was from around Nov 30 if not) seems to be a likely culprit:
> -.SECONDEXPANSION:
> -$(INSTALL_TARGETS) include-install lib-install: %-install:
> $(abs_top_builddir)/$$*
> -       $(MAKE) -C $* -f "$(abs_top_srcdir)/$*/Makefile" install
> +$(INSTALL_TARGETS) include-install lib-install:
> +       $(MAKE) -C "$(subst -install,,$@)" \
> +               -f "$(abs_top_srcdir)/$(subst -install,,$@)/Makefile"
> all
>
> Thanks,
> Paul Larson
>
>
>
> ------------------------------------------------------------------------------
> Return on Information:
> Google Enterprise Search pays you back
> Get the facts.
> http://p.sf.net/sfu/google-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>



-- 
K.D. Lucas
kdlucas@gmail.com

--000e0cd147f851aa3d047a3eb10d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I&#39;ve noticed the same. It used to be that I could easily build and run =
LTP, but now I build fine, but running has become an issue. I&#39;ve typica=
lly ran the LTP suite against every kernel that our [my company] various pr=
oject teams create; however, with the last few releases I&#39;ve tended not=
 to use it. <br>
<br>It used to be that when I built LTP, I could run it from the same direc=
tory, but that is no longer true. With November&#39;s release I can&#39;t r=
un it period.<br><br>kdl<br><br><div class=3D"gmail_quote">On Mon, Dec 7, 2=
009 at 6:56 PM, Paul Larson <span dir=3D"ltr">&lt;<a href=3D"mailto:paul.la=
rson@canonical.com">paul.larson@canonical.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Was trying to bui=
ld ltp today, which sadly, seems to be a bit more<br>
complicated than it once was. =A0The make install completed without<br>
errors, but noticed at the end that I didn&#39;t even have a testcases/bin<=
br>
directory! =A0As I watched the make install output I noticed that<br>
everything in testcases was getting built with the &#39;all&#39; target, bu=
t<br>
never install.<br>
<br>
My make-foo is quite rusty, but I&#39;m guessing that this change from<br>
changeset b2e46ed73e9601ecad1044d37a85c97ba0ca42ce (if you are following<br=
>
git, It was from around Nov 30 if not) seems to be a likely culprit:<br>
-.SECONDEXPANSION:<br>
-$(INSTALL_TARGETS) include-install lib-install: %-install:<br>
$(abs_top_builddir)/$$*<br>
- =A0 =A0 =A0 $(MAKE) -C $* -f &quot;$(abs_top_srcdir)/$*/Makefile&quot; in=
stall<br>
+$(INSTALL_TARGETS) include-install lib-install:<br>
+ =A0 =A0 =A0 $(MAKE) -C &quot;$(subst -install,,$@)&quot; \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 -f &quot;$(abs_top_srcdir)/$(subst -install,,=
$@)/Makefile&quot;<br>
all<br>
<br>
Thanks,<br>
Paul Larson<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
Return on Information:<br>
Google Enterprise Search pays you back<br>
Get the facts.<br>
<a href=3D"http://p.sf.net/sfu/google-dev2dev" target=3D"_blank">http://p.s=
f.net/sfu/google-dev2dev</a><br>
_______________________________________________<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>K.D. Lucas<br><a href=
=3D"mailto:kdlucas@gmail.com">kdlucas@gmail.com</a><br>

--000e0cd147f851aa3d047a3eb10d--


--===============6204326135890372109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev

--===============6204326135890372109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6204326135890372109==--

