Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA7CCDB47F
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782303277; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=sCwhZU4oPP9eEFYeapie24jiAehE1KvEq1AKvndx3mE=;
 b=oqu7eeCfxzyR/NuWVxn3exH3IUEmBo1Q80W+pBm1EuHB0ncJO5QPPzGJ3xqatMIJDC62Q
 JyU8zpVrymBWoRW64M95AUZyHkx8JorGR393QjSP/+dlC1qyJhu62FNVWJ1UShrMQsD3VZZ
 sXHa1EEfflwtdvEzzhW0RcGLQIyc0tU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 357C93E621C
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 14:14:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA1053E5872
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:14:16 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2EC5F1A00988
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:14:16 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4645995069bso659266f8f.1
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782303255; x=1782908055; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=uBQmy58TdIPlB+eyB8uU+mbI+4sFq8mEQVxsYnvQyj4=;
 b=YthJOt2ju2dj9VowL+b09CYgpk1QAA5NIMhjRnpllvBHM414QMI/Kqbxlrd97t8kwh
 MLCOrKU3+voffqPabq/QaXrtFvoLlTnuWu/D4aCmeDLsc3Y6iSVJYe63U3ggQ3JzEDj7
 L3aKhtc9yVMxUo83kXNRFG3Tey3GTEigAEKIqL7Bnsgh9NvM9bpDg+S5ePpT0pYPsITR
 bHFC2tTyEcLd0AJ1IWKRs+kObedjHxszMP3Ayc6sNkgFwvWw0MJXP3C0pu2TuYl9DIze
 SQ/YnJx/fCvfw2tFG6u676Uo5yoNptW1AZn/xDEpoOsbl6LrV98MKt5IMWUnIVw3TcLj
 ytNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782303255; x=1782908055;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uBQmy58TdIPlB+eyB8uU+mbI+4sFq8mEQVxsYnvQyj4=;
 b=k/+Ug54wsStRz6RzaZG0+Wt+aZBYxoMsu9WMoFz9BpxhReQe1B8D0Vl69b+JV0RYcR
 y2/9ymYRCEt2vwOwCDeLU6MdxrkySb4T98Yefl0Naqj7QaEb/pziZAdRRdvnwo8gta+m
 L0Cq7a8ciNEN+tpWQDnJLdubp4wC+kQRorRivbhEBsyAKbS3pnzZWdpzt4Q1P/MHll48
 NGdUhN1kZlsfgaiQB3ho/5LieTDoZVaXIh7rL4kdKTifI9pLLz79v2fzzXzhYp1U6wlg
 xeyjDuLpTCXGdxtBF+dbYuqjjpzxL7S59KbOqXOxxx0kSgsgfZD+jP48k6NNwRdO6D1s
 ljEQ==
X-Gm-Message-State: AOJu0YyA0C9F1yqKf8nF6KyHQuDCxR4s2ewwkcYlRQmScLjRkeXD3Ok+
 keK3x2FMe3M5UOJBGhzKPiD4Lbz+Sx+Y0ybTSHUoPZsu6h0eycbohdTcI1++fbL017/FhuIxFQd
 pZ0+Flq3zXw==
X-Gm-Gg: AfdE7cnGxpW3nd9Hzc0viIsWrk0DiPMEl71B3fMWEu9r1wu2R+3uWBo8Z4NSd8ZBaiA
 45v9tvlFdQP+l2lnTrl/4aFSqGyl1sYyKdxevpI5O3CWWzt28/JIjBNnypfUNJRkYtxXntNDjIx
 yZEBRN6md+Y2FZi5b/U56Y7K05DTYIWZLrG9AQV7OVTooRVxyi/sfCeX86o8Knx4BqFpPjIZEQ4
 3JvM5dLxfEMr1tZdBkzV8yET9EXzE96mkv9wIEAoIEXIOpCyuF6rpe8NYWpH2T22AY/jeVVBhHO
 Ua0k9Y437G2sRvX434cP3CQL64SpsSMTUuBR9Ozf/TLi1tG8Ku2UjclLHmc4ZfsvMlTIlskw/Ag
 YdzO+4l98MKl3ixC6wryFBU/HdCWRht/VpKeRt2ywIYJpwye/NHnMG7GTfbT9tgvcrOaXfk9EdQ
 B371vgGedcUhNPcM9BdP0Bv36ylkmE3GdN6VNq82OEl7O9Aiq3YyUAqOlbteh06g==
X-Received: by 2002:a05:6000:2990:10b0:45e:f780:6177 with SMTP id
 ffacd0b85a97d-46c053d38b0mr3861778f8f.18.1782303255438; 
 Wed, 24 Jun 2026 05:14:15 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46caad603b3sm3289939f8f.7.2026.06.24.05.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:14:15 -0700 (PDT)
Message-ID: <6a3bca17.95d0a0ea.2222d.1271@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260624091900.4107041-14-chrubis@suse.cz>
Date: Wed, 24 Jun 2026 12:14:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 13/13] metadata: Add runtest file generator
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

Hi Cyril,

this is a bit controversial, because we would like to get rid of
runtest files. Also, we should start thinking about moving tests
variants inside the tst_test struct first, otherwise we will always
generate runtest files which re not taking into account tests
parameters.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
