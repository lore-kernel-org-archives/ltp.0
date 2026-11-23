Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B07D606A31E
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tUHRSQ+h
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FB253E9F10
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 21:43:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01B713C2978
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 21:43:44 +0100 (CET)
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5BCC92000C3
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 21:43:44 +0100 (CET)
Received: by mail-oi2-x08.google.com with SMTP id
 5614622812f47-545a4fb8d5dso1017960b6e.1
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 12:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795466623; x=1796071423; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8NvuNZgh8jJNmNK/x405z54z2E3bQB+13f1OT9fP+BM=;
 b=tUHRSQ+hN7pyEch6AcVUdrLBUn1uuj6D5Qwb1mTe1zEdVTf6UvHlYj/IbNSCwDhj7L
 HuvnmYHahU1IZpx46S9WnddxNw0BAEKr2I9y9jadJ1CIAtmHTvqEeeYNybz1z5LsGIvN
 5ZVHt+7Nijeu8DGyUU+QDymTgre769a5SQxzELrmgYN+Pa8vLWn8elFqQU1d/XFVCann
 Qm9tJlvQ4JPip9oR7u4T/RDsDEKmQKysQkTQAfra7CuXMF4gqndfAEr4+2fdkRBHVSB7
 DZHc8JE9rt8oHCOm3mjEROq1/51+jXsmDWGTMijiMhEuAth6EovKlctltYxUPNraJvQf
 kfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795466623; x=1796071423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8NvuNZgh8jJNmNK/x405z54z2E3bQB+13f1OT9fP+BM=;
 b=KVXDsjoL8GMtl7y4geTm5AheoOsMqAWhat2HMdKnaWGVcM43auBvoM+GmS0W7ALrgK
 Bt/Dvo2PLEVQPOId4uXkXXR1ruJ7VWLA6gv+k+Dvv7lTwmuFzmIfwz0DCOOHa9oacTG3
 Vvk3a7xGUB5BO4eZATLfOS/dpfbCsEkyRLqGBazD3KcIfJSkTtMyfY13RaIF5XhT67M8
 CvLpG5GznRbfOoku1MiOYgfzChGk7DhIumEKmvWU1MYnU+Fh8wl/WmPdXkBdqSDpXUdn
 Us3IzAKx0A6u4JpBzdfX6gb1kxTpt0aemaepQ1S83lBhsVO03npJNjCSS7tdYZXIXC7S
 17Vg==
X-Gm-Message-State: APuU4Z98XoflvqIE1YbLCguVyRK4muW9T1D1G+PtHG8eVf0WcqoAuQHc
 VG38rzPCOCZftBGqCdguU9zmZFONJAT39AzsZOp8cOeLBKpjJpYgUAtGzXdLxXkf
X-Gm-Gg: AZFdTZeKsWwaIs4MkMyCuFbZNGqyC2MWUf/wQAObB2m4NXJBclnspocWK1rkvCtC+Wg
 U6CTXaAFG4p+ms8O2x5OTQLjQMfbj/U19hz7kvfH9pNY4evxIn915+dRS8FcCVGPdKEVGhFQ8PS
 MHAGYyCDrdLAvRjgwsfdm8P7cv42qyFeLwcQuPSaFyUMyXBSos5Yx1SU1ZyervblH21Nid7WhOj
 4bnQICjuzjuddC0MWvl8uvrgLgacce8O2lTpB1b0bgaU/54C4zDIgO+om3Dnz8AAGKUY2RwUQ7L
 TKy8/LxNInPKMqP13Q+xYSUF02sI+6iKuQ6nUb5K8DZrt9TF3zlUDeMCePUhJ0MUx6xoJX0Pags
 rrKdWX5rd/UMIa9st0AzZ/GySRLqcvQrHQIKPNBxOsbwIHjcdqM2LoLiKSmrK8gajr4UhgeYZ82
 AKHshiKdcvWeQHHkX6Uqyz9ldOWyrxd7csK2kD90Xra8mjoKZsde0WFmMumXIwp3/ucTEnXv2XR
 0VwJgrHFeqFNWNvA44oqGtVXPE/E2X4MeMGJAgqieZktGjM3bB5td57Z50fHRNLsss3DhGD4oSY
 nmRgRVYvt5Y8YRRSuU0tJorezt1oY4WVnw+AMhWP5MJ5SJ7JSk+ehBS2zyTtwiOSLhylw/Q8efi
 iQbareRm/zXVBMp5huXNoC7i9uI2z8yoET/TJ2GWf1CDNVSDTA9xhnyG6sW3n1Bg=
X-Received: by 2002:a05:6808:1484:b0:4b3:7b31:8df7 with SMTP id
 5614622812f47-57a0a93091bmr13970048b6e.14.1795466622949; 
 Mon, 23 Nov 2026 12:43:42 -0800 (PST)
Received: from
 runnervm0hi8g.depkc2g5bqbunhyfaphfdnoarh.gx.internal.cloudapp.net
 ([135.119.23.13]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm11689415fac.12.2026.11.23.12.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 12:43:42 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Huaisheng Ye <yehuaisheng@open-hieco.net>
Date: Mon, 23 Nov 2026 20:43:41 +0000
Message-ID: <20261123204341.4031-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123080537.20122-2-yehuaisheng@open-hieco.net>
References: <20261123080537.20122-2-yehuaisheng@open-hieco.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap10: Add linux-git tag for NUMA fix
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Huaisheng,

On Mon Nov 23 16:05:35 2026 +0800, Huaisheng Ye wrote:
> hugemmap10: Add linux-git tag for NUMA fix

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
