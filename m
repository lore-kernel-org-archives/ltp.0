Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36987CDE000
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 12:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782392076; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=T3rXaUVa72ckZsRnNBhvYMdc2lvBaMyy+9qjmSpDRtJcRenWXVY/LEEam6DtERaELYCO6
 MohSLI2YByWNZfmJB0lEUW/JdyFE+qbhLwD9zT3Bs0sNz46bvD0fVvZt1bvQD+zHTsyNlut
 rmXY4SYSX5LmM2CE1tz0hDw+35yRlEI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D24CE3E4D8D
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 14:54:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA1AF3C5AED
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 14:54:17 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 07A90600838
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 14:54:16 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-464192ab2e1so1600396f8f.0
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782392055; x=1782996855; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=H12e6bGSD5UTI/jAz2291T+srTQtsMFYv8zZUIu5ygyx8l5/akcddEhGGA9MVsNxeK
 SoAlCCNKgGqjY6buIAc8a24lAVgJV4fTjXFtDLDtJuVK8Dn47ishD59v1TMELsed1nnd
 NLxquR8+xIue5dGHvCXF5mJ/QyGkpN7pATdb0KP062ur6Vkyqyd78qtLykDQW4cB4jyP
 g2AjM1ePvXgHJoDHSL5JrW2gzGglRgO1vy3T6p4lUEFTCip0MQ8+8E1EkjKSCAxXRWn2
 8iaSZHX06J7hR+/rMShm9DItGQk42ohO8o8RHdhE8TxOMPMyaytzwB2SeX+0vPMUEatj
 6W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782392055; x=1782996855;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=C9AyVQzCwitVcd69KD7gE7/xiYuWGuTAjoExAwNABvdB5jJiFd4zTQHNUMFdwC3BIt
 IB99SEqi+BruXLzE05yQEXswa413FSmcLslsOsqlgke/A6I9vX0f0KvG42DpYfMlenoP
 eBcAnPzfyGGFDL9i+j7wPMvjAAitcsmWXrcWIwO3uc79PIYySb4QkXAx0WAtUbOfZLVu
 xJTPJVInq+5MSLKwVXdUlENnMpuWinwY8rVLF1jbjJJ14E1FqzTXfBWbbvThBEqmWqxS
 qwE2/Eezm4fHoDGzuLbCBiuhVbBMHkFSWqQZKJfq1zAtBBEwW3of13drBFfoDJ/x7gsQ
 9/6A==
X-Gm-Message-State: AOJu0YwoBGW8dwj03EppOZgIk0e3hQepETsxlOJlJK1sPPtyBo2o+Bkd
 1iYWajWMN1Rrr4MmIokIe/6iyYFYx6SyHxC47I+5LMki+0J8u05FfNmE/JN6gr8XpRqmNpQ5+X9
 a3yRBDVeaTQ==
X-Gm-Gg: AfdE7cldS6dPNP7SPPYgPlw6cTPs6YHC86qCfMP6pL0q2rnPf/nMMy8533PRpk42LoG
 BRPCktT4gmFszrw29akuME6d5/25KhoCGlhG2z8jkH/hVPoYo1I8MrCnz7w07CODri4MR9/rHbs
 zN39kGXophfD/a8cyQg0JZfPmiNCs8uoWiVhd8DxSS2MuSLw0OMGqS7+ZtUfyD+9fisI7LVrgKP
 ueVOfkcYD3Or4KK/eVhRb/VEzgV9JXEcqrobIgLhCemS8L3ui7q5drQmvE7gHXc/1EeFe91INry
 O97YFxbxBQ9f/AppcXzAS34S9HgIQyZ2KA7P5CwsYtWEbqW8dNkJ8UOiN1/+LKo13bPPpa1PjKv
 VJnSn7bOF/of63fLiQhJdmyKsJkb7Un99yf2HbmqIqWBCuFM6hyzFI2MWpsn89KdXYurthGsf3G
 R4Hyt1zZEDz4bNri7om2CjOdarj4m5iRZzHZZfFMqbt9RpuIRCCvuuz53XhU10GQ==
X-Received: by 2002:a05:6000:2c10:b0:465:81cb:bb20 with SMTP id
 ffacd0b85a97d-46dbef257e0mr3988868f8f.9.1782392055211; 
 Thu, 25 Jun 2026 05:54:15 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46e6167c05fsm724395f8f.25.2026.06.25.05.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 05:54:14 -0700 (PDT)
Message-ID: <6a3d24f6.debf6761.389056.9b08@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260624091900.4107041-5-chrubis@suse.cz>
Date: Thu, 25 Jun 2026 12:54:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 04/13] tst_run_shell: Add support for groups in
 the env JSON
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
