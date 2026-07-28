Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F0DC54F4C
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 13:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785244173; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=kKjDSA1iWRE4OPBMyBOf/wpwmFELiixtWeV1nJJHviE=;
 b=punpJslZCG2EEE3o+v9PYLk90WbJGb/10Ep3+KTqWIM1NrIAMZvROE8r48a/qVAlJ+yz2
 2rz19yUJaHjXw7pSMa7zWSbfK7KUcBl9q20WCEEm2S0hFEkSlj8ep+miowNGTKPogxUxsNP
 6qIxZuWyEaOMnDXxpNAT4v3sabgngoE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D50D53E74A1
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 15:09:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36E693E14C8
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:09:14 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 249541A008AC
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:09:13 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so2301425f8f.0
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 06:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785244152; x=1785848952; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uKm53rBBfhONradGdC1CIAwQHWfQcS78tq8hoWuCjZw=;
 b=AHA3PsxH9OQ56vgXN+Gq6eEtFgAiqxiJeaMQcKm367E2hiraj63eOO/SQqFFlPrabM
 +WHXR9QB7JTPyRm0q1Cuu5ewcusbY2IeTy2vXBwxal4IlLhcScTsWGsD45Qa0FuJ3jcf
 Z4uxgwGAQ3k2fDVe3rEM2gdnJYGi3NIJ4Jetgz8Gh0jvJBwlz1PIaavvx5ZLCCK+XFzo
 pCAQ4uu30mESNeSZqMXhoKvG//wlbYSoGJruTt4mSma5Z116HJylTtGSVP2qSAUW01Gf
 4cTd/8F7JNVLeHPTnRfHTDCU42qSJ6BZqiclF5cxEEkw9MDoeeThd1tm8m+ymYlp1jqN
 U67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244152; x=1785848952;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uKm53rBBfhONradGdC1CIAwQHWfQcS78tq8hoWuCjZw=;
 b=dRQJlLORAg9vVn5L8thgwTS1CI+GyhCtnLkMkJId67LPNJMSgNb4IXZTVvofhJ12Z7
 Cmu3dSPpL2G5s0mU9jtfHh+Z+Tusc7zGk8r51TYqJsLzBTB7wtWZ0F2CvXGWesSmS+aN
 9tQl/u4rmCPxAkCmsaMqYeYzQAYy8ozPLdSVk6SocuT6jWcVRsbtz2ftXqZ94k0H/8hW
 ryDXXVrsqE2o5IDaw7Bvm9EzJ8ys4724rIcRe0VODtHrEX2uT16IrjQtzEvBw0suzzmi
 NYJTXaK4hA0uSMh5A8c1tCJAeIvqqLx4oCZR90kQR1ABRnHpOxs+7rkvWh1FUHg1bMm0
 aXKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpCRj2v1icQORXKDvp7R5dZtqwkjgrVHwsRP8gfiqrpYoK5pMxLmXoK8R0ojRA+IAGwxk=@lists.linux.it
X-Gm-Message-State: AOJu0Ywwji2lveeKOSgu2vzXbD1SF3IWuMWsG86NK1444L00u3ZDTEeO
 AQ6+AawcYckXuGAaguUKsN357/HG5uRQBec3O3mG1PTxiWl/FYd39kDIvxFGmeHR+QqnThfUj2K
 XlZs8rVZzdA==
X-Gm-Gg: AR+sD131e11l7ZXsuZlCJFwLwFQ7A/AbGJfdgCjvKL9XOsZTsUTa5ZD1f67UWuS8eP9
 S9d0qEZ3umvBu8psjt1o3tvZL9jj1VJKS8RnRfFkybykh6HEW1er1v2Lm/4mrO5rXz5N7fxzF+f
 xuANGB1BDkuSx48FMlDdL7mJ+JdBTI3b5byK7AfRBCFjOxJ0nUShCeZdKVN4FfCh9fqQu2XgH71
 r0DqOFdw1qLEy+1dsRv5KS9rowYtJTZrwjGvxORiy+8d809Ph+1QZmVwVm7gZ/vL2TjK2NFRxgs
 FJy0UwdRbFMekuAvGWl4Zc4SKeWO/xY5YwihzpyqWY593NbiR1Lx05aMxqEKQ1F8D0hCPqvk+YS
 rWHD7vNF9GgIYb5LYijimCqeHbUnh3H3oPht7MhxVvUjN190FpY3uroCb46nUVULdGisLyfu8T/
 iSk1cRTmgGfxxeEy1kuLU/cg==
X-Received: by 2002:a5d:64c6:0:b0:47f:6e23:64d6 with SMTP id
 ffacd0b85a97d-47fb1ed9641mr2910125f8f.16.1785244152490; 
 Tue, 28 Jul 2026 06:09:12 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f939c1465sm43222303f8f.26.2026.07.28.06.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:09:12 -0700 (PDT)
Message-ID: <6a68a9f8.16149c93.4e438.be9a@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6a68a078.dda25a5e.283880.f17c@mx.google.com>
Date: Tue, 28 Jul 2026 13:09:11 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] min_free_kbytes: Handle transient memory drops in
 check_monitor
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
Cc: Wei Gao via ltp <ltp@lists.linux.it>, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I also forgot that maybe you can check the TST_RETRY_FUNC
TST_RETRY_FN_EXP_BACKOFF usage. That might be suited for our usecase.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
