Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F010EB64D7
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 11:52:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5371F3CDDEC
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 13:52:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 090223C9D07
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 13:52:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CFE5660071A
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 13:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687348349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bB6oMPP6UoRz76ScLAWWaUZS+Yg66+7v0dNXnQipw/4=;
 b=ZtyS0PA39UPPxb2wzikBC6HfZrsEQeocugQ0k8O0vN+IxQPlb9u39OsRKrXYYNcdcyyV/r
 EBgUiuonLl8OGa0clUyjFcTH5OXxkXJCxcB1aagZgnOGsjoLFrV8Otv0qQwlYcSIwVnspN
 LB0UaWlWDm/JrNN0COiiYj+rF7Prdis=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-191LT3TmNom9W79_D2EedA-1; Wed, 21 Jun 2023 07:52:27 -0400
X-MC-Unique: 191LT3TmNom9W79_D2EedA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b4795cb42bso29514791fa.0
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 04:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687348345; x=1689940345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bB6oMPP6UoRz76ScLAWWaUZS+Yg66+7v0dNXnQipw/4=;
 b=lD+VNb8zPHUHTzFl56qk5iSOBeYUxW/i7KcOwM1/Ih3qShQiDlmmO+XBiueKv5gJjf
 nfAl+0bBm0aYzoL0VLFhtjtGRRcAubnZlbKShs6j1KrQ2CK14lYgKQfnAe7volPuTtif
 WUbRpq8K7oGIx8m5VnNtvHc2zvOUz4h2urnu8OGbQ9wboy1dvleI4HkSerI06EZBrjw7
 ++Skaivl0Yo/MBDMon3GVQH7UiU7Pfo8287sUqaPotY70Bx7YzaulGilSNHAstIo6vAs
 6hXcSAav9GhUtIFstG6YZgEGir5fG+YycJRMobT3gxAyVfpj9P/b1iNSOTRlZV+BUUvX
 08dg==
X-Gm-Message-State: AC+VfDwYtmqxEBGusX+R1Q8hLfFhaFLCGv45IBOolBgw3PGXO62vmYg+
 iXrteEe1RqvY7v5xSgJw/7Zh47K0N1kNe4hrXnTiBO8e2UU12Tp/5AtZy8jflbNZvJhGIDYCTCH
 qlYijT1YY9NAjJ6m+a/PRb9gU5LE=
X-Received: by 2002:a2e:86d3:0:b0:2b5:89f0:bcc7 with SMTP id
 n19-20020a2e86d3000000b002b589f0bcc7mr723312ljj.29.1687348345686; 
 Wed, 21 Jun 2023 04:52:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7heqAy3RciSFaifA+urBFDxoyF+sMGetUeBVKVWq3FpyZdeuCVxRzjhxpUQsYh+Tvq24HtvN1o31TFKadofsQ=
X-Received: by 2002:a2e:86d3:0:b0:2b5:89f0:bcc7 with SMTP id
 n19-20020a2e86d3000000b002b589f0bcc7mr723299ljj.29.1687348345264; Wed, 21 Jun
 2023 04:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <80595ab205ea7b3f633bf4228bb43ee999aef3a1.1687247273.git.souta.kawahara@miraclelinux.com>
 <7ac34b5102d65e6bb7112234f6ad685e98d066f2.1687306661.git.souta.kawahara@miraclelinux.com>
 <1cca2a5f-64e0-2932-2971-8d7d91e01605@suse.cz>
In-Reply-To: <1cca2a5f-64e0-2932-2971-8d7d91e01605@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 21 Jun 2023 19:52:13 +0800
Message-ID: <CAEemH2dYgefTdWd2VgK5aur9qo8Z89C9CuK=pAT1O_dccOdw9w@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/1] runtest/cve: Add some existing CVE tests
 to runtest file
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Martin Doucha <mdoucha@suse.cz> wrote:


> >   cve-2021-3444 bpf_prog05
> >   cve-2021-3609 can_bcm01
> > +cve-2021-3653 kvm_svm01
> > +cve-2021-3656 kvm_svm02
>
> All kvm_* tests are intended only for baremetal testing and they're
> built only for x86 machines. On any other arch, you'll get errors that
> the test program does not exist. In other words, they don't belong in
> this runfile.
>

Thanks for the info. I look a while why can't build them
as fake programs and only exit with TCONF on non-x86,
but seems it has some platform-dependent assembly language
and the linker rule unsupport that.

Okay, I will make an additional patch to kick out them.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
