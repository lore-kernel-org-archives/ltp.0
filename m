Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE72F3C985
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771944120; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Wfk4xEpsZVROzV0N0e3SuChL9KlOeX3vk3tHsiIT3B4=;
 b=dtLyMtZWL9ybs483KNSAfe/0TucsC0NfwZEpmL1qEC6WpOGHphPmrTKCfm8IxOq0uo0wP
 pGPQFQ21LDv6Wcm4zVYgcbPOLaLDRxodKD0RP0Wa3iR62gvWDJB1Lrxkrz6ZxwpwYQwVBw0
 HxwndUJ9UBvKZ7BVDmmg6rLIVCHSTVA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF4A73D0FC0
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 15:42:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F23D3E11C6
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 15:41:37 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DD30B600BA6
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 15:41:36 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso44045825e9.2
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 06:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771944096; x=1772548896; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWYXEUEifFZBMHeVmrbJAPnEJvyyfnEVusXUsSRAp9o=;
 b=OMyk48yDNVH66W7cq9V9TnVxv5iccjWbgSN3fwc65y/ve8XXogPHG1Zq+dMrVsaBxY
 ijJY2WDg9u8+KJL9XXAPDwCffLs7g2St7M/Q5jACW1lCkDtMU7UJqoOe4xgCcbq4ZY2z
 ppU2Ejxxey+S43VceeoHbxNxVZjc/OzxuyPTEKtDEYR5+WKt+xPqN00ar5N+XOjGzLgS
 A135P8/QiPsvfEPKiuByzif61Kb77F0K2zL/tR6gc3vF5jk1a1ZKlLWnAqfz95Ndq1Wv
 fCEKbCyllEx0zgpVgXLtXiZYVjmToNYF9JGAetRoUYa73PVPJ40EkTrKjX3rZ790yQ2l
 g5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944096; x=1772548896;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oWYXEUEifFZBMHeVmrbJAPnEJvyyfnEVusXUsSRAp9o=;
 b=vfLoSiEpHWUc/04B/LZsxEOvtuv6fSfIZGCihlJEWpKUkrgoPjVnecD9EcUpQll524
 cRrRVHctdepT8ib8r3jVkUuHOUpFI9J4nXKeAze6cxBQAT1ocR8TvoeJgfkyMwShjeYj
 YF6GqyEg3R5w6UIxTQSCQVk5gVfkmL0qvooUuG8hkjudDyQLNGEwbJBxDa41dzC6hU0g
 Sw0yYZuQzj09iE7rWZiQcPk4ZcJoaOHeF3VnC6hZLox28t/izzJa18tPBKZzFgQLZFbB
 pxQNDWRckaW4k+JFPs1O8Z9eI+sGeVGL/XIiyDPfWCSEVxHIRI/bEy/jaNTBpPz4LD2y
 uJpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJO5cNw+qEqUTzrM7UZL2brHrd9oGx/oyUF9YGqij58UDSuX+UYtAMPH0lm2/LnRXTEvk=@lists.linux.it
X-Gm-Message-State: AOJu0Yz5StUcRj+ae44R7XzUbwfY2clXk5WOHYx/XtKKLid8XZIeOQct
 5PgX5gdwYEEYDeosOzPnQxxPteBkMfSQjKFhFLmY649cZAMttXXX1Wj7qNqKWT9bHWY=
X-Gm-Gg: AZuq6aLYBhu+P7/rEB+gY7aNy/AOrOedfIT7Fya+iGJM1XjkeKvqzRbrtk9oFJpcObB
 uq0N9LI3tHhfDehsxyBMXI8/SsCsGnm04R2QKg6ItCrHU5wmNxGZz280nxA5KNScoZolRKXLwg5
 9lcJHsp7V68BzTfIlP7gO4chHUTYbM1LQ7Hh7hocsMqnFeJLW90QsTYrDTNFFU54Ml7r7l7U4KJ
 InmDEq8nUdZJoNX9z3c9vH2Z/SFu61FAaIH6afZrnxyUJVbkzoubdH8oKVCXH1zxCb6H+OSMY0H
 h0BxkvPVcZeU8uFIVhW0+oCCH+Va21CWy0M/6TOduid5fxhxa9boc1gaibK+I7dK2r991J7knfy
 BUyn8nmxvY0fFYuzm/OzhaiD8MNl3G+mTt+G5S+SoT2s9zTw5ZkRbs7Zt2mc0y2CZpSjynopmpc
 LihEhOXG11TQqs1fez7GUTp3bm7GyFaLOwLL4=
X-Received: by 2002:a05:600c:34c6:b0:477:7925:f7fb with SMTP id
 5b1f17b1804b1-483a95b71f1mr217578575e9.10.1771944096252; 
 Tue, 24 Feb 2026 06:41:36 -0800 (PST)
Received: from localhost ([88.128.90.16]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43987f3ed03sm5654217f8f.16.2026.02.24.06.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 06:41:35 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 24 Feb 2026 15:41:35 +0100
Message-Id: <DGN9RBN9A1RO.38OJVRJVY8RP4@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, <ppavlu@suse.cz>, <ltp@lists.linux.it>
References: <20260220154742.54150-1-mdoucha@suse.cz>
 <20260220154742.54150-3-mdoucha@suse.cz>
In-Reply-To: <20260220154742.54150-3-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add test for fanotify monitoring of tracing
 filesystem
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
