Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB3606A31A
	for <ltp@archiver.kernel.org>; Sat, 31 Oct 2026 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uHwfvJAl
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB64D3E9866
	for <ltp@archiver.kernel.org>; Sat, 31 Oct 2026 23:58:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58B023D266C
 for <ltp@lists.linux.it>; Sat, 31 Oct 2026 23:57:43 +0100 (CET)
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A659D100049C
 for <ltp@lists.linux.it>; Sat, 31 Oct 2026 23:57:42 +0100 (CET)
Received: by mail-oo2-x06.google.com with SMTP id
 006d021491bc7-6de056f06beso789596eaf.0
 for <ltp@lists.linux.it>; Sat, 31 Oct 2026 15:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793487461; x=1794092261; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c+fQad2xQykgr8QC9ElNyCu/3uqlR8Rjak9+ac6ubUg=;
 b=uHwfvJAltdRp2FkB24fNfcly6xvcWHKB1I94pypPonG62+RWn+rRaftyxV/NpZk6xi
 EB15uE4e9YIaiLhEY+GQqVc8ZfFv/YjPhREg9tzfVPijvr3Xu5Rb6tWOj5wrzQYB8WKR
 sUCRDcOZ3kHDg9EFfE4P8iY+I0bONen0lvbDK0HU4FlfPm5jZZMw2Gcilog5l2qAzQEg
 qwqZXdz0SFFhvVttPBIyi3wBSWb3RrwN3caMi+QMvTlFskAAqWummPXTOQtMOGraK7Dc
 8WqvHrRaazeM1wOnLYM0wvjhvlktxkTKk3e6VoEBVz0/DkYz0JM+QWDr82QBl83SBzTm
 jMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793487461; x=1794092261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c+fQad2xQykgr8QC9ElNyCu/3uqlR8Rjak9+ac6ubUg=;
 b=Wpvz6Y4nL2GQdXkS9ZhizzIRPphDt3UE5bVkoRBtzeQfk3Hl62QbWup3qzQ7CMHZ7o
 iQKSjB+y2eSzvL+j+WCyzgTJvWi2dt2G8tzld/vcQ8TrwDRghXguZZFm8CDwXXcVxWlb
 CXZPrwKGBl5vBkEUkS3YlrZq0xFiA7ze/VknLec9fFwvOY2PY9HABPLo9lRoSayUm5wb
 AORgtZRUwqORVz6qMB36moZwdT7lcGEK/rVOX56ZGxo0PFg+TclCO/mF9kYyvkOcxeAZ
 TAu8nOTCkE9MKHrCzcoxv673Ykv7690IllHwr3xGbcVci4YfxelRT0BHdQveT1La+D4S
 ow4A==
X-Gm-Message-State: AFq9FYLPTqNoVA2iY+BxPbzNDT8IxEB1yDKfxHXQHbmx0g2SdSkdHTHe
 rjN9PzLLafZQGUo0jqHuvAD0EaDrSy3Fwb6K8YvIokMaLEEDDULsZHTy
X-Gm-Gg: AYBFou3GCF7Uz5R5jP1peK2ORgSw10/mSaFDa7MwHl+TwNhHx0EPPs4VmUeiit1qmSI
 xctWRmF75t5Plyv69cG2Q2oKhJVyZ0dZmc5/Xvh0x1BjuI3Mt+RcEjUENXDdYfxsP65HYrx524V
 j6DIUS82rexIswaa+BzeeWYkoxOlKwR8OjywOUfUQdei5/3RmckFQy0sNxZLVZqUjrZkdS1VwCB
 e7kk1Rwbp+ExNFJgb5vdTQsVHQWYGYpCQV0NaudUWgDPcuSs+rSyvdl3mX9OLEpPkzO+ytgNhqA
 JKtP/feq1/igAMbkeVDt9TaSTskHgMa7kX0swTHqEYKSfOm4oe+TAwNRtUgW7jAkm4o9BCavec3
 OkDYoveYBMC1O5CFafzSyYozjkBURVbJXUyciH5+qeK2zGYVjHRkWKz6S4uqIantwazxcl/SYJH
 ddP//dk3+jP2rPIHffxKum5Id8GT8edomlM1loO3JbfCAx/2mkGOixo87i6eWW+4NNbLumq7+4J
 TtgSRr82hxXOIvC0x1sLxo4rUiNnTztUFkmvbnKJhLZpy3dLy0OaLcrbCPRVjcEVKgMVSrO+yVt
 7gJm57uAv6baow5WYRDo+UXnT3yR1UM1cVVitCRK2qeoQ9kz5WuTc8gV7d29RPMKrd1eF3iPM13
 /X2Nt4VXPouYYS7529TGcJxAYoHuW0mRnz+uSCQMSkjqTPcieJRFsZmyHkPx/4Ug4Mig=
X-Received: by 2002:a05:6820:169f:b0:707:27c7:86d0 with SMTP id
 006d021491bc7-714f1fda00fmr3459340eaf.4.1793487461170; 
 Sat, 31 Oct 2026 15:57:41 -0700 (PDT)
Received: from
 runnervmnwato.suwjjoo5a3uerdrpgc2ruyrmoa.gx.internal.cloudapp.net
 ([128.203.199.118]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f2ce7c9csm4973094eaf.5.2026.10.31.15.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 15:57:40 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Edvard Conrad <edvard@tuta.io>
Date: Sat, 31 Oct 2026 22:57:39 +0000
Message-ID: <20261031225739.3680-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <P5Iny41--F-9@tuta.io>
References: <P5Iny41--F-9@tuta.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/fanotify26: Add directory cases for the nested
 event
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edvard,

On Sat Oct 31 22:13:57 2026 +0100, Edvard Conrad wrote:
> syscalls/fanotify26: Add directory cases for the nested event

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
