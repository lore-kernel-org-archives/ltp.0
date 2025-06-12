Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035E9C61CE8
	for <ltp@archiver.kernel.org>; Thu, 12 Jun 2025 07:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749712749; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/5PFc4uzGfdkyJ3mG1szyz9TG3PxQ+8p3ppJtH//Q6Y=;
 b=nfgRBem2HVQBk8fH179XR/E2vunAqPyQS0BAe+RKD+U8NPAA21lg8jcNcWHB56wa9MEUS
 2CR03hLModvjsv+pm5pljo9sjDl19GN/dOhH2vzOcyqzEtqRbFtbqd32cLJJjXiaDA3D1je
 UNDNUFdLcgLgFPk89zF/5nDrJxKapsA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35F083CB314
	for <ltp@archiver.kernel.org>; Thu, 12 Jun 2025 09:19:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 645DC3CAB6D
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 09:18:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A45F460004C
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 09:18:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749712725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6YoWbrLtocmLlQlAeG+yHYR96UJ4Z665gS+z4yIgmes=;
 b=dDUkTZ93AGWBfMxH3veawlcTiafPFz+TAlNRhysVhE8PIk5KqVd2Ts+/z/hD2jmhyJBvHm
 L5b5qG+3V6yjZwZaH7iTKbstWdSDQig20bM0n87hlwn8WraUQdtKACvcmpU9VbTUp3o+cX
 C8g/v5X3CfonfrXBmMcJ6UBOPcx3R20=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-kcHYwJWVNNaJYc3oi1Gvqw-1; Thu, 12 Jun 2025 03:18:43 -0400
X-MC-Unique: kcHYwJWVNNaJYc3oi1Gvqw-1
X-Mimecast-MFC-AGG-ID: kcHYwJWVNNaJYc3oi1Gvqw_1749712722
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-310e7c24158so687177a91.3
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 00:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749712721; x=1750317521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6YoWbrLtocmLlQlAeG+yHYR96UJ4Z665gS+z4yIgmes=;
 b=uXbV3Yu0XV4yLQthBUEwkWruF+vh2tSs926dMGgf8b4V7J1OICjoSHslI/eq4eeSR4
 7iyRXcaMtG3YXJBhrMRTR3Indlajf1ZguUQUyXnv1ElZ1XNeDux/eztn5tOK6wB2i89u
 rd6wJ+hO264usfPDToWt8Nx75lDNzqXyxYvaa+EwgOogLdAGLkYOiUyBuRZX7ytKCn6B
 MlyLjt/DoHRlmDU019d5xKM+OImMqNFQY0nqjIxKTZY67BfEJcHqJK8t1GWMa/ARJ9ou
 2ZFZumLgME8zfpvy2fFkTQz7+grc9s4dFc4WFt4C5zl2D5GqwDWC97FtMk+dcxKMoUVt
 FqVA==
X-Gm-Message-State: AOJu0YyhS7M5/4X5JLA+0MpUoogC628IxAQhxN8XBb9JAGPvk1a05gZu
 Niv3nYreP+iMShPsRbBHYeelmOw0e1/GlB/pyfYxaHmrS4V+OxF6b60Re+wwgStF7loOAPNfbpd
 IQzMoSGosp0TdUtIubROkCW4cFrHk+mkeANbH49binfeUejgQyQqatGEjrwJ3NpATxqV9ZTwzY/
 U5ar8bJ4BoB1s/Q33cKLKQhLgUt2H5h76x8qha2Q==
X-Gm-Gg: ASbGncs4fdMVEhJiC0vEjLTZBP8SDeu/w5VQumhqzYt6nImyV6evSKdm8Qj3tKfA/Oh
 z8Ly0st+RmL4uWO8cFJEV3rXUSJ3Lel5hq3pAiHkOxyS3BYR0fZZv2Prlt8CRZsAZK875IqNwQQ
 veq2gP
X-Received: by 2002:a17:90b:274e:b0:311:afd1:745b with SMTP id
 98e67ed59e1d1-313bfb6768dmr3616471a91.11.1749712720898; 
 Thu, 12 Jun 2025 00:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3nuHP4FqgdUrWGeEGizKnHRo/Bshv/SWYbT32NacAKFs1S7vmS5E0ZdV99WOmoecM3NXtq5Q1QfaFUW0a0Kk=
X-Received: by 2002:a17:90b:274e:b0:311:afd1:745b with SMTP id
 98e67ed59e1d1-313bfb6768dmr3616452a91.11.1749712720520; Thu, 12 Jun 2025
 00:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250609124506.1454420-1-pvorel@suse.cz>
 <20250609124506.1454420-5-pvorel@suse.cz>
In-Reply-To: <20250609124506.1454420-5-pvorel@suse.cz>
Date: Thu, 12 Jun 2025 15:18:28 +0800
X-Gm-Features: AX0GCFuYA0cs0GkWyE2oJm00tkdcSGEepT4XUWmsmrXC-d7OfF72BYu34-D-X1o
Message-ID: <CAEemH2daxDgyXu2Hm4X7qaB+UDCP-A3g6Z7p7-P4NbdhBpLPtQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YzKClho-pZBLSds2B9RLOooYFZerwGETz2wZXZ_7Ug0_1749712722
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 4/4] shell: Add shell_loader_setup_cleanup.sh
 test
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel <pvorel@suse.cz> wrote:


> --- a/testcases/lib/run_tests.sh
> +++ b/testcases/lib/run_tests.sh
> @@ -10,6 +10,7 @@ shell_loader_kconfigs.sh
>  shell_loader_supported_archs.sh
>  shell_loader_tcnt.sh
>  shell_loader_cleanup.sh
> +shell_loader_setup_cleanup.sh
>

One more word: With this shell_loader_setup_cleanup.sh, which contains
test shell_loader_cleanup.sh, maybe we can remove the latter one?


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
