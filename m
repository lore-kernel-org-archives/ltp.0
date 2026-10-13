Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF42CC6B08
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791902425; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=NDBrw+ICYIrIMWhaBGx2ZPzSdN63o1+S/fO6qYJaxGklKot4l76S24vBQSidBHRtSm3X5
 15MOTQicB3PuVzcsWN5SwQTpneu7K0YtFFUgI+CaPZYOZtVnQXbFtreybO0Sj1hy0e0nAWc
 E0YNGnx2phQDVL2nqatx57WBfJHc+Is=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8135B3EA83B
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 16:40:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E84FE3EA83B
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 16:40:04 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6556110009CE
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 16:40:04 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so30366905e9.0
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791902404; x=1792507204; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=SbOd1IBKWiodM6C1apGbjU6M+sUtnzwfu9vyXnQVUeSnVuKb0WwYxSRh4JKfkK/Qcr
 vYdOa8JGaPr9Eu4lZ8AJKlExuhK3jMoP77I6/i89+UCj/uO1raDC/bWjFLZAPH0mmY8Z
 vZT1cxn9ZKFJg2fNHvtMSA92WtaXLi3wtCFLZrinEfOsiBnRkUj+MLWte00z3p+GdP6c
 rEQfgC0v6bu9hTMcEUXUztIWr9yVjsId3yKOLBZ2Dq9qwudOjuYz+io0RyvvHr7MRcIq
 falCmvqlj/vDpsrTe1YY7edlxF3V3hiDUZ7SYbGH9+Pq2dqiU3qGR3nmDICr1KZvEj/q
 +V/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791902404; x=1792507204;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=d1Dpyc/qvko4x+BV33igpmxGMgeV7MF8kHHguzPyKJu5IBScGw+yp22h9VbMyFwZVU
 HL3uMfqOGzrB+729tL2fonWaPdnX/eKcH+0DJk/C7Rclc1Q8FrR6rwia6pB1yALZzw6i
 cnGCY9x38xiZtsZFXNZHcBwrxlk/8cDoQEeNeRW4nJsML1E3QYtLfzAi3Pxgz8RlqmCX
 awmfmsT1Ig8fFzbdKTAN62ZQpIbM+3qdL1+P+8PBqXl2W03mNgrALTbGlP6YhQCb1YfX
 boQ35DD9CLHzH8wvxSDxZJwW18VDWRdtd+fUipmA66wnJwSHi8/dvjuauybkJgvhQ6pG
 0zLQ==
X-Gm-Message-State: AFq9FYIQYsmjUcmAk1N25gxow7NH1ImMm8plv0MzZozMCHGtrvD66zbG
 dDOSw3/AgcJqUjQiKAzPce2WJ/0uipPOSgNpv3ELbThggac7wHaDQWkiSOTTvknbliznRHIjR8k
 XOznpKWov7Q==
X-Gm-Gg: AYBFou0a8RNbem1ITsiF8lNG/sErGCiL4BeUaWwAnRivAFjyd4rD53Y3vtUwwQV/LIZ
 043Ff0I7Hena599Hd0OpkK/L4mUUMCnzgrt5lMhz1mqYHroExeqHOMopUz+AFXDIugttTCLcYpm
 Ke6oGIe/AALFQ/YQExdCVOWfUU90VcjjfBPFoVCYDIsHila/qfOY9Nz/+AJhtno1krsLihzQCiH
 zJoOLMkcyAPhXHkpyM1ccr/GZ56BzsR3gdyQ0ApoTz/AOfkNY/fQw0L8GSeRqXoKbVfdOszHcyZ
 Wqz5h/BMfWgmnukofldPptEhm92f0fWUw81GLpuiMRrhUgQ3stZzCc49TqFfRcVDV8DTtdW+fkA
 TRVAlT0I7laUswa16wMvI2R6VzyZ0SVj/JVwHVU+/B9q+GUjQyFRxXnSIqWBAdg/5cpGVkBMy0C
 Vn3oq6SXmPVzLW04oXGGcHQYmzNkpKwsdXCS5ZNWiaGUjP9LRDfCnRUZbRR+V4gYMv7d+fm35SI
 It7cam93hSteNPKI0tTxOKUP54oq80w2IGfgfzT0UH5eko=
X-Received: by 2002:a05:600c:1909:b0:4a1:722a:d2a3 with SMTP id
 5b1f17b1804b1-4a18e4a3f5amr282888745e9.23.1791902402986; 
 Tue, 13 Oct 2026 07:40:02 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf1358asm371364365e9.4.2026.10.13.07.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:40:02 -0700 (PDT)
Message-ID: <usjSmIvlIlfOMg33P0K5SIydxxzMPuHJgoVL@localhost.localdomain>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20261005061933.4108985-1-wakel@google.com>
Date: Tue, 13 Oct 2026 14:40:02 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pathconf01: Allow EINVAL where POSIX leaves
 support unspecified
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
