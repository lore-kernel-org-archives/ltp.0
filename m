Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53722C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 07:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782806264; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=agmsvzqGKuyqFts40R/Qw0Ok0cuM11oCO0XOjOO4l/k33AwtEuxWgG3fxazHDlcmFssTA
 c4tqhoZbgfvVX1qlatpiku2iJc0k+QZwjIZAHx1sllFy4HQyK0MyuRRFqzStCsjzj6upvHP
 271iRgyq6J7SNuNVnPm87E41POGYmVY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5396A3E4B1F
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 09:57:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BD423E4AF4
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 09:57:24 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 96708600823
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 09:57:18 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4629051c946so228685f8f.1
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782806238; x=1783411038; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=N4FEjHwYm85lACpi+J7hDPm9gW0uEsEH2RfKQXrNy19t02Uh89Xf8xtJePqJkvDx1Y
 IKWKds0ceYkVMwsBpBtEJL4PoTaCFQFbauO3OqJHDEJA4UKXWg/+sJE+BbPxVLejJR5g
 dItDiH7SB48eXKMqcosQ+QQL/VCq8914n3W1oRs4gdp9EkWYxsoYqJf5kYg87m5aNhnk
 mhiU8cVd27cywJ8GW1YlLRp5Yab/INoHnqXTil56ey8aX4uC8SOLuEZ4Nn8FRWeiTqAa
 6cIyQlRXwu+w0SW4RKBlw8oD3XLhfWFpCii4GiKLYVZ/pf7i0q21LbwHhE6Lb3XF6Ann
 L1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782806238; x=1783411038;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=siw/nwNkHyXSSOfmVz8kf6eFISYSY+0OnriTQVgs8yLuX3KeWsR+LBjZkAkT16xgXS
 taWOgNspVHpGk9x6LKBaU3303PcWiB4vycc0umoL5sVcpQXQtFaL8457YAyDxySYJiqN
 qbZ0Uqxx1dIYWbxWx8FpvpugNAmGt2z+qipDXuK3EnxX8/UUQZMPDU2HZERKWtNhVZPB
 7dg3Yvbsk2CfWtCyMoO7KcKPRDyCbFFu+3Rof8ch/MSld25fFgWdBb4HMwPh/6O4nIJB
 rYm6OEnJ6sWJscQUHRnWikEWc4qMIWT5yjYGQx0PEWabaIiBKvg0VnjcHGWabbrw17vI
 9gHw==
X-Gm-Message-State: AOJu0YyEH9BBx8Kk7dGCyeG7xI0151dMJ/yvjOodcOXDp8ABCYzDNPlY
 RsjdyKgKW3DnCQ/kBawwZ98XJ+AmcETIbX/7DOw85FJDJbW15S7B4Xd7E0RTBrcyPf4vl7neQP1
 gohlCwnmIlw==
X-Gm-Gg: AfdE7clEmCVTADvbakrt/gh7Qru9yl4xQzHgevFSE+59Mz3VhKUZFrfSZCNVU6jFZdf
 Ex5e1PU+4PIPNHnVYoC/ui0WC/sC1BSfHbwKf5b/JHhltttK18U5fsWzK/JL8G8VJcPeWuVgh6u
 ZEpM/W/8E0qJfLdRD8qznAr5QuMN2Ei0oclophDY4OGcPdLjT3pigMqoYFOEdspJWwhxSGpEEjJ
 KqaiZKDEATEyYFBROwnziUMyyXbnNfWEddgjiOPt5CdHKm35wtOMzIs5aynOsXINvN0uwBuzzsb
 y6mTdtY9e0bGgEbtLZyOOnvXg5VNos0HRy7YRfdkQg4lFcq+X6CIaVFvxw2DQbS9sgTkP2KbIax
 wnrYjoShttbpBVFee1YmXb7tc8TDMDkfbwNRZ4fC6x3JC/mT38rGHhXWgcwxQviMSJn+HdxyQf9
 5kZh3onNukNeQr8PfiBhxonFOTZN7OrNPECw/wsu9GEJQVOIIRjEp8OH3UGzKzUGdb0zUsI/gaY
 5QjBknOwJLpGgW1jPbrX/VcuLG+n2Seyvcb10lbQGywlU/cF4+ukSrwfGjakJQX3Gg=
X-Received: by 2002:a05:6000:2c0e:b0:475:f0c2:75b2 with SMTP id
 ffacd0b85a97d-475f771d846mr853804f8f.29.1782806237919; 
 Tue, 30 Jun 2026 00:57:17 -0700 (PDT)
Received: from p200300ef2f13eb00680747d6cefceff6.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47560effc81sm5472329f8f.0.2026.06.30.00.57.17
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 00:57:17 -0700 (PDT)
Message-ID: <6a4376dd.41a38e5f.2c1dd4.d666@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260615111358.73462-1-avinesh.kumar@suse.com>
Date: Tue, 30 Jun 2026 07:57:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_security.sh: Use enforce toggle to trigger
 SELinux measurement
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
