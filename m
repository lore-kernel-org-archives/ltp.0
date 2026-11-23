Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9235F606A31E
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 20:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZzPVDmPi
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2586E3E9C44
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 21:38:41 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E55F3E990E
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 21:38:26 +0100 (CET)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AC9051A00250
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 21:38:25 +0100 (CET)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-92106d5371dso47565106d6.1
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 12:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795466304; x=1796071104; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i15IYcDFLGkhnRd80w/RIJUOhXJc25J9jyG/+McVSw8=;
 b=ZzPVDmPiWLVDqMBqYXJIJa3YJEH81m6iMvvTVDv7Z3LzJNOTkdOatKzfvD6VCA2MbW
 pNjyCXrl1/WrAgbkxM2Cprnfj7g9qZFUi8tfRVtOAJK3iOnVm9LRyjU4WFvqQmgPajNG
 2uY17FNMFOS0IjnM+JxqoBQ37kI849fszr9QMOnAe/aG5RNWw7TrUE2Ond5Zxnzs1KFL
 khcTD+IR5/d/SvC0rN5zjQCNcKAcgJxkLXoFdayHuaJTMmrIdfNRdrGyXgefHoWHScb1
 x0pSxL0MYQcl9qYKuLx9DtB7eCLg2OR2m+p7oFzcx71HdsLKVkKMXxDz9JYgUKdi6mcK
 ZbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795466304; x=1796071104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i15IYcDFLGkhnRd80w/RIJUOhXJc25J9jyG/+McVSw8=;
 b=AQ2fEJKyFmD6AIQ0152StnvomfBXya19zf7197om9GDRIrvw5Rn7v2CbuUR/iGnLCt
 xPis2uMDGioH1K2FVASikcLsWk1ERLM/aKpOQjNtTZraOmvVzm1CBK9kRZm6lt8d44vz
 r6P0Np3XyuAfRcKK/J8rtnS8WO2d5fJShPc0jPJY8P+Ky7zcKIBxdD79/ZUnkYEyIH+N
 WOJ3Ugn7Tm/cN7cq+gQ40XGdnKZOJXoQ9Yq/gfQ21th3gaiG2kqVNkj/AtA/VAGO2wMy
 1O3wiGMfDFmFAErsyG3aemJjn6TeacFggjPKSPL8BXD6naYf8Seza7ZsejqIkigiNV/P
 biyQ==
X-Gm-Message-State: APuU4Z/CCwgw2b3RAiPAXRLWDjl5auFHGZk2gINNgTJbuj3WAAER2dyA
 he/w9WjKwaWtuUPPTQjXpYP2XkL4Nghzjgb1CZMD5W4lTt2pj5dem+xL
X-Gm-Gg: AZFdTZeML2WmItyU0NJ2r5tdcxUVAKVEO5SRn+rcfdXR6NZSDFOfdCji1G5vmUE87LT
 BKSJ9byJ2Rrleg2E2ZAZH3WP8B/n6BfLhDEKgElIZc9gdRCtrVoa0nxGk5crSOUPcEHsnbAQO9A
 1uf95hwAcW819+2xn1P8UWaIaDn6XgZ1wrUyTbrhhTjH6kjearhDWebkKtITVGTH7dIc7hdvyGb
 qGuzlGyV3k3Ikk67dKg7pFum1ZEpIwHEDI9dSicGxFK4GrnxIPnsRfrms//nXbz2CngKF4qRY0J
 YN00o7RrZPxBr/uIq/8sOYCTzTeuq+xEHkasYo0TQuza6+UnnjdxH9lLIhUDYKM99IKjShndVVu
 4M1jOFg3TQVZR+ctKvj4CpX9fH08Gdr0vCKfec57wErnJB9NvgnF8iVXmHXH8LmESCzc1UysYCo
 WqTPuA1ogYAC1d6JuOyH51iEaWA/gtOL0nxnMIIklRMQEvQQGCKV0tFzBxO31KaF8jI6IPyP0De
 60Xy5hyIY3HK29Mu7lWi/TVIY0UPnCLhs8AOyn83mTpsUzFOtrsLMKnf2xv2KtxgupEJ4eFxe5i
 akirsU6e0a+8sX9Rp05z28tCvrvTLEeLqjRZR6grqz/qi2Va2o84n4xwqB1IbWIorcKQDAFs5Kd
 BBnZZhtl6Os4MXcdZSezfqbsrTgAYmoh7qkg/20gCaRM=
X-Received: by 2002:ad4:5c49:0:b0:91f:3063:6b2f with SMTP id
 6a1803df08f44-9212e0b6d3cmr233334836d6.17.1795466304395; 
 Mon, 23 Nov 2026 12:38:24 -0800 (PST)
Received: from
 runnervm0hi8g.4jqpsrdllcqevabc4shomduahf.bx.internal.cloudapp.net
 ([48.217.226.160]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a0f5d7sm116157666d6.37.2026.11.23.12.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 12:38:24 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon, 23 Nov 2026 20:38:23 +0000
Message-ID: <20261123203823.3864-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123123626.1499705-1-wakel@google.com>
References: <20261123123626.1499705-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] swapoff01: Create 64MB swapfile instead of 65536 blocks
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

Hi Wake,

On Mon Nov 23 12:36:24 2026 +0000, Wake Liu <wakel@google.com> wrote:
> swapoff01: Create 64MB swapfile instead of 65536 blocks

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
