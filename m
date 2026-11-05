Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4841C606A31B
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 00:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BaBgkk0Q
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF4F83CD79F
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 01:38:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 419DC3CD6FA
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 01:38:18 +0100 (CET)
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D00451400123
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 01:38:17 +0100 (CET)
Received: by mail-oi2-x07.google.com with SMTP id
 5614622812f47-4b39374fdafso240402b6e.1
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 16:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793839096; x=1794443896; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=97SnOuENm60ul9BwvaTwQWcNbIZ/ZAtmJG6LzCmLEL0=;
 b=BaBgkk0Qu82VpJQnu3G3G3PHx/cHFP5VeLzvvHKCeYQYnBzThn0tX79o98FqhJdp3J
 lv9BMTxpFPsneZyzun1y/MgDtrkuOaUJa9yfIdQgX5xHRGOqKp+dr8TS0zh+/X2qHwAM
 BWiF8rlCJuaw0CtzTt/QnQNwD9oLgS2cRqXPtdmVBQnm/YduAgNGe1pHPHmNi3Wwa8Vw
 KX67visTzYW1bGRiSn7d7OmXfM5mHzFxzYJPaDetyTFp39/nIXNiN2v11s/LAO2Yrt0O
 WMxQSMT3iHtOhbXv706kdFSOWI1yh8+SJYLoinz+nEFfuRQeh4TIYMMaiRNVo01z+k07
 s2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793839096; x=1794443896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=97SnOuENm60ul9BwvaTwQWcNbIZ/ZAtmJG6LzCmLEL0=;
 b=xVC8pG5jhhCF/bY4ieIQudT/enSt/OAyLldrF6LkSJFOB4sAwOn1s+O0JCqiGa1Tm9
 1VJnoAT2BymMxtVjzEpXMUPZ0pI8jJ2APMccewEGzACLV64pb0hKSO4Ftwb8oEhyjYAw
 MWwA1BM8wWEkKDmeh6P/vZK8P3Y8+y0KlNW/brz+QEb9kZBrWJ9a80vGYckLbVQriJIE
 ooig2qZvnZag/Qvr0GsDvNr0NMH6pvcSnbbLXN3DQ4javzOHHt1kjdqFIM+Dx9Bu3Onx
 aeuyk8I5bQIFWMHeKIG1mVpXq19jpinv3jAX2DSGNyPtUM1XeDMo5SzZxHgFoqNE1OCl
 ZLsg==
X-Gm-Message-State: APuU4Z+0wdH1xvlkcEb8swmygeetSkXK7U2m9zOoD3WXAfSWvbMNvp8P
 R4ZwITwboS6wQp2llURq9VTVbteVW02j31dEAfUz4Zm61CIsIczFrJov
X-Gm-Gg: AYBFou06UMQskLoEuyNBC73sJPhcFiuMNpSZqJRNG8+pyC9Nnv+6SGUrCH5RarvlbAG
 0PDPdw+ZOp9Ouwmq2F8gyKYfYzLNpEPf7rL+2F/Gg3Q3DbU2lJbVxmWelKoVamsSAEhqRDLsYYb
 kjozSDKV/lEjld8z8rjm25JrqY6L0XFCedRTDDYfSJUfI196qjNSYXB6pXt41ZcBjhkjmQ58+cG
 97YH3tVpUfqAU9AzBwA5w2T/loysDRlEQP8vIjENGYgpGiu1B0T+MjtUworSq7RYVpjWIClhx9C
 1bK/PXzC7ubMGnbj4PAgSEATVuO7mTS3RJ2SJyBc9m6+3VlrbZKpv61Fb4xtssFgL3uAjfx/LrT
 6+5RzS+j39WjOBRo9vRFw6Y97p5kLkTCvs8gqWu9kY53kvJw4jxjP0e1BIfyaONjSouj8ElcIb8
 5DWmET4wvyJPA4kH5rpsoERG6vG/I9hbZV3oMgBhNhjZpUevm9jJ4+zLTZ3O87UbmoeZDU7km5J
 uYUfPn8RuNWSfsHHo9tMJzDWdn21sfwBSULM+3BCRAKs4Plj29124Qcvj/ubIZvDHFyq2218wlJ
 nJoFt9axCOx1k755BQRooZYPoxHcXh2+K/OMzSOBswr+V3PfRNJm9t/lQ1PSzTm1Gt49rUfE6eA
 ICSCYMS/89XcIkUMgxHBc8/sCb+5zKK4Vk9cRLBM+dYk=
X-Received: by 2002:a05:6808:6c8c:b0:4a4:c95a:38d1 with SMTP id
 5614622812f47-567be1fe614mr703946b6e.4.1793839096455; 
 Wed, 04 Nov 2026 16:38:16 -0800 (PST)
Received: from
 runnervmnwato.mklpuzqhpy1efhtd0jxsic2jwa.gx.internal.cloudapp.net
 ([52.176.125.115]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567a9fdfa53sm2843231b6e.15.2026.11.04.16.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 16:38:15 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Thu,  5 Nov 2026 00:38:13 +0000
Message-ID: <20261105003813.3811-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104203555.475536-1-sbertram@redhat.com>
References: <20261104203555.475536-1-sbertram@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] accept03/tst_fd: Harden parallel runs against shared path
 races
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

Hi Stephen,

On Wed Nov 4 15:35:50 2026 -0500, Stephen Bertram <sbertram@redhat.com> wrote:
> accept03/tst_fd: Harden parallel runs against shared path races

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
