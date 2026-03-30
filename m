Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B76FC97E2
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 08:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774860896; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=APKeqPfTKnlJRl39u72vSP2QcRUKQdwj0rd6SSSxEBg=;
 b=LP4tXJhOIGcSZDafB60NSjeIo8NTkzm9RkG36quACeuiYP5F2RamHVePcatnI85lfK1Ke
 f/NuTwlFVbZZqlogdGq+yLR5uR2kb5g3MocJMCZzDm3GrH6UtwX0O7GooQV9QEp+/TqjZJd
 GPW4ys/MXLtBnQjubao3JKCQrfEni2g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4ADF73C0372
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:54:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78C603C0372
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:54:32 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D42661A00342
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:54:31 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439d8df7620so2973739f8f.0
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774860871; x=1775465671; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kKd1sUkewpw0J5x7ZqjRO1jMbrZv2yBgttePtuN56Qk=;
 b=HTjXsF4VnafGn/CpsCwLO0n0hKt0iDOLawBNsofLXwc4xCarPLXvS2KWYtItaoPLQx
 ovXif3obT1hyU04iPbCdfN/DQJY2rTMLYyDc1agkmrT/jR3bEmyLzDodLF4rElWtt43U
 I+jMIeWqDOvXVYuxbfzqGTu9oot1k3UNRTlHrwJOZTQ1NqKVhTMtgH6ZU0oROWjDXbxi
 PmHRYMLnJSS61PNTcg7F8CbdmF5BpBPI6m+pKpHELFXqpHVf91awFFtRsQxBlpNFcZZV
 Cl7eWD7YYgfXMrOgJ9rY52r10rD68hLyfgUoxrNQVDvtnM332Auj2zlGVNKZFeqRxcx3
 4Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774860871; x=1775465671;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKd1sUkewpw0J5x7ZqjRO1jMbrZv2yBgttePtuN56Qk=;
 b=I5Ei+IGmu/IhG7JB+3CNetHSETYzwsb4LUC/qItvHwkK08dPv9O3LmTaeGYIacshNt
 UepPqWGpJyecOcXKK8PnZpGA08CF2IzdVve+SPquPFNR1E+Z4segfa+ahwUPWTEkuTcU
 DU2l5Gh8djw/84SzXSxKxfpTWWjPtMUHWsmkDuzC99cR6TQNm5S/3qt/DnY5lvUzYCx+
 AQV2NiunulD1aD/iU+blKvaPVA1wJY9rx316Gcts9NMjid9b4PfHbgT5I3gYrwBMQW4x
 ZkyPN0fCmikMhMHgwy2iAX8HPGMe2nc6692/NQdORpuBsqusZ9WZuXxZL3ZYgIpg6QwH
 BqYg==
X-Gm-Message-State: AOJu0YxRftgHrDg85axjgCz9M8OkKadE+Cwc9pbHwS1lRSTlQ7JpH8kV
 QY6aPW9/CqkMrxsS6aFv+6/lhIvUE0eZDvxZg1ksnL4S8EythAZ+20JscO3yVYwwLmjyeJADt6x
 VSx123VI=
X-Gm-Gg: ATEYQzyx60rBEbCjboNKEUI42ldE+ucvd96vwVEHRF8ltYKunBafOyktQHL7hWgtfqJ
 b14rwBEN/u5PlolWvYfKc3p7mZhYgvQy1ctI/06CiRAQmcSpY6/G8KuAhrm08PZIoCnR4PgbTr8
 ywc6NfLr7tVOwb9+ejvIx2RsBacSRhtcKQ4Ww9HsD+9lb0X96UiRVO1jNQ+hefsXTRU/CFzy8qd
 RCJQgF7RhR6GELO3BBFAQ2IMjnrG7PwanO/RzjUam6SScRLQsuMSxCtU6bDjkgO/hSzOeGWjKZb
 SGpQ6XqJCltnszXiyAuNbBHK2ck+5Yd27elzb1fAfbkicqiydIBvme1rpJglbp9BA8GBnJXZgRs
 8u5aKnrK4TffagURHKum+XxynbvTps0nMb/2qBvbEvUR6CxuaVXc39/fOpNGoZsQf00R2Y6vZHH
 Nc2Dmjb6FJwBuzm1bS1a66ALcMUqgzCxcuuRq7XA0SJ1bzm+JBllw7vUkt4FJ4dxDmQl1xRww7k
 ZXLtgfaFO7CDH8el3VZsZexqLWrb4Sk7Hqwj3mrX4BYLA==
X-Received: by 2002:a05:6000:4027:b0:43b:5095:d101 with SMTP id
 ffacd0b85a97d-43b9ea4ab20mr19752400f8f.27.1774860871205; 
 Mon, 30 Mar 2026 01:54:31 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e2727sm18948147f8f.2.2026.03.30.01.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 01:54:30 -0700 (PDT)
Message-ID: <69ca3a46.df0a0220.a2812.a956@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260327173252.1112192-2-pvorel@suse.cz>
Date: Mon, 30 Mar 2026 08:54:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] lib: Ignore empty LTP_ENABLE_DEBUG
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
