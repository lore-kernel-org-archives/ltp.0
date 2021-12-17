Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5D9C433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 02:03:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF0E73C8FD8
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 03:03:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36A023C2FA4
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 03:03:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 464ED602499
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 03:03:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639706593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y4/SG3cyMVPVbnbz0tlmG9cdjAh4QewJJSfqYGQSD94=;
 b=AM1O8Ss2kZq/bwbxdkNJEAs9dqB+DzLFk6lcZD1NwIWk1QQlmMlOhSAjAX8LTmemXRMwpo
 l7FLugwAHmkdyg2AUe1psdWBiiAP2CWsRBfonUY8tpjF4o36JYWu2zKk5D4L8YeTTTjgqf
 jsJhwQPpePgqJcLatSlG1wdFef3+5wM=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-WDtMZr4nNrmBARptW0K7xg-1; Thu, 16 Dec 2021 21:03:12 -0500
X-MC-Unique: WDtMZr4nNrmBARptW0K7xg-1
Received: by mail-yb1-f198.google.com with SMTP id
 y125-20020a25dc83000000b005c2326bf744so1790761ybe.21
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 18:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y4/SG3cyMVPVbnbz0tlmG9cdjAh4QewJJSfqYGQSD94=;
 b=ypnwyqkExcdevt6YtVnL5mSmEII/XrDUtOmMAnTIiEGO8CVutFDWIRLu96RA+VhchO
 Ik86jAXZvp0tCCP590rjrZVd6dK/1ZwDn57gvzbWwvc3Upg536X8SUgYSVMyeVCra+6B
 wzrvS5j/tR0wFHOGhzo5WKqNVAfjLkuYbDcxvokdp9IGsMYXQlXF35KRaJR77tTkADfa
 ekPYJ7SYHxxFqOtwTu2yWID+1rmC65sNEY8JrXrFFqUP4j1RRSII5DQ0kXKTODKllG0z
 afsJ69Ha3R/tBvtHWoBBbP6tnm6sUcSGpNKkrJc76TJJPvuD3z95+J1EwG2YWh0wqKpA
 13tA==
X-Gm-Message-State: AOAM5323xCcQa0VK9jA/OGpTtGguWAHWBugHht+727SdgutsMz/d1KnA
 tMJk8Re6hFQBEUqzwWQvG6hlIsuiKMmSedQq2kQuAlG7+BuMmsCUWqjVkWheaeQh42D9GNw4ujk
 R0N0/o/VBmAXfCTj5iDMOJQYhwpE=
X-Received: by 2002:a05:6902:4f4:: with SMTP id
 w20mr1301493ybs.421.1639706591016; 
 Thu, 16 Dec 2021 18:03:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+hrRP7aDPGAxUKbKgGE7VRMSPYqE0BEmVFC7md2LcR4jvk0cx5ga6ptiAGR2btMIU3AF0PhHUsLgl4KX8ZnQ=
X-Received: by 2002:a05:6902:4f4:: with SMTP id
 w20mr1301473ybs.421.1639706590774; 
 Thu, 16 Dec 2021 18:03:10 -0800 (PST)
MIME-Version: 1.0
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
 <20211216034125.255907-1-liwang@redhat.com> <YbrvolVYj7io6rOm@pevik>
In-Reply-To: <YbrvolVYj7io6rOm@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Dec 2021 10:02:56 +0800
Message-ID: <CAEemH2fpXYOADGY9PvcrfnXoGWrEjy+Lv6W2LxJGX--jN+u7LA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lib: add functions to adjust oom score
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
Content-Type: multipart/mixed; boundary="===============1739771231=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1739771231==
Content-Type: multipart/alternative; boundary="000000000000e1249e05d34df077"

--000000000000e1249e05d34df077
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Thu, Dec 16, 2021 at 3:50 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > This introduces function to LTP for adjusting the oom_score_adj of
> > target process, which may be helpful in OOM tests to prevent kernel
> > killing the main or lib process during test running.
> very good idea.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> > The exported global tst_enable_oom_protection function can be used
> > at anywhere you want to protect, but please remember that if you
> > do enable protection on a process($PID) that all the children will
> > inherit its score and be ignored by OOM Killer as well. So that's
> > why tst_cancel_oom_protection is recommended to combination in use.
>
> BTW deliberately not documenting it as it should not be commonly
>

Yes, actually it's not a commendatory API to users, and I think
we do really avoid using it unless we have no better choice.
(at least for OOM tests I can tell this)
The main reason we use it is current kernel OOM is not very
perfect, we just use it to help get the completed log for LTP.



> used in tests? Also although oom_score_adj inheritance should be known to
> person who will want to add it somewhere, I'd move it from commit message
> to
> source code (into header docs or or C API doc).
>

Sounds reasonable, will add this in V2.


>
> > +static void set_oom_score_adj(pid_t pid, int value)
> > +{
> > +     int val;
> > +     char score_path[64];
> > +
> > +     if (access("/proc/self/oom_score_adj", F_OK) == -1) {
> > +             tst_res(TINFO, "Warning: oom_score_adj is not exist");
> nit: IMHO "does not exist" or just "not exist"
>

Agree.

-- 
Regards,
Li Wang

--000000000000e1249e05d34df077
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Dec 16, 2021 at 3:50 PM Petr Vorel &l=
t;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
&gt; This introduces function to LTP for adjusting the oom_score_adj of<br>
&gt; target process, which may be helpful in OOM tests to prevent kernel<br=
>
&gt; killing the main or lib process during test running.<br>
very good idea.<br>
<br>
Reviewed-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_bl=
ank">pvorel@suse.cz</a>&gt;<br>
<br>
&gt; The exported global tst_enable_oom_protection function can be used<br>
&gt; at anywhere you want to protect, but please remember that if you<br>
&gt; do enable protection on a process($PID) that all the children will<br>
&gt; inherit its score and be ignored by OOM Killer as well. So that&#39;s<=
br>
&gt; why tst_cancel_oom_protection is recommended to combination in use.<br=
>
<br>
BTW deliberately not documenting it as it should not be commonly<br></block=
quote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:s=
mall">Yes, actually it&#39;s not a commendatory=C2=A0API to users, and I th=
ink</div><div class=3D"gmail_default" style=3D"font-size:small">we do reall=
y avoid using it unless we have no better choice.</div><div class=3D"gmail_=
default" style=3D"font-size:small">(at least for OOM tests I can tell this)=
</div><div class=3D"gmail_default" style=3D"font-size:small">The main reaso=
n we use it is current kernel OOM is not very</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">perfect, we just use it to help get the comp=
leted log for LTP.</div><br></div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
used in tests? Also although oom_score_adj inheritance should be known to<b=
r>
person who will want to add it somewhere, I&#39;d move it from commit messa=
ge to<br>
source code (into header docs or or C API doc).<br></blockquote><div><br></=
div><div><div class=3D"gmail_default" style=3D"font-size:small">Sounds reas=
onable, will add this in V2.</div></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; +static void set_oom_score_adj(pid_t pid, int value)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char score_path[64];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (access(&quot;/proc/self/oom_score_adj&quot;, =
F_OK) =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;=
Warning: oom_score_adj is not exist&quot;);<br>
nit: IMHO &quot;does not exist&quot; or just &quot;not exist&quot;<br></blo=
ckquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size=
:small">Agree.</div></div></div><div><br></div>-- <br><div dir=3D"ltr" clas=
s=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<=
br></div></div></div></div>

--000000000000e1249e05d34df077--


--===============1739771231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1739771231==--

