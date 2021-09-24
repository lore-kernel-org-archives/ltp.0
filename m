Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E28C433F5
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 04:19:18 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED4E610D1
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 04:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AED4E610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C52D93CB3A3
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 06:19:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE8333C2E1E
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 06:19:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BF5D61A00CC4
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 06:19:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632457141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ljaIJTEjKUeSduAbxINB2jAm4gQsW8RB41e/t/ab2R8=;
 b=CMr6cH0TLgx3NRgl75GWMXr2Wl4yrb6sug9ZEkNnArlfFy5wH2L3nbnCGm5ZIW8Tlz/YEW
 fTYlThiOYM6RdimST9U0GLc49zd7TaUXlbN9xYqwTpc/5dBAGpBEZhWYfU5Cg6WFFjk5QV
 3AuQEBUaDa0IlXjJ06sQqXmvazB6i8Q=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-c1AwXHcZNMCH6HQsvxmg3w-1; Fri, 24 Sep 2021 00:18:59 -0400
X-MC-Unique: c1AwXHcZNMCH6HQsvxmg3w-1
Received: by mail-yb1-f198.google.com with SMTP id
 o202-20020a25d7d3000000b005a704560db0so1896282ybg.17
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 21:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ljaIJTEjKUeSduAbxINB2jAm4gQsW8RB41e/t/ab2R8=;
 b=X8+p+qh1U3KCpBeCQjwtIPdHQTLo1VbZydHXKN/t1lAHMS/QvrfTY7z+0qAybL2mcC
 USpKzdLBBxuoY5woR+dJBDrtZW3WzREVJgdTXI1ad0dB/VMlWIhdXAMUFrXq4gBFfA+R
 wS6yf7YCw5HEk6ss3z4+WaubHzoJxGwR6P15jeIXpbimdrISpLAYOMgln0wDdgdHdm3H
 V5o3Dhj0RWe8uBE4t5aIE5CIcRDDKkBJHu9pzNFRxJ6qvkb0B1dbsNdb1QjbP5O0KFn3
 PG9sxr9oer+vzRerr2FBAfAY5POAuceYanZqCcKxG8gzFxR1DSDKOdXUSkCLm6NK9iHn
 Uf9g==
X-Gm-Message-State: AOAM530YJkVuafFMlvBU0iEXBUQFjA9mQVoJ1U3zVb+jINouG/lXOfL3
 q0/Ugm62IJWkFc28u5JMTDUG174dw0IZihg1XPkjMlqIcYoyPEXWUoEPSN2U3pUkUBVjYUErq19
 ta9VpBAPCRHoosSnPSk9C0Ew1pdk=
X-Received: by 2002:a25:4b02:: with SMTP id y2mr2345627yba.144.1632457138896; 
 Thu, 23 Sep 2021 21:18:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx14KEBW+SSj2VcrrhjYhBmrBGWQjyIRo9WcSptJRGipFPJxqf7QXoiM8CGasMlIdwqpqVonRY7+34gYKy8fUY=
X-Received: by 2002:a25:4b02:: with SMTP id y2mr2345607yba.144.1632457138652; 
 Thu, 23 Sep 2021 21:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210817104625.2559362-1-liwang@redhat.com>
 <20210921203349.GA2014441@maple.netwinder.org>
 <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki> <20210922165218.GA3081072@maple.netwinder.org>
 <YUyQMBLPbCs4/Gur@yuki> <20210924014900.GA3975163@maple.netwinder.org>
In-Reply-To: <20210924014900.GA3975163@maple.netwinder.org>
From: Li Wang <liwang@redhat.com>
Date: Fri, 24 Sep 2021 12:18:45 +0800
Message-ID: <CAEemH2diTBrnYAbBedQN+bog6y4NdLZG628egCqxuopZ7DHB0Q@mail.gmail.com>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0620472958=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0620472958==
Content-Type: multipart/alternative; boundary="000000000000dc6d6605ccb60ba9"

--000000000000dc6d6605ccb60ba9
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 24, 2021 at 9:49 AM Ralph Siemsen <ralph.siemsen@linaro.org>
wrote:

> Thanks for the suggestions!
>
> I have tried setting .dev_min_size = 64, in addition to setting
> FALLOCATE_BLOCKS back to the previous value of 16. Unfortunately I am
> still seeing OOM when filling the tmpfs. I am confident I made the
> change correctly, as I can see the message:
>

That's weird.

What about the testing result with unlimit the tmpfs size?

My second thoughts mentioned above (if it works, I will
fix it by following Cyril's suggestion).



> tst_test.c:903: TINFO: Limiting tmpfs size to 64MB
>

Hmm, set to 16MB, 32MB? test result?

Can you post the /proc/meminfo here? I'm curious how
small memory it is can not tolerate 64M consuming.



>
> For other filesystems (ext4/btrfs/vfat) the test is fine, and I get
> ENOSPC error as expected.
>
> I'm testing on kernel version 5.10.52 currently, but I could also switch
> back to 4.19. I'm on ARMv7 rather than amd64.
>
> Regards,
> Ralph
>
>

-- 
Regards,
Li Wang

--000000000000dc6d6605ccb60ba9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Sep 24, 2021 at 9:49 AM Ralph Siemsen &lt;<=
a href=3D"mailto:ralph.siemsen@linaro.org">ralph.siemsen@linaro.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Thanks f=
or the suggestions!<br>
<br>
I have tried setting .dev_min_size =3D 64, in addition to setting <br>
FALLOCATE_BLOCKS back to the previous value of 16. Unfortunately I am <br>
still seeing OOM when filling the tmpfs. I am confident I made the <br>
change correctly, as I can see the message:<br></blockquote><div><br></div>=
<div><div class=3D"gmail_default" style=3D"font-size:small">That&#39;s weir=
d.=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:small"><br></=
div><div class=3D"gmail_default" style=3D"font-size:small">What about the t=
esting result with=C2=A0unlimit the tmpfs size?</div><div class=3D"gmail_de=
fault" style=3D"font-size:small"><br></div><div class=3D"gmail_default" sty=
le=3D"font-size:small">My second thoughts mentioned above (if it works, I w=
ill</div><div class=3D"gmail_default" style=3D"font-size:small">fix=C2=A0it=
 by following Cyril&#39;s suggestion).</div></div><div class=3D"gmail_defau=
lt" style=3D"font-size:small"><br></div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
tst_test.c:903: TINFO: Limiting tmpfs size to 64MB<br></blockquote><div><br=
></div><div><div class=3D"gmail_default" style=3D"font-size:small">Hmm, set=
 to 16MB, 32MB? test result?</div></div><div><br></div><div><div class=3D"g=
mail_default" style=3D"font-size:small">Can you post the /proc/meminfo here=
? I&#39;m curious how=C2=A0</div><div class=3D"gmail_default" style=3D"font=
-size:small">small memory it is can not tolerate 64M consuming.</div><br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
For other filesystems (ext4/btrfs/vfat) the test is fine, and I get <br>
ENOSPC error as expected.<br>
<br>
I&#39;m testing on kernel version 5.10.52 currently, but I could also switc=
h <br>
back to 4.19. I&#39;m on ARMv7 rather than amd64.<br>
<br>
Regards,<br>
Ralph<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000dc6d6605ccb60ba9--


--===============0620472958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0620472958==--

