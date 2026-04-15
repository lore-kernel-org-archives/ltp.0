Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7BDFA0C26
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 05:29:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1BC43E20EB
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 07:29:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CED873CC619
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 07:29:21 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 445A86009EC
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 07:29:21 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so12862230eec.1
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776230959; x=1776835759; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDNOPAWf5qtfnlBhiayDnAGT5lpOhwzdVd2iAwktsz8=;
 b=JcE8pEEeBWISk3yXgmL0Byd/4+X7BFmuCPX0akjFHEJ8WciTKKkrF2I/EU3+to16OU
 OthrEbQZLFTKSpGx3bnlYkVIJTpQMJrGr/cq4hY4eoOY9izLH/hWNsLxa7araMxZshdr
 JIza/vGfxYHdQ/GnQ+s9qhCBV9dcLE1eq7MgToLOZewj8V1NObfB0h0mUDe5MurNXyHt
 I6fyN9J/UGtXW21C7GAHZBzCPxYJfUlW+StIH9j5p26KUh5QHnQQAL2Vkx9MpjGZ5H/s
 X/oRIO+EGNLNronDMmhp0i+OMjeeeZuPXGGnc6IYy/RtyhjDbOxjW97NofAZPkHcGuGn
 ot6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776230959; x=1776835759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EDNOPAWf5qtfnlBhiayDnAGT5lpOhwzdVd2iAwktsz8=;
 b=Et/3kB9LBN7iVCtCcht4QBilnK1Xpa1cp6RIYrRS2nmDnCOFpTJtiPterXjqjwuc0I
 H5tf+hpiUwyKtCZrzEdONoWVzmVd7OFmbgrKn/jqfEAPw5dYHw+mPUUHyMweYBcphXWw
 ZHBwi6b2+juAMJGqfFonLKG+yIOPexyVcCAnt9bbKYKJVZOrUraKceuXOfLUo4FRL8tr
 bTXRc4YnNsUu2lJl9hvUS4bDET9GzSwjaJBBytbrXi/+1Gmco6bHQ8pJo7yIgnvTGNF0
 S1zm0iU/9MbSvUqB66umbUDGD8JK8TSPAdc+FEufoaxYQcOhwLv3dilsUM9Rw0REKNCd
 Uf/w==
X-Gm-Message-State: AOJu0Yyf9d2H6Bzr3HWzwlT4lNds9S92O604JY6KRFhgg3jwh1tSjZSY
 V80+Rrj+O5r4LtZy0yriMVvQN6m51Hwi5BSgz7w26eBgLicMtVDj5GZp
X-Gm-Gg: AeBDievmRuhAdi4PIUEXoVL2EKpQem7T/oQYU8Od9hEwwvUp+tTnpiVRGjTcJOKzLZ+
 E+rTDhHU7m8GqB4Egjd9R8c7iK6EvDsT9oaX4oPBX1AV15imaVdOwnsZYk5nOy4zPLG7Z+r03Tf
 weEkZyTCuwHDPtMglVrRHDeilN/ynHbGrEKwpXyPg/4h6HsaOGodB7H+0fP60hkCFjZewPAsWU1
 OM1SpTokfeLyKtFtRp3z5biz++zL5R4iksFZaOh11PsfHGdUW3nNS1d8gmmQrWR6FBZZPsdCneU
 1xXz+LXdgrOmqNGinfinmXxLjDlvQgLpvI/DsPPIKoyEb4p9NvJmkDfi5ok86mtU+LMuptMyAxj
 3YQaan4iZj8DyO8ezRYLYmLcVqAWumoVGMCcCEnHxPcg1uIwji4I+oBNHz0V5qx2dqyVzuRi1MY
 zXc2KdKWVfjeE7lfqOMWgUR4IhpiccgwGgyxStub1D4nfJC11sLBJyuJBOc4U8ZzooUgOdkQfn3
 Ly5iYJJ1joiM3c6OVGM8f9AxQ==
X-Received: by 2002:a05:7300:320a:b0:2c8:6361:ab2e with SMTP id
 5a478bee46e88-2d5877a7b8fmr13794416eec.8.1776230959443; 
 Tue, 14 Apr 2026 22:29:19 -0700 (PDT)
Received: from
 runnervm35a4x.ul30hyp0irqepaj0su5chck4eg.yx.internal.cloudapp.net
 ([172.215.217.99]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10ad3dsm1299030eec.3.2026.04.14.22.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 22:29:19 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Wed, 15 Apr 2026 05:29:17 +0000
Message-ID: <20260415052917.3944-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415044641.97806-1-avinesh.kumar@suse.com>
References: <20260415044641.97806-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_kexec.sh: Use %s in printf to prevent evaluating
 cmdline backslashes
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

On Wed, 15 Apr 2026 06:46:36 +0200, Avinesh Kumar wrote:
> ima_kexec.sh: Use %s in printf to prevent evaluating cmdline backslashes

> -       printf "$cmdline" > file1
> +       printf "%s" "$cmdline" > file1

Fix is correct. Please add a Fixes: tag pointing to the commit that
introduced `printf "$cmdline"`.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/24437929854

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
