Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBEDC6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 10:11:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8EC03CAB10
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 12:11:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 073B43CA599
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 12:10:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F188D200C27
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 12:10:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663063854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EChuwWa6uK1R//jEYcAMkJRoXef5Tah94IuuD6cHNX4=;
 b=BVEVRJKPgAqCnhFky4o5X9SA0qAqS8SWZrWitsuCPhyup73fKO9gQPSKjkLjZ2dx5D95Vw
 bLf/7QSy+D5Escdk2q1DuIaqHoxn/GciB88410AEojgHj/FFxggxTZSX1T9v0DsNrLqEnA
 V/9PNev3fPQcyHDx2bVKZEx9bJMMdW4=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-265-Ib2_upaCOeGjMdmBJBD4Xg-1; Tue, 13 Sep 2022 06:10:51 -0400
X-MC-Unique: Ib2_upaCOeGjMdmBJBD4Xg-1
Received: by mail-vk1-f197.google.com with SMTP id
 s5-20020a1ff405000000b0039ecef730aaso2410423vkh.13
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 03:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=EChuwWa6uK1R//jEYcAMkJRoXef5Tah94IuuD6cHNX4=;
 b=Cv0HTTsVJCThdi5UeJcWgjOFLotK8sDJ7n/AfRItj2x4uSJuiSlyPBxNyrUZC4XDFm
 jGYwzveB31UFNRw3Z4o0P5sw5GktPbN1aTE6l51dV9QOXHwg/hhO8duYYltoEBf05XyD
 ONKp0Nlc0HeTTvjqFgewpyqXV4FOvzsQYH1miBaJNhnZpVpsgMtwt97FHZXH3DwLcjiV
 rWNkDqjV6ciTioY1e0D5W7OQU9bI9/5RT8xgo7FFQMoalMzB2GFhUEOZyviYFYc5vcgX
 M9r/3OEx91hzwU7oDmLi6DcbQ5/b7udmQDfC+pmEAtwVEL0feEOh42Bu649Lbrt6BUNs
 wwwQ==
X-Gm-Message-State: ACgBeo1fXpvT0pXktRDhmCGmmmj3YrL1MQFNvBKq7GFRXLJZ2HXLgsh3
 8vDp1TiZYce2uyjQj7g0SdXpqfxtwwsQlteMVJoUHRpeVEJmc1oJc526uaccwfbIy6KT6lbmPZK
 RZmmuOnOL/ti1CBJeAc4/EiieQ1E=
X-Received: by 2002:a05:6102:23f2:b0:38a:8fe2:db89 with SMTP id
 p18-20020a05610223f200b0038a8fe2db89mr8854015vsc.41.1663063850420; 
 Tue, 13 Sep 2022 03:10:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5wGwIx+PWlcUPsRRc4tnGA6c5mcOd+vGOx5dnL1D5hmMKmP/GuHQ7fYTD1oCEe46DHtOW5V8rntkx6B3skhqo=
X-Received: by 2002:a05:6102:23f2:b0:38a:8fe2:db89 with SMTP id
 p18-20020a05610223f200b0038a8fe2db89mr8854012vsc.41.1663063850239; Tue, 13
 Sep 2022 03:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <98009b0ab476426996e5687fca79b454@huawei.com>
In-Reply-To: <98009b0ab476426996e5687fca79b454@huawei.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 13 Sep 2022 18:10:38 +0800
Message-ID: <CAEemH2fTBEYH5r9kTxLphUqFUgdcyXUeZ_4LaA9Ex+4SgPOj5w@mail.gmail.com>
To: "luoxiaoyu (C)" <luoxiaoyu9@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pty04.c/pidfd_send_signal03.c: Drop redundant
 tst_reap_children()
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
Content-Type: multipart/mixed; boundary="===============0310621302=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0310621302==
Content-Type: multipart/alternative; boundary="0000000000000860e805e88c3a64"

--0000000000000860e805e88c3a64
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 13, 2022 at 5:34 PM luoxiaoyu (C) <luoxiaoyu9@huawei.com> wrote:

> Maybe I have a question to ask for.
> As my understand, tst_reap_children() has been called in API even test hit
> tst_brk, right?
>

To precisely, when hitting a tst_brk, the main process will invoke
do_test_cleanup()
and finally call tst_test->cleanup function from the specific testcase, to
recover the
original environment as much as they can.

In pidfd_send_signal03, the tst_reap_children will be invoked in that break
situation.
But we shouldn't say "it has been called in API", they're totally
different concepts.

see:
https://github.com/linux-test-project/ltp/blob/master/lib/tst_test.c#L339



>
> Regards,
> Luo
> -----origin mail-----
> Re: [LTP] [PATCH] pty04.c/pidfd_send_signal03.c: Drop redundant
> tst_reap_children()
>
> > On Tue, Sep 13, 2022 at 2:42 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > > Hi Luo,
>
> > > > Drop redundant calling of tst_reap_children() in cleanup() since
> > > > it has been called in the API (run_tests()).
>
> > > LGTM, I suppose that was a mistake.
>
>
> > Hmm, I slightly think that reflact a cautious thought from the author,
> > in case of test hit tst_brk unexpectly with invoke cleanup it can also
> > do reap children.
>
> > So, it's probably no harmful to keep tst_reap_children there.
> Ah, thx for info. I set status rejected in patchwork.
>
> Kind regards,
> Petr
>
>

-- 
Regards,
Li Wang

--0000000000000860e805e88c3a64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Sep 13, 2022 at 5:34 PM luoxiaoyu (C) &lt;<=
a href=3D"mailto:luoxiaoyu9@huawei.com">luoxiaoyu9@huawei.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Maybe I have a=
 question to ask for.<br>
As my understand, tst_reap_children() has been called in API even test hit =
tst_brk, right?<br></blockquote><div><br></div><div><div class=3D"gmail_def=
ault" style=3D"font-size:small">To precisely, when hitting=C2=A0a tst_brk, =
the=C2=A0main process will invoke do_test_cleanup()</div><div class=3D"gmai=
l_default" style=3D"font-size:small">and finally call tst_test-&gt;cleanup =
function from the specific testcase, to recover the</div><div class=3D"gmai=
l_default" style=3D"font-size:small">original environment as much as they c=
an.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><=
div class=3D"gmail_default" style=3D"font-size:small">In pidfd_send_signal0=
3, the tst_reap_children will be invoked in that break situation.</div><div=
 class=3D"gmail_default" style=3D"font-size:small">But we shouldn&#39;t say=
 &quot;it has been called in API&quot;, they&#39;re totally different=C2=A0=
concepts.</div><div class=3D"gmail_default" style=3D"font-size:small"><br><=
/div><div class=3D"gmail_default" style=3D"font-size:small">see:=C2=A0<a hr=
ef=3D"https://github.com/linux-test-project/ltp/blob/master/lib/tst_test.c#=
L339">https://github.com/linux-test-project/ltp/blob/master/lib/tst_test.c#=
L339</a></div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
Regards,<br>
Luo<br>
-----origin mail-----<br>
Re: [LTP] [PATCH] pty04.c/pidfd_send_signal03.c: Drop redundant tst_reap_ch=
ildren()<br>
<br>
&gt; On Tue, Sep 13, 2022 at 2:42 PM Petr Vorel &lt;<a href=3D"mailto:pvore=
l@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt; wrote:<br>
<br>
&gt; &gt; Hi Luo,<br>
<br>
&gt; &gt; &gt; Drop redundant calling of tst_reap_children() in cleanup() s=
ince <br>
&gt; &gt; &gt; it has been called in the API (run_tests()).<br>
<br>
&gt; &gt; LGTM, I suppose that was a mistake.<br>
<br>
<br>
&gt; Hmm, I slightly think that reflact a cautious thought from the author,=
 <br>
&gt; in case of test hit tst_brk unexpectly with invoke cleanup it can also=
 <br>
&gt; do reap children.<br>
<br>
&gt; So, it&#39;s probably no harmful to keep tst_reap_children there.<br>
Ah, thx for info. I set status rejected in patchwork.<br>
<br>
Kind regards,<br>
Petr<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--0000000000000860e805e88c3a64--


--===============0310621302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0310621302==--

