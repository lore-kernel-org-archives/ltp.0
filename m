Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFCAC43334
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 09:43:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B4B13C8852
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 11:43:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D3E83C215A
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 11:43:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4E793200D53
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 11:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655458977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=532P8LcEsAjBdcvBJJ7jSwgjce5dsw5snLgKObDIvxI=;
 b=PNEisbddjKLy4JXnNbDJ6rL2CCpOWXLbpMZU4kjzKGVrhHb95rXOmEbskhdz5KwYN5olhB
 Z2kaLwNFjWDO2y8JaMOwOQARiSG1MDjtyet4aNqgxb23xsHBNAO8PzBAwi3kdkQm5QjXOA
 49re91dmVJYPamxHz43es+NB7Ajcwlk=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-Gmn7KL1HP-qoKIpfmohzeg-1; Fri, 17 Jun 2022 05:42:56 -0400
X-MC-Unique: Gmn7KL1HP-qoKIpfmohzeg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-313e5c642dcso35003907b3.3
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 02:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=532P8LcEsAjBdcvBJJ7jSwgjce5dsw5snLgKObDIvxI=;
 b=eF4WmTwZx4R4lLktzivhzXiUaiv962fqzk77E7UGzL3MWwVHZl0j2sgO+38Qo1v1NK
 /IZqrVb8IEHbs3qfFIZGaROZmsko5MSjVdEmVkX3rKx41ojRAp9Pwo17v4uRb9SB/Bzy
 b4/iE7O8gxHTnloCRgGatOmZrz5K7mQjXj6v/2Tc+a/yvB0uMeEzEjPMt9HN7FImsOt3
 8b/saKT5nelBwPozvBPtQs5olgvgNcQwwINIAeRVqvJ/1RCyO9P/wl6iw3Z6kWj/BlTS
 vMKR0pGO6ZZd+ySl0CnIqLoqY09rKXfHiNm+qPyqSVy7obXBatVvQeP9MKNi/d0ZEVPz
 jytw==
X-Gm-Message-State: AJIora/GbiHhoQGkyqdFiAZXrVloadfBASSLh3PXMgQRJYMa4LCsgVBL
 59LtBCUoX9nZBpkoGhRcaYwD2yau7vttGNH9nnFEfG/ug6Ycz82yEzxGB+62B8PO1qJlQXhHgy0
 baYdg/LNNzNhp8HYHmB4m/bN6wwA=
X-Received: by 2002:a81:1e50:0:b0:30c:8246:b5a9 with SMTP id
 e77-20020a811e50000000b0030c8246b5a9mr10212571ywe.12.1655458975695; 
 Fri, 17 Jun 2022 02:42:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1toaCE11D1ZkiJSXTWmxk/9Dl1vPyKT+zw6jEGVq/My8qbEpTkXf9jwV7ATDE6+dELwZkTZqENaKWe0fczKPJk=
X-Received: by 2002:a81:1e50:0:b0:30c:8246:b5a9 with SMTP id
 e77-20020a811e50000000b0030c8246b5a9mr10212551ywe.12.1655458975459; Fri, 17
 Jun 2022 02:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220615090648.405100-1-liwang@redhat.com>
 <875yl1jbkq.fsf@suse.de>
In-Reply-To: <875yl1jbkq.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Jun 2022 17:42:44 +0800
Message-ID: <CAEemH2egR16PDbTASg9pJxBdY3w8B_=XEf+Du9hbLaqR0X3Wsw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] madvise06: shrink to 1 MADV_WILLNEED page to
 stabilize the test
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
Cc: Paul Bunyan <pbunyan@redhat.com>, Rafael Aquini <aquini@redhat.com>,
 LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============2027104222=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2027104222==
Content-Type: multipart/alternative; boundary="0000000000002c448705e1a194f0"

--0000000000002c448705e1a194f0
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

Richard Palethorpe <rpalethorpe@suse.de> wrote:


> > --- a/testcases/kernel/syscalls/madvise/madvise06.c
> > +++ b/testcases/kernel/syscalls/madvise/madvise06.c
> > @@ -164,7 +164,7 @@ static int get_page_fault_num(void)
> >
> >  static void test_advice_willneed(void)
> >  {
> > -     int loops = 50, res;
> > +     int loops = 100, res;
> >       char *target;
> >       long swapcached_start, swapcached;
> >       int page_fault_num_1, page_fault_num_2;
> > @@ -202,23 +202,32 @@ static void test_advice_willneed(void)
> >               "%s than %ld Kb were moved to the swap cache",
> >               res ? "more" : "less", PASS_THRESHOLD_KB);
> >
> > -
> > -     TEST(madvise(target, PASS_THRESHOLD, MADV_WILLNEED));
> > +     loops = 100;
> > +     SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld",
> &swapcached_start);
> > +     TEST(madvise(target, pg_sz, MADV_WILLNEED));
> >       if (TST_RET == -1)
> >               tst_brk(TBROK | TTERRNO, "madvise failed");
> > +     do {
> > +             loops--;
> > +             usleep(100000);
> > +             if (stat_refresh_sup)
> > +                     SAFE_FILE_PRINTF("/proc/sys/vm/stat_refresh", "1");
> > +             SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld",
> > +                             &swapcached);
> > +     } while (swapcached < swapcached_start + pg_sz/1024 && loops > 0);
> >
> >       page_fault_num_1 = get_page_fault_num();
> >       tst_res(TINFO, "PageFault(madvice / no mem access): %d",
> >                       page_fault_num_1);
> > -     dirty_pages(target, PASS_THRESHOLD);
> > +     dirty_pages(target, pg_sz);
>
> Adding the loop makes sense to me. However I don't understand why you
> have also switched from PASS_THRESHOLD to only a single page?
>

In the test, we use two checks combined to confirm the bug reproduces:

  1. swap cached increasing less than PASS_THRESHOLD_KB
  2. page_fault number large than expected

The 2. case is more easily get failed on kind of platforms and hard
to count an average value for tolerating. So maybe we just reduce
the page to one that would not affect the final result. Because we
rely on both checks happening simultaneously then assume a bug.



>
> I guess calling MADV_WILLNEED on a single page is the least realistic
> scenario.
>

Okay, perhaps it's a step backward:).

I was just thinking it is a regression test and if 1 page works to reproduce
that (but more chunks of memory easily cause false positive), why not.



>
> If there is an issue with PASS_THRESHOLD perhaps we could scale it based
> on page size?
>

This sounds acceptable too.

How many pages do you think are proper, 100 or more?
and, loosen the faulted-out numbers to 1/10 pages?


-- 
Regards,
Li Wang

--0000000000002c448705e1a194f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Richard,</div><div class=3D"gmail_default" style=3D"font-s=
ize:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small"=
>Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de" target=3D"_b=
lank">rpalethorpe@suse.de</a>&gt; wrote:</div></div><div class=3D"gmail_quo=
te"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; --- a/testcases/kernel/syscalls/madvise/madvise06.c<br>
&gt; +++ b/testcases/kernel/syscalls/madvise/madvise06.c<br>
&gt; @@ -164,7 +164,7 @@ static int get_page_fault_num(void)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void test_advice_willneed(void)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int loops =3D 50, res;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int loops =3D 100, res;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *target;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0long swapcached_start, swapcached;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int page_fault_num_1, page_fault_num_2;<br>
&gt; @@ -202,23 +202,32 @@ static void test_advice_willneed(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;%s than %l=
d Kb were moved to the swap cache&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res ? &quot;more=
&quot; : &quot;less&quot;, PASS_THRESHOLD_KB);<br>
&gt;=C2=A0 <br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0TEST(madvise(target, PASS_THRESHOLD, MADV_WILLNEE=
D));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0loops =3D 100;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0SAFE_FILE_LINES_SCANF(&quot;/proc/meminfo&quot;, =
&quot;SwapCached: %ld&quot;, &amp;swapcached_start);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0TEST(madvise(target, pg_sz, MADV_WILLNEED));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (TST_RET =3D=3D -1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK | =
TTERRNO, &quot;madvise failed&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0do {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loops--;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usleep(100000);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (stat_refresh_sup)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0SAFE_FILE_PRINTF(&quot;/proc/sys/vm/stat_refresh&quot;, &quot;1&quot=
;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_FILE_LINES_SCANF=
(&quot;/proc/meminfo&quot;, &quot;SwapCached: %ld&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;swapcached);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} while (swapcached &lt; swapcached_start + pg_sz=
/1024 &amp;&amp; loops &gt; 0);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0page_fault_num_1 =3D get_page_fault_num();<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;PageFault(madvice / no =
mem access): %d&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0page_fault_num_1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0dirty_pages(target, PASS_THRESHOLD);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dirty_pages(target, pg_sz);<br>
<br>
Adding the loop makes sense to me. However I don&#39;t understand why you<b=
r>
have also switched from PASS_THRESHOLD to only a single page?<br></blockquo=
te><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:smal=
l">In the test, we use two checks combined to confirm the bug reproduces:</=
div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div c=
lass=3D"gmail_default" style=3D"font-size:small">=C2=A0 1. swap cached incr=
easing less than PASS_THRESHOLD_KB</div><div class=3D"gmail_default" style=
=3D"font-size:small">=C2=A0 2. page_fault number large than expected</div><=
div class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">The 2.=C2=A0case is more easil=
y get failed on kind of platforms and hard</div><div class=3D"gmail_default=
" style=3D"font-size:small">to count an average=C2=A0value for tolerating. =
So maybe we just reduce</div><div class=3D"gmail_default" style=3D"font-siz=
e:small">the page to one that would not affect the final result. Because we=
</div><div class=3D"gmail_default" style=3D"font-size:small">rely on both c=
hecks happening simultaneously then assume a=C2=A0bug.</div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I guess calling MADV_WILLNEED on a single page is the least realistic<br>
scenario.<br></blockquote><div><br></div><div><div class=3D"gmail_default" =
style=3D"font-size:small">Okay, perhaps it&#39;s a step backward:).</div></=
div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div><=
div class=3D"gmail_default" style=3D"font-size:small">I was just thinking i=
t is a regression test and if 1 page works to reproduce</div><div class=3D"=
gmail_default" style=3D"font-size:small">that (but more chunks of memory ea=
sily cause false positive), why not.</div></div><div class=3D"gmail_default=
" style=3D"font-size:small"><br></div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
If there is an issue with <span class=3D"gmail_default" style=3D"font-size:=
small"></span>PASS_THRESHOLD perhaps we could scale it based<br>
on page size?<br></blockquote><div><br></div><div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">This sounds acceptable too.</div><br></div><d=
iv><div class=3D"gmail_default" style=3D"font-size:small">How many pages=C2=
=A0do you think are proper, 100 or more?</div><div class=3D"gmail_default" =
style=3D"font-size:small">and, loosen the faulted-out numbers to 1/10 pages=
?</div></div><div><br></div></div><div><br></div>-- <br><div dir=3D"ltr"><d=
iv dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></d=
iv>

--0000000000002c448705e1a194f0--


--===============2027104222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2027104222==--

