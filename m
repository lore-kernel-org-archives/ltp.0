Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37653C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 02:27:42 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FEC360F44
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 02:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5FEC360F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D13073C928B
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 04:27:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CD713C1DF5
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 04:27:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 00BD91A0116C
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 04:27:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631586447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Stn60ZBHB8/hReY0i4GRYTRhWmb01Hf1CHa9tl5FHwA=;
 b=dR1LU7HLN6AxNWfH1iRIGByPoFcyRpDvL9D/SbwWWc8YZNYPM5lNYYebLsVRNZWaFu6zR1
 eYHtV5LdtSy8LX/jS1XSYH5VwlmKz9pPzWOaesiZk+aE4Qo1Xxza5XpLjeXj3IELJ/+KaC
 jN9VW3ioWz4Dhah1QT5QLXu8cdq2xhk=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-5n51nETiPrme1wnjkA53Rw-1; Mon, 13 Sep 2021 22:27:25 -0400
X-MC-Unique: 5n51nETiPrme1wnjkA53Rw-1
Received: by mail-yb1-f198.google.com with SMTP id
 d93-20020a25a366000000b0059fff274d9aso15627790ybi.4
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 19:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Stn60ZBHB8/hReY0i4GRYTRhWmb01Hf1CHa9tl5FHwA=;
 b=jBqg2r6W9eZlu1QS4JWQ5MJAtdkVtcmEgKW2CUSU8/OLGcV0Zl2s2WgNz2YpdYNfGX
 x5qxo/pWp4Qx+s8pVkNHytMITwxzjCKenxWWfhXXBRw6NeeWtEEXpbSiN9frDCzR2VgE
 S7nds1eDXGgk2ZAvUm+KP0DYdH6UYqY7KCklluu5iY6bMnDto2vxBKmtvpfME1GcfmnU
 XN/lK0NB6csocLZmT5f1NGnDQwrOnOWwOIXI1CudLDrgU8Fxkmz3sSJd8LGAmPuy7a13
 CYlpkGkN2vawo5yKv+IypirKR8WG3q6LSwgpgx+zP6NDhDt1s/Gd+lUZEPFC3SB73y53
 99Zg==
X-Gm-Message-State: AOAM530lUSSK4vB7E7Lh8a19+i3p6lCwRdNxVvCROPB8fhjAdZebnUnz
 zc5Ta8DKf4gCprLCLVycwLSLDIdtx+CMispx1ENm8VMSwRAaIOV0bDEY3Y/1rQ0iXNYBg3qcZW3
 r/O95QiqQ7cA9Eav+rhb3Wx4O9Pw=
X-Received: by 2002:a25:2f48:: with SMTP id v69mr18938360ybv.339.1631586444686; 
 Mon, 13 Sep 2021 19:27:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHSucRp/PuwFsjBN5o41cVWwBP3+9/C/ncpqeq36P2LWFH5HliN7O20PHJDDO3fZRm1SN6LRt8WtL+EU8Fd6I=
X-Received: by 2002:a25:2f48:: with SMTP id v69mr18938344ybv.339.1631586444443; 
 Mon, 13 Sep 2021 19:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210913100022.14501-1-pvorel@suse.cz>
In-Reply-To: <20210913100022.14501-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 14 Sep 2021 10:27:12 +0800
Message-ID: <CAEemH2ety5_Ps0J=Y_1wRhAqV3higYy=OVEnok69LGgadyC1PA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] sched: Remove process.c
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
Content-Type: multipart/mixed; boundary="===============1450565650=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210914022712.6vGIEJ2Gn2MpGvWRhxPmomnrSlYW23c0Urbqmh9-iIA@z>

--===============1450565650==
Content-Type: multipart/alternative; boundary="0000000000007119f105cbeb5222"

--0000000000007119f105cbeb5222
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 13, 2021 at 6:00 PM Petr Vorel <pvorel@suse.cz> wrote:

> Test was removed as buggy from the runtest file nearly 20 years ago in:
> 576f1ee56 ("Removed a test that was not correctly running.")
>
> Test is probably obsolete, not using even legacy API, non-zero exit:
>
> $ ./process -d 8 -b 2 -t 1; echo $?
> total number of process to be created nodesum (511) is greater
>  than the allowed SEMMSL value (250)
> reseting the value of nodesum to SEMMSL
> Terminated
> 143
>
> + leaving very high load after being terminated.
>
> Reported-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--0000000000007119f105cbeb5222
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 13, 2021 at 6:00 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Test was removed as buggy from =
the runtest file nearly 20 years ago in:<br>
576f1ee56 (&quot;Removed a test that was not correctly running.&quot;)<br>
<br>
Test is probably obsolete, not using even legacy API, non-zero exit:<br>
<br>
$ ./process -d 8 -b 2 -t 1; echo $?<br>
total number of process to be created nodesum (511) is greater<br>
=C2=A0than the allowed SEMMSL value (250)<br>
reseting the value of nodesum to SEMMSL<br>
Terminated<br>
143<br>
<br>
+ leaving very high load after being terminated.<br>
<br>
Reported-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_bl=
ank">liwang@redhat.com</a>&gt;<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br></blockquote><div>=C2=A0</div><div><span c=
lass=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<=
a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;</span></div><=
/div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div =
dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000007119f105cbeb5222--


--===============1450565650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1450565650==--

