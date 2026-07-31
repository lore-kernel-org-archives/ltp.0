Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02AEC55167
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 06:15:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D484E3E2D1D
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 08:15:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AA7B3E2A65
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 08:14:49 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B3E766008A0
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 08:14:48 +0200 (CEST)
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-93108a3c326so98245885a.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 23:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785478487; x=1786083287; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3a3sJR1oxOqCDQ+1WZpDkCAgMd+5B+6Lq/PPB/Y3a9c=;
 b=AmLcQzD6LcmOcvljrwqtmqdaNAu5YFZenOxEJ4albyJfbBAF2/reMwbZBYmDKU6bHs
 Hw7YdulaWBEF2bdjz+CREskbiUpW6AXZdRGDFpMMHevooYEEjkPYH13fUXaXJIGdwYMS
 2eRiD5QaHM3fb64YQFMBRFmnhCK9oyrSOyMH12D+WN+FV5RCYp2qLqplZoagmWxG56+x
 DHBCYEZQQ0K0GRKbot8QcrkPScjp5RzlrW9Pt9GEGuz+8Hk4QYvaerYZqg2GpN6vcKBl
 5MivzMXdlYJXHxEwiBfx1C8xCGT2YundZDt8BfGFLNtxkH2r++aOq10ZUwscfYIqWuVd
 Sfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785478487; x=1786083287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3a3sJR1oxOqCDQ+1WZpDkCAgMd+5B+6Lq/PPB/Y3a9c=;
 b=rBeVPyymmebPNof3HuIJcNjbHMdx5+/GDiyK2LQpK82XLM62Jtn+lTELdvn+5HbY6b
 JJ3CtBMNbBtwXtsI1TcDsYKi6KgefIxCdu7O127uESHKtH1HzkEa70LCkOev7l4D6UZt
 XyveNX2wGo8ywwsMb84ftUGrmJCK/b1/f4+S1sTSwjCgdiWwbihvK6xGjkvIyS42oUnQ
 fCFC5Gp7I+4hf7l1o1RNopd/zQUCRgJXn7GxlVEaDIlE2oDf6cAnRBcpCt26Q/ghebpb
 rDjCvkTs6l8c8kSK61a3CPQGcnJpfdAsAHzOeeRg1owpAGYK4iDDDBKp9dkad3TvKUJ8
 lGbg==
X-Gm-Message-State: AOJu0YwQ2XSPpLhmeb3cZ8jxaU1nZ3TnSgMrtVppa6nM8q0altnHV9jK
 HFXtGKmxS4ULBUzRy6pVszBSfgPWZqel1UnSjETBzQ25L62tIpeiIsmf
X-Gm-Gg: AR+sD11kmFjK22RwpJyxx2PW1kzF9uPC2fVCmhuThzkqA9uiHJr3SNXeuCKf0fdCMP+
 lRFsiKANXVxeFE+oSXOzafEBb7I/NwRPJV04f0dhMrrfE1mmecmOWrJq1yJy+CRyR3xIX9FT3If
 UItgCqBntmd1c8gB8Wqeh4RAtntBvtuWMJinUunu3Rs1YygVgFFoW/NCOq8FvOT69LHMLiXw9RC
 sFe9ArmCU+5G6ridpR2aY4aj4i8/1/WaFu4Vy6ThO2qV9bQhbErFEA4kgd34bILb7NDi8jRXESc
 DUrXLhDn49S+//jtG92R+Fnkb0IUc8TstLY0sthFlR59LnxTcGrdFPPnSjIw27ZVszUVlLRT+ef
 jITky1JAkPWJfbwHaLXmfEoxq2Q7Nt9boLT1+pvS2H+qgsxYtFM3C2yuYwVuS5c6O+xEKNbIzob
 lq4v8rly+T7NWT1j+ono/l8AwznEsn+PNZvbO5bkR096X2e10vdsVBm4X5D4WZso7chhxCZDwjH
 UduG8Z2pO+yhojZUC3PFljIgKQv1cabVaOXl1cGgGqy4yQvrl2wMXaJ+9axnddugPDzxLvadLw9
 2XU=
X-Received: by 2002:a05:620a:708d:b0:934:8f0a:c68e with SMTP id
 af79cd13be357-93497427602mr55410885a.5.1785478487339; 
 Thu, 30 Jul 2026 23:14:47 -0700 (PDT)
Received: from
 runnervmvrwv9.43bcwkqot5wunoncdo4jh425pd.bx.internal.cloudapp.net
 ([172.174.157.134]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908434a26basm3711956d6.12.2026.07.30.23.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 23:14:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 31 Jul 2026 06:14:46 +0000
Message-ID: <20260731061446.4022-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731054548.133241-1-pvorel@suse.cz>
References: <20260731054548.133241-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Switch to patchwork.kernel.org
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

Hi Petr,

On Fri, Jul 31, 2026 at 07:45:47AM +0200, Petr Vorel wrote:
> Switch to patchwork.kernel.org

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
