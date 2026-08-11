Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B65C5AC67
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 08:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786437701; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=Ai9IGZoRDTba8pyNXkF5stq9ekYqQn6iKRNigJ5rHq1LYZuRwYrfEEDnbznp9vqwMYRab
 xzCcIwATglgwzZ/2SIwL4y2LtA4H8Gym+9wow1JqU/Vn/yw/G13j0rK3g/I4kHZxLmi+kZO
 shFMR3v6EXU3++QRgo0yQ3Fmdqp/TtE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1404D3D077B
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 10:41:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54C393CB2CF
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 10:41:20 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8EBF11000246
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 10:41:20 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-480033bdcf4so1593237f8f.2
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786437680; x=1787042480; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=XC1D33vqkFWoARMBPNpvoL/yHhZUEUaFSKyJ454HQztIKMKeboYoWP0QBwn2sHacTj
 ipf5rPZ3I6G0iI5ckZIYv3jN+MxYaVq+OdqMspCDFWEzfKHqHVtCqr/ynXehz4/Pp5A+
 UPY+F2M52T64ehu6PvNTHMIWeVTrkAC1IH+Z/DgXPXWiqUbjuVrSmZvwXk0bOUQYsmTp
 CFMNrNSW/fk9nmfXX2EQQ8740J2F7v7om06VBXSX3+0xY2wuGDI1MDNCcKKrzJ9R6R/P
 hZj0YrvYCCd4AcNeDFGX0heJ0bQYZ1G/atV+EZuxkZRcjcFAqULGeq5Eb5t3uy6VhZo8
 wrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786437680; x=1787042480;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=ff87QYrXoKoztlOsqN/0uOr4AfNROwznjZtsxQLNmoi3uCxrt0wfYf0TX08q8680YM
 s/1c9itDiLWqwUJCDtGDsZaXPwydlzQaI+EAjV8/SWo0Q8byzO3YGW+FTxeRI7kEB9t8
 y+QIylwzmnqDIL43q8rEfNk7Gt70hMSAheuL3bJwM5dMAHif0arQ4DK9s53ijqYKsbQE
 6t1YdaVRW74ybpmGSFgWKAyf2To+qExGw3j8HjgGn2p8oHVexXALOymzPTt0UbJjFPKF
 fSWABFYdb4ua5JQNUEaGJT7NYJL5CbEDbuiK4L7QEIByxoVXFhI3vrZ/DYsKp+BQFgdA
 dhSg==
X-Gm-Message-State: AOJu0Yw2bQj3OHvu2q6AT9K36YwWeXTWa2TOlTUUrW4GZYNfuLd1+l7z
 lqPP1N1CjwmWVaMPfqPxgvH6bR1hD8zVphOlg65GUnG9qOsKdYp2ujvyKbPA3j6eCA2AoVPRepm
 uo9+Vvfs=
X-Gm-Gg: AR+sD10jnF9UqZYVZMt1LL/VnihbEfCQOhmXb3Pjd16rhsZ3Sbxs9RNOkPQk+Ny3hsx
 idnZiSl3zKPdRPS+uorLwszJ6jfyROPsOdwO2EAit8T3rDp5AwXeFCLt7NCgA5Mp7drRmUJxee7
 ulNgfKzikAoTPpmcdPpVxvtpA62yclRNpUdUNbwkAjo4n9sOLxsQJOcJayQQ620dL9aHj8NPfmK
 zziFmsxEq0axMmNKwTUnkbJbwv8hBtwKQy+9f0pPfu4pEsJsoqZa+CVNPD5QL5IdDAQHOYrdRlS
 Z3nV918oi3wCqSSZe9cVkp5N/cmM7tQMVdGr/X5KfUL+AGFhRUZkwa6T8Y8v7EfbsO1hYNS7F4o
 HdzDkOEMHddiU2vKdCdMbfbE4D7/TpEcziFCyC7lG1C3ggvYXdluj8xqbF25FV3Ct29B/zq8UbK
 HwSqUfRdybTjnDwUTdmzgaqZRUxaqti0d+Aj0TBTlWspzxotjXm6sSorZgoeFyncfYQvkLP9CpF
 BiqKIsX
X-Received: by 2002:a05:6000:40cb:b0:45e:e1a4:c4c3 with SMTP id
 ffacd0b85a97d-4814adafe03mr2575190f8f.15.1786437679895; 
 Tue, 11 Aug 2026 01:41:19 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a7097b8sm2558421f8f.21.2026.08.11.01.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 01:41:19 -0700 (PDT)
Message-ID: <6a7ae02f.e862d496.135d9f.ec95@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260806231423.17724-1-wegao@suse.com>
Date: Tue, 11 Aug 2026 08:41:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] min_free_kbytes: Handle transient memory drops
 in check_monitor
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
