Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0844FEEF25
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 11:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775561995; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fnglgVBsBcoYBmYBfJCM3OKzGnmEkKGY8Ehz6Y3m4fg=;
 b=e48puq/oztZsH8PXqEoaKvjNtUhbfrHU7HBj/vwNSuO6jQjrsqztQhXoIrDwTi4+mTz8i
 JQxKDPfb+FEAg33juQakbUCDjhmZnIltIcjPRhFprVaoCrK3yz63Z/Zf54OUfHNTszp8Ur9
 5OGUIPdOoDm2/iCueckrX7q/wuV+WSk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42CF23E26AF
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 13:39:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 962DE3C1987
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 13:39:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 43635200777
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 13:39:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775561966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uqGgVUekWYuNLVyfofKvJj/ZNO66HbIsCRhFREdbPIA=;
 b=QMdHC+DZQ/zsNmQ+URBxU236theMZX5BeNVoeaN8hG/Zl4ef83q2n8fVVPpdyGVWBZjWpm
 e/ijHoE5fIYJcmkn75uX5ObY+b6Yk4ByuuMafrhsKQZloQfq7zAoDNL2zisOw0EIywaENI
 nMeHjIFdTqeq5rwiBImFcTNuoCE73vA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-edJHnnZGMj6Xr29jXUf9mQ-1; Tue, 07 Apr 2026 07:39:25 -0400
X-MC-Unique: edJHnnZGMj6Xr29jXUf9mQ-1
X-Mimecast-MFC-AGG-ID: edJHnnZGMj6Xr29jXUf9mQ_1775561964
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82c714cb672so2566425b3a.0
 for <ltp@lists.linux.it>; Tue, 07 Apr 2026 04:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775561964; x=1776166764;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uqGgVUekWYuNLVyfofKvJj/ZNO66HbIsCRhFREdbPIA=;
 b=Jz5QizedzWOtwgV2nH77ArMA/75PJizwWyMRYdoXjR6dbsFTfDOQCn3JAsSF+1cDFl
 TlYkvH6Z0hLoEOJlMsi5thLWUzUtuLGRLK4NU9qNCszLxkDwpymzC8zd+MmKiGYKTq2X
 Jut8j2rsXdSAjDXthZRO9wqQchJxCYDA315kioJIEtzps2K0djfYsDi/fNuMAhgRHEDj
 BPWVgV87ZQ7zSI27X7Ak84Qi7W1KYTfTEQK+eSpYBSAzrAo3JgOvXDMCxNaZbwe0pDsK
 kR1PviB8zcLZuVoSNFVFBrSptdNjjse92K9XW7HcsGqj8h8oUPKsA5aItPAcsemx09YN
 Z9uA==
X-Gm-Message-State: AOJu0YxSoL1RLT8YnGfiW/M+Mgu6KULt9ZFz/1ETJjtykavWIEPCSiCe
 U2YNyNqsk3dNSdCAP87y64WvukqAH9is6szYQLy4Oc3nzkKdBMsVGVBsfyVCpaAS1GTAb+srTe1
 5BkUSXI5TD6/RYMEO0Hpihd97VoZaPAhsImzttopZsHcYwE/Nft7H
X-Gm-Gg: AeBDievuxl5Qe63EKgG0r25Y1uyDnL2K8iGYoJe6pfi6T5u3x0TIQEKSYNtR8VPxNNM
 Q4iQJfAcZjC2OlC0xfUVCb1pJxL+45hA1YM49jH7b0wikYQY0eBiQm2AK2qmJ0dBiFI03dpj5Km
 dgn0fm56aKhjnmubpQF0IzhBgOzQWUeVqVKMOuk+3qyrlxNHX/VkHXj21KLP2+IGm3JcTjm6X29
 siqAhgBQ8v/DHE+9xliARiJbZZ29g4v8l4JK3yoqJiYV2iCpM4W3SlePRfoI8Hdt/ywy53GSUM9
 hUawHI62QQyEl1x1jcYNnKbn2INubHLngJLQV/cN7C8Z8zjP9bw4LGa1wdTgAHJKGfGUOH738m1
 owlMjNi5NS9HTknLNKw==
X-Received: by 2002:a05:6a00:808:b0:824:b181:f492 with SMTP id
 d2e1a72fcca58-82d0dbb0808mr15332594b3a.45.1775561963950; 
 Tue, 07 Apr 2026 04:39:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:808:b0:824:b181:f492 with SMTP id
 d2e1a72fcca58-82d0dbb0808mr15332582b3a.45.1775561963462; 
 Tue, 07 Apr 2026 04:39:23 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b3dcb3sm16897144b3a.16.2026.04.07.04.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 04:39:22 -0700 (PDT)
Date: Tue, 7 Apr 2026 19:39:19 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <adTs52bG8FpUVhFD@redhat.com>
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-17-chrubis@suse.cz>
 <CAEemH2c5OfBhcR_KB6LY4yJdxAUDR7HbWAf-V0KjiZMN2Jkarw@mail.gmail.com>
 <adTWHgQO2gLj_bXX@yuki.lan>
MIME-Version: 1.0
In-Reply-To: <adTWHgQO2gLj_bXX@yuki.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n-LEbVc8gfQmXCkCwDJAUFbpZptTXeJGnc8upz5xxcg_1775561964
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 16/17] lib: tst_test: Remove now unused
 needs_drivers
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

Overall it's good, just minor polishing below:

> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -511,6 +511,13 @@ struct tst_fs {
>   *                  and parenthesis are supported, e.g.
>   *                  "CONFIG_X86_INTEL_UMIP=y | CONFIG_X86_UIMP=y" is evaluated
>   *                  to true if at least one of the options is present.

> + *                  For some config options their presence in the config file
> + *                  is not enough to assure the functionality is present or

  Merely finding a config option in the config file does not
  guarantee that the corresponding functionality is available.

> + *                  enabled. E.g. config option may be set to 'm' but the
> + *                  module may not be installed or functionality may be
> + *                  disabled on the kernel command line. The kconfig library

  For instance, an option might be set to 'm' without the
  module being installed, or the feature could be disabled via
  the kernel command line.

> + *                  has a set of additonal checks for a few config options that
> + *                  are used in the tests and need additional checks.

  To address this, the kconfig library implements supplementary
  runtime checks for specific options required by the tests.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
