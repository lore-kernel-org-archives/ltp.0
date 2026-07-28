Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E498C54F4C
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 12:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785240395; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=RyzkeqRkMsfcnEpNsCLPTkwdxURQUCVzRik1AfqjCwq1PZMvfzVYTgeK8CoIfX9iCuTRZ
 wXVuwDscK2g/JqKhs4fsTR0Fnta+/3mULVfdv7HU/fKW0nKNUeG+xjVsCnlkT+poIgLggYv
 h8dWFSydXXsGoU+42I8ww2pz9jzW/u0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 788073E747F
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 14:06:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD6F63E7496
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 14:06:01 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6EFA0600075
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 14:06:01 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-472326ca506so2569928f8f.2
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 05:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785240361; x=1785845161; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Pvew7OkUQNgMlYzCNw8uBCiO7ZEnhqYsTSQw2Fp4Tc7YwJOxYWpjncCPs6FLBT+xZN
 56Ubs+3hBdpVqvDJr8WYaxFB4vlT1ptYWgoA87jCaWxHPEzskgc1N50tvFu0QOaDzTDQ
 Zwg0bKI+S5laCkBf+yLvRYUJrr5FEfNC0QYVbLlExIc/YIwnKBSZsfJfe6Wg876DpLE5
 HpnIoXdeP86v33Pyp0xaEo4Ht2PNJBaS9dt1Tl9825x3QJxrha6vB7niJqFo3dbGkNAZ
 fpaJBcVkcbJBX+QsLQ6a893OtuO65Y71aqKJ5sMktG2+KXSp7wWHwxR3W5wZRuiRGoVM
 IceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785240361; x=1785845161;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=YV11DqS7DtRt8vXiwIGaGgW9gmykal7XAVwyKAsR3NgRV3Jx6myjtlQ/T9eKDvIVoy
 dYn/WLYwQHBv03915QJQco/EwRT3u03i6Bl5inERpYdIo4nJf78A3jjai6bqYe3zNAJ6
 0L0DwAguzXLsb6Sfy4hoPkavBy10zRsdDo3A5R9GkNpCFX9xB2uM/LG2np4b/b58b0lG
 FAmFiSQ0IbRWSVjdl9pLOC2w15sZDkFFVmwNlOqYNVC5eDHcRKblNC3TRMYpSZnNOchi
 Ny2HEAQW1vyRJXBBwLOF+GO75ChicXPb2eNuF+kZd5SDn9RCPN3WcEfJRqXXa9ds10C/
 epOw==
X-Gm-Message-State: AOJu0YzEK91+wfHO/B5wApwsw0fyR8gV8cEBtbCUhss/Au/EOMFtmW5x
 klAHTfQH3g/NRgS+sBHxA9F9Y2oe/MNMJpdKmidsxoyrdfD718IzFBnHaK9zyHxIH1RPJnfPbGF
 oy89LlxkmwQ==
X-Gm-Gg: AR+sD11vlI5yfS8v/u7KEkBbqH9KOhPESnDWPs74JQhkdsZtTcAWvRGi3yWMlhYymhL
 0MnrtftRz+cm74wtpd6WS73ukLdPvKcQmLDtwpJRm5c2t+Am/3HwPAdF+rIgyvzSqRjvCE0I7px
 hnhJQOyddK32WFMOQLc1mgI2s1LgzVLPKMgUZMx5ECLqOWn+E2PwJLvz+gTIlqOKj3cTqDhyFGv
 PTeqAZbYK6zJVGOUwGhHBaKKHz91ezTP3Favh9j52U+EYJkYQpiJPlmbHLgyNed2O0u8kMAeyKU
 dcE17nqDJI/hkndVhvLa+cX4zWKsSaZzOBmYYGfI8VcbENoObpym0/NTSEkXoUuPB2EpSXZE24a
 iZSABapSXaVCWxF3vKmjlHy/oZgJHERkJPI/t0ADUZZtzl81a/5CznyhY4rtQxAxUv8EBBzoB5Z
 lLGx0JWo+fzl5pHrSkyDoUoQ==
X-Received: by 2002:a05:6000:2dc4:b0:47d:ed1d:e0e6 with SMTP id
 ffacd0b85a97d-47fb1f2a08dmr2535734f8f.55.1785240360770; 
 Tue, 28 Jul 2026 05:06:00 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5d9sm55956155f8f.5.2026.07.28.05.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:06:00 -0700 (PDT)
Message-ID: <6a689b28.b7086f8d.98294.c2c8@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <20260710091437.92148-2-sachinp@linux.ibm.com>
Date: Tue, 28 Jul 2026 12:05:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] mem/min_free_kbytes: refactor to use
 SAFE_FORK and simplify tune logic
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
