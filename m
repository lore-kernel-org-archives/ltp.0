Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1640106F311
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 10:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774519312; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=VhCA8cw/3vhUsd0X/eBhV779OECwUcgvOanqwB4FKWI=;
 b=BkdbuUc84aat7sSgL8hz9K0e0sAym+4A8q2gmBDSOeDgp7gf7EFvy4xBqNAHPh4c5R9bc
 NxokB8WsdHcQXBIhq2TSVnUXZ0A9dVdlBjfGIeAIy9fV3/oqyQP03wvPnkzXzimFeJCrpjW
 vLhteVQmbXwcva3H3TbJDY+tJfQUMfI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21C273E2AC1
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 11:01:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CF3B3E2735
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:01:27 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EBFAD1A008B2
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:01:16 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so7092865e9.0
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 03:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774519276; x=1775124076; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Yl079hKQcShQ6h7tcWkYBwOl/EUgRVwTpAW2t1xWIKE=;
 b=DuUR7I48xaUZNidU6BgitzbxOBzKMojACZrZ0M1T+3Dawknjv2+hIQeSAhGOIzVvBq
 rCnmxZ5lw7iMBti7jUwVarOF8PHPhoDj7dW+2ZMUjS0GrL5OrtvZfGjqgLBoqpFZXITb
 muoc7p2VluYdI55K0sqmRtN2w77Gyw1Z9Ry8sKl0qR/jwN0M9W2623E4tZkHoKuZy2V0
 +zwrR31NpS0wn/l0scdP/Hf6FCnBtGdlG/HT5Trt9FoiTRudHZ4fkzi9nUFTkTsaynVM
 0dP1D5Y0Nq+uFqaD1Qkt7FHZQGhscTZuOmIFo2Gh89zDquE4aTOlC7rtYYcV3cxlcGWF
 vieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774519276; x=1775124076;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yl079hKQcShQ6h7tcWkYBwOl/EUgRVwTpAW2t1xWIKE=;
 b=o/kaW9BFJByh69fKMGQP9Yo17hVU2vcy8ynZNC5wrF0eywX2JIDrN4iLHAgIcF+fbu
 Tzvtu0sMbq1Z8X7WtWk1qbyqZ7SW/xe8/M0p0jeGwp8IklfrtBBKkeQimRvhWDRFZXJV
 fD6ozq0bWlldoV20tneLhu5QwTTKQzDJwuKw4VECcEJdesK+NuoBeOmH2PzDzFJMGHlb
 3KUFUa8d7U0+fghqJApQWhl/CsRknYVbr4kDb9mrXSkQTSB4+UDSKILPe6tKXER3H87x
 k6HPgPK6+6Gt9CZMiIYyG93bmgay7xi31hCgTJXyEEZAU1OlCUFH5UexE7hyF4RJRmnl
 yGww==
X-Gm-Message-State: AOJu0YwYzl9s5pFpC5n8RW9JaTVJosayg1NPWdVKETDyHN64QBKbdwDt
 3lTxiX/fbuFJ6aBod7dVHrxtL7v0XekdBB31s+qzpKV+3xHdtav8+2OZpbAMKVtfU3k=
X-Gm-Gg: ATEYQzywKvEcfXpI9ajjkVVPohq8XF2vC133JoyQr9Rrw702UhsfY20rgANchQbDBwW
 dCCOenKd+dmI1wgAzXPlnKMhNkRmcsvUIVPKjW1T2TFHZlMsVH+aliliPv0GDDEXVeR7YYv5GQG
 QGnXRPoyjKJJyipR6DU8bQ7tmD7fRDfsXf84qoN1L4yf2HdwIYjvjBEd5n4frtEJ2U7T8yTxol5
 s7ToTCR/oA6GJ4YWJOGHn3/7UcqNhOPIfNoUJLfsFYdfqM7IzH3j0RMJAcMw7NFCC7KNoFtNBCt
 v6VQOtKiiUm70/9qKbQFqVTVEOUa+LQQagbLz7o59zey+/LKFowA7UMc0F4/43hYZBaygFVLAjd
 KCiWax2EMOIlup2W8vdeJDV43VuCR/T/0ipyXJ72PFVZ88UY+XI/hs8vzvUROtIH2jmWtNM6bgb
 TJq7ayh+NcUe+GBidTBocoRxkm6qxiOUv+Gw5O0nvZpeyk9fNlxhoqmjTcoy9MRs9C8DazwqUNa
 IaEwAr/2hfGx1OzpyRt4z+CHLKRQRPV7D4=
X-Received: by 2002:a05:600c:4b89:b0:487:219e:42d with SMTP id
 5b1f17b1804b1-487219e05a4mr11428035e9.11.1774519276006; 
 Thu, 26 Mar 2026 03:01:16 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4872438891asm2694975e9.6.2026.03.26.03.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 03:01:15 -0700 (PDT)
Message-ID: <69c503eb.050a0220.3d57e6.08fc@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260325011605.5957-1-wegao@suse.com>
Date: Thu, 26 Mar 2026 10:01:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] mremap07.c: New case check mremap with
 MREMAP_DONTUNMAP
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

Hi Wei,

we are almost there to merge. A few comments below..

> This case test mremap() with MREMAP_DONTUNMAP and use userfaultfd
> verifies fault which triggered by accessing old memory region.

English can be improved a bit here:

Test mremap() with MREMAP_DONTUNMAP and verify that accessing the old
memory region triggers a page fault, which is then correctly handled
by a userfaultfd handler.

> +static void *fault_handler_thread(void *arg LTP_ATTRIBUTE_UNUSED)
> +{

Missing return NULL; in this function.

> +	if (strcmp(fault_addr, test_string) != 0)
> +		tst_res(TFAIL, "Verification failed: Content of the old "
> +			"address is '%s', expected '%s'", fault_addr, test_string);
> +	else
> +		tst_res(TPASS, "Verification passed: Content of the old "
> +			"address is correct after fault handling");
> +

We have TST_EXP_EQ_STR(fault_addr, test_string).

The rest is ok.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
