Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B1CC43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782844784; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=DJ4JoZa4T7JJZLMQhPqh8/8LbGPK1Zo8UJqbhbEtq/w=;
 b=A9yMXjKX0mVq/e3LXeqqG8BIGdoHLCJTFydHBDo2Y4mHU/7wApwryRx+U+eVynCimFjtD
 eSaba1WMZmzH/amhdK7SaTwEks1ZSjb1GQoAk0moRlwYiLDrFrE2XhM8i5UU2HVPU1+Cda7
 Wc5OzKSHdh40OUKfigGORdgdVkQLWEs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9ABE13E4D28
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 20:39:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E7693C0F6F
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 20:39:24 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 56DBA2002AE
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 20:39:24 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so13529695e9.1
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782844764; x=1783449564; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+n3U5wwSeV0LoCh2u4qLjtm5KEl+PjXBcMSOv2cFD4s=;
 b=ZCH4eh6XawLRf6PKYCx8BUzhycA/tNf3uczDFonBtSLBEUIMu1cWSIskBdKuOjbRKP
 KbrNOrHFP2uGZE/VDm65u8sneUkBzgy1vsoqFdiat3QVbhF8+JlIKT10gDuMJu/6YX2h
 iVBUSGbjB89oCye3VUY18FMrsZqhcTAXtwYxaFoZpVGNbdv3+Um0534QPrSoWqyS+O7m
 7PlIWUnKHUSyaF2WB499amP2GrWxDTbVnLDIgKAw4WYO7o4HdVYzAyU5TDy1ZLXX9qfw
 tpOTZMmVNi4IvjBWehMS2fELbeo4BaxqXX+QHZIYHOiWzz6ay8vL24ehYRhZr8KX0D9g
 m2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782844764; x=1783449564;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+n3U5wwSeV0LoCh2u4qLjtm5KEl+PjXBcMSOv2cFD4s=;
 b=b5U0wa6Nmko5fs2t/L1A872SF3rCEvFaROzXApG++vGUsxWhMJSt+AuDF3YTDGQvCq
 rIHQCgcYlqBR9G+66pgEBPBiX6V8JtI6RtHKkKHhumWdePN2glKWi7uk1Btz++OvTK3W
 Q7DTpgtfQrE/SQSlO9195JWijUgWcITXDCedXbtUgevv9gid4tmaaQVU9OoQyDOSoXE+
 L7wJQuycUU/R1KLaseAwEVkLfOxEIcsRMmnyMwGHyyV193rpc/jtbJaq3kh9QGBNssjZ
 BMUvNIwQU8/fXjSTvXYI4WcRS6wUzvvUcEw8fFlZzeEFiywiTEFK+V56T4muiilbp+K2
 8Xtw==
X-Gm-Message-State: AOJu0YzXPbMyHh25OIO8+QvC7IGbdmgJOAEhh530ZktMLzzPIaQ27Djs
 FiWePNmblPef6745MOEaJRVEdF7t1rc2Z7E1BqPAleM0V/3QzhTtlRc/ONbvNNbq+5Y=
X-Gm-Gg: AfdE7ckjX69cH1Y/dEmLWJKELoJav7/2dewoaPjEYv6erxTgByEnjXi1CwyirA8swfT
 Aven5JCjOAQKvFt4qqJj7aW5adZunOcQhDUMgdXmJtk+adg0P8XUK9eICkgSoyLzeuszgGGzlwc
 +THkXACfSIeKoq+tQNjlTv1uqG+GqMCHLHJjdg2v9sKnPssLr1i6tFM6wIN+WSpFjw6I/+C4zZw
 ktwPt4KpgakASKypVpSz+QG3GXOt23Vqc/k6MWmDeXPsu5TNZixtNEA4qn1BXvZgM2zE6RToyWz
 fo24j3Gmoo15Ijn9uATbemAEDAfo5cTgPMmyMBYj0+w9bzH5AKq9eXnB+pFcwzuZdcX1+2Rec9j
 dzShaZlMC89w5CBZDcwIVAlvHZgfzCJMGcQg478BwTuoe6iyqx957dsPfcwxw6JZtFh8ai967JE
 6u2G2nDREabK+t4VXUjfFedeR1mm8x9vXZ8PSAFjSx
X-Received: by 2002:a05:600c:3b24:b0:493:b729:3a9 with SMTP id
 5b1f17b1804b1-493b82bc0a8mr79468435e9.27.1782844763660; 
 Tue, 30 Jun 2026 11:39:23 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef183e7sm5625225e9.2.2026.06.30.11.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 11:39:22 -0700 (PDT)
Message-ID: <54a56eb9-a2c4-48be-be7c-9ab25e2dd1ef@suse.com>
Date: Tue, 30 Jun 2026 20:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260630170611.479639-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20260630170611.479639-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] irqbalance01: TCONF on missing interrupts
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

Regards,
Avinesh


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
