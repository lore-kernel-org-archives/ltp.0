Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F0EC433EF
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 09:24:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CF273CA9DC
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 11:24:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59B553C1BCA
 for <ltp@lists.linux.it>; Fri, 13 May 2022 11:24:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 60FFB1000DF1
 for <ltp@lists.linux.it>; Fri, 13 May 2022 11:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652433867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSmJfri0SoEZpBCOvujbn/lxOkvChDn8U+QcDVUONmw=;
 b=ZKhcjApgt1sc8em5QdwOTSvbi4geWYw6CdDeqsjGcfGgaqJ10wkymeI4OFqdxmoSK5zcxX
 sb2Qe1VOypugCWPniKjOYleAEiN9qZ5w7QwKem912dWSLkakgKe/57TDzS5Y31VzCTGSfa
 2n0jFTlv5Bg3x9abkFhny4p6scFaZxg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-H3czDiogNkOwCewSngWX9g-1; Fri, 13 May 2022 05:24:26 -0400
X-MC-Unique: H3czDiogNkOwCewSngWX9g-1
Received: by mail-yb1-f197.google.com with SMTP id
 9-20020a250909000000b006484b89c979so6730300ybj.21
 for <ltp@lists.linux.it>; Fri, 13 May 2022 02:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SSmJfri0SoEZpBCOvujbn/lxOkvChDn8U+QcDVUONmw=;
 b=fGhsGew22/9rvwma1LvLdeXI/y9kRF/ELCi5pTUr9FFmcNVuC6hCy3E9nE4bFZviU+
 LjfAYM5+BrSN06cUU75FT4ceO/j2Vsj6gdqZrrZDUU3aNL/bUi1SRHZadTWNmlDSfKA4
 1qkURcIH2IEq+4dFe9RLyyA0VVnqnDngYAzOcTAbUC4utLT6TsL6wVJBN5AN6KpaWkUU
 RivTdKOosaD88ib/AkvzKSTiz8RuqVLhV2an8I3VcrnLyoMQhU3Sl62Q6N9H6o5/fUC+
 iEPltCxrIc59P4KHKUiHN5OtYi4mtOHGdsQvd/MDcr/1H5zWAYHzGDCqQm3uwVfjUhLs
 7VaA==
X-Gm-Message-State: AOAM532MUn7iwN43wdLjsgJTUoDaXJlKAROXssI3oaDne8xWUWVn1f6R
 XkvN1A8JeVrkUor0edIiHOErto4C5vI66nTK90sK3gyx8TMJEUOh+j/dcCSAomn2CTql/wIcLOq
 SuobJkxY2m5NSPaSa9yIKX0EAhaI=
X-Received: by 2002:a81:4b8e:0:b0:2ef:5240:69fc with SMTP id
 y136-20020a814b8e000000b002ef524069fcmr4757462ywa.19.1652433866156; 
 Fri, 13 May 2022 02:24:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuYtqqeM6bh/3cG/pB68+5hm4oSumTWS5uQjSqzxCYRJ5It/HID3o6rvU5GdL/g7H3UUtRqEbB0TWYiS2KD1I=
X-Received: by 2002:a81:4b8e:0:b0:2ef:5240:69fc with SMTP id
 y136-20020a814b8e000000b002ef524069fcmr4757442ywa.19.1652433865964; Fri, 13
 May 2022 02:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220512131002.26093-1-chrubis@suse.cz>
 <CAEemH2dV04-F1mFHiCodQV+uWMbMWxEVy3hW+iqSv6zyJwjyMg@mail.gmail.com>
 <Yn4f3HLBTJ/ehtyh@yuki>
In-Reply-To: <Yn4f3HLBTJ/ehtyh@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 13 May 2022 17:24:15 +0800
Message-ID: <CAEemH2efDs=zfc70=C+Q0C-v6ZhnbcV7WUreqeWOY8vrjcnJTA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] waitid10: raise SIGFPE directly
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
Content-Type: multipart/mixed; boundary="===============1683316450=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1683316450==
Content-Type: multipart/alternative; boundary="00000000000098951b05dee13d7c"

--00000000000098951b05dee13d7c
Content-Type: text/plain; charset="UTF-8"

> Triggering SIGFPE by invalid instruction is not always possible, some
> architectures does not trap division-by-zero at all and even when it's
> possible we would have to fight the compiler optimizations that have
> tendency to remove undefined operations.
>

Looks good.

-- 
Regards,
Li Wang

--00000000000098951b05dee13d7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
Triggering SIGFPE by invalid instruction is not always possible, some<br>
architectures does not trap division-by-zero at all and even when it&#39;s<=
br>
possible we would have to fight the compiler optimizations that have<br>
tendency to remove undefined operations.<br></blockquote><div><br></div><di=
v><div class=3D"gmail_default" style=3D"font-size:small">Looks good.</div><=
/div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--00000000000098951b05dee13d7c--


--===============1683316450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1683316450==--

