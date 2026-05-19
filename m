Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E320CD5BAC
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 14:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779202070; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=eWGMuT5hhX9TFyMKj08BnpwFTuLE9d9iDMiwn2lZBe4=;
 b=WhUIDJfknGs5szYKnnhTwV72QgwBj2bge5srS+T7ixiOqUbLmmVdnRSVkR9X57OMkbE7/
 fXyOJaDcKMqpvEL7TSAE6ppGF1MXvsu05HpcLheJtkF1rULb538TdBM3KJVGYGaKLv5rtAu
 pIn7gHYkzNJqi66e2vbVk5+qbt+xuio=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8CE03C6FF5
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 16:47:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 805C63C6FEB
 for <ltp@lists.linux.it>; Tue, 19 May 2026 16:47:27 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 20B2D10009B0
 for <ltp@lists.linux.it>; Tue, 19 May 2026 16:47:27 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso41752305e9.3
 for <ltp@lists.linux.it>; Tue, 19 May 2026 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779202046; x=1779806846; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5DjFl+Fbpi8/7A1KxtQv88godxSlqHsgE5dv2kdXHfA=;
 b=MYV/sHEUftuKFUBCal0j3z/vdiSiQXMJIZOq0joaQJ6aOhqo3eYOIhj8vwnqUYurIN
 B3FGwJgdcWXu0/Y0RHFZRKG7KCQgvxEEfeiSDkzvkfb9kb8CHv7mdH4PCdsMTQSTwx68
 R7OIKqFUKyn0ANNUI/zPz21ta95igabi0Mir7PxnIvcM20r/PXtZjIgPjtwmVMcpZXGk
 RO8EqvFz+M9yg8ahkr1X2r78dmqwtHJYCn8zusVUZrItvOlKHpe/o+Vu1BIhakY/BkQ7
 wl0JtgZ4IrOF/qqkGUpsVRTq2yl7S3UGcyBp0yMLvcJJ7DkMgyfB++Em8nQ2FS9m5Aw5
 TG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202046; x=1779806846;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5DjFl+Fbpi8/7A1KxtQv88godxSlqHsgE5dv2kdXHfA=;
 b=rVPxPOPbkTWjtYK29Qj+ZXvhhkWinPT/Bmc3XkTbtUeMB7eHHM+QNaFMD3iR782+Gq
 JbC+hq3LOZ14SKSqw8/byfKFYmYFdXyOMpM9wViQxkskhcIsXRNCjQDPSLKIjuPdwFui
 CcD/8vviLN0sCRhPaGtrL+ITzfYY0EDU+YoKgyWaOWPx36/taEmXNB0yNCYos/9FJqAa
 7GS/AjDG5HRhHWuLaZdu+8GG1h4O0oTWCQvp2UJBKtN4c0KXHuvKX93moQGOfHDWEBnH
 Ybqj6hFCBNQKgfi0uV76gotDbdKjwb9H/tsSikHXFK7+RsEJyV2/cjYDwo+3Vp2T8pbJ
 P+aA==
X-Gm-Message-State: AOJu0YxRO4zivdqJgQ3p0UqrZw2JZBys10rLrohz6Vpa7rlq6hq9+nFT
 ScEqOPQ5xQerbQIYyHxQQT95TYezHKngmIhEmt8HuUmU4N/ztciiqLcINhUjkD6eQk1K0KOKiXA
 5xL2srqBl0A==
X-Gm-Gg: Acq92OGX6fdZlKPABlVH/KqYhihk2CSbv1GE/cI9uq3NQEspWGFv05q7A82KesHXAKA
 yd/2yCRwPzdxsXBwxceI0sKaIJBx8uH7lekHiPGWGjJyVuqhlZcgZgBZWKayQSwXFA6Q9LPcG5J
 w4+BzbWjlMdX+VaGs/U+WlYSmJ/9i8yE9j5+sI4IXNLoKJCgvNL3VP8xjRg291kLXsy/jBz64fy
 AQH+gLbKi0Cz/UumZrC1ZisLRaIDru/E1Ts5j6xA9imyf0pINeHIL5b+jNXpbSZ/9s8V2ZOUPZw
 MsB2gJwOnL8MdI3uXD6DE3ZXpMproHmZaIISL1aurR8FhQdbJ1v5dn3R0ZdlKpKh+vKESOY76eh
 bzjDeC8jZQcxA1IF8ozHshFb5mn4JACX61bBFZInNiHSADVdeCg1fNR+z0t/uPvnCC0LQMuAOJ3
 h8gVMU9+gXflYNU8YasPql1XWXoHAUl0mnkp8rb/VzOKpyGyZgBsU9eb8Rpteg0Q==
X-Received: by 2002:a05:600c:a406:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-48fe63297b9mr253426765e9.25.1779202046228; 
 Tue, 19 May 2026 07:47:26 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fffb9aac4sm399886605e9.9.2026.05.19.07.47.25
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:47:25 -0700 (PDT)
Message-ID: <6a0c77fd.7ba9b9ff.39add.4ee0@mx.google.com>
To: "Michael Menasherov via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260507111809.28934-3-mmenashe@redhat.com>
Date: Tue, 19 May 2026 14:47:25 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] futex_wait07: Add EINTR error coverage test
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

> +{
> +	if (futex) {
> +		SAFE_MUNMAP((void *)futex, sizeof(*futex));
> +	}
> +}

Please run `make check` on patches because this is supposed to be
an error: 1 line statement doesn't require parenthesis.

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
