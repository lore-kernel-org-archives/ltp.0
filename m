Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF0FC433EF
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 20:16:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C5653CAA18
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 22:16:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DBDC3CA584
 for <ltp@lists.linux.it>; Fri, 13 May 2022 22:16:29 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 81A601A01220
 for <ltp@lists.linux.it>; Fri, 13 May 2022 22:16:28 +0200 (CEST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 484D23F1BE
 for <ltp@lists.linux.it>; Fri, 13 May 2022 20:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1652472985;
 bh=q5XUu1SpeEWhRSrpNi03LKTQauwSGRZDY4I73aGQhdc=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=K0OcSTJdOsQy4D/lez6r5o2N2TysHTMipYLMAL7pM7CTd71BXOzpUb95rvoIZQKr1
 RndwaGhRqnoMjPeLXzDKyvPp55xOIVlXjNiiCCIuTESoXzM7BHi5UgGxCtPjAMKtwl
 1iDfOHsjJtZc3ubtw+r3cJoLCEMbAyfwlVMJm2cSBvfI8dej3XShQo3LmpBnmnDS7E
 P0pis6jHV9u9bO8TpgYh3oJLG+yUsZbWXurHLfba5UG8pOdsa5e+mCQcFTLxMRRmjl
 bOtD1vFwbGBOHGPiF2ELQpjGf/BIdg8ShBMyCs8aQGIL9IKlizzwLjaZUTMzllxODc
 Qa8Tw6QFb9Jsg==
Received: by mail-ed1-f72.google.com with SMTP id
 k12-20020aa7d2cc000000b0042a2d586c56so4302572edr.17
 for <ltp@lists.linux.it>; Fri, 13 May 2022 13:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q5XUu1SpeEWhRSrpNi03LKTQauwSGRZDY4I73aGQhdc=;
 b=t7Gwj9g70d99BjoAAK7W3UURbXjs0m+Refxgd/++FB+R4Ux+M6azCYGhKWxxqcFpDq
 fFwgp8rcUdz0JQ/Sn8yWFhcpM56ZOi5WYu6JkWx1W9PfQ+NdU8ZW20+brWcUC06CSArD
 onLSe9c12Ruxn9HGluTcmi9w55j/1SM0U+MgwMtwuVagAarJUI76W96nfvar8NbvQdsQ
 ia3vNJelZkcTZAvZc3lZSEPfWk6R5EoeXu13lemT9kIxiumSL9S2AOixdR5hDpnb4MeR
 nFpu+quSW6eoIhq0+OyVJC7iY859k5J0aexOyEb5q3vJ75l7fQzIJg3coW95ovm5vmtd
 7WdQ==
X-Gm-Message-State: AOAM533RVwS4I9/77RedmUNEMzR5rYr+WuJ3fLsYzC+QgvUjeW1isMbz
 aGkbSl6ZjlNG1Qdio/rgksD2FulI9BBEiTSSHcgTU5sH/+apaao97QRsdEa/7Bcp0Ph6VOclncm
 rse5eAyUtvmba8NPkl+aZJWZbrhVXokZxe/hUap09nGIF
X-Received: by 2002:a05:6402:11cd:b0:427:bda5:542f with SMTP id
 j13-20020a05640211cd00b00427bda5542fmr414877edw.290.1652472985014; 
 Fri, 13 May 2022 13:16:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4wRzZeOH7OL9f3lirl5jjy3VrFOPKhdCOSt6GQl5wQzg4XEQotGY79zgUQdCJnMx3WBTzlhra9SVhzJUJQ6U=
X-Received: by 2002:a05:6402:11cd:b0:427:bda5:542f with SMTP id
 j13-20020a05640211cd00b00427bda5542fmr414863edw.290.1652472984800; Fri, 13
 May 2022 13:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
 <3d85635f6b87c73a2389627bc94c847c52165dc7.1651176646.git.luke.nowakowskikrijger@canonical.com>
 <YnOH4h8rTbg1NzCO@pevik> <YnPW0gfMAUGZYPSM@yuki> <YnpKSTal7IG3jtAx@pevik>
In-Reply-To: <YnpKSTal7IG3jtAx@pevik>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Fri, 13 May 2022 13:15:48 -0700
Message-ID: <CADS1e3ehEbnh+wwS-sfS0zWSw4t6Znz_wVmETox2QDCgKaL-Fg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 11/19] controllers: Expand cgroup_lib shell
 library
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0179502154=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0179502154==
Content-Type: multipart/alternative; boundary="00000000000042a54105deea594c"

--00000000000042a54105deea594c
Content-Type: text/plain; charset="UTF-8"

Hi Petr and Cyril,

On Tue, May 10, 2022 at 4:19 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Luke, Cyril,
>
> > Hi!
> > > > +_cgroup_check_return()
> > > > +{
> > > > + local ret="$1"
> > > > + local msg="$2"
> > > > +
> > > > + tst_flag2mask TBROK
> > > > + [ "$ret" = "$?" ] && tst_brk TBROK "$msg"
> > > > +
> > > > + tst_flag2mask TCONF
> > > > + [ "$ret" = "$?" ] && tst_brk TCONF "$msg"
> > > > +}
> > > As I wrote in previous patch likely we can avoid tst_flag2mask in new
> API.
>
> > > In few cases where needed we hardwired numbers (IMHO POSIX shell does
> not
> > > support constants, which would be better than variables which can be
> changed).
>
> > > In this case you could probably use ROD() or EXPECT_PASS_BRK().
>
> > Or we can just passthrough the result, as long as it's non-zero we can
> > do exit $ret and be done with it.
> +1 (that would suggest to use ROD)
>
> Please, rebase the code for new version. You'll have to for cgroup_lib.sh
> put
> '. tst_test.sh' to the end and also '. cgroup_lib.sh' in the tests also at
> the
> end - required by 04021637f ("tst_test.sh: Cleanup getopts usage").
>
>
Thank you for the reviews! I agree with the changes mentioned and will
submit an update to these patches.

Kind regards,
> Petr
>

Thanks,
- Luke

--00000000000042a54105deea594c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Petr and Cyril, <br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 10, 2022 at 4:19 A=
M Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Luke, C=
yril,<br>
<br>
&gt; Hi!<br>
&gt; &gt; &gt; +_cgroup_check_return()<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; + local ret=3D&quot;$1&quot;<br>
&gt; &gt; &gt; + local msg=3D&quot;$2&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; + tst_flag2mask TBROK<br>
&gt; &gt; &gt; + [ &quot;$ret&quot; =3D &quot;$?&quot; ] &amp;&amp; tst_brk=
 TBROK &quot;$msg&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; + tst_flag2mask TCONF<br>
&gt; &gt; &gt; + [ &quot;$ret&quot; =3D &quot;$?&quot; ] &amp;&amp; tst_brk=
 TCONF &quot;$msg&quot;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; As I wrote in previous patch likely we can avoid tst_flag2mask in=
 new API.<br>
<br>
&gt; &gt; In few cases where needed we hardwired numbers (IMHO POSIX shell =
does not<br>
&gt; &gt; support constants, which would be better than variables which can=
 be changed).<br>
<br>
&gt; &gt; In this case you could probably use ROD() or EXPECT_PASS_BRK().<b=
r>
<br>
&gt; Or we can just passthrough the result, as long as it&#39;s non-zero we=
 can<br>
&gt; do exit $ret and be done with it.<br>
+1 (that would suggest to use ROD)<br>
<br>
Please, rebase the code for new version. You&#39;ll have to for cgroup_lib.=
sh put<br>
&#39;. tst_test.sh&#39; to the end and also &#39;. cgroup_lib.sh&#39; in th=
e tests also at the<br>
end - required by 04021637f (&quot;tst_test.sh: Cleanup getopts usage&quot;=
).<br>
<br></blockquote><div><br></div><div>Thank you for the reviews! I agree wit=
h the changes mentioned and will submit an update to these patches. <br></d=
iv><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Kind regards,<br>
Petr<br></blockquote><div><br></div><div>Thanks, <br></div><div>- Luke <br>=
</div></div></div>

--00000000000042a54105deea594c--

--===============0179502154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0179502154==--
