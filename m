Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6338AC4451C
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784637863; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=HGQ7rLRccLbdy9Lr+ZiIW9opS466S7tptlgLuJvhZm7bi+3hW5cHca/D6MLVdhIKlXI9s
 mPWIbKgTZXQivXcpp0dYqHfXGXVl2JJdNzbkgAiQWrReAqkhmqwCHik+m4wPMkP6mIlPB35
 Fr0EoQ4+k+KaRCF0JHRx4yJjtmNvNMM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05BE53E1C66
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 14:44:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04B143C1CBB
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:44:02 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 762836008A0
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:44:02 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4955158f26aso19327205e9.3
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784637842; x=1785242642; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=G6KD1aIxtFILzACKqXqAW346r8mD6VnnNfnEJwwdTGpW4tSS3Nfn5Qr9zwkgsH6qKJ
 n/1OmNCknRn9Mn/DdEP87Ew6pp9W1JOv6DFIukR45iMBxxjRn+xIjqTwqITXr5Q+FTAg
 5FHG04GQUgi95f4kqfYqRQ7v1cbz1XNixbsMnG+OioDN7/A3yoCRZCWqTMg04EA2/FXv
 gP4paSAe+lCpX1thu1HPJKVP3yvv64jn0MpQA2/vdvWgbkM0wiMNBIWSo3z6eAADEXYt
 soETCzPPfnVOUMJjx/e79MiYXvuaMR1HmOUFF9141Bfds/OHtS4F9zA7Ngabz2wH1H+b
 L5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784637842; x=1785242642;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=JaLR/uvDyW1JSoJkbWup+36i/QX8kKFDWHcqOEOvGdJycNo+HaAzi9eCOhAG+eOhn/
 xbH1ZGgmLryqQveOvxOZWxAOrIo4Pr26/8XYgirHXgr1kFT4nxScQawuWEfmPnx9UxqJ
 87ysuENw8k+/tzaqYhevDxPaI92Y+bqrZstP3e9R7Stu4AHx3Tj5FateDFZzIKNfnx00
 B2oF9FHJvVhMuyXUNV+SJXNu1mKf6GMen4g40jegoPGgyMxWChc1qrJ6jB5MkfmpkhUr
 IHCYkRKTa482w5rbQvJ2Oj9NolfHYRfPoWXEKX8iwbWnSgguctaZtVC+AnXVaVP04MI4
 EgSg==
X-Gm-Message-State: AOJu0YyIer2Fya6goV53QJ9mcRkjC5w89Yh9qXq3no6qSyj5yD2jkus8
 OhqPM3kO+6uG05RPqawyx2ZNTjdV2mznsVj5DhzxDeRSje8v6FQyHGBSQBKEeLAS/Pg=
X-Gm-Gg: AfdE7cnpMisR63gf2EMlkHJVEMN7wq/EaI63YffmO4MxHTUENt7yvRTymKLB+AwOHku
 c0+AzYGTnRCDV7ySDUi5fwWnF/YD0iXmktG6+nARojsgXNM3B39NZUXu0vLF+clJb7AcFqathZL
 /Odv7koNu/dksnEP3K5Npxx9Ya9WydtTosx3EA7Fyc+OmmHcsJo1Bx1m9flinE3BLGjzCYiT1kg
 BXb3xUBateq6gB7/RsAQZf7u6rxtTr39n0dflSVsAaIseXM5r0dbAWdHVB4zf7pUl9T3ORTXoXD
 3enUutC7SxmpSMR92zxXFwE47vC8qpKPM1nJTUowHZv+VCfJo06hEgyUDMTMm2ohAlvsahL/Dm0
 EsiynCSSUGD717IJGNr9OIy6qqkrDgr/MH8L+iW31AT+b5jVrirEFcGGSfkAjw8DYJj7Ss2dtPg
 mFtmbuC2JwJGSvXywlYpgA9I6qVQ==
X-Received: by 2002:a05:600c:c84:b0:495:4689:1e98 with SMTP id
 5b1f17b1804b1-4954a3ed426mr197720395e9.10.1784637841798; 
 Tue, 21 Jul 2026 05:44:01 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c8760sm61315035e9.14.2026.07.21.05.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 05:44:01 -0700 (PDT)
Message-ID: <6a5f6991.bf927062.8cfc4.5b49@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260720213610.627213-1-pvorel@suse.cz>
Date: Tue, 21 Jul 2026 12:44:00 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] setsockopt10: Fix running with more iterations
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
