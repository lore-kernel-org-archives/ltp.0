Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144C1FF885A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 07:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777362050; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=HyZd6Es2ZllT+tWOII91Z9SNRz/weajIWW2hl/p4xS0=;
 b=lnKfoXGKM9NbLUjx1I3woSQR5zRpEeRJFCR8lBS2FiGogc1kBhSPAjI9F+AdaOtG26ES8
 GP9sYKSMTa4szGmh47T4moXRdBXCmyq2okeXLlg6ADtvb0ryOwFCG3O3aAQ5goT4/EFJs9e
 FRvakU+kMcXtXpUwnmlPPVz1S1BJEHU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF75F3E211D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:40:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FA833C682F
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:40:27 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E007910009A5
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:40:26 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso156096665e9.3
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777362026; x=1777966826; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+NpGHfkAKAUS6pQeZW8AEfDVTthSsGItiG6lkIgLCz0=;
 b=ZU20hByullHtYv2FeQqAyZgk2A+Fyh4zBcd0X6smwuW6EACtu5MG64Po0yANW+wM+d
 d0mnFeHCncGAYUzj3AbGoXlxgnXWnkgcHO1jPd+mKtUIQ5ezEvhEQj/g6nOZNjlhf9o7
 sIZVGer+u7WMMvaBtBuXyWi7hcyZZP/zChTBdlgObcNXqd7BnARPqx0JuABernsR2med
 UboWvB6FPwXjzsM3tRHNtzwG8CjAChq8hfn/y8XSGshXuDEKjCdm0KBRm+wA7dCaqLaQ
 SmrWZT61MRDZLi4m3HQCUSF778cFqZW3PxJA5MzX3jQv/G7wBjiAPLWZctms2vRQ6V6k
 Lejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777362026; x=1777966826;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NpGHfkAKAUS6pQeZW8AEfDVTthSsGItiG6lkIgLCz0=;
 b=EqUD1RVXjgi0o/ggO06q7trEEmN3kAiPlndgXMoiGGdLQZvbhmpAls3Jlm86qfZMg3
 s7M3cPcXGHoyXjgPrGowyacNOYWiA0nFo6AHgvdvETIhWBZDMct/YSSYXAZG6tuZUL9W
 OGt/NWWuyvBBNuNHjtmzkocCrioPwTB3JXmKLptHb/y6Vssk5PJ2wpIBwO1nePxPUmQF
 s44SH+MsP+yNAPdac3nIr7f9sjGsAEu0Ewx4J2iFpoKMHkpordLJUGMBXws5xIOh1G2Y
 gNZ6sOERDClxvO9XzhF+Rt/XbSb012aJRF6MY70fbk0r6wb90EBYnk7nxFmcCLxzZRD4
 DbVg==
X-Gm-Message-State: AOJu0YyAVdUjdkaGTRIpL+J2NaGJoMA4EM4wFlBgnMo0XoKPk3Cr1XTk
 kbVBWNeLKz3foFTyUywlDL9vnvY3XNqLs+hBcBeLeH9IVeSDQewtKxlIxF9BRvDZ724=
X-Gm-Gg: AeBDietpy4xrNok2I1VGDERUL62VTzfg1ozTsUXkpQCXuz8RojM9rG9LV2LBswaUD6r
 ts5MYlC5IFVlYwuDeBt1hqO4LVWd0v8dgjAPYZ4PGpdJWOt9E7caxal+E0OVJxooyTKklxiV1yv
 PBIVSBl6XMQvrx7acuSRiRYK8F4Al1zG23OGS+mqt6PdxjwzsoKToMtDyTOexj1kEvCMOnKyjK2
 Jx2Iwlzbs8umBWsL3J8dZ61HKC2Fevcx0vNtx0ipS5u2CtIufSDfgQhdqasqWD4yBT1POoN40ou
 7XnmPHBm5RhlqKo1bu92ek3mvqwY/mwYJAJL7vA0Vr0DNBmX79rks7Nh9DAG2ofPrECLRo28X25
 jCn/dbD89mI9HB1be2FhevpUJdNpmI2zqTeX0lzEWCz5vIXp/0Z8Qn4djAkXIXKz8zgwHF2p9eh
 539EQAvCxS5Ur/3les6870eJePuATyMNtJ29eceRjQ/FpOu85jJgZwMNOwmzv/4Y8=
X-Received: by 2002:a05:600c:3b1b:b0:48a:56de:d62a with SMTP id
 5b1f17b1804b1-48a77afdb10mr29611635e9.11.1777362026242; 
 Tue, 28 Apr 2026 00:40:26 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77af28e6sm31816385e9.6.2026.04.28.00.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:40:25 -0700 (PDT)
Message-ID: <69f06469.050a0220.971a9.2df0@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260423095834.11932-2-chrubis@suse.cz>
Date: Tue, 28 Apr 2026 07:40:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/8] syscalls: Add epoll_create03
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
