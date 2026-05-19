Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FABCD4851
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 08:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779179178; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=GHnQJqK/tk+Ezg3z23FCIjZJ2vUmQH3LGL60BYBjOv0=;
 b=COdClgSs97RekXtgWabp+L90m4+dpWFjbMyog05mqzTwxHdnGLYD939cvRLe66hrZXpw7
 jFsJSFbmjyaV18tKNTlvrT87xUABy0pGAAK8liFluUab+XibzFArNp1mnMV8nuteeaZWv6d
 7zkTPsl1e/CcnyPiEQK39G2yTHlQKnQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1F3D3C5E1D
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 10:26:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 567D63C311C
 for <ltp@lists.linux.it>; Tue, 19 May 2026 10:25:55 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 18E6F200970
 for <ltp@lists.linux.it>; Tue, 19 May 2026 10:25:55 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso18109715e9.3
 for <ltp@lists.linux.it>; Tue, 19 May 2026 01:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779179154; x=1779783954; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WwbFYpoPdCbqmPaekgvQvEvkGYYArTCsKcL2kuGgZXE=;
 b=HNmjtPMhYVzqFDm6TWJesHV1j5Q3ShUwKRPcn77QPvjJiM3y8459nxgPmi696T1oCa
 esLQWub2d6o9zO1/7LXHsmOexWnTXy33G5zhYI9KXTNSqWM9wUvHdVU7yTDppIB+OFD9
 0P3TPGC/xQRSDHqoFCVJ9IQX7rPqV80aNy3RfQpxtfDcb5H95AMY1NxQiS5i1y5EJgW0
 U3S6ZBV2rwVn+lH6RI6VAzTRGLaXKpQPWkw4juJqBm1pKnmooAfpO5wh4tcU8sgZ19my
 vqZA4sfB6Zs+CTtsxBq78r/17nWdz/qjeppRekpN+oed0tUlXAkn+0OY/LDLM+OxRfcu
 d/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779179154; x=1779783954;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwbFYpoPdCbqmPaekgvQvEvkGYYArTCsKcL2kuGgZXE=;
 b=EkwWR2kH3Rcg8jvREP93eoBBerNz6elT3oMpaSrS6ozH7cHePUJ3BC+7Dt5jd48RSq
 fJWegZOpyg7cm+2VJSywwD8hNUQjoD8xySMeWSK9oSQMKtd9mY08f0SX+xwFvSqSpeje
 Si3O7yPxRvPLRgmYus+p0+ZkszetUTFk0dP8DkmtI6X8rCa6CxjRyxhkzooKbIUO1uZz
 XHHuaFj3R6B1yXgYWrMiXRJ25jWi7e/fkAFAwBW92nXP6zrhDCrlvLQoTKSJzeNsdjUU
 sHionr35bB3giEEq6SzEJpeIzhyHRGKGj692bU5m0S97zQ63WmrLKNwdLyKNQOhapDoE
 FhmA==
X-Gm-Message-State: AOJu0Ywb5xNWwkMG+EZtO8MCVezokXBD8ZvG5X65ySx2oO76czC/GkCJ
 PyUO42Cv8lUH+z32sM1P/KOfprg4xf2TyYRQHsh6IxFLXPwslkq8NIo9LcbBpdKP+EI1Wabqf0m
 rdvnwLsvbfpyg
X-Gm-Gg: Acq92OGUXhedNcTRp98ThuiI6l00E31+ORtIRU098CqW/laAvzFUdb4JiHkYWJLGcHB
 qJTUjC2IsV5Pnp0e0pR6GenwhjMaA0hX/QMAreJwG1a+6GPB3WEzwZ4FLMEXt8syaKcKCH0G/qH
 3HXi7RyvDkDsRy0d9rJThKCQLvZwQ9zCwLSpvun+FWomRCIRzwvsI+qgU/dz6foEOyqsBP82JA0
 p+0vWimR9DRGbV7A1fPBSyIQS3geIeH1tlDX8WQucWUqGX6Xsf2caLmGh+FY5tZ0HFH8hQXejQa
 ll2S4KmWVJaZNsfHQsYP8MReDy/MgkpxcFw5Z1Teb9gIuQTEXsEIsox4XiUkzSTSAMSK6VLd7dq
 edpNM7Kp/Eg+RjcEgLnpjcoPkRrjwbDAjqyffd9IQ2+IocV9POb2/Gtv5ZrFwhFvNFbmLDI6zfO
 v2a8rT/Kpaavulm8VS6i8w0mBach2XxOX0yhQulCLzgJ39pPddBZN4BDDbXp9udTrMrP3bS8AT
X-Received: by 2002:a05:600c:8b45:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-48fe63253f3mr273768735e9.21.1779179154351; 
 Tue, 19 May 2026 01:25:54 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4dac000sm317510325e9.0.2026.05.19.01.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:25:54 -0700 (PDT)
Message-ID: <6a0c1e92.26e4f91d.2ae5ea.c144@mx.google.com>
To: "Michael Menasherov via ltp" <ltp@lists.linux.it>
In-Reply-To: <CAHGiOXcxLaTPhwAUKqtpzEy=O3q4DWaduK0BE26YhspHTrDuvg@mail.gmail.com>
Date: Tue, 19 May 2026 08:25:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] futex_wait06: Add EFAULT error coverage test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: LTP AI Reviewer <ltp-ai@noreply.github.com>, ltp@lists.linux.it,
 linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

>   Hi,
> 
>   Following up again on this patch series originally sent on May 7th.
>   The LTP AI Reviewer has already approved all four patches with no issues
> found.

Unfortunately we didn't have time to review the patch-set yet,
but keep in mind that LTP AI Reviewer approval is not a certainty
that patches will be merged. This only means that agent didn't spot
major issues :-)

At the end, one of the maintainer will need to approve the review
of the agent and sending new feedbacks.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
