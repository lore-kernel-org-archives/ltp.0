Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C66EB64DC
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 12:49:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE2D53CC05A
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 14:49:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 953DA3CC301
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 05:33:22 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 189C71000D09
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 05:33:22 +0200 (CEST)
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-668842bc50dso331211b3a.1
 for <ltp@lists.linux.it>; Thu, 29 Jun 2023 20:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688096000; x=1690688000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jM/AUq/RMEa5c9tqz/HcfbKPNY5hIFG9GawyK28aaDo=;
 b=I14MZ3+iveLdwE4YbiK1KkbLFJRv4QCRs6SENdXvswCmqsROI1n4zIRSJo+zgrtj2O
 LKkFF0YognTaQUo9Own634Vi2ZteobJSDFasgP0aXKqAhr3h0eQzLYQujFerINpIFvg8
 qw0knzJwi5MIu3gHrXAeN6xHUfLXWqsJzNm9wvbkfHbJe/ZbJQfsudk/u1O37DNQkn1q
 dPONlxKr0fEUHT1npnzAqcdGLXN1aS93VLTNmH7PgKiNgleTVYbq5YanydgLOuVxp3bx
 bk5Jbc35QWN2ZD8P/maNEafOica3az+BoElPG+A6+Q1evoIoY7R3MyAxhoE88laFXXJE
 ecTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688096000; x=1690688000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jM/AUq/RMEa5c9tqz/HcfbKPNY5hIFG9GawyK28aaDo=;
 b=FHOd5tmgfSxOhmLdGzrt3l9x2211syuyoqs/etlMGSy7VPI1NNhxVAUaMKP4mUuf16
 qmUXHT2fzncPEhKweSJiptgqAoOQJQuTke+i99qGKJnmu/x8pHy72qgp02HB99PCEweh
 mJEdRTEhHF+VEmIDeJ1gWWSY1ZWHSZDdHdxw2+b7ano3Wf1i87zkRLxLkqGGtND1qgxa
 RMjARy5nL/11OML/HBpNCGqCacNkzfoSnYFE19tQ9NY2FQIGSY2He/bzv+iz1OIc+ufJ
 ztZlWN8g1YdPZRqjzDs5FKJcOS5zqWh30PyOk5wMiqs3L2hXRMWBMCWdIx28It01y1uu
 oZqw==
X-Gm-Message-State: ABy/qLbN71DV7vFyiKzqw3KLKEMAphs6FZQiJ85iKsAqu5Z1B05EuOVh
 XlgEx2AOit4l90qd4iikbWw=
X-Google-Smtp-Source: APBJJlFkj6gEDy3AZXrqSAMF0josj+9BhNnXNj8jTPfmdg1Stpm1eSzwg6Snr6vyEFyB1gW0lB7IGg==
X-Received: by 2002:a05:6a00:1f90:b0:675:8627:a291 with SMTP id
 bg16-20020a056a001f9000b006758627a291mr1808226pfb.3.1688096000400; 
 Thu, 29 Jun 2023 20:33:20 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
 by smtp.gmail.com with ESMTPSA id
 c26-20020aa781da000000b0062e0515f020sm9010683pfn.162.2023.06.29.20.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 20:33:19 -0700 (PDT)
Date: Thu, 29 Jun 2023 20:33:17 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Message-ID: <ZJ5M/aHvomJEUyox@hoboy.vegasvil.org>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
 <20230629110648.4b510cf6@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230629110648.4b510cf6@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 03 Jul 2023 14:49:15 +0200
Subject: Re: [LTP] [PATCH net v1] ptp: Make max_phase_adjustment sysfs
 device attribute invisible when not supported
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
Cc: Linux Kernel Functional Testing <lkft@linaro.org>, netdev@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, lkft-triage@lists.linaro.org,
 Nathan Chancellor <nathan@kernel.org>, Saeed Mahameed <saeed@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jun 29, 2023 at 11:06:48AM -0700, Jakub Kicinski wrote:
> On Tue, 27 Jun 2023 16:21:39 -0700 Rahul Rameshbabu wrote:
> > The .adjphase operation is an operation that is implemented only by certain
> > PHCs. The sysfs device attribute node for querying the maximum phase
> > adjustment supported should not be exposed on devices that do not support
> > .adjphase.
> 
> Richard, ack?

yes

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
