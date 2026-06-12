Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BB5CD98CE
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 14:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781274494; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=uH22vIRb8/GngLLexzJ2WLJzRojZ+K1hDYt7VfOrayk=;
 b=fxDQSDKY7j+dBRdxxx75Lkifsxj7sGGmCKAnLPwsB8sRLH11whRbAlKBqqluq8jdHgvTh
 eT1KbinZUfPQmDGzWeF3yZv4yKJiofybA4gvpNktCKA0Q1H7U16nKDVxmqN6E8WmoDZIncE
 iwe0S9TDuOpl4dZEAmkWx0SISTZ7+z4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E5333E6A53
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 16:28:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D40A3C8445
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 16:27:53 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5EA131A009BC
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 16:27:53 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so1069174f8f.3
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 07:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781274473; x=1781879273; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ANlgxzfNGp+mdoPUrUlYIpbuU3kDFQFAuHbqBNXUjXA=;
 b=G8cZvkQDajq2+Ccz74pA72fNJLcEk0N7fKWXBI7v2xEx0M0A5f+CxejXJ8K/PchsqY
 iETKe771/ZukCo3b2csd3LXc1YYPrLKSIeJdJZKJcmeoGdmaeJi4xKJHA0vMAiCGF7tw
 FXtE58C+onX92zycmpJ2WI1kD/w0GkzrBnYcEoEmMTkP41eZeALIBCKdHBUCmidwCNAd
 jbXbTaBQKn1BxCl4yxhU5rZzPczGIwTCztRee/POavRKDha2n5A73R3HZntIzYazoNIF
 FwKxDx9r2hgKs0PZPF5svp/OwyW9RJn1s9yTxJw2dp5kDjntp/tHdBVMaug+vKklh/CW
 PCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781274473; x=1781879273;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANlgxzfNGp+mdoPUrUlYIpbuU3kDFQFAuHbqBNXUjXA=;
 b=WLfw/MGHrUGAbwUPhKbaqPgKTRqJd7uM9cUgby9bwxDYImWvFQ2Aoj8PZXeLazuFCh
 1bbm7waUGCFCE/weRxLc2NNpDCDfvKAixDudMLhtLDwFDe+UsqF/fUzX9bs9Ke9jc8Ib
 ockhSdTvBo3S6E3ygrk6XPjAnsr0OrBjf4Fu30840qVaideJutuAd3BpYZCQSdD8eAjF
 8fFXTdg17b4h1u7q4DaJOGgY2o0zud1osZGCw1ipmVfks1MqG4asDdkcPEHNi18oezJF
 Id0uzUYI7u4uN/VTTMmU0ZLb3UgzyoP2uY8kHxgRZlH2/3+Brgq4uDytTNzBB68U3kEj
 xetw==
X-Gm-Message-State: AOJu0YxHdIGET1ofVaRdFw9VoV7gZsPYxnP4m5z49xHjwemOD8+K++HX
 727WlEQ5oXqJkBoK/lUOxr29j1103fgvQfhg2twIb+u2Y4XOYUMV5I8ub93qSFS5hfw=
X-Gm-Gg: Acq92OFRwPLxHrNfhYKkxFYnKk77iyC6vFUkSlBvMkPthlbeiO6QGB2pV7+jyv1DIcm
 kHCeVQF2hEZenopDmiyPPYEPIbPdgieeYO6YEe5e6r12TUhoueHqf7DCcLBf2+pq5oVmeNVZlPO
 YvqvRCd7KGkLwUNlFJBBQTbesyxPfyMzvZOYUuWhbERJdM2PuEpWKRthbyJUiPmlQ9QgfwCAkC9
 SrLTW8If8fBtlpPTjNUNCjfSiMY1Fs5hUxgvq9EFJy/9pqtnkk5xVI1ZdLjq5TRv8Aw7v042pXb
 tXU+OLiX4aq6YHVBLnjWrC1U5I9oWgiFOdG0k9DQnTMV8IKAoVCgHxPJwULfSpzEk437aZixh0t
 yRcjC9TJJpLUn5+rw7AIpmsWc/N9X6vKWB8IGfdG1XdCrgJDy7pd+lZ+asyU/qdw3usV855fa4+
 TG5bW73q148l0IhuM3m42X8PGRdV82dhsRnT/ElMZPcFuZFJUGTdHchw8qJdY24DwkMJWB9DXp
X-Received: by 2002:a05:6000:4818:b0:446:96b1:f53 with SMTP id
 ffacd0b85a97d-4606dbad462mr4283475f8f.26.1781274472566; 
 Fri, 12 Jun 2026 07:27:52 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm6522422f8f.11.2026.06.12.07.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 07:27:52 -0700 (PDT)
Message-ID: <6a2c1768.2224f9ac.1726e2.df83@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260612-doc_add_missing_headers-v8-0-a4639c49cad8@suse.com>
Date: Fri, 12 Jun 2026 14:27:51 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 0/2] doc: Add missing headers and complete API
 docs
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

Merged, with suggested @cyril suggestions and agent error
discovery.

Thanks,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
