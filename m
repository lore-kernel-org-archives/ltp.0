Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0553ECDB471
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 15:51:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CE933E68ED
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 17:51:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD91D3E5872
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 17:51:20 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 59F2F200254
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 17:51:20 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8db9f25c5acso1213196d6.0
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782229879; x=1782834679; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uGB74m8ri0Yes0RimbG8uBym2NhQP1Vk1CZV2npWF9Q=;
 b=BFGImt25XhKb1e7LawuKBWU6fjnF/u8+EYsknHZOh/vYkJsGlVvVDYRL+dftlqEaGJ
 T/iFVBGT4VPMraE6ULYeSDIxCrGVMEtpUbsav0AzNw7Blu5Leg2OLL4d4MwIT9CxDj/Z
 lR0tamD0/1c6jyucgyq5Jk4YIOYtdQpuoEVjLQpR4Vn33zGvB22ngrbXYzq+/K/5MkBD
 KikEFWKqjF8TLGQytNrncws1I7RGRFn5nVXnbCl6XDZbqYN4q7/ZHaaFr7tMz2iWaVOM
 ey/bre24EA0eiGareC3CqD+NPHlDErmJQjXhd0GUlQcFuQPIw1acRVrfX4pi2NMsL6Vd
 FvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782229879; x=1782834679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uGB74m8ri0Yes0RimbG8uBym2NhQP1Vk1CZV2npWF9Q=;
 b=sgBzEvWe/Q3Lk0WY+mu2X1Yabemwa+iMtlIufiSVh1O7oRp6LsIgDkw4S8PprjdVjY
 eNf/iW7GQgUE+CSInFpx1PE9H8frODxAOyRYrJ3EO+Z0ydd2eVoxz/gQDDI2TW5np/yZ
 s6npCccJH2EskPOdVeiK4vVW5S8m76LmqT1WmEegQxIezVHO+nF2Hdv4WkPAIpbcW3Sz
 6Cv65FVARMwM8WmiCDA5875DIQxvYW+2Os+2/zc/zC25GGUCS0UI6jo7hjCrf/d3N0wO
 PZrIzMaA9QtXQFx4Kd5YwBhh0hQLmFKQedRMIY4oQJOuzaIhPabEm7pTVzpCLDPgrELA
 MEhw==
X-Gm-Message-State: AOJu0Yw3Z4qzHu+3jM6GCTudVT9pilLxamKb1TCEbbl5c/C0WT83SpQ0
 3AJqfmrqiP/CIkTQw8DVvRRlGOdVnzKzfPAxWgrGmHFu7GdAmxq/H34WUzpcWtIz
X-Gm-Gg: AfdE7cmRE5uDtj+LDaunuUFONfbUFodcAvEk5AS0ewlGwINcb+aUTrvsMpVHQ3d3qAm
 Hi4eiOgWN/o7EVJxUxyrrPsyxz8ir5b1LFPl9S6f5jL3fPomkx7P4XKkFtZ9HhNquZYCzBeuOfm
 9e0J36OdtUdWvpCCn0+/nqb/ZJTV3HGZ+pXzo8gBH3X2CkJS/vXRPQLtGkVML/13Ku/X3BMDeb5
 DlQ+rSHY60Ina/zdPkjPZ3yYLnii0Yuj2+eSblOgtoYtb3by0mOe0X+IXuUUHxOtnzDAuTuFp1e
 xGnTD8QKZQ54I3AA8aJ8vvXIa3fIM0jp8IDhP2/qXq6/2nyaxI4ficDdGprB2NZVQE9aSSTEOSt
 dlpjL8M8xUtRygBX48SDkLWSN01c1u20Bs4EiTyQGb19B+IM4JBYMxqxqAORi+2Q6O20ynoHdUB
 BMJ1LjR7fkbXhgjGEyJ72MMQ32FvMt8DGf75wqGcSEfixFiu7iATotQjZURlVmEL9vLVsjvb/QZ
 HVRhkGgDWJt0bzuC8ZWny2vuaon
X-Received: by 2002:a05:6214:29ed:b0:8dd:5fa6:cb31 with SMTP id
 6a1803df08f44-8e4344aa943mr45793486d6.17.1782229879094; 
 Tue, 23 Jun 2026 08:51:19 -0700 (PDT)
Received: from
 runnervm7b5n9.yuqz1jw5yhjepgxuxy13g0zykh.bx.internal.cloudapp.net
 ([4.236.173.170]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df82692405sm128286576d6.39.2026.06.23.08.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 08:51:18 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Tue, 23 Jun 2026 15:51:17 +0000
Message-ID: <20260623155118.3998-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623124812.46022-1-avinesh.kumar@suse.com>
References: <20260623124812.46022-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] set_mempolicy05: require CONFIG_NUMA
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

Hi Avinesh,

On 23 Jun 2026, Avinesh Kumar wrote:
> set_mempolicy05: require CONFIG_NUMA

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
