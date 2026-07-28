Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC518C53219
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785246852; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=8g2SLwrczT+JOLsoOZMvyczXO2rjNBG1jQDcrs56E/w=;
 b=bPEBtln9e8Ol+jTvdEit0kQanGQL/gXMq8+1nELokEjnGGJA1R70lVywzIJ3g9AzlkPo5
 UjCi8uMCNbGizWO9At7iowPzyCY64hNIsergS0hr5SFWSyCN+w+UhGbv0Jdl9JIIu/nJwQs
 aA5Wuscw5yPT+O7N1lWk8vEyZ3tUmyo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B68C3E7528
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 15:54:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97EA33E55A2
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:53:52 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0384B1400987
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:53:51 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-495590dde14so43758045e9.0
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785246831; x=1785851631; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T7EUp4LxhYaK4Fi0rcBiFphESftFzGxrHmBbuuqCgOQ=;
 b=Nxm2STpzZEaMETvN6Xk8mfPJND4qKdvzON0ihBihtTVcpef5wnUeInvnETUUFzr3WO
 N8lrkObkhhmMOKHK0odeVQ1gvrWuleDh5If7gUUGmVB/ZJtUgpQorxn0aPI13NBUGX+Z
 dYdACjKOBKPD2OM7XURgYo1sW/JaezuzQqAsRh1z+RCfVqB39UA+WaaDyDsAlsbQqdwW
 BLl/c5zNaYbrVf9NxkIr6AL7UyEtgl6ogS3UqG7pQmfKxIiUgbL16DlGxlg86Xv/PM3r
 XFmq8ulHALwJxvbiFkocU+G9gynaSStafpdxqWTT2Aq537nEDKWLXDsVjRwUuH+rv1Vj
 7ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785246831; x=1785851631;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T7EUp4LxhYaK4Fi0rcBiFphESftFzGxrHmBbuuqCgOQ=;
 b=max0Y0YP3inOwIQLgS0VbBkxPsVRjnFgF/QUE4VQ675NneMe4oENqcPCG6y7N0v/7e
 KYBcnUBcg5Hqw10zznZ7xKQams1OyB6yg5Wdd6HcQLf5Y01HvE1yb6pZ33lbqAJxfBAh
 9HzFRv70dsSZWyAd5tudlgh+ceS/SB2JJe/cUWaauECJ0/AFflXBOoshi0mjzBIkhWic
 u4VFDCDpkTTN51MfbImGnbrfMI8Wt32darbUWCvtLM5RjAvcB22zCbBsgjPIpawYqara
 b9bSaCGpml1UlNQ6uj3z4NtabVv/kXyQcJ0RFksx9BM5JGwsVR08ruKinwLSqG2sZfE5
 YqaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZ7D1KmiJ8JmHi+7nBAcQVBpsRRbLuZbx4DsJ7RY6w8kkOxtvVBCaigFqpeIDXsacAOVA=@lists.linux.it
X-Gm-Message-State: AOJu0Yw/ohjp5PpEZANADLSCDHvl1Dsw2bnpX7pb0CUrosEiNrXt7GtW
 qelnePHKHrVV43+V5isu+u2B6Zx3XX+D4C2/BMtLnKIabnyimN58xIsgxE7F88BDx+k=
X-Gm-Gg: AR+sD11W6fWzbWIex90Pi1gwdU5DZRGM5almjYu+Pn3cu39cjHCepmNuW2X0IaUTT4W
 LNugqLosOc8ivyYWEbRtazrfi15oVgW7R0mR56BhcIB0tOeqaVLh8wPCqIFd4m9b3JWTn4nJ05e
 24QJyyvip7TqGyPS4Xj4Q7WodEkZLhZZ9vM/uaYoO1Of/0n5uHpcvHAGH+Qnzg7gMfkMYyexcC4
 mBcDvEdKfr0inli0K62RWuN31CYjYMOtMVk7h0uTK14YRawQKjDjES9wW0WaoaG91xaFkToV3ma
 Tp+CccbWjT1Baxiq7dpBCbObslyBhD40e2DkeUX17TG5yjTtnQxyj1ht6yKqxBhmZAw4We0rm6v
 +kN72Q9epCcdVZfffse4GC9gF01iZfBNmqnxPDUG5CayYx2CPtAjNFVDRuu60ze6lXzkVCpV03w
 qcdAVy+R+GN5dSUezTwmJJm4TBpqDkFSzEeuNwBn+3i1s=
X-Received: by 2002:a05:600c:e549:20b0:495:71f8:7325 with SMTP id
 5b1f17b1804b1-496c6586a5amr19128275e9.32.1785246831326; 
 Tue, 28 Jul 2026 06:53:51 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45b0535sm77209985e9.4.2026.07.28.06.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:53:51 -0700 (PDT)
Message-ID: <6a68b46f.f3563870.c8a40.1a2b@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260617073757.3983-1-linuxtestproject.agent@gmail.com>
Date: Tue, 28 Jul 2026 13:53:50 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify20: Skip FAN_REPORT_PIDFD | FAN_REPORT_TID test
 on v7.2+
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
Cc: ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi AnonymeMeow,


> --- [PATCH 1/5] ---
> 
> > +	if (tst_kvercmp(7, 2, 0) >= 0)
> > +		tst_brk(TCONF, "FAN_REPORT_PIDFD | FAN_REPORT_TID is supported "
> > +			       "since v7.2, skipping test");
> 
> tst_brk(TCONF) in setup aborts ALL test cases. The second test case
> (FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME expected to
> succeed) is still valid on v7.2+ but will never run.
> 
> Should this be a per-test-case skip instead, so that only the EINVAL
> case is skipped on v7.2+?

This observation is correct. If v7.2+ enabled only pidfd + tid combination
for fanotify, we should not skip pidfd + fid. The 1/5 patch needs to be
updated to use a per tcase TCONF.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
