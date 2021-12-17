Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB723C4332F
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 01:50:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3406C3C8F60
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 02:50:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 946743C89CE
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 02:50:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B3D011A01C80
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 02:50:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639705841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dva9asql95rKIj4BMtTxSISlcl0DyraVechKpgXOYUg=;
 b=EYMmrXnkoSFyJIET/Ihm3PwGmROn8QkXqIjpvQh3hG6KBKJSizkPFT5hiIFNAr00mcLEhW
 yqacOr3ukP3i/xDGza8VCr2FIWzM/ZG71TviofVx2LSz+IsW1ZSieTBzPdiSzH/ErHdRHv
 vqiN2p6DnadHvcOzeOtksN2KjwaWRcw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-XnM9gKtPPV2GGB6-_zrFOA-1; Thu, 16 Dec 2021 20:50:39 -0500
X-MC-Unique: XnM9gKtPPV2GGB6-_zrFOA-1
Received: by mail-yb1-f199.google.com with SMTP id
 s7-20020a5b0447000000b005fb83901511so1849433ybp.11
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 17:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dva9asql95rKIj4BMtTxSISlcl0DyraVechKpgXOYUg=;
 b=1zvmLgVshhkE/if+ljIQNrrBXyGpL3OBKGzmymP++Xy+OV/mVjP4p+PmKVb7ILkd6O
 9jf8P/X4ygVr+6M1w0kfApIylQZstvM/HpzKUnRwISRxYV16z69IxyLuWq4DOHdIeIh/
 sBcQbl3tqizvdRkzrIgLjTXWYiohdfC7+SzB3v/myKxURGsvtibW49gJFJf4t4UdC0oh
 kbumo9A833fzjnqUA43+2W8SGWTI8ytQFsgZ3vk4UP5uUC9khZm2AYmT65Im4lnO0Wa1
 OGFjvSAIior20G/9N2Y8j7spHZVQ8R9FSvCUa1MP2zbLcip1xNe9Y9dhYNncOtgFE3Rf
 gN7A==
X-Gm-Message-State: AOAM532dTkMlKio2kOdlYa01Vh05V/u7YqPcluMNQthtJ5tUczRgwDLC
 o1519lqhFhyFjhZCDNEsNk9XJrNJdeXmx9fmRzhWUF/A2oWvsYnV7sGYCSVmhL21KhCwi/89bnr
 QpJ/tGhgAnNZxc4m2YXiE+TxlG78=
X-Received: by 2002:a25:8c9:: with SMTP id 192mr1313948ybi.102.1639705838793; 
 Thu, 16 Dec 2021 17:50:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxZh3zrck2p7NYNkfU8rBeaEWiV51qE6WZ3CiZxngoUQPfQz+FGpcIYzAKNzggvuciJQUJDgTnTsGV4OFrRj8=
X-Received: by 2002:a25:8c9:: with SMTP id 192mr1313932ybi.102.1639705838552; 
 Thu, 16 Dec 2021 17:50:38 -0800 (PST)
MIME-Version: 1.0
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
 <20211216034125.255907-1-liwang@redhat.com>
 <20211216034125.255907-2-liwang@redhat.com>
 <e396e4c3-605f-2fa6-094a-59194bbc0c3c@suse.cz>
In-Reply-To: <e396e4c3-605f-2fa6-094a-59194bbc0c3c@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Dec 2021 09:50:20 +0800
Message-ID: <CAEemH2funwbYUB1N67rw=KC0BP=easdc60pVvJ1BU01tVBEVUA@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] ltp: enable OOM protection for main and test
 harness process
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
Content-Type: multipart/mixed; boundary="===============0507352224=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0507352224==
Content-Type: multipart/alternative; boundary="0000000000000b201105d34dc44e"

--0000000000000b201105d34dc44e
Content-Type: text/plain; charset="UTF-8"

On Thu, Dec 16, 2021 at 5:56 PM Martin Doucha <mdoucha@suse.cz> wrote:

> Hi,
>
> On 16. 12. 21 4:41, Li Wang wrote:
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index ce2b8239d..f3ae48240 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -1441,11 +1441,15 @@ static int fork_testrun(void)
> >
> >       SAFE_SIGNAL(SIGINT, sigint_handler);
> >
> > +     tst_enable_oom_protection(getppid());
>
> this is exactly what you should *NOT* do because then the OOM protection
> will also be inherited by all non-LTP processes executed by the same
> shell (or whatever the parent process is).
>

You are right! I previously thought the parent process is only ltp-pan
and we only need to cancel the protection in fork_testrun's children.
But obviously, one thing I neglected is that some shell tests will still
under the affected. And furthermore if run LTP test manually the parent
will be the shell, non-LTP process also inherits the score.

Thanks for pointing out this, I will remove this line in V2.

-- 
Regards,
Li Wang

--0000000000000b201105d34dc44e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Dec 16, 2021 at 5:56 PM Martin Doucha &lt;<=
a href=3D"mailto:mdoucha@suse.cz">mdoucha@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On 16. 12. 21 4:41, Li Wang wrote:<br>
&gt; diff --git a/lib/tst_test.c b/lib/tst_test.c<br>
&gt; index ce2b8239d..f3ae48240 100644<br>
&gt; --- a/lib/tst_test.c<br>
&gt; +++ b/lib/tst_test.c<br>
&gt; @@ -1441,11 +1441,15 @@ static int fork_testrun(void)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_SIGNAL(SIGINT, sigint_handler);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0tst_enable_oom_protection(getppid());<br>
<br>
this is exactly what you should *NOT* do because then the OOM protection<br=
>
will also be inherited by all non-LTP processes executed by the same<br>
shell (or whatever the parent process is).<br></blockquote><div><br></div><=
div><div class=3D"gmail_default" style=3D"font-size:small">You are right! I=
 previously thought the parent=C2=A0process is only ltp-pan</div><div class=
=3D"gmail_default" style=3D"font-size:small">and we only need to cancel the=
 protection in fork_testrun&#39;s children.</div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">But obviously, one thing I neglected=C2=A0is t=
hat some shell tests will still</div><div class=3D"gmail_default" style=3D"=
font-size:small">under the affected. And furthermore if run LTP test manual=
ly the parent</div><div class=3D"gmail_default" style=3D"font-size:small">w=
ill be the shell, non-LTP process also inherits the score.</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">Thanks for pointing out this, I will rem=
ove this line in V2.</div></div></div><div><br></div>-- <br><div dir=3D"ltr=
" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li=
 Wang<br></div></div></div></div>

--0000000000000b201105d34dc44e--


--===============0507352224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0507352224==--

