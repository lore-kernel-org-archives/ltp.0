Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CE0C433F5
	for <ltp@archiver.kernel.org>; Thu, 24 Feb 2022 01:35:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E78723C9C3D
	for <ltp@archiver.kernel.org>; Thu, 24 Feb 2022 02:35:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA8943C966F
 for <ltp@lists.linux.it>; Thu, 24 Feb 2022 02:35:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5DE5B2009B7
 for <ltp@lists.linux.it>; Thu, 24 Feb 2022 02:35:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645666501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yp3yxuW8PHDcH9eMkVhSzImsMVQpPPzbHln0x2WC/C4=;
 b=XrnBjwQ0/nH2EDVq/6jkeZLqg2Yzg4q/EOCq6M/n14RtIzEGpcJatCfzHIAwAZO2IPi6YS
 QV7cAfCzpbCpcxgkOwA8YCg8Ukmtl/qOFDKvNrZM35Yg2d8oyZoQ1V6LXMFNmy7Nbnom4W
 G3N6s6sDS46wlQFumRkCHk3XN1NVgOs=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-KT13oGhrNOSGChN0jFleVw-1; Wed, 23 Feb 2022 20:35:00 -0500
X-MC-Unique: KT13oGhrNOSGChN0jFleVw-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-2d6b6cf0cafso7581267b3.21
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 17:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yp3yxuW8PHDcH9eMkVhSzImsMVQpPPzbHln0x2WC/C4=;
 b=hW19aZUbJopa6r7U1OmtIMW2/MSRV58opahtycEyZ4+aaGLwW84LEpW2IRsymTS8fi
 +93UQRFFKq5+Y/ib21zuGVBG1gomwGsHIgLJzdhdiJTe5TRuKYz7GwLCFnvz9CMbwACR
 epiztFYo1WoFBuG6lqt0rMwf1FOdgfiiVIbIWEJqOtsvx51RS+mSR6+AyL8EkYr6fYcx
 37sECq+9l9PrHKBaSogcP8MB+Z3S/C7CGPGrNCsP4QEYYK8xWHXRUiX+yon6pEIG/H+T
 e7Gl5Wb0gGcB5sdj+EoadD5RETjEC5l9NlXa1AYlYLGx3c8MZlryK0AFqFgXlv6jKPm+
 9E5Q==
X-Gm-Message-State: AOAM532MYb26yvNDmjMMKkoLUJ0Zf71aKdlqD0FhlPyM0XbUTJ4v1drS
 y+H0a/m3XlWFSx5T4I2OfTSTDXu0cTHC3y1xwbDGfIgiiGZMCR2Zo38cz/SUWpy2FDcpeq5uWNJ
 d8N1wn+CwG18Ivx2DVbX5CYQS6MM=
X-Received: by 2002:a25:7752:0:b0:611:818d:ed43 with SMTP id
 s79-20020a257752000000b00611818ded43mr458804ybc.26.1645666499589; 
 Wed, 23 Feb 2022 17:34:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxPcFhnrI+LrYIPBLPoS1wmvjaQvgTpdK0GZ/uHwc5M20+0/nRVRdI6KSV7FyhqS3fbldN4p75a9nXxyJrqcU=
X-Received: by 2002:a25:7752:0:b0:611:818d:ed43 with SMTP id
 s79-20020a257752000000b00611818ded43mr458794ybc.26.1645666499419; Wed, 23 Feb
 2022 17:34:59 -0800 (PST)
MIME-Version: 1.0
References: <b32ed0e56099520bc3e75455e2472841aa0b3020.1645096642.git.jstancek@redhat.com>
 <CAEemH2cM9-qHgu2F1=H9W0sWZFkGu1BvWdNvGyREsf+s9kHSSQ@mail.gmail.com>
 <YhZAokgMMBLJfamN@yuki>
In-Reply-To: <YhZAokgMMBLJfamN@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 24 Feb 2022 09:34:41 +0800
Message-ID: <CAEemH2cXSKbDFNg-xsL1Baz7uw_8i=xeSx1tVafnStpmbhTtSw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/perf_event_open03: skip test on slower
 systems
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
Content-Type: multipart/mixed; boundary="===============1454506572=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1454506572==
Content-Type: multipart/alternative; boundary="0000000000001df5bf05d8b99787"

--0000000000001df5bf05d8b99787
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 23, 2022 at 10:09 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Generally, this method looks good, but maybe better to limit this
> > check_progress() only perform on -debug kernel?  Otherwise,
>
> I guess that it may be pretty useful on embedded systems as well. Having
> TCONF message with "system too slow" rather than a timeout sounds like
> an improvement to me.
>

Yes, sounds reasonable.



>
> > Reviewed-by: Li Wang <liwang@redhat.com>
> >
> >
> > ======= FYI ==========
> > I'm seeking a fair way to make a global evaluation of the test
> > system to reset timeout dynamically for the whole LTP.
> >
> > My original design thoughts:
> >
> >   Create the numbers of threads equal to CPUs and bind them to
> >   the corresponding cpu for running. Use mutex lock to sync up
> >   each thread launch at the same time to collect the basic data
> >   for their CPU. Then we can compare the CPU state under the idle or
> >   busy time to get a relatively stationary _value_ to measure the system
> >   performance.
> >
> > But so far the test method is not stable&reliable as expected.
> >
> >   // do float computing + dirty 10*pagesz memory  in a limited times
> >   one_unit_of_operation();
> >
> >   // count the CPU looping numbers with (type = idel, calcu)
> >   // and call one_unit_opertaion() in 1 sec
> >   cpu_1sec_looping(int type);
> >
> >   idlespeed_loops = cpu_1sec_looping(idel);
> >   calculate_loops = cpu_1sec_looping(calcu);
> >   ...
> >   // count the _value_ from all CPU average loops
> >   ratio = calculate_avg / idealspeed_avg;
>
> I'm not sure how useful this would be, I guess that the speed of
> different syscalls will differ quite a bit on different kernel versions.
> Maybe the whole system is too complex and cannot be described by
> something as simple as this. But I guess that we will not know unless we
> try.
>

That's right, after try with many times locally I realized that we probably
need a general-purpose function or macro that can pass with a kind of
syscall to get the performance value of it. But that needs more
consideration
and practice, so I add this to my long-term TODO list.

-- 
Regards,
Li Wang

--0000000000001df5bf05d8b99787
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Feb 23, 2022 at 10:09 PM Cyril Hrubis &lt;<=
a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; Generally, this method looks good, but maybe better to limit this<br>
&gt; check_progress() only perform on -debug kernel?=C2=A0 Otherwise,<br>
<br>
I guess that it may be pretty useful on embedded systems as well. Having<br=
>
TCONF message with &quot;system too slow&quot; rather than a timeout sounds=
 like<br>
an improvement to me.<br></blockquote><div><br></div><div><div class=3D"gma=
il_default" style=3D"font-size:small">Yes, sounds reasonable.</div><br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=
=3D"_blank">liwang@redhat.com</a>&gt;<br>
&gt; <br>
&gt; <br>
&gt; =3D=3D=3D=3D=3D=3D=3D FYI =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; I&#39;m seeking a fair way to make a global evaluation of the test<br>
&gt; system to reset timeout dynamically for the whole LTP.<br>
&gt; <br>
&gt; My original design thoughts:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Create the numbers of threads equal to CPUs and bind them =
to<br>
&gt;=C2=A0 =C2=A0the corresponding cpu for running. Use mutex lock to sync =
up<br>
&gt;=C2=A0 =C2=A0each thread launch at the same time to collect the basic d=
ata<br>
&gt;=C2=A0 =C2=A0for their CPU. Then we can compare the CPU state under the=
 idle or<br>
&gt;=C2=A0 =C2=A0busy time to get a relatively stationary _value_ to measur=
e the system<br>
&gt;=C2=A0 =C2=A0performance.<br>
&gt; <br>
&gt; But so far the test method is not stable&amp;reliable as expected.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0// do float computing + dirty 10*pagesz memory=C2=A0 in a =
limited times<br>
&gt;=C2=A0 =C2=A0one_unit_of_operation();<br>
&gt; <br>
&gt;=C2=A0 =C2=A0// count the CPU looping numbers with (type =3D idel, calc=
u)<br>
&gt;=C2=A0 =C2=A0// and call one_unit_opertaion() in 1 sec<br>
&gt;=C2=A0 =C2=A0cpu_1sec_looping(int type);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0idlespeed_loops =3D cpu_1sec_looping(idel);<br>
&gt;=C2=A0 =C2=A0calculate_loops =3D cpu_1sec_looping(calcu);<br>
&gt;=C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0// count the _value_ from all CPU average loops<br>
&gt;=C2=A0 =C2=A0ratio =3D calculate_avg / idealspeed_avg;<br>
<br>
I&#39;m not sure how useful this would be, I guess that the speed of<br>
different syscalls will differ quite a bit on different kernel versions.<br=
>
Maybe the whole system is too complex and cannot be described by<br>
something as simple as this. But I guess that we will not know unless we<br=
>
try.<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"f=
ont-size:small">That&#39;s right, after try with many times locally I reali=
zed that we probably</div><div class=3D"gmail_default" style=3D"font-size:s=
mall">need a general-purpose function or macro that can pass with a kind of=
</div><div class=3D"gmail_default" style=3D"font-size:small">syscall to get=
 the performance value of it. But that needs more consideration</div><div c=
lass=3D"gmail_default" style=3D"font-size:small">and practice, so I add thi=
s to my long-term TODO list.</div></div><div><br></div>-- <br><div dir=3D"l=
tr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>=
Li Wang<br></div></div></div></div>

--0000000000001df5bf05d8b99787--


--===============1454506572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1454506572==--

