Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A5EC43334
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 08:58:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1238B3C9788
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 10:58:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6AD03C9175
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 10:58:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C40611430DC3
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 10:58:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658221097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yo+U+SN7RsOx+biIwd/fqI9p1ca/4iatIJvkGCf2vWk=;
 b=EnUbDxh1/ScpGQOJREA0OUSFM03QFz0nCjlA8jqrf/zh36ZOH+/B/28kZJj0IUYpxtn/dH
 rs8OcuGbuK8Z8Y3KQdDoapLeoFqZ9OKszu7ciJMeiPIpkDe12AVq5XmvrI0G0OCReljHvO
 G/AYBd+a2h5CZ+3D3i1MeV2aOsTM/xw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-0q2ktWnWMDuqiGRugaaDDw-1; Tue, 19 Jul 2022 04:58:15 -0400
X-MC-Unique: 0q2ktWnWMDuqiGRugaaDDw-1
Received: by mail-yb1-f199.google.com with SMTP id
 r64-20020a254443000000b006707b7c2baeso1924300yba.16
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 01:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yo+U+SN7RsOx+biIwd/fqI9p1ca/4iatIJvkGCf2vWk=;
 b=MqIJuLkTtq1VHg0xbUoZ5UVV2m4Z/0NhUOxAmTajxSLyCJbDapuL+8ecuRzQAcQFwC
 2Ky0446n/wbjfXtHIW2BVtKtWP2YR7fCmjkSYINqx61sgpexnj23+TxibK73X6T+6Amx
 Zo1eyFccddgedP/q8gRhRO4DcQ8BmBaTKC5clUbQXyjU3JsuQCZyUnJh42gvyQjxnJHB
 KZSCnfxF9ZuegEUo9qMt74iRBgZyChtAJDUH9FkhqPeYdy2YTxCFBPpJEFgGB6yWJ8RH
 9aMVHHb0sPEvxn18OwJYRAa7pu9ecbUScvBPe/ATpEF0HW8tQpEwfrXXt18feA0IHsF4
 I1CA==
X-Gm-Message-State: AJIora8lk8XWezNyOcY6ve0bRvYU+Ik6JGbJ6E8ee74wdhrLNBJ2wN/j
 w3KIMoBdoRbhLrEX/SDVsFwEOJ/mQnN3BYyshHBTx1DgFUj+G4oe9aX3eMlWTnw2duPVNhaXTh1
 XnfzMoStNmwiTnMaeJknwyzlBWQ4=
X-Received: by 2002:a05:6902:70b:b0:66e:8dde:7a58 with SMTP id
 k11-20020a056902070b00b0066e8dde7a58mr30523950ybt.186.1658221095300; 
 Tue, 19 Jul 2022 01:58:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vcXp+K4PFi+/A3OfHT4ckiAs2ABnwbeKDHneEj0ubfokIi0zzY5XlDBNR6QKXldkiWO+c69NZrE/u9xRGD2CM=
X-Received: by 2002:a05:6902:70b:b0:66e:8dde:7a58 with SMTP id
 k11-20020a056902070b00b0066e8dde7a58mr30523936ybt.186.1658221095010; Tue, 19
 Jul 2022 01:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220712124617.23139-1-rpalethorpe@suse.com>
 <CAEemH2e=-8rt+N=VdiA27xO=-Z5zE4RPu+MCf2NDCuOTq6xcAw@mail.gmail.com>
 <87pmi2iu4w.fsf@suse.de>
In-Reply-To: <87pmi2iu4w.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Jul 2022 16:58:03 +0800
Message-ID: <CAEemH2dVW7eXsPx4RRXD=N59xTG0+cbuLNG0qrA8aPrYSRwP=g@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] read_all: Add worker timeout
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
Content-Type: multipart/mixed; boundary="===============0636419927=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0636419927==
Content-Type: multipart/alternative; boundary="00000000000053d99405e424af8e"

--00000000000053d99405e424af8e
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 18, 2022 at 6:37 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello Li,
>
> Li Wang <liwang@redhat.com> writes:
>
> > Hi Richard,
> >
> > On Tue, Jul 12, 2022 at 8:46 PM Richard Palethorpe <rpalethorpe@suse.com>
> wrote:
> >
> >  Kill and restart workers that take too long to read a file. The
> >  default being one second. A custom time can be set with the new -t
> >  option.
> >
> >  This is to prevent a worker from blocking forever in a read. Currently
> >  when this happens the whole test times out and any remaining files in
> >  the worker's queue are not tested.
> >
> >  As a side effect we can now also set the timeout very low to cause
> >  partial reads.
> >
> > To restart workers which are blocked from reading files is a practical
> way.
> > My only concern is that restarted-worker is also slower reading on some
> > specific files so it will still be timed out again. Then the rest will
> fall into
> > restart cycles. Here I'd suggest loosening the worker_timeout to 3000 ms
> > to accommodate systems of different IO speeds.
>
> I didn't observe any issues setting the timeout very low
> (<100ms). Worker's remove an item from the queue before trying to read
> it, so they shouldn't get stuck in a restart cycle on the same file (if
> thats what you meant).
>

Ah yes, exactly.



> I'm not sure if this is better or worse. In my sys folder there are
> approx 35K files. Obviously a timeout of even 1s is far too long to read
> all of them if they all timeout. In fact if we set the timeout as 100ms
> then they would still require about 58 mins.
>

At the moment we just give a rough value on that as nobody has lots of
sample data.


>
> Of course most of them take a very short time on most systems. I guess
> that ideally the timeout needs to be adapted as the test runs so that
> all remaining files can be read. The issue with that though is that
> kill+wait+fork
> takes more time than most reads. Although that can be measured as
> well....
>
> This issue is quite a lot like the issues we have with fuzzy sync. I
> think it's maybe time to start dynamically adapting to system
> performance. That's probably best left to another patch series though.
>

Yes, collecting sample data can help evaluate the performance.
That's a practical way to make things more reliable.

-- 
Regards,
Li Wang

--00000000000053d99405e424af8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Jul 18, 2022 at 6:37 PM Richard Palethorpe =
&lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethorpe@suse.de</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello Li,<br>
<br>
Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@r=
edhat.com</a>&gt; writes:<br>
<br>
&gt; Hi Richard,<br>
&gt;<br>
&gt; On Tue, Jul 12, 2022 at 8:46 PM Richard Palethorpe &lt;<a href=3D"mail=
to:rpalethorpe@suse.com" target=3D"_blank">rpalethorpe@suse.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt;=C2=A0 Kill and restart workers that take too long to read a file. The<=
br>
&gt;=C2=A0 default being one second. A custom time can be set with the new =
-t<br>
&gt;=C2=A0 option.<br>
&gt;<br>
&gt;=C2=A0 This is to prevent a worker from blocking forever in a read. Cur=
rently<br>
&gt;=C2=A0 when this happens the whole test times out and any remaining fil=
es in<br>
&gt;=C2=A0 the worker&#39;s queue are not tested.<br>
&gt;<br>
&gt;=C2=A0 As a side effect we can now also set the timeout very low to cau=
se<br>
&gt;=C2=A0 partial reads.<br>
&gt;<br>
&gt; To restart workers which are blocked from reading files is a practical=
 way.<br>
&gt; My only concern is that restarted-worker is also slower reading on som=
e<br>
&gt; specific files so it will still be timed out again. Then the rest will=
 fall into <br>
&gt; restart cycles. Here I&#39;d suggest loosening the worker_timeout to 3=
000 ms<br>
&gt; to accommodate systems of different IO speeds.<br>
<br>
I didn&#39;t observe any issues setting the timeout very low<br>
(&lt;100ms). Worker&#39;s remove an item from the queue before trying to re=
ad<br>
it, so they shouldn&#39;t get stuck in a restart cycle on the same file (if=
<br>
thats what you meant).<br></blockquote><div><br></div><div><div class=3D"gm=
ail_default" style=3D"font-size:small">Ah yes, exactly.</div></div><div>=C2=
=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
I&#39;m not sure if this is better or worse. In my sys folder there are<br>
approx 35K files. Obviously a timeout of even 1s is far too long to read<br=
>
all of them if they all timeout. In fact if we set the timeout as 100ms<br>
then they would still require about 58 mins.<br></blockquote><div><br></div=
><div><span class=3D"gmail_default" style=3D"font-size:small">At the moment=
 we=C2=A0</span>just give a rough value on that as nobody has lots of sampl=
e data.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Of course most of them take a very short time on most systems. I guess<br>
that ideally the timeout needs to be adapted as the test runs so that<br>
all remaining files can be read. The issue with that though is that kill+wa=
it+fork<br>
takes more time than most reads. Although that can be measured as<br>
well....<br>
<br>
This issue is quite a lot like the issues we have with fuzzy sync. I<br>
think it&#39;s maybe time to start dynamically adapting to system<br>
performance. That&#39;s probably best left to another patch series though.<=
br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"f=
ont-size:small">Yes,=C2=A0collecting sample data can help evaluate the perf=
ormance.</div><div class=3D"gmail_default" style=3D"font-size:small">That&#=
39;s a practical way to make things more reliable.</div></div></div><div><b=
r></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr">=
<div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000053d99405e424af8e--


--===============0636419927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0636419927==--

