Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4855610AB830
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774623165; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=APKeqPfTKnlJRl39u72vSP2QcRUKQdwj0rd6SSSxEBg=;
 b=GbVMP6xesXO7UxPZZDLpgg9wBhb2AvwZIxnf/fX1WNDE2wuW36mKwFYZM+5Qz7Xk3AOD0
 NvLbU+OZjsUR/ihsUZigYwPlVfrFNGnA+sge4yRL6Q/MCNxqI40p8cS5PClCrbe4721vgiL
 KpvUuKh3kAGBQ6VBdl4TpeG2TBeGcBk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D98013D0648
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 15:52:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6939A3CAD69
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 15:52:23 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E9BDF204713
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 15:52:22 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852afd42ceso17061375e9.2
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774623142; x=1775227942; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kKd1sUkewpw0J5x7ZqjRO1jMbrZv2yBgttePtuN56Qk=;
 b=MUXKAHFizoYCEMJSuGsX+3OVS1zAY/H5EUJgOC06CAUW9JwkpU6ATiTWX9bJr7MYbq
 CgTgXnkaSBPE4Sjep+ziE15InGr0ZibGUsLU5N+tKxpOWpDpaEUD5T34nsK+TkHyLPc2
 Jv6dIsP4S8D/6MU4uA3AvoXCyHOtj960hRgx8ubeIpkSiTYFROdEeDi96E0NIiPTywwQ
 /vr+kKB9PwchHt0Eg0vLAGUxAuvIIrI6YsdLeRxaCI0o3v7H9DPZaB3zREJB4MdQIkHb
 tebukxj6r4wND4j7rXm11l/bYij1v407c18L0Vtv7s5lFxZJA0kFTh+Xy0y2iSgjwMCg
 PycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774623142; x=1775227942;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKd1sUkewpw0J5x7ZqjRO1jMbrZv2yBgttePtuN56Qk=;
 b=sK+ddzcXr2hVv8LyxgR159pc6g3WBq6raFy1ZRc8wApzmrQ3IH53RW/Mo1NKf6ZqZE
 rB6ZuYMuBRLnMCeakD6e2YKjHqr4J/J9GG8dyG6+p30drS6TM8R6WmWvkYpcmkKPKjaE
 oyGJDLx9q6wahH91sjoRio5jbK38rJqRj9hvJcEjHnge8GZsdlSkHYe+66I8sHnRNkV5
 K6o/ANBCDSsDvhDO60K/nrI508Ip7ITMHdlM3Z1Yw0uPMZYhHQ30dM1j88wxAXiA84rq
 K0hVGXWEAFCt1opgXqCFpqaCnjqw1/8wShPFZqPav2N6xFEE3Ry54ALfaU5Avsc2Dxrg
 AZEA==
X-Gm-Message-State: AOJu0Yy6L1iGXm0qRXI07lLQQWTN3ojq7MRJplS9T8wGB+8uDUgQ80Tn
 o7BKhtYr3YFBcEtDWbgNwT5h4NRpMfqcQyvAALBvQgwmCzHYjK8nfkh46tBW6qQWQooocfrXWIB
 4Wdb74EFHFQ==
X-Gm-Gg: ATEYQzxNFX6iltOD8IR8fjNFhgbsTTmC4h1DhTpB/B+hxbOPPsQwv7SEn9sAIzCOaS+
 QBgs6Yu2FL0vTWYE2g7Jm6WX8K7aL124v39wjt3jC+pwZFViRebkafq0AOsRzip1R0F41+DMdm1
 roDC6B1zu810aTHIQEson40t9foxxpM8pGGF8nTG3OEBNBoMLDlWhyxFGlKTEAWYuNfcoUdEM0I
 X6YMpXl6dH5CE2+u6ygCnk+mlZOn4DmIVfGvBoYNPvAeU7/5oXVgca1qWX2w8q0yPbq6R4jkhkx
 0EbQrlUu+9zIjzaTz6AKcFnZ9wFB8RRCJQ6SYCToy4rrmx8EOTUiOafuMj7zENMjiGKyaC6vxQn
 Ulz8UdeEcssoWWGhpr9g1XmkLSOS6qoUSu7qeg7/jx3s9m0N+IhK5Q8A5l35LHdMosFjxkUSaKV
 WiyW/u+Gkp3TgLjg4tMB2GNvFz0svH+3l8eMFWiIK2vbkvfSfwvg==
X-Received: by 2002:a05:600c:8b88:b0:485:2c61:9459 with SMTP id
 5b1f17b1804b1-48727d83bc5mr41993925e9.8.1774623142218; 
 Fri, 27 Mar 2026 07:52:22 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.9])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-951be56f28esm7063107241.10.2026.03.27.07.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 07:52:21 -0700 (PDT)
Message-ID: <69c699a5.050a0220.290dd5.e27e@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260327140310.2306-1-always.starving0@gmail.com>
Date: Fri, 27 Mar 2026 14:52:19 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] open: fix cleanup condition and use snprintf
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
