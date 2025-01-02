Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB23E77188
	for <ltp@archiver.kernel.org>; Thu,  2 Jan 2025 06:42:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90E2D3E24B6
	for <ltp@archiver.kernel.org>; Thu,  2 Jan 2025 07:42:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0BC63E24A1
 for <ltp@lists.linux.it>; Thu,  2 Jan 2025 07:42:35 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D0A7022C399
 for <ltp@lists.linux.it>; Thu,  2 Jan 2025 07:42:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735800152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+KNohO0Z7QhK68hVthXXCcIHqcOSBo2e7FIVfcfMyyo=;
 b=M3y6ENszXiHRHsOTSFz6xIYIkFN/U0GoTXxl28PsGYk5ZAF/w5obFDKkZSOAhqRqqmwhrV
 47hX9c0PWNkjxhaHKzHezgV5Lnf7AzzX1eKsFMZpmcXdCn2GCFS9rsiBWF6j8qFwi3yrSJ
 rvjPpE23LnzGLrvZfVzm4W33mPQkL08=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-09BP3N-nO-Smh_-hEQRIFQ-1; Thu, 02 Jan 2025 01:42:31 -0500
X-MC-Unique: 09BP3N-nO-Smh_-hEQRIFQ-1
X-Mimecast-MFC-AGG-ID: 09BP3N-nO-Smh_-hEQRIFQ
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2efc4196ca0so14798155a91.2
 for <ltp@lists.linux.it>; Wed, 01 Jan 2025 22:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735800149; x=1736404949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+KNohO0Z7QhK68hVthXXCcIHqcOSBo2e7FIVfcfMyyo=;
 b=l+9i7q2TAhXnJCALq9uZwOqxUWkvUJLKkrCH6U0gGFdvuEqLUpCliddOoHVBiQcQPk
 pbi9GzifgxZclkeYKXvdw9Awn5e8bfEi0AuCo4OutGHkeNL2zNdRIcHC/2a7tHxehyQg
 epy2gzZ61/ho5tQorZBDu3mdTELspEtnCBCaGV6pw45/s8MrD5zzHf6s+2JUKLoX8qgp
 YTy8fNos8ieKGJIXYtvF6o+N/1/W/zjJelstTPcOzwAojU9mNcJY0mh7m3YBI9T5WVJp
 hVMf/eW3BDinj77gW6brpQpDxkLhgLSuoNq5G2BO1o0ROiYCWSlnAHKgvR1UW+6rtKlG
 KkZQ==
X-Gm-Message-State: AOJu0YwEUPHQsP+N5uAkPXxEq9+t+6AIURWEVGbEb4maUJ9/fLZRDo15
 RWd9U/4GTDckILljDB6kkIgBxO3zN9rrebfZr42ID3JkK568WFLIx/pkoS1psBWbAGiwNSsnA/k
 UeJAFMJg3zC6lXWojkMIMAPky1Aq2BkyHDjjfVNAvN8GbkuqeMC0P1AEUl05F81d4SZPk6DYMnx
 QuZblnIZl0fj5xsxTjuawZE8OX24+EGVoZvj12
X-Gm-Gg: ASbGncvxULLxDrqXjWQGehQT7BM2tJ0NcpKFSKwNZgvofWdy4h/fZNU+1sJMbjimaRi
 LQpvVQYIqqRNALDSebnD05N5LHmoKpN6oNaXQaGk=
X-Received: by 2002:a17:90b:2d4c:b0:2ee:c2b5:97a0 with SMTP id
 98e67ed59e1d1-2f452ec290emr61559003a91.25.1735800149140; 
 Wed, 01 Jan 2025 22:42:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYCfQJ6Fbi4N3K2hanWwI6mpmNTQjC/q4KRS0eoDjp/2ymRtAuKU4FJitwkrpnY05I2kh60V1gdsSfpH9NvE0=
X-Received: by 2002:a17:90b:2d4c:b0:2ee:c2b5:97a0 with SMTP id
 98e67ed59e1d1-2f452ec290emr61558995a91.25.1735800148805; Wed, 01 Jan 2025
 22:42:28 -0800 (PST)
MIME-Version: 1.0
References: <20241231115607.56105-1-pvorel@suse.cz>
 <20241231115607.56105-2-pvorel@suse.cz>
In-Reply-To: <20241231115607.56105-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 2 Jan 2025 14:42:16 +0800
Message-ID: <CAEemH2dUU4JNNxL3Gxrdgf-=_DPWW=Cbb-2AysWi0_BLc3yDFw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iwErZlEPY8xPkCfZOmHEs2JZ_Tp96WFnptgB13OfHVQ_1735800150
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] lib: Add helpers for module signature
 enforcement
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
Cc: Po-Hsu Lin <po-hsu.lin@canonical.com>,
 "Ricardo B . Marliere" <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel <pvorel@suse.cz> wrote:


> +/**
> + * tst_check_module_signature_enforced() - Check if test needs to be
> skipped due
> + * enforced module signature.
> + *
> + * Skip test with tst_brk(TCONF) due module signature enforcement if
> + * module.sig_enforce=1 kernel parameter or CONFIG_MODULE_SIG_FORCE=y.
> + */
> +
> +static inline void tst_check_module_signature_enforced(void)
>

This function is used to skip tests while detecting the signature
enforcement ON, but the name might be ambiguous somewhere.

I would suggest to name it:

  tst_check_module_signature_not_enforced(void)  or,
  tst_skip_if_module_signature_enforced(void)  or,
  tst_requires_module_signature_disabled(void)

Otherwise, the whole patch set looks good.

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
