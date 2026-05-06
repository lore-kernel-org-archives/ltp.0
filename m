Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A9CCD3440
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778082604; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=R3M7Im2mvf3VPriZpKnHaxxfXavT9V45BBkqOPpiPHxn+wyJFAdp2bj+Qdc48nsauSRTQ
 G9G4JX61L3lYqJUpY0YaLckhxUor2fdMh3IDcf76YQPjRPyfY/EQgaTuV4Cbvmdehm7OdM8
 eZlRawHl+fsCJQJ4q3jYGU67LpcBakI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C321F3E6166
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 17:50:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE43D3CBC10
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:49:42 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2A1D1200AF8
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:49:42 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso3175333f8f.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778082581; x=1778687381; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=JaZOirxaYaaHMGp7STLyFRH0yGucSnM2fBeqaqWGndh+u0DWtc2sQXs1tyzz2/bsqE
 P/6zAh47YjbDkjMvp58bGvxa2CCd5BfllskhxmoMD422/uRrU77EMBs9rz4G8qI/l4cw
 2SeWeenc89zSpjlx7hx9V5pdY93iQN/avF2HdT24b6VNe9IaMtlSOn4GVI17vXZzKzoQ
 ca3mZxSGmLpiD7J+ybxbxo0iAVa8+lbHTL+Xe3HiXtZe1DBB0vNSCCUujjd80+noUcGB
 xIGO/y6SyZIYNf3C9Bdmo395RVb1tj7xuB0eTsaA86gC+mad6CWnV+rmeWyiczR3gNd0
 2Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778082581; x=1778687381;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=RWbGYfc7j0NfUk/Junhe+IM5q0osDEweSXZECimPf/be4zfDbCHrq1UHQYDhFbfgxP
 QsVoPuh1QPgmCfB2RCyHUSTL49jzrygP50t17/2Z5ovL3A+Mb6KhXI7iT5wzVkN9eGVj
 VVJ0AcUPOTZzIRLkgvowotPEyCVSz9ZGqhMFYf4cZV4kZnTQut2KPEFSSU7/+QJaRnqv
 5b/Zb/riVcPPCYenM6PpZFofoZIs1JIIaE44Emg2n/ImA7zyHqVrMDYoUIWKoB90b+e2
 f+9bvaXCySgQlo0xpVXjplRd4rGQlZWBj2oy+gTT8jgE48YbHJxGJIANuDPkjIr9ncl4
 +b0g==
X-Gm-Message-State: AOJu0Yw6VFhsQANQx/hDfeeKRuqhJ8ePmyr2+vm1a2wYyUUA8TNrhAC9
 iHK2F1fc4DYnJpuDxyoBx0/PV3aFi09bUb2r6yNTx9ERFzWhyYEPEvBxhLDAChp3Za8XuGaJ1q5
 mGtHs2rXs1A==
X-Gm-Gg: AeBDievYmBn/IAKemJXN2HpgzU2AQnhmpxws/AmxJemFgyo/flYNutRmNVvvRHQR6ws
 vlKRyDtoATFoPoBBTBzEq5sshX2+Q32S15gJvWTt+dvHCrT88z+t1dhSdz9y0Jxhw8g32QAaRZS
 uDCAI8TPEAz19u7EwI3sZvxx5n+jn/bh/RXQ3KOsVFbmQjN1EHAvPml9vyMaL2aMlzx7v0/56UR
 CXMqaUknVbhA0YeWeMr758W93cpeTBSEyPgMz5+G2WUSH+r2byjQT6h0wGuKkNYmHAz+V+rt5y9
 1qAz9/Pv0/WOni4SdTdflgJzpA62iZrtkbtPN6qy+ICRK5ZyZ2jMZq6/nVco5uHs2xLI2qwyyIi
 L9Yg6C7iTcZa2xHVtPl1W7Ypdq6ALxhjAjNP94yjXqU+o5QjaOZobHj8x40L7/QJeoOXZQFHRTB
 diUyAGE/tlJtpsfPZFwZWagpoODO2N+FXfIgbnlUzqAaX9EPZOAGNg+YS8Uq57JJd9WBaXkTDQF
 o91tH/L0+7ShJhUGToqc7PiRpyn9w6YTX0q1vDCxiT/7g==
X-Received: by 2002:a05:6000:2c05:b0:44a:aa3c:5927 with SMTP id
 ffacd0b85a97d-4515d5c69b6mr7169754f8f.29.1778082581117; 
 Wed, 06 May 2026 08:49:41 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-450524833e1sm13633559f8f.2.2026.05.06.08.49.40
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:49:40 -0700 (PDT)
Message-ID: <69fb6314.df0a0220.2eadbc.7aed@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260430063326.53566-1-avinesh.kumar@suse.com>
Date: Wed, 06 May 2026 15:49:40 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fsmount02: fix invalid-flags test
 failure on Linux 7.1+
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
