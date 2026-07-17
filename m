Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E7CC44520
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 13:34:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C2323E76B3
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 15:34:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5497B3C6FBE
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 15:33:50 +0200 (CEST)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C96F51000A3D
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 15:33:49 +0200 (CEST)
Received: by mail-qk2-x01.google.com with SMTP id
 d75a77b69052e-51c1ff471c1so29598431cf.0
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784295228; x=1784900028; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rtVsBRftYYZu65z/RcTlxlOyDFmen4WhNk16/Ix4kZo=;
 b=HyOwgZPtfQm+1uO754gDvHZ8WkIo008hvOBKtXOGKu6bJZivrDwwo7FwasZp2eZCu/
 QDwoZ8PziGdeoKET5PTWPC+x8GPRi33wlqE/F+b34EO4HMBgjT9zVigeBSuPk1DLX2vI
 wipQ0hRjCGsTzj/4jCMVr7AW7lvlDap0XbN1wcp9pahI7NjJ3vgxsr/aYh60aweUOnuy
 ujwBHc6PrJiEQwX24fPM2lYOnQiNSL/kO0NmeI3eg1iIG8hjOeedZ1d4a9hln3g6PnjK
 LhE0CAbacsO2vQnC5HC3MKaBbLLr/7Mj1lJozHpzgMBPf6/I9LwgjRg1wZTTRUm0zPyf
 EXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784295228; x=1784900028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rtVsBRftYYZu65z/RcTlxlOyDFmen4WhNk16/Ix4kZo=;
 b=Ek/bfOB+yN2hUu4R1HHuvCqRgL64a4TVrmWfnhY9Rk2pg8GiKU5R/PSyu9ZF0jO0Vu
 BvMv8vbw33r8wBWb5exwOKGQmP83cuDX6zB8WkDVLbR1Z05WrKTLXSXJ9527uzACdu2l
 rFe8A7zKjrnSgZA3aKZJmYUa5AVTla40QaDMIHjbFiai9OmQhWm2PtviTs2JuEbccTEU
 2lC+1WO5o6m/S1N7TFPAhiafGjJrc4cq24sKXPTNNjQ20S0TMyjtvG9VEVSit5q/UGdO
 qT76iGJsnsnt1cI899Bf96EpCjxdaasXn3ooDCAYlXL7MloojHf+4HVss5BKZDgj0WeV
 PrsA==
X-Gm-Message-State: AOJu0YwnLelLzE9Y43UUDHzth0HL03IqKPHl/SRycu1tfeuLMOP04YFR
 2wK9OpnrgXGj2xHewK+2rIq11a6NwiwGiaWzNKTuHqjiHQGVsQDRRSX+
X-Gm-Gg: AfdE7cnGL+PLbee7YHcK1FHfXNo4fyRTBD25IMWC9dBLXMR+fDo1WjT3Nhz6PRcDhqe
 BeMsdkhDHDalelcSrLMj4ajsvxdkVniPsK0dQmjtNdggvun+n3rK+BK7xGCiesAZxNCCaMnVCsv
 jA9YbvXuaETAOtny66EXUY9GFMNGWszbBoj9bYI2AQn5ijCwYw4U7wTV70aujYZJdXj1NbewU6l
 cSKKtjik6+jLiB5jmtu2ymvhgS2tVnV3IdGnpTclZs1/Ejwjz9an/ie/BXQXMZpSyUl69MrChIu
 /9UNtAJAv6HfqMbsHrjFn/J+uoCRKkbbInMRtuyUxDQxgKCRny0vc4rO2gyR6NFqLHi/1daXJRM
 RTI1GhVo8+p1pLLCZMQiQZk593p1xPJPRsz5FU8MZGFBWJUIjbpmyFodnYKqnVndKjfxpcapUfp
 YKHBexvDd9yXQIJx+2swyzPQHjMDROZA50uEqWwvk5SETsFN7OfNIjSeiiTz+u8/HpGD5XjhtCz
 zVFPgXx4wyVxNhnLI0=
X-Received: by 2002:a05:622a:206:b0:517:8f98:aaff with SMTP id
 d75a77b69052e-5213daa206emr23252061cf.49.1784295228519; 
 Fri, 17 Jul 2026 06:33:48 -0700 (PDT)
Received: from
 runnervm3jd5f.1ulu1jd0ufcuhdc2rce11ouqxb.cx.internal.cloudapp.net
 ([145.132.100.89]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5214d2896f9sm11782851cf.13.2026.07.17.06.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 06:33:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 17 Jul 2026 13:33:47 +0000
Message-ID: <20260717133347.4009-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717-fix_core_library-v1-1-c575fcbb2cb3@suse.com>
References: <20260717-fix_core_library-v1-1-c575fcbb2cb3@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Avoid loop_info.lo_name buffer overflow
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

Hi Andrea,

On Fri, 17 Jul 2026 14:33:18 +0200, Andrea Cervesato wrote:
> lib: Avoid loop_info.lo_name buffer overflow

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
