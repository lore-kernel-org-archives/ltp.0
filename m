Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FF4C2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 12:52:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ED2D3D3948
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 14:52:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A555D3D391C
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 14:52:18 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0AFF61400B8D
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 14:52:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720529536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=svdFDJs2g/WFSAVd3T1ObrRMyn+uOEivdo16ASNJqRc=;
 b=b5hpK2X4TSrY/3vLPr8/hJDuKyQFDLlkTmw74bxkwIChbX3dFP0+PzGz3TobuJHFbGNN14
 /Xn1x/HdLIyAYvp07QmMhjP5icJQ9UFHlaATSD1D8Wg10zCcEiYQm4Ys36Qw0UB3/XyRXv
 Qc1xMIt+qhXTfTnQC6gcSDsy4J/VJlc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-mhJvfwO7Ncih0Jfd16ZY9w-1; Tue, 09 Jul 2024 08:52:14 -0400
X-MC-Unique: mhJvfwO7Ncih0Jfd16ZY9w-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c96a0c27fcso3805183a91.0
 for <ltp@lists.linux.it>; Tue, 09 Jul 2024 05:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720529533; x=1721134333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=svdFDJs2g/WFSAVd3T1ObrRMyn+uOEivdo16ASNJqRc=;
 b=FCJtI1jAZRS4L0LgALPwMFdzLQbIKKrvsDsF3utNndIbIqkqUh9If7Y3xtXcnGq3JM
 ttCEiDdbHRkIsXjnYh9U1y+1NPKqgC+CC/ifVZgJvAAk4MEoFWJ0CBN5KtHIHQlqW1iy
 MoyanFiGOdWoFP4uqiH966vY7701tHvdHYsF5997E4bzvCmgWhMaueNNLOo4ePSNVhgZ
 jPL9OpIxPb7MB9D/sldjd4e59ZdDuGRGibSJg3IULrY26gKpAeOphpR4qQXAMT1SP1cS
 82eKmo5cZvl6pBsMqlLdE8a4uMBWkn18DSVCEUql9eyovjf3wEh8FWbT8vQIqKU1eAME
 ilHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWtED1xxZ43eBb/pnuTwlaIMDsfuPd7Ujc8oDa7a5H/WjpIJAqy55OGNT9xcSiDPIX3PPR8DSo/3Swel/rSvl8ckE=
X-Gm-Message-State: AOJu0Yz6Ou4zJGNV+O2BNXx9A3qhsXha4JuBdL6aw+34jF8eiqQto1I+
 cjZD7rAAs91DT6wyplrD4+g+CKtplgHPeQEW7cO3SUvRxoQTltJ9A8HoDFInxyr9k8rb+NQ5ZFo
 XIUgX5kpAlN1R5zLLBVcih4Mqy4YGWRgyYOigxv4mCuVv7EsVM8nb6NrjeT6Ze4JQnznVfmB1I2
 DbwseMmVGNY3eQNKBejN1qf/+WmQQl+DwOuw==
X-Received: by 2002:a17:90a:c097:b0:2c9:6cf4:8453 with SMTP id
 98e67ed59e1d1-2ca35d392e0mr2131824a91.31.1720529533108; 
 Tue, 09 Jul 2024 05:52:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJvMkOBx/upqSrFg8ppvTiyZTn5x//xAI5AqoKI7vkI2w+XSjLK3m29HfijAhpgxoGb4WQUtdyVDT3F/GrXOg=
X-Received: by 2002:a17:90a:c097:b0:2c9:6cf4:8453 with SMTP id
 98e67ed59e1d1-2ca35d392e0mr2131811a91.31.1720529532767; Tue, 09 Jul 2024
 05:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
 <20240709-stat04-v2-2-2693a473a2ab@suse.com>
 <20240709124830.GC198566@pevik>
In-Reply-To: <20240709124830.GC198566@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Jul 2024 20:52:00 +0800
Message-ID: <CAEemH2cHVu9ZX55qUzgL7PBwQ=FHJLzE_i+zi+=FaZemChTaGA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/5] Fix TST_EXP_EXTR() stringification
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

Petr Vorel <pvorel@suse.cz> wrote:

merged this commit (obvious fix).
> Thanks!
>

Thank you Petr.

I think it's safe to merge 1/5 to 4/5, but yes we can wait for more
comments if you like.
(Only 5/5 has a tiny issue I pointed out there)


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
