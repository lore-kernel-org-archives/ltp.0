Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D69CCD98E2
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 10:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781691600; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=pFZx/hJloOEF+T82nZzR4Nd27aP5Pkvfb90xfAGgWtl18actTI2f8iz2RGYB5eg46OtFB
 hTqDGoG1sHj4dHq/fzcnm7U2OEME/s7dd+yZ6KXM5MLVIbPo/mc/HiOvzPCTb6ptI6YDYn1
 peazz8kVcG4geMAHvGE4l9T8ItBqUP4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F421C3E5931
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 12:19:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A25763E1C49
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 12:19:41 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 260866008E8
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 12:19:40 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-461a5a39da1so1360343f8f.2
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781691579; x=1782296379; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=UGHPVlttecrCbmWWPzZ1629u4edXqH3s+yaeHEcvUdMBrwHRM88zorWKK6DRos0wSh
 22AhB19LPSa4MKtyg7sNePp9J0DvgA6WHt2mH6L6npoBE3Q8ournR5iYuiLeyj498a/L
 67njNsZVvKtr1+30DsTAUuHx25OzQdc7M8sR1qEB09n4kGmdkzw1hQMD9WbdfXDJmWCH
 ZD1Pdi17F4ADPNn/67saz287CyypDiQu8dvkvPgoZthafM0vqF3m7W9SYW1R6yXDmtNf
 1VXWHM9m7PnVhqe6WVRIOD8oOQvIZaxbqV5KR9tHrrjybMPplAtj/7mR7+p9kpH8Iyvh
 xuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691579; x=1782296379;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=KSZiUU3AdnIbb/M02CwSeTvU6ejWqqOX8rimPoVPnYXYkDtEUc1G69nyzxCCynbvvq
 WsJXbk5nLsCpP5+IuuBP1vYyDFeOZ8/EtFCALQxWpVfQgFSleM0bZ1ntW3SGXjDKKAS5
 XKNTiqlgd1xnyLy0Q8YAKK1b0AbpRvJvyHko0FDwMxwT8MZPfmJ8O2G7nmKghHLFjQNt
 cdpBO20ynHc9j4I8wUvduEyISwYSn7CkOGzpFsV0LgbxHzRd8UIkThrcVQ70ddspUC6Z
 pGXkZEmU8UsFNRgMJJxpOHY486wj0myUPX2H5UKwMRaXaVsrnwYEIPu+vQwYdfbjFeD1
 tcNA==
X-Gm-Message-State: AOJu0Yyh86Au4cdBrN9vhVLC+276GuvmWIIVWuTlG5tPyB5Yxq3ndW/D
 c+SQcRVcwNCihrepjBtpGbEE6LzJ+GLYX9vbHzn6YFI+VZeXZOHglSDUEYOjrXOyLsM=
X-Gm-Gg: Acq92OFvMp24uRNnWTiAg2ox0a+9NTMBrBCodlkx/7NgmWq7Qh1U9OwtmyKRNmym15F
 J2RVAC5XwjsjrR6e9RHl7iR2ocybDmz489/AfVAi6s3DVW4ShwMd5CcbX7PL7JVir8WaZovsoFF
 HmXfzA3ohw7qq5LBGq58d/VmkSdl+qWB83HOitXgCb74ypVRgLs/ntHeqEbsLgw9FovzUqZ11e3
 ZQkWbAnHV6FUH4DNt5Mc2zKebP7BfUFTYkYqI6SOEhoV0ysRyaepTLxbJMpu66jxNCkRSu15s+O
 5pEoTSiOHt4IHLhPDmNBxb1R59amj6SaxvtsDXwYDX7hvE8m2m0UCUE/l4FW2kjP2/axMSrXe3t
 GZfmKvkHB+0j/mi8GALiIg4Kg3bhNRMmWSquj5GGEA2+CAvFdes8VASfh5IgOnjiOeSLGY3uYsL
 dIKT+B6BTxAEFzk5wvteZcAxLoEgKzlboq2LveVxKF/RQiypIt42bTLtfMp99edeWsiZXqF468+
 QXqEPeEsM584yIUAvKJawYrilrxbjC9b0sj/K9KHSCayUS4W/0tRLIw7IWOgBmHQJ4=
X-Received: by 2002:a05:600c:4e02:b0:490:c2a3:1781 with SMTP id
 5b1f17b1804b1-492333f7765mr57048645e9.34.1781691579413; 
 Wed, 17 Jun 2026 03:19:39 -0700 (PDT)
Received: from p200300ef2f13eb00c15f82d9757402d3.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4f8d7sm143783545e9.5.2026.06.17.03.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:19:39 -0700 (PDT)
Message-ID: <6a3274bb.2cf1dda8.28cc7c.2624@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260615142526.70655-1-mdoucha@suse.cz>
Date: Wed, 17 Jun 2026 10:19:38 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: Remove pthread_detach_1-2
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
