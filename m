Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2091C61DC6
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787905852; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=AmNNVI/sCBK2z4BgHzpXfR8A2mtF8PcK1fsJ1duCGzE=;
 b=Iq5ddUjpzXqvMWfgiLU2Nd6KjKfVc91R8KhP8ZAWdwsd1QENgPJ/K/Z+s+FwlZKjNUPF4
 hbdRIY6U3l8U7UnjLdoanuIfSig1Mf9RiYOoz+o9QuHLjWZZV9JZtRhZJIAtHz7EacNqDwX
 nEyw2ZY/ALfSGCCxw/Uq3yfKHOROnrg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 425813DA1BE
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 10:30:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C97AD3DA1BE
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 10:30:32 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D26781400C64
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 10:30:31 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-482fc2b44a7so224916f8f.2
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787905831; x=1788510631; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GtumHM+XvoROVTlLYvhfX6Lvcik5vi1bLQM859i3vXA=;
 b=DPSMLyM9ranes0a0QxaVcW3W3NSN47LP0ZSsy2jzRtpvlBUtrJ75WGyvHo39XjeQu5
 vxYoBPDJa90dCK0ZKhu3pbPPZrmMBBYq7lYeWNpsh+xHqVkh4uIklf42SYgt7UxZznGW
 TD86ygS6fEBqbwlrqOsxCWK6VucW5oVxTuRQFtqAID/G5IUt9JKCHKIKzS4f6aPgmsYr
 I5avCcMQw47HaWmYABEHGKD54VT128s0evHWHyQ1bQiBpb6Hnq4t+3G0dA/GLxHLBRqx
 59/zwZEVocPbNa1Y3NkgAPRVPTDoxdpTCW4FGs4TUcrr476uc6jYptnrqqFhCssG66mx
 axnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787905831; x=1788510631;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GtumHM+XvoROVTlLYvhfX6Lvcik5vi1bLQM859i3vXA=;
 b=UKg7o43YP1VrusTq2VZY1oRbLFfszpkPE21CNcog/LzhkcvxtXmO23KmHeTgebcg/C
 XiaJONVPmx7zKG+BXtQNecrzmZAqdPQsOX6PkX54dJSeWpIFHEy6FGA401TyOReQuqy+
 3UEwfQsch5qFYF6+gayBtukrzOPj+9aUgTSoZ1djLIUt7QDpbYm/aj6qxsgEIboHABYk
 nfmMFTzxniWOz3KeQcb7zmbJExGaZtoHajHWh4ZnSo9u+b89BRfPfjeTb8viCUdEaqkt
 evbmsdww2WUmQW5neIOw5QIHc5xxEbBiiTlSufoycQAFswwrE5/HaoTLgHZO2ysCZ9xu
 Kcuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBYcK+n/x4g4kayxBP/jDG17vo+rK2mnQ6qcOvBCxbI/73yoocxDt/XzTTai5XhpS2noY=@lists.linux.it
X-Gm-Message-State: AFuF++lRebLfL6abAXpSVUbv4r8kZer8AzOL+FpNVTZmbs/z9Eh3g0hR
 EPl6LaBWAINlAm5Jb1R8lsevW7Ffx6PmB6bMesW6IJ+pv1nT3W6GI4/OOLVDOuXz55kcL2Y13Mt
 CJmaedYfN5A==
X-Gm-Gg: AR+sD128yQAd0r0BXo6JlbPyC0K/nM8c+7QyOJPa8Mo3e2k+cq0JUiy9BwgpgrjYbJ0
 f8vuYgU9uF/S8LjTo2Uxp6uhDSVQKxwt8uDdPMr/5Eqep+7iGMIOqYGlrdqX2frilPe49b+HlqU
 9ganoH+Uk5f9FxFkGuEyzNC8HCONKVmyhhPTMabuAGw/vJsTwp31+KAJFNGsbAUyRiVhQBhi3WG
 hQUvjsaYgzY2LDr7fM03GLZ/fgVpH0tkY8wk3zOf6wbk7sL2a6BxxwUw8AvtweI2XY6uAE43vFI
 Pp07+9Ld1qP5Xln1Dw08veFSh4XvJxkjw7vu8l+8mCTvRR1v7n8/fWe0O/TKamES1AvwO72P3Rb
 Ounn98Dk18jHQX1q5m3DUWY+gCiIIUekq47gt50HZkH6XyNneDMhL6hpeN0G3fOy9NBgHAAWas1
 +Y67nHA/UwgTFr8oF3dW6Ro+20dvXDPEMbTgYrR5H+AmFAnbXloJBhG+2uI5mJ616xA/J00VYUP
 NPiHESHoaKaKje2oWroDTFpE5xdgB1/iAY02rv0bcEgkCeFUkhMdv0grKjioLae7CVLN0I=
X-Received: by 2002:a5d:5e02:0:b0:482:e2f2:19c1 with SMTP id
 ffacd0b85a97d-482f7975f7emr6764686f8f.2.1787905803550; 
 Fri, 28 Aug 2026 01:30:03 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbac4f9esm2047939f8f.11.2026.08.28.01.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 01:30:03 -0700 (PDT)
Message-ID: <6a91470b.7557dadb.15e29c.77e9@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <apEHQxmBxBG4Vm7w@linux.dev>
Date: Fri, 28 Aug 2026 08:30:02 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] swapon04: Add test for discard flags
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> I encountered an intermittent failure on my x86_64 platform running kernel 6.6.
> This needs further investigation.
> 
> tst_test.c:1986: TINFO: === Testing on xfs ===
> tst_test.c:1291: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> tst_test.c:1303: TINFO: Mounting /dev/loop0 to /tmp/LTP_swa4Dz6aP/mntpoint fstyp=xfs flags=0
> tst_device.c:103: TINFO: Found free device 1 '/dev/loop1'
> swapon04.c:170: TPASS: blocks_after == blocks_before (32768)
> swapon04.c:168: TPASS: blocks_after <= max_header_blocks (8 <= 16)
> swapon04.c:168: TFAIL: blocks_after (32648) > max_header_blocks (16)
> swapon04.c:170: TPASS: blocks_after == blocks_before (32768)
> swapon04.c:168: TPASS: blocks_after <= max_header_blocks (8 <= 16)
> swapon04.c:170: TPASS: blocks_after == blocks_before (32768)
> swapon04.c:170: TPASS: blocks_after == blocks_before (32768)

this is interesting. Also I notice how it's hard to read the logs, so
I need a TINFO before the checks. But technically, this could be a kernel
bug: can you please add a sync() before stat() while we are getting the
blocks_after? We might need to flush the cache before reading the blocks.

	fd = SAFE_OPEN(BACKING_FILE, O_RDONLY);
	SAFE_FSYNC(fd);
	SAFE_CLOSE(fd);

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
