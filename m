Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B61C54EE9
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 08:40:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D7E13CACB1
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 10:40:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C475A3CA493
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 10:39:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F13681A00813
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 10:39:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663576791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gRcgcLLyEOHoEzaNJnPbepwvahERgysdKpgPLZqyQyI=;
 b=ZlfQ1Be5eQ2gyVhid/i9IryJvUxZjmfTG45U/gon3vFCedE1evrUpvywUHJJ7Ce3wtgPOW
 va8tbo1QPJOhqvWRS0PlDuU3Sn+isnjnv711MqpBlHAF33UMx72kgGW9pbOxGhhyUDBuL9
 RKEBKpn+pqZzpWZH/1g+uthRluCwVxo=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-520-jfWVRwDsNXupUbutPT7kmA-1; Mon, 19 Sep 2022 04:39:47 -0400
X-MC-Unique: jfWVRwDsNXupUbutPT7kmA-1
Received: by mail-ua1-f72.google.com with SMTP id
 b28-20020ab05f9c000000b003b42433bfc7so9023012uaj.2
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 01:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=gRcgcLLyEOHoEzaNJnPbepwvahERgysdKpgPLZqyQyI=;
 b=QxD/16TdmEMd7pQybXkrgIN1JIEOWg21L9aqQoqmNAcEtMn7rQii/pfIvPT7O93PHr
 D2pYppsKBYz9E12YnjQO9rs/9eKJTnu0DNzGpt9RgaL4DDQc8Id67xUmxX/hWSdvqTN+
 hwmPWR83yUCDQjTiepJLmZZCZt6jB/88glZvlzvXEpnqTUT3zheE2DQWUnztdUehfM9k
 WGh6fzHOdpkJL5N6TB7lit082AxcTiPk6VzW0Q0JSLvm/mCym4aS8Rp7GRe0t6NcRvVT
 RRcBsVG9E/pY4gy240OpHq4Vd9fEIr690nNAseyJVPAnfDaEB/ro6hpkELIwmRNlKs6B
 tAGw==
X-Gm-Message-State: ACrzQf2oi/DD2JvtkTcrCxooPyDJej0F5rVmoEtNGs7tHqPd4QahbTkM
 LgbGcGSxbyuKOLs7Wgq8aRs4V7yFB8CkGxVwUo8DgTq3rdnpFbmDsg3UE1uNNJJat8518+BFcOj
 OUtXH0YJ3btKfwbYPADP+DlE5hEg=
X-Received: by 2002:a67:e109:0:b0:398:563f:eb0a with SMTP id
 d9-20020a67e109000000b00398563feb0amr5608278vsl.57.1663576786745; 
 Mon, 19 Sep 2022 01:39:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5krV5kXJw2VR+pPWAz/ezqa422sPS8XtVMvfGVRjim1T8Dp35kLrqVhCVZmHlz4BkdGMnrO6KgPah0dXeAIgg=
X-Received: by 2002:a67:e109:0:b0:398:563f:eb0a with SMTP id
 d9-20020a67e109000000b00398563feb0amr5608271vsl.57.1663576786545; Mon, 19 Sep
 2022 01:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <010001834b528ae5-11a8d4c7-4e72-4f8d-af66-e9ec2a864017-000000@email.amazonses.com>
 <YyfeaeMsvACB5dcf@pevik>
 <CAEemH2ddod62+jkLjvxbNAwPxF8DrVGcyH3fKEJfkLrGaLZJng@mail.gmail.com>
 <CAEemH2cLKhrE5SVjfd5Got3adf9+C0dJeuP-qY_r98fDUr2gMQ@mail.gmail.com>
 <YygoFpOWW4Cuh2BB@yuki>
In-Reply-To: <YygoFpOWW4Cuh2BB@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 19 Sep 2022 16:39:35 +0800
Message-ID: <CAEemH2f=BQ3bdfKgPQzSYZjkTAx5mptptA31ToSTWzu-GQ1ovw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] lkft ltp for cea142b
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
Cc: Martin Doucha <martin.doucha@suse.com>, lkft@linaro.org,
 lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0580162858=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0580162858==
Content-Type: multipart/alternative; boundary="0000000000006b5cd505e903a708"

--0000000000006b5cd505e903a708
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 19, 2022 at 4:26 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > tst_pollute_memory() consume time is proportional to the amount of
> > > free RAM, it is hard to find one fixed value of max_runtime to fit all
> test
> > > platforms.
> > >
> > > From my experience, if you limited this test only run with small
> > > machine (e.g. RAM <= 32G), that performs well with whatever
> > > bare metal or VM, no timeout ever.
> > >
> >
> > Btw, we did that by setting a test filter before LTP running, also we
> could
> > add a field .max_mem_avail to tst_test struct for achieving that, but not
> > sure if it's worth doing that at this moment.
>
> The proper solution will be adding a separate timeouts for setup/cleanup
> and limiting the setup runtime to something sensible, but that is
>

Separate timeouts for setup/cleanup will break the integrity of
setting functions, my concern is that if tst_pollute_memory stopped
in uncompleted, the main test part is meaningless, right?

Or, I may misunderstand you here.



> something for the next development cycle.
>

+1

-- 
Regards,
Li Wang

--0000000000006b5cd505e903a708
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 19, 2022 at 4:26 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt; tst_pollute_memory() consume time is proportional to the amount o=
f<br>
&gt; &gt; free RAM, it is hard to find one fixed value of max_runtime to fi=
t all test<br>
&gt; &gt; platforms.<br>
&gt; &gt;<br>
&gt; &gt; From my experience, if you limited this test only run with small<=
br>
&gt; &gt; machine (e.g. RAM &lt;=3D 32G), that performs well with whatever<=
br>
&gt; &gt; bare metal or VM, no timeout ever.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Btw, we did that by setting a test filter before LTP running, also we =
could<br>
&gt; add a field .max_mem_avail to tst_test struct for achieving that, but =
not<br>
&gt; sure if it&#39;s worth doing that at this moment.<br>
<br>
The proper solution will be adding a separate timeouts for setup/cleanup<br=
>
and limiting the setup runtime to something sensible, but that is<br></bloc=
kquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:=
small">Separate timeouts for setup/cleanup will break the integrity of</div=
><div class=3D"gmail_default" style=3D"font-size:small">setting functions, =
my concern is that if tst_pollute_memory stopped</div><div class=3D"gmail_d=
efault" style=3D"font-size:small">in uncompleted, the main test part is mea=
ningless, right?</div><div class=3D"gmail_default" style=3D"font-size:small=
"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Or, I ma=
y misunderstand you here.</div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
something for the next development cycle.<br></blockquote><div><br></div><d=
iv class=3D"gmail_default" style=3D"font-size:small">+1</div></div><div><br=
></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><=
div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000006b5cd505e903a708--


--===============0580162858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0580162858==--

