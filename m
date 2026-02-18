Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E06E9A03B
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771413885; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=x5whaO3yIJzFR2/cjW7HH8f7zxb/oBBei65bycfj3no=;
 b=nKHT8aPZEQzcIgq0cI0r5/b9uaJmp/0LNzW4ND/acpqjtF7T6iDo6qm45YkgHlnD6Dm53
 NdMLUbn9l8Hw02X9rNb60NXujyKBIJV4/Hnho0zppdzA/0GMomMUp8x/nVvOTHGKY8mpLCR
 Lr+oAwd2BmaS6BPm1q3MjZtY+imyT+k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70A5F3D06F0
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 12:24:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E2513C65E2
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 12:24:23 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 844E2140012E
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 12:24:22 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4376c0bffc1so3970831f8f.0
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 03:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771413862; x=1772018662; darn=lists.linux.it;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5rKEaRM0Lo0EIU53lTYzyxiwqF3MmsIvG2tdQpWxU4=;
 b=gj7OwbmOrqNutasmwpWjGNP76y2umTgAircC0WvkyLMvi/68DPJppm8kHCwMT+jpFq
 eOXelMqpXghC+WRWdTszUnhVpvr5xReUeOwNaRrmWY0UrYxrFeKpgzlyuZEvfrOEyPOH
 lVAk3NbRKOt9+As4Do+zlaMSqz3AQh2OQLvjEZ8gSrHkMQC09isbtIDR5+a+KWw1hvGe
 mPzQXYeaRNkMIAsUGmaiAZ7UCO9oxa6ag5TWJBRBLcW5+Gm/DyMHjxaA/sx9Zf6Y8rd2
 kd6sz0ae672U/t3nZWoKEZl25uvcSwMjda5cpzv6bFFW4ipan41A5aARn+zRfvvJgJbk
 fWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771413862; x=1772018662;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k5rKEaRM0Lo0EIU53lTYzyxiwqF3MmsIvG2tdQpWxU4=;
 b=mIUBneR6yp4zc8xdH1lSBAsXYqW/rRywXnKorrsRUI2QE1/gaHERxe7O8HiiguMjLM
 YlK28fxnXANdPYy5fppfiiBhYdr7oZzeE28KgKBeppWQk+jgsleTxTpiiKFs8lvDfUWP
 D9KCxF0WreFuYZpgKukBaDg6jRbfGjjuDyXizLDbjwds/5j/nK/ZJ9PksjKr/w0/7UyQ
 2zZhU1KwByPYVcqdkNbYkQp/WdHoZVwqoiCYPWUiL3OsF7hJVYLk7MCmxUsEDlvg+8P/
 55QqqPYO1BQUmOUxrT7Z8xNheQBd4z/C/y/48CbIQFbED1f0xeoK3RScfXsy2UNhEgBC
 XAPw==
X-Gm-Message-State: AOJu0Yy/gquNXfmzQszrUO2JAwCbY1ZGxZNyJufmPNipkSvbzCdv7pBd
 wRx4KKqFO7qTQAxGGbv4ObtYd25zUq9npCyrdjMi4No2RXzTwuX1H8wSGl/Q5PMmJ2SRTKHI6+S
 WMknqlJE=
X-Gm-Gg: AZuq6aIdelKty9DZx7Lrj6W/vtfcmXAE+8utSqaB148z5wAmDT+fP9vdFNavRoJIYos
 3zePgnzC1yV7swsUkwQ0yRl8OFpNTxoXSxmqoNA+zpZy2Jz+88O+R0qFRrooeWgNZSbXnXyt/z8
 hmktopHnFxTESh7dMdtKQE53yOSnXHLy8h6RYEO3HrxTotEST+JPb62R0xK5gQPLRermH6WeZMh
 GB6UeQ3iA53W5jC23vVqMf/7o2RFABu9D24vStx1TdQb0A6EJZ+P0qBEmKBWtQzDRfBvDeTNau6
 CK+/UmZhsNXbMKvK+Z9O4Rlsl1beKYrZYlDEKj3RkZFBOttTXnOfdLuSiaZLk7dLDkrd1oiGWFh
 Tkx07+PtINt1JsXQE6hp+pqM3f8ISzba5HEa9HFer6IZvprOvg/Q9t8n7erBtpl89LbsYiW62Fs
 7PtFMJCcw/WFtlqiUcu/a9hk19cPeaRvgVh4xphmH2qmpPZgRORt7ST7R4tRS90q86dHv5A70Kz
 1z0kUj4mxGTSF8M2Es=
X-Received: by 2002:a05:600c:4104:b0:480:4a4f:c36f with SMTP id
 5b1f17b1804b1-4839b4c703cmr8575715e9.21.1771413861769; 
 Wed, 18 Feb 2026 03:24:21 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483801ff9b3sm296293465e9.13.2026.02.18.03.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 03:24:21 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 18 Feb 2026 12:24:20 +0100
Message-Id: <DGI1T1ECNGG3.2GYTW6XD9IX4B@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.18.2
References: <20260210-fix_cpuset_memory_spread_warnings-v1-1-3e97d58e35a2@suse.com>
 <aZWVX9Rlf966N244@yuki.lan>
In-Reply-To: <aZWVX9Rlf966N244@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers: reduce number of warnings caused by
 grep
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged.


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
