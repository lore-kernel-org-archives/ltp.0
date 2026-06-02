Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BED5CD6E4A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780392738; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=hMPyY0FVPDexKt0owG7t6W7SWrDKMwmm8zF64DBY4GvOVmXU1Y+AY+bZgBulrbXp/Nbs5
 1fDBsNFQ2IAEn3k/pMCEr0Yurkye8pauoFU3EjtBoSsnLlSmAtpGstnomH0JXVJLIMxv4ZR
 zpRwxY9jfsb8rOJGO7igO3r1+StsQFA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A1D93E30BF
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 11:32:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6A6E3D0861
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 11:31:56 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 11D451A01525
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 11:31:56 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so2583010f8f.0
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 02:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780392715; x=1780997515; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=d8UQ90TegeTw7UZgt8tqrHDi0lT5bGX0oPb1Km4kKelESrgfooM++Jr7WuY/unxLkr
 J5YeVOhfHPG4/m+61sEs96ex1dGF2BO7ncT0VJ/963pIG0GuPE8YMAr+Mj49/i4WkVep
 pFGcJRnVMcdbSAxyX7X1UKwfeNCl7iPce1Zqn5SnRRBLINIDzgC+KVkOw661l2ldobqS
 cf0j/qA6kTCwGkEPUXVnETeK6vpufTZ1UltRBstdmoHpi4wGBdCfFJS8Ur+UWjQzzFMI
 Q+OM5gnhEPeWptCTy0MBcpJuyzRm3gw62qlOjKHaF5ZvbJDIbtGoyZUv4niMMN4h1WJN
 Hl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780392715; x=1780997515;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=rNYoaOB7VBuV0ZZhEREk+D2swpqg4RQFukMc+zXGa88fqTu6EKjZkuJ8QQxZi0KGK2
 uSAeoXGydr8NdBoWFeMNZU1aJvItptoK8z0UdNqtLndiQKkxGPGis/hLyiooc8s5i+K7
 oJP5DffPGASsXEEWerQBY8NIrDd0TyUPby/Z1PcLh1Q0CwKPHKvH6d0w/aRGhoZhIO7N
 IH2nZug1U6ylzD2vGJ9qQ9o2qf+tgUASvALSoUGmIiOy73ea/7z49uaGdxaakGQk77aD
 5dFc8HlS2Ki8eFWCDT1wHLHmGrD8qll+FGMIUYCPg8XYUu3OpotECN9wpzXNfm9GFLhN
 l9MA==
X-Gm-Message-State: AOJu0YyDtKKdmhpGQ2/b0F7b5gMxaWr5qAvTxinQgDVADBCNIeYJw6tt
 wuxdB2aZlmswlFlWgu2nd1v/rGJJlwPg8lk+PIMjSv39HjFwQSpsVauczeIBmH9xf7QvPNBuBe8
 9TFyfsD8=
X-Gm-Gg: Acq92OERM01t1LVYwcMiu0jf4iZRodDykCCL+SjHryIEpOz/LM7ewVcxgEIymCaWIxI
 FDUDV3hPLoc5FHM64lGoKDJeuGU9+S0k4Xe/Vlbj+Y0WEBL5WRRNwA1UI80V56unP3TWuzZY7Ke
 qiaYBbQqZkRzg3vujEIVKqIUhn8r1YnKUPVHGzyS+tN3FwE8n7IP2URYiYmlkjCIcdY6jdPBRDQ
 HLrBgQFCIUYePnfVpNunQB8QpGejQ6Tsgw6lMgKYYw6tIURq9a00v+u0rfmccUU64Rii3BkIMnq
 ST6B+FRpNY2V/02IhdEmeNcUzfy2OfJOC7TpznfS08B1FzCMLEyGCH6hm71lxN9buy+ErfMN9Ft
 IJ7AtGdq+J6tvj058IgiV9jWPDNiDi/dK0803fF6vHCgFX5/8iOxX7aPPCDhEI/7RsxM9cht47S
 UNH/7QjkztGVcQfpsndY/CO+yq8WRMg4J4foMVQiOYaJYdHQGJO5j5W6h+KnTlKZACwk7/WQDv/
 xyua3XEuyVje5p+sSG43HO1w/sp3uAUgx6upF1YnY5Fek8+olSrkqAht5rZbmK+XFve51FKHPRk
 JObvzZsGVuPx
X-Received: by 2002:adf:fe90:0:b0:45e:ee20:b897 with SMTP id
 ffacd0b85a97d-45ef6aeccb9mr19811464f8f.6.1780392715354; 
 Tue, 02 Jun 2026 02:31:55 -0700 (PDT)
Received: from p200300ef2f13eb0055088da49ee1ea7a.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34bd896sm30663957f8f.14.2026.06.02.02.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:31:54 -0700 (PDT)
Message-ID: <6a1ea30a.283787d8.b405f.c74e@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260601-doc_update-v1-0-b0f59834fbae@suse.com>
Date: Tue, 02 Jun 2026 09:31:54 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] Fix documentation issues
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
