Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D2B606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=SeIQjNiX;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=dAHoboPm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792569740; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=xE2UWAujIFTAbRvndnfxfgmez8x9blq0r89nCVn8rVs=;
 b=SeIQjNiXMF/BBe/6pYK4dhLhizM91nACDVmhM8rFgi9gS8UE2UNZSwRCH1leV4sT7AQeT
 gEgqGyXCkDKPGN4y0In+CG7ta1fP5NNpTQesbebEIqUkxSI9o9cqRPsLtR/XsPjyBL7eVW2
 +JE0uA6Oq6JZkbCi2UcPgmPMwbj4Rbw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 538483C20E4
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 10:02:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7270D3C029F
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:01:59 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BD5701A00995
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 10:01:58 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso3015855e9.3
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792569718; x=1793174518; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XYtfAqz90RD7yIds055SlhPMcU4Oy8ucEALQDWH3HrA=;
 b=dAHoboPmY3rL6ww/I094Lz1ednUtKSfvfl59wryxa6yLrRCzygI5Jp46XDbPv3/M8W
 X7FcGrV2PexXrTab6z47mZyxDehmHK4VGEIfmLFWpW7VemFm7qb0hAAOMUtRO2QpuQGE
 D82jcFKZ2Gg/rcsFgDqX/hU4mt51XuwlbYO09TjFZE0N2+6CIe7I64+7POLOzq1aBla8
 bKQFZkEOqvbvJP+XQWHTFnh+9KygEtcsEJBG/j2cN0wl+xQJYWu41WspVpkozcvVZye4
 zuBs3fMp9pGYClcTbyYT0C4wFriHioqOzn+2/gkTUTB4We17ZTYJmpvjf8LKccq1wsTe
 S6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792569718; x=1793174518;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XYtfAqz90RD7yIds055SlhPMcU4Oy8ucEALQDWH3HrA=;
 b=gMbqZf5wO/S2Ricaj8cJZdbnr33F0K3E1Mdi6pcourXDoni2jusrraM7MWr7RKZ0tT
 w+4ucz+zrj6cMbLdO/OQdg8+Y9Pa6YzGRPzimd6CYUJwobIGsSRSDMLFcxiNqDL0Fi5G
 hfA1mCwO3KEzF33BbYe4WeRdrJMT2eVVI/uOFrLyvkaim1BXD1D4t86L9qI5OwQux6FZ
 ck9/YQnl58SndpFh92CkAZkEQVFaOk31bsQE1UoSxF2rqW2RKrpnWlZMIT98r0dZEXXv
 qPZ8F0NXc3ZH9cR3Chof3r5qw+mBa7sk7cCgw8ozRapSw/Y921YfG9z6Z99K2TNANCC7
 UJRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmIJVLUHpj02vMz3ItVzdug1nJFTcZ8yF3uPeQPPxxAlLz8i9shVVhPaWuITETOH1SnBQ=@lists.linux.it
X-Gm-Message-State: AFq9FYJW7g/59W0rjbRTPbMt4phpRbklqxARkW7QmtOf6/z+YA9VYygX
 7fmN/LVhAp4bzggE4t55Re6kcVjNEbPINo/ph+F8ghXlET2LMRVUvfYpOjHpCQ5tjvQ=
X-Gm-Gg: AYBFou0KWtYD9LT7fqOy+zL4hSybejkIUv8HiQkX68kUE9iTCJW6C0tOkTfcHk6AiYT
 xrgE2zGk55JZeMdcpO2zlBun92O6nmZgdhybhEpiyfJM7RKfUVqgl22LLZsjD9m5C5dq6R5rlGk
 e/dLGbBVNaCWZms+ViDhl4HRfYFKrhhQMaStZRAsSyyGRVorc0eiIsaMUMsbOYKGp3R1oZqqMU6
 8DmZbZJWYxFwXPo1Tx2emRb2LEme7HiOg1JYSD/QPouNlYtEJsbtnI4QF6nor/ESdJNEfIH51Cb
 hj27bxoVMezqD6LoFpG+bgKrF6z1ndHovBXTJqF646erpdSCVFLMfbryDXUTx/7DC/FhVuwoxWa
 XUswLEwAv/AmSKwCEczpoWeHw3xgi0geo8Jm0SCuhdoABaZtgYFjksc7YmtHbolvmOi4fWxSZYY
 BetH+D/5IQjk8KK6X51vFtEDXsespk1Y7lLz/0BQl7HP6DeB2fk/OL+WF0dwN7hyjVutqNnw4tG
 Mu7MyCTFsjRvDudN/5AtTNFCOgQtpZC4JHmuqYEvOHNmRRjIUDtLc8GSmB7Z6z1MymO6DwFyll/
 FxluPKEfKyDPhYuRuwiFJ4zTr8oIf5O1iotSuw0+PltOCOW32sAUaKHqwS8=
X-Received: by 2002:a05:600c:3488:b0:4a1:fa33:441a with SMTP id
 5b1f17b1804b1-4a1fd8a0560mr25935155e9.2.1792569717876; 
 Wed, 21 Oct 2026 01:01:57 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fd0f4427sm31964995e9.3.2026.10.21.01.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 01:01:57 -0700 (PDT)
Message-ID: <oB4QkHztnNTcZNqTMjoGQkygrRUmUoyoYwsG@localhost.localdomain>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20261020190151.9420-1-linuxtestproject.agent@gmail.com>
Date: Wed, 21 Oct 2026 08:01:56 +0000
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: add pwnescape reproducer
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Andrea,
> 
> On Tue, 20 Oct 2026, Andrea Cervesato wrote:
> > cve: add pwnescape reproducer
> 
> > +	.tags = (const struct tst_tag[]) {
> > +		{"linux-git", "6785011f8b16"},
> > +		{}
> > +	},
> 
> Add {"CVE", "2026-99999"} to .tags in testcases/cve/pwnescape.c.
> Without it, metadata extraction assigns only the regression group, so
> CVE-based metadata selection and the generated CVE catalog omit this test;
> the runtest/cve entry does not populate that metadata.

Valid, I will fix it before merge

> 
> Runtime verification was blocked by unshare(CLONE_NEWUSER) returning
> EPERM in this environment, before the forwarding behavior was exercised.

This is the github LSM pushing out the reproducer. It's not a test bug

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
