Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C31C3DA64
	for <ltp@archiver.kernel.org>; Tue,  6 Aug 2024 09:29:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A4BA3D1D38
	for <ltp@archiver.kernel.org>; Tue,  6 Aug 2024 11:29:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26AB03CB256
 for <ltp@lists.linux.it>; Tue,  6 Aug 2024 11:29:42 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 15CFB1A01925
 for <ltp@lists.linux.it>; Tue,  6 Aug 2024 11:29:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722936580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2cR6Rna1UrdrkVJueMdSmeFNT31dTYVGQv57J4PGU9U=;
 b=GCPO8SANiyJ1jrcESCAPwJrF36DBtzlNt6Bl56Z96iWpGO5gBW6F9GYa4CyvsgW+SORWmN
 8pf+XHaKCqOq/QwLL9lw4WfveJhVbqRyo2SdxaNK9nnErJfW/V3A8lX0M/Ub+I4I0A8Ymv
 Tb44A5c4Qvr7guuXPIl+fUboDRdkRck=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-r69H1ApbO_SP07gHgYwiMg-1; Tue, 06 Aug 2024 05:29:38 -0400
X-MC-Unique: r69H1ApbO_SP07gHgYwiMg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-70d188c9cabso451281b3a.0
 for <ltp@lists.linux.it>; Tue, 06 Aug 2024 02:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722936576; x=1723541376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2cR6Rna1UrdrkVJueMdSmeFNT31dTYVGQv57J4PGU9U=;
 b=DL/5afYxNyDu1Z0aYnw8+9jFBmCFM3iEORws4eK8AqMCMRNjOURQww1JRyCNXs594V
 bovrSsFiHSpQjmXp8buox9CmRkH4BKTlHc9pNccMp2uLkPA0ksPiKqQCkzPf0V7VRqZd
 xCDT1VYIFBGHhpH3hIkojLAkuLTZrnr4AL51ayKMWHp0TaOg6O/GcHldsoMztgnCXut4
 jbe1Xo3JV9GJMfPl77mMJRD3jcT+G7kJ5wq1xq9m4UyiAnkH44mH3zt7ps8f4UcUpxvU
 F1vEIq/mTd7WOvMXfHzEn17fLRmg3P4I9BOZhnWpHeR0gbz+ogR3rj+UBAASG0JZS1ek
 d30g==
X-Gm-Message-State: AOJu0YwFqzCnsqqf2+EdMgiT8aRPHQHD0Cd3S1wGaICg4+uj4iCJQnLk
 uoPlqJBVxL8dZLK53PV7XTEq0V0Vf4PNjG7r37Jzq6EfOE1PMTOz59HSCYj6iwBHrsHLa1C6xn2
 eqpehGO1EEKk9g2hW2VsdHkoGb0zIYzCG477x1Alqnkx6rNXpqG70PiyEzmzvNONQxIzQITaaW4
 yKlSDmbTmPcV1axOyZW28r50e6FCmbEV8M9Q==
X-Received: by 2002:a05:6a20:9f4b:b0:1c0:f0c1:5d45 with SMTP id
 adf61e73a8af0-1c699627beamr791974637.44.1722936575874; 
 Tue, 06 Aug 2024 02:29:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiTUpGnH+D1Fs1xAnO1NzbfbJXbZcL+5ygHtmzBGZq3h2xXw4wF522JwCYB9dvAA+kG5c9uaaCqkMPRlxS9v4=
X-Received: by 2002:a05:6a20:9f4b:b0:1c0:f0c1:5d45 with SMTP id
 adf61e73a8af0-1c699627beamr791960637.44.1722936575513; Tue, 06 Aug 2024
 02:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240805134618.41203-1-pvorel@suse.cz>
 <ebe0aacb-b1d6-4815-b998-388e3ab48446@suse.com>
In-Reply-To: <ebe0aacb-b1d6-4815-b998-388e3ab48446@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 6 Aug 2024 17:29:23 +0800
Message-ID: <CAEemH2dXh-nzXYE1d1+aL5awe4-aPqY6QOyGVpoS0YkvmPpzJg@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] lapi/stat.h: Handle invalid __NR_fchmodat2
 syscall return value
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Patch merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
