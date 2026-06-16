Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA85CD98CF
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781598297; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=h+eJG9gvUEdIQvliyi8Nind7IoDnaUd8n9HwonrtFKI=;
 b=FECi4gK1kCJF3V/ESdvnEQtnrMUTwZ2vgnFi+g1/cpfi+TJeCcOg1bgHcIJPl515YHul4
 DhlJTVHfdSHyCi0IEGb4y0EOjVI+WOrLmv90UFFI2fY2L1bTEuve2ktFKpdse/8AAyf9pXh
 +5GRpCyu/n//vWB+9f0ZyT1ec/TSZkw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58D123E5969
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:24:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AC983C96A5
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:24:36 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E3C0D10009E5
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:24:35 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so2405097f8f.2
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 01:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781598275; x=1782203075; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FHMZwvfwjgTVB39Jhl4dAM5FEQkv6/XWd2YbbFQ9S08=;
 b=HXTXJUFmZ7HvHwSQgb09C50nXREqo1v46dw1iKAPE6abGtwh0o6y1hQCW4zoZ4r4O8
 61vB3Ibi8BpEFUTJ9CFkC6t8HiwQhP0fOg+9P66pgzivzJlXa8wEDllYXrRI2AR0f1Nw
 Uo4kUmxoAUvwa99ABFvSOeMRa83eTRO6ORkN9gwkRcaArRBI08MSO8uQOdb2dxUqAU09
 r+X/iyfI8jiIv8QHMv0TVTS6/6i2eqh93acSEwaDn+4evWrBx5wX1xiID5UZQGuenWk2
 A5HlCXk6Kz1OQiSU1dC0pKAnwSTwDYO1ajjtBT/EZb/+wJIAMSOrXX8G8vmMJmj0GMKm
 Abcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781598275; x=1782203075;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHMZwvfwjgTVB39Jhl4dAM5FEQkv6/XWd2YbbFQ9S08=;
 b=ZeQZN9mHrSm+t4BlvWtPc5QuGpZdms+x51osEb9NV648hjDvOJaYzxdGHw+nYyVlCH
 +Xyucdu7AVYPaE/wcSKxTiec6BTsWmdmUm9AgmohzEPNh6xFzp6ZY/7PnBpz8xV0PfVg
 IAU+dAaWvvpPidT1xU+ub3QyheqNUzo8Wcm9glqoIY7ZmNRjxeNedcKgm+mS6ocGoiT1
 7qfsJRFFhKNIz7Lt2id3s++97LRJqFIbrJNbhXy8J4LljQ2v0fC1xwxf/+qAEvjuBWon
 eizZLcItrB2kb/1GuIi2J1Y1qbSV9EvjGTJv/0JrkieBh8/r+gayhqN4c3EimLPqT4xT
 ONdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ER5Rlzm4PugAn/n56wmNSmZWGsVnIBFCXAHmxR+jpMUv07De3CY0MNfcdHvc8hGkox4g=@lists.linux.it
X-Gm-Message-State: AOJu0YzlSWVy8xzSlONiL3UClIpcA7OM5yGhV57ZcxzZxpfcr2XG2b9j
 ntMWTeJp4HiwXBtvwHrxBgkbcEiLSYl2crJV99gL1utcOm1bKcrKIgZQBLBvGZJySis=
X-Gm-Gg: Acq92OH2R3G6XxPEEbFhNeI+aE2LlZCAXezymZzSLg4k9FgsnHhwKyQW6UKOnBam7s0
 FlBjtwE+bA/F8ickZiN5mMFiWhaefhtwmx5arFKzaenfJOAJCyzbCNDgcf+d4h+Hqf9YAEvho0o
 bCQ9LZVIHSE6y1vlTSMxWu4WIVKNHieP6f2KCjwOxnsmurMA6LvPDStbE/9dR7moJe64lueMYPx
 GTACiZOnTlXLzVHp54jZnZdbHVdmAmD3un27lNQYX9w7AJONxX4qWyMkTq88iYRiaeLdTA76ZAZ
 yhXaRcBY1XVxqc1ZwnqAGgGXzHIPVEY13Fi+7MbECt8mlGyXn3xrZSBhc6M/BDtmT+bnD//gIDi
 v2gNMZIUHj3bXbHFERUIMn4L8410zsRw5xsq52Uc4j5vzRCUQss2uiWrYOv3qpXCQRlTzlgLz8I
 pwmzhyjV+N+YAlirmxgIR1zD4ChTONh1JFkQPvJ/TaWjdIBOG3hqNgGlKIzzmEVnlEdqNgHkFk8
 PvFkppoTA8N3cuEJjbFCXy4yD5u8egISA0=
X-Received: by 2002:a5d:5d06:0:b0:461:a161:b625 with SMTP id
 ffacd0b85a97d-461a161b669mr3298850f8f.17.1781598275074; 
 Tue, 16 Jun 2026 01:24:35 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d4fsm46130609f8f.24.2026.06.16.01.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 01:24:34 -0700 (PDT)
Message-ID: <6a310842.7d2905a5.2ed87e.3229@mx.google.com>
To: AnonymeMeow <anonymemeow@gmail.com>
In-Reply-To: <20260615180629.7148-5-anonymemeow@gmail.com>
Date: Tue, 16 Jun 2026 08:24:33 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] fanotify21: Add test variants for
 FAN_REPORT_TID
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
Cc: amir73il@gmail.com, jack@suse.cz, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

the patch-set is failing to compile on our CI. Please send a new
version fixing it:

https://github.com/linux-test-project/ltp/actions/runs/27572447779/job/81512172691

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
