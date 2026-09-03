Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38090C61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 13:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788441961; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=t+tPDrkda4uUQlbqtfFN0F8xSI5bPkZcInK1UohHcIQ=;
 b=p/9vO7b4E8giXORHUDFR0Ad8ON8cMXHG7KWCb7R7pHqZA8ojB6ZdGOJ+3HEMv3I2B03xE
 8RnjfVAEGAa/EmtHY4bg6HA6fgbpJDsl5P9ADK+x4uYAJOJg9ta2svQNRmFug2DcffQRqo/
 XEdtQdq4CM1/rA0TkXxas8/0Ct8CL84=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47FA43E71B6
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:26:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7678A3C064D
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:25:41 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F0CAD200B00
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:25:40 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so24070655e9.1
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788441940; x=1789046740; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=G51wvgHTY2VPlELVE8JCv6mglBfE9AaXguEqPYC7JFvkvJ33B4qJnam6GQ4PeUZ/HB
 VGouiOY3NwpsQaYSFG3pLo52gJrZO6i90RQw8wUfsffGnS8dQCCCGnZ3dBnc+EkuOwTY
 EVK+ju5Z3N0gVPvG0ASx9Oh9ouyrZ7IcULcaXH0deOQ6xaVWmwXTGhow2bqVdYSfOmum
 NRlR9Si3X9NaimawRJCelaKb7eBWkDojoWSzWO81mpGn10jX+Xzus7N0xt0NHep8rVj0
 hx8656r9DeMQgmcjER1JIKgWCrduhUHatqEzieN9aCVMjIar3WES5rzd5Y+JwgXAXC2Z
 bjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788441940; x=1789046740;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=BGcbDyz8pPiQ777fr5OW7jnv3ilR+s5Uxj6lX/L6sk8AQZoFM00yeE0FnL+nRrKghM
 1wxMH8+2vF8qhZ+l8Vb10mYSiRbwRC4mcLZVgjHYjgbyP+VqPPjgtBeifvlLSIKjTGED
 buD0nUEWX3hVRS2ehBINbFDOMFf5qmO5jSW1IkQjsVyDh3nk2gZkYv+pNS+OCniaAsdt
 M+StMBZCOK/8RAK8Th/scCrJ1XJmOifGXKYlWIn4NjAFLTlRqu1ZYhgsNpqeYZcULJHd
 794ubBhYz7KEeEsUcIdfAzSxc3P8BxmDXyYis3XQapgaLLxTVcj/BKJlJAi0YKUVl9m3
 ET6g==
X-Gm-Message-State: AFuF++m0cv+Z9JMGAoJ/VcRLY+B+C6SF3i77X23UM69LvnrXF1hESXrC
 VfNtNYrKseg/aCUwsJiCfEd94BRxRKg/3PSo64arZxFXEdBU7d6CYnrYEbCl3EZWIp4uL49sH+g
 TgffjEUD35A==
X-Gm-Gg: AYBFou3bRgn9MbN/Tg0a+6yo5fiiZrRZk8MNUOCsIhzpkIOUp72iE80ZzE2kSk5mt/v
 R1H8Kxf0uvC0RsrLVLVynapjSOXyTPRJpcuFJrlE6cRn2SfVvX0aXXrCyk9JGdZ0BMVeTqYMOH9
 COYyHVxq7sG5ZHtaFZIth9Ah4niqDEbGY7weYiKOATu3Zbah9xg+kS3DdteMjocILZBpQNmec5K
 fTAGskQ5MQLZPVWdajwGZI5EqaN1CHCFCvB2urH4Py1WuQbN/zJGvyqcC7AusYB2BndsLQQ+uZ/
 mGvRuipqmJ4giBhEYznmZm7C2uN7Su/aK2PJoANIUGNQOQsquDhhQMEfywGJNFn3sE3dww61tZB
 HOct5Ff9/1HwLFZJ68FnX/tmRzrWfwnNgPqJOxzA+mVZ1qtd40/OVicnRxRvd1REaE1994weJ8M
 UkFSngBQi8DElWzoN320W/gd21cdXD/WQDdJfBEXrM6QN1uW1nXhNWp0IjuSretix/rPvPb/0U/
 9v/cWpc+u7C
X-Received: by 2002:a05:600c:1f88:b0:49c:ee01:8c53 with SMTP id
 5b1f17b1804b1-49cee018c5dmr47368955e9.2.1788441940277; 
 Thu, 03 Sep 2026 06:25:40 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f912esm72031915e9.4.2026.09.03.06.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:25:39 -0700 (PDT)
Message-ID: <6a997553.f3563870.1e679.79e2@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260828152631.254653-1-avinesh.kumar@suse.com>
Date: Thu, 03 Sep 2026 13:25:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] uevent02: Make wait_for_uevents()
 order-independent
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

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
