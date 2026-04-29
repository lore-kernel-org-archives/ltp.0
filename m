Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6A7FF887E
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777473783; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=PM4U/QTRiGzEgLOz8H9Av088KUq9WO+BC0UHuaPvyJB8IBKWmHYSWqQHuEZ56wt/Qh1V0
 zP/5EPIr69hfsOSAByJkQjssLmaezKAxzKsVZQGiPZny0873Ea3XNWMeqvUetTHSoM36o6g
 GaBd6AhoBH3acsTbZKNW2eoB0+gunMA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA8B83E49C0
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 16:43:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 850EF3E2587
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:42:39 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4BE582000C0
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:42:39 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso129315195e9.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777473759; x=1778078559; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=glTiIWszkC59ijx9V/on3MwzBs8A8eoMYC2BratvxvlVjthL+i0XWRrFSbKzC5qmKA
 U3yItp3EfwPowFOkZjZ1EFiUVeLthWxi8/u69aFZ3f6Hhjpjc0wWaJQNJyvY9lTzQQ/U
 VXeyroiY7MOYjnT6rzBlOz3j6PuKMcG4Sifortc4hf9+mcDgP9Iqa3iqc916G1zAELFz
 PJa0TkZV5MJypCfuYRseqL7evBive/+156ZVS/ZN2GWJ/Bey3iCnKh8fbtqFEvRMT6BM
 ipG+rf9eWmdliQyn3K5+fphdXU3WrJHjX/KCBzKI1fHLslG9QFg+SvbaVodb0bq1SNFP
 zdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473759; x=1778078559;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Gq9tofE1rwfRLwy8CzPcLtDlWQMgl5VKym7wRfXt9B/tLosM0xqgXd2x+qh7nEFcu5
 uD0amNKJm2JIXld5W0E6YgEZdLZiQdT/lAFgSOruXComY9q64aeyvAGidpuMJbveM6pV
 zj7NvxSOtPwVY5RR7W2CA+oSgr9QeN8RL+YWyrgmXtc3JdPdgjaxBPBj5zRZF2HZlkBx
 09cyBBWQ2jRmZzCIwDiBCuOaPvBYZCGoLatBBKjFPhrvyPuGFRBc71359B543eMDevyL
 SAkYy1yvMiag8JnvZJRanvNWIV84ZPjnHFm1b7kB/c+jFl0qzRHMf+aqIE13E5K4bRsa
 BoIA==
X-Gm-Message-State: AOJu0YwUeLAsRk8XXTIUIDN7x//6USowiTZQrqSiWls1CiVFiAjhqEYP
 3rCnlPLjdP+7Y6Q9fQSKkPhre2dKtsllDUt7rshyP3Rpzy6h2o7e8wLESVip/EHKuMk=
X-Gm-Gg: AeBDievz2hu5RTxbhf1zdHXOdf+4ZJmrS04HfOuIYpQlj+zx1GMPR3V9s8ysp0euG5n
 OOm8fNwMz7JmvtHcYIqBfLHTl2NviEi0LSnULYt8KwKoqc9hAnQtaKhnVHz3Jj11ogIez4448Vn
 yW+XKXB/I7m0LiEGDaak015FK9ED+/1+4QAP9TLXccj+2Pgo3mXQE1PQ2urQWF/PaSpfXUeML3s
 uWbv3OA2/P78lwrE8CVqb395qEQKnIvqFBgJWoQ8XhQbEQsSkOMOrobRXGH+0gzt3vZCl5bni/z
 F+lOxlIFefV9IuIQFAE6oFcBXRNIxi8a2X/zTCoKyLfuJBpD1WQzPLeQ8nkmyJxe+0DWanLF4l6
 ZzBhDwEfs9n+nEgdNnGIpUDQvY7G3j5me9K8QwpFJpaybGryrKseFFB6bYg/ZoV9FUGJrHZ4+ks
 hyQ4lIlshJE+nXe24zwpeJpvH2GhLkJsFUr0kwHtkB8LGgcXuOEQ==
X-Received: by 2002:a05:600c:528d:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-48a7b546b7dmr75550235e9.24.1777473758628; 
 Wed, 29 Apr 2026 07:42:38 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c32687esm19814835e9.33.2026.04.29.07.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:42:38 -0700 (PDT)
Message-ID: <69f218de.050a0220.5bcdb.a696@mx.google.com>
To: "Soma Das" <somadas1@linux.ibm.com>
In-Reply-To: <20260413180725.411367-1-somadas1@linux.ibm.com>
Date: Wed, 29 Apr 2026 14:42:37 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mq_unlink01: fix EEXIST failure when run in
 parallel
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
Cc: somadas1@linux.ibm.com, ltp@lists.linux.it
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
