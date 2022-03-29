Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF7EC433F5
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 04:54:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2E4B3C9BB2
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 06:54:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 388AE3C7883
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 06:54:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1A91E600C44
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 06:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648529659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=djHsIIGaNPI18vQ+x8pyOszHdKcKcTd6Oolq5tZWqLc=;
 b=jBTNkVCxLqj7gwqHFBpIr0acwX4SgZW7NN6ONXnlHawSUARG5wlX+2WjbJRFPmO1kTUWDa
 DC3+VuZTZINzxgIl6YQ+pqUgNGEksJSBd5WnycAAW4XlEotTaTuo4URt8LHTz0UbGwrRIe
 sss5hCIlp3c3nRWpHt5g4Gc751NS8qQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-WiI9GXR_Mrqenj-s1jDPkQ-1; Tue, 29 Mar 2022 00:54:15 -0400
X-MC-Unique: WiI9GXR_Mrqenj-s1jDPkQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 j6-20020a25ec06000000b00633c6f3e072so12516388ybh.12
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 21:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=djHsIIGaNPI18vQ+x8pyOszHdKcKcTd6Oolq5tZWqLc=;
 b=mfsqe7K3FUpASc+FMu74IeW18pZ2S3TSSrN6zQjYqQs9WzhNG1hUXWMM4fbMREu6/s
 B6PcRDPwULvlGiNYjgHfQmaypvN1kA7AS7oAb+5R3sRWIbxCvtImfwJKL0jdCmyjKjAR
 RNYM9xo4q0GWRQ1qk2/9HMCgejm7dMvftZYW2gwjCWjwpOzmQ+GciLIETrLiGQY/0mMR
 b0xOedXcbBV5i7Pu6zmmLr2v/f47aKc57tswnWyNi6Iuk7Vam32LnJr+srh+/AyYKr/B
 BoRlld6gKV4Omozpe+FG/b2H1+aKwepTwLjTcW0LW3Nz5hjpnz+rPgCe6O/V/O8k9ZrG
 0pRA==
X-Gm-Message-State: AOAM532OQo0hpr0JGUJMCwDlo0ujy8Fz+9vNv5eFzdUvWVr+hq0dvfx9
 +HEjWojMrjkQdCR6dRqmlk7I5wZZVj9vqW4JZjZFQE0nMNEvA8kQ5QdggxkUigPA7dElElv/3MQ
 vPLVe8CzVxKQp4amRqOpKfvTBqVQ=
X-Received: by 2002:a81:bc5:0:b0:2e6:dcfe:bfcb with SMTP id
 188-20020a810bc5000000b002e6dcfebfcbmr24977929ywl.19.1648529654908; 
 Mon, 28 Mar 2022 21:54:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygvcfkrOXG+gwQumgGCqGhOBPqzuxJoUxV40o58xwD8Mk2osrrffMnhJ6oW5PXoAHdOwJrgEGAW+ERy63LILU=
X-Received: by 2002:a81:bc5:0:b0:2e6:dcfe:bfcb with SMTP id
 188-20020a810bc5000000b002e6dcfebfcbmr24977908ywl.19.1648529654645; Mon, 28
 Mar 2022 21:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220325014821.2286280-1-chuhu@redhat.com>
 <CAEemH2ckzJRMB8HBkHx_3TVS38Ofy-neT8sK+5oYoNk=A0+TBA@mail.gmail.com>
In-Reply-To: <CAEemH2ckzJRMB8HBkHx_3TVS38Ofy-neT8sK+5oYoNk=A0+TBA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 29 Mar 2022 12:54:00 +0800
Message-ID: <CAEemH2f9Efe9=7mbCY1UtY-w+Mnun8xiCth=RdvJCXBuQB0_WA@mail.gmail.com>
To: Chunyu Hu <chuhu@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] futex_waitv03: fix SIGSEGV in TCONF cleanup
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
Content-Type: multipart/mixed; boundary="===============1942861635=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1942861635==
Content-Type: multipart/alternative; boundary="000000000000779f7705db5438af"

--000000000000779f7705db5438af
Content-Type: text/plain; charset="UTF-8"

>
> Pushed the two futex_waitv03 related patches, thanks!

-- 
Regards,
Li Wang

--000000000000779f7705db5438af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"></div></div>
</blockquote></div><div class=3D"gmail_default" style=3D"font-size:small">P=
ushed the two futex_waitv03 related patches, thanks!</div><div><br></div>--=
 <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regar=
ds,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000779f7705db5438af--


--===============1942861635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1942861635==--

