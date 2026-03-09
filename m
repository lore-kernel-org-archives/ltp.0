Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15339F417EE
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773068194; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=XVBSgjkJt0Wsg9Rdmtyh13/NXW4H/Wre9BKk5FWU39o=;
 b=Wdwjn0SC2RTwPO1HIJRCuMJLuXmA7sj7sFjLxznyxsm5sP+oVPmgvxYyq4soesh4rSdkm
 CZ/23IFIf8sWInj4SUO5QSlx3zqXg9/RduSKIro9DPGoyOYuCLc7XR4oHQyPENimthoybXa
 4iOl6sswdDnRrv3emINr4sC9UdcAkWg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B55C93DD9D3
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 15:56:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBCBF3C198F
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 15:56:12 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 26DC4140098B
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 15:56:12 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so135977275e9.1
 for <ltp@lists.linux.it>; Mon, 09 Mar 2026 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773068171; x=1773672971; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kkph32YiMJot4Sd5+G49IG5tlwM2PCB/awE3+bxMeug=;
 b=MqmYmw0Wvr6+tv/lscKF6gw3ltYtx+r0bP/JFwbNiNR7ZD+kA1FEDngLawhDzD+OYr
 NdJnAM9QhvwDLYCInMD2JFGzrNUztT3r5Cvf01nY01+wB3zJTu2nQqFfY0ncYEbidqmD
 xTtCyyQHdFX3oXE6vqbGvxBwUyUd8e1pmblkxzdT9CbYl+rJLyg2d+p4CVwUl0A0/t7N
 uhrBfgRtRLvhIO/0Y7ovixWipdzP8GXMcaA9hBNKLIJ2Qzm6xmCmwSdqqqPGbcrMN8bB
 YPpbwV+VYhVgRzy7wXiMu5uDt1ycWvuRMAq60vttx9TaSWe1R5oJQxz7Vw2hjr4aubMs
 shdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068171; x=1773672971;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkph32YiMJot4Sd5+G49IG5tlwM2PCB/awE3+bxMeug=;
 b=DNViuippvnB9juGp2Xq1mEhCWT7qnU6l/uqBpSiMSHyvQsQNVkqeez9/n/1CGkSErd
 a4VmpcW9xbWtlEuy2OsAHNIJt3YS0YLgzYaWxpkInVgPZdyIvEBb6Vw+HWi0NjPYZUzY
 x50yuv1+8iCVRgLCX5gce2iSjMP0AxoXej0a5xKjkwIgq4sQbZQMp7cpxnctNUTGBPT1
 OKmlgUmX7oWQf5p9K8O1a00PCUIQjq9ZBrTatYAZavuzRr5vgO9Xcu9PFGq+GBAUOopU
 Dqw84nfCBvHaMSSzWuGSa5Z9YFb4XZVqUIv7NsHiC873nRPTJ+6xWEZQu585vP2Eo0aK
 EWgw==
X-Gm-Message-State: AOJu0Yyl9o2LLnPXt6t73+OpT4EQGnMW0ARZ5GwMzrUQun6zhWO5QXDX
 QrevWgEGwDQrQxaBF3CffdoIzsZN7n3mZMqx1tgx9OSCiOCRddg6JlUOycTolsyqA4U=
X-Gm-Gg: ATEYQzynJNRSJiBvUfZQKkbV55A254XJCCAbyeD9wkUr5oTaXlzYNnUrXUxbxs2dSVe
 NtaZIQUwZPhVf0qSqcVwd5SKr5Sl/NMqwKfw3pt1rTXfcBUd6ih1CkPyO8BOu5frG505OtPbzUq
 xst4A6owzXmpRf4wEMIcLvYerM8LS1C7g8SOc+DCq/ubNubBjUNbZnVmI6n04h3sArEW00WA0OU
 OZ5m41XNjGoOi8MdzboIMo50hiLd3bLm5dfw7ctD46UR54bs3RgWYqvVf0lgeiKbGL7PIaxj4Rh
 HVo4jR/7cFYJf2XvXhxXzh04MpS82qto+Mgc/pOALDxSI/eqOSgmQHpUohFZjkB2xbemjHfUltT
 MyavJC1DX0hVGU05Qs18kHWn8Rif9BewWas8KG1Gu8pGnibtltTYt87rRhVuiWOA+BPrqrUeYVQ
 yq0PnIiY1w36t7lx//UJNSPP4waBi+okJPALWmYhBuajW9Vi1VbxQ=
X-Received: by 2002:a05:600c:a013:b0:485:17a7:b9cc with SMTP id
 5b1f17b1804b1-48526958835mr182389435e9.18.1773068171458; 
 Mon, 09 Mar 2026 07:56:11 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.16])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852e38c013sm381431455e9.8.2026.03.09.07.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:56:11 -0700 (PDT)
Message-ID: <69aedf8b.050a0220.24143c.7ce1@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>,
 "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260309144236.GA28075@pevik>
Date: Mon, 09 Mar 2026 14:56:10 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] agents: Add AI agent configuration for code
 reviews
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

Hi,

> https://linux-test-project.readthedocs.io/en/latest/developers/ground_rules.html
> Ideally text would be just in a single document.

I was thinking the same, but at the moment I don't know how to combine
these two things. One is a documentation oriented format, the other is a
list of rules for the agent.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
