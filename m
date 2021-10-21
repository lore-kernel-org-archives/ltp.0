Return-Path: <SRS0=SXDC=PJ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C592DC433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 09:46:01 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFB1603E9
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 09:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAFB1603E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 869EA3C55EB
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 11:45:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFC2A3C004F
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 11:45:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 29B631A01787
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 11:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634809545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sSiqNCl2lONG1VLLJfjeBaHBSbBY5bO4QIaWhJSKoQ8=;
 b=M9JH8HxOmxHxkrcjT03eJrLrAudNBH8Uay4M772sJ1W2mLQGJIQ/X5eJRjWMWskux9vPQi
 bOrzV4aHsNKnrfXrpcTNpga1xnjYgdlFFDKEapOzns41yM4mfgeXKQDl8+2iovih9sk7Q8
 bbQ28HIEN/RNqo+b7xhbsIj57fLXF1E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-JZT2F0X3PgKNXmAHgzSCMQ-1; Thu, 21 Oct 2021 05:45:44 -0400
X-MC-Unique: JZT2F0X3PgKNXmAHgzSCMQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 e10-20020ac8670a000000b002a78257482eso4304334qtp.10
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 02:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sSiqNCl2lONG1VLLJfjeBaHBSbBY5bO4QIaWhJSKoQ8=;
 b=36B7dnfSfYao556n4JVWAbaug21TPtzrlgARbGOQeCj6x5LSDsXHTNlEzXroG5mUco
 cfhSqoAiymA5EZbOqAJJ7yd9LldzQlxrBBfDQH1nMaDPx5iiDzygK2ccb3NGaeH6hYbB
 +W0AI1uJltEXZ7XNeN+EVTG5tHOFe6X6fDctIATWDzpDWcAl2wZ41lbyfnfFPDwX2q+q
 9YKUmS9EDEiZVC5ynVNUj72TeyZ/sRDco/S+naKe2cT8zOgMFdhkg9cfQwNyfnpy3DE7
 aQL740AZjHUexK8UPf52LRGYhZyiFS/GVf+VjKY99vVk7CveltfZo2R5dzh+2HMb/BuU
 i/eA==
X-Gm-Message-State: AOAM531BoP5sxowVxiljl1j2Obz5MzMv77ARUQuOS/X5A05InN1O2fcl
 y9UyQ4Xv1b5QeKO3D65M4KEn6EdMymOUdmmHV9+8Zhynm0ZulsDKMdUvDlHkmhOvleTic0GIP9E
 nOILqpCCU65hJC/yRQcuVqyHqXhg=
X-Received: by 2002:a25:e4c7:: with SMTP id b190mr4893238ybh.302.1634809543709; 
 Thu, 21 Oct 2021 02:45:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJya6nUwd0SNJMQsGst8xY+WiIEX+g//8gpO1uoLadYRYYzMLEG18EtEOl51K0dTyb0JCC6gX4DGrY4Vd0uzwns=
X-Received: by 2002:a25:e4c7:: with SMTP id b190mr4893215ybh.302.1634809543532; 
 Thu, 21 Oct 2021 02:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211021083547.111590-1-krzysztof.kozlowski@canonical.com>
 <20211021083547.111590-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211021083547.111590-2-krzysztof.kozlowski@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Oct 2021 17:45:30 +0800
Message-ID: <CAEemH2d6mVBo1T_TB6FSDhTxhiFK33YftWRF+B+B7qjBZTj79g@mail.gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] lib: memutils: include also available
 memory when polluting
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
Content-Type: multipart/mixed; boundary="===============1022489299=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1022489299==
Content-Type: multipart/alternative; boundary="0000000000001e388b05ced9c2a2"

--0000000000001e388b05ced9c2a2
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for the fixes. For the series:

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--0000000000001e388b05ced9c2a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Krzysztof,</div><div class=3D"gmail_default" style=3D"font=
-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:smal=
l">Thanks for the fixes. For the series:</div><div class=3D"gmail_default" =
style=3D"font-size:small"><br class=3D"gmail-Apple-interchange-newline">Rev=
iewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank=
">liwang@redhat.com</a>&gt;</div></div><div><br></div>-- <br><div dir=3D"lt=
r" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>L=
i Wang<br></div></div></div></div>

--0000000000001e388b05ced9c2a2--


--===============1022489299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1022489299==--

