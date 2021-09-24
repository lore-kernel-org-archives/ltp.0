Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3BAC433EF
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 04:29:05 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE01F610F7
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 04:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE01F610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CA373C7209
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 06:29:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 409A73C176C
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 06:28:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5AB1A2010E0
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 06:28:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632457689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+z9aiYwWursWRWpMjOS6ZIIF6HMp7EQHwZrOhcTZcT8=;
 b=Eqdoh3mepvhiVVd+3ssOgx/ezHQ8Eg7kr6XUU8Mm/T01KkJW/dhgRMRxG3tEEexu2UeA7P
 yICZHhDAdnf1JD9hJoNjZSm2pSoGiHuUCY7bS0zvR6zGs5gN5ylGC/CINTsAq2Zp963h5Z
 Kuogr97Xzp2teNmJWBrHVfvHsd7esno=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-UrGWhyOjMsehjPg4R_7dQw-1; Fri, 24 Sep 2021 00:28:07 -0400
X-MC-Unique: UrGWhyOjMsehjPg4R_7dQw-1
Received: by mail-yb1-f197.google.com with SMTP id
 83-20020a251956000000b0059948f541cbso1915629ybz.7
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 21:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+z9aiYwWursWRWpMjOS6ZIIF6HMp7EQHwZrOhcTZcT8=;
 b=uwqCMuH1ZsggKpcblZq4VT+CyDQ8ROM4KtTer+zE+L0liA4YNW24adHUWyz95OfaXH
 rrZyFzxKDnkekietaBO/+ugFUEA1BqKPhEZxEoBf5zkGLOlbGMSUn7qDes0TI+csUmRR
 TkpItYkKCT2XKZA1mrkICgvl7V5XibiITXocASJmSbf8SpbgTK+zgPv1wLqdcOa5H9m9
 sOiatn4/fdL4U5n97El9TURBO4hEJsERRPv8I3j1WPGKJMNgfAhvCb92PbbD8WDwBArp
 TJz3eYF6VjPneeoTme3JtXGuSsd0bXLRCNHnb7isiYunaaEAKQls9gEgRz/JHVHo+1QO
 u6Pg==
X-Gm-Message-State: AOAM532ej9l50PORJDdWSnxtjQ2fJYSDVKr8hSyawoQg49bWR0ejsEGo
 Jlj4zppIVOYwcnJs5cQEGaUkqFelkYfQl4/vcgeu028aAoPNqv5FYe7shAuMMGaXMi10Iig6PU1
 bhbrFxWPap0w9G9E+Z2BrL4uwN1g=
X-Received: by 2002:a05:6902:705:: with SMTP id
 k5mr10622871ybt.490.1632457686925; 
 Thu, 23 Sep 2021 21:28:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcakAhITn0+ksjCGac2pBYCt69D3NSvWjJOmNLWo9u1giimjR458DYDe/aVCTftht9EjxO7/uN51DtgNBpLUo=
X-Received: by 2002:a05:6902:705:: with SMTP id
 k5mr10622857ybt.490.1632457686765; 
 Thu, 23 Sep 2021 21:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210921203349.GA2014441@maple.netwinder.org>
 <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki> <20210922165218.GA3081072@maple.netwinder.org>
 <CAEemH2cj3AJU01aUrodUh6WnSioyWmzC4U53gEumM9p7hnxmfw@mail.gmail.com>
 <CAEemH2f0+SL6pizzNs4syontAD5SeKmXFbVchRs=oXM-oEsEzw@mail.gmail.com>
 <YUx8p515ro8Y/Z8l@yuki>
In-Reply-To: <YUx8p515ro8Y/Z8l@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 24 Sep 2021 12:27:54 +0800
Message-ID: <CAEemH2dxKbbbKGcxnaJLV2TKZNANaow91_Wv-y8QgsE8WBZuAw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Content-Type: multipart/mixed; boundary="===============0911511404=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0911511404==
Content-Type: multipart/alternative; boundary="00000000000087e40f05ccb62cdb"

--00000000000087e40f05ccb62cdb
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 23, 2021 at 9:09 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Or, another way I can think of, is to cancel the tmpfs size limitation
> > when MemFree is less than the twofold size to be mounted.
>
> This would fail horribly if the machine has all RAM used but there is
> plenty in buffers that should be freed.
>
> I guess that we should really add tst_available_ram() function that
> would print either MemAvailable or sum of MemFree + MemCached. And of
> course we shouldn't eat more than half of that in the tests.
>

Agreed. I would like to put into tst_memutils.h.



>
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -895,6 +895,9 @@ static const char *limit_tmpfs_mount_size(const char
> > *mnt_data,
> >         if (strcmp(fs_type, "tmpfs"))
> >                 return mnt_data;
> >
> > +       if ((SAFE_READ_MEMINFO("MemFree:") / 1024) < (tdev.size * 2))
> > +               return mnt_data;
>
> I guess that we should as well skip the tmpfs completely if we think
> that the size is too small as well.
>

Just canceling the tmpfs size should work so far, since Ralph said
he got PASS on 20210524-version, which does not include the size
limitation.


-- 
Regards,
Li Wang

--00000000000087e40f05ccb62cdb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Sep 23, 2021 at 9:09 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; Or, another way I can think of, is to cancel the tmpfs size limitation=
<br>
&gt; when MemFree is less than the twofold size to be mounted.<br>
<br>
This would fail horribly if the machine has all RAM used but there is<br>
plenty in buffers that should be freed.<br>
<br>
I guess that we should really add tst_available_ram() function that<br>
would print either MemAvailable or sum of MemFree + MemCached. And of<br>
course we shouldn&#39;t eat more than half of that in the tests.<br></block=
quote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:s=
mall">Agreed. I would like to put into tst_memutils.h.</div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; --- a/lib/tst_test.c<br>
&gt; +++ b/lib/tst_test.c<br>
&gt; @@ -895,6 +895,9 @@ static const char *limit_tmpfs_mount_size(const ch=
ar<br>
&gt; *mnt_data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(fs_type, &quot;tmpfs&quot;=
))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return mn=
t_data;<br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((SAFE_READ_MEMINFO(&quot;MemFree:&quot=
;) / 1024) &lt; (tdev.size * 2))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return mnt_dat=
a;<br>
<br>
I guess that we should as well skip the tmpfs completely if we think<br>
that the size is too small as well.<br></blockquote><div><br></div><div><di=
v class=3D"gmail_default" style=3D"font-size:small">Just canceling the tmpf=
s size should work so far, since Ralph said=C2=A0</div><div class=3D"gmail_=
default" style=3D"font-size:small">he got PASS on 20210524-version, which d=
oes not include the size=C2=A0</div><div class=3D"gmail_default" style=3D"f=
ont-size:small">limitation.</div></div><div><br></div></div><div><br></div>=
-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Reg=
ards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000087e40f05ccb62cdb--


--===============0911511404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0911511404==--

