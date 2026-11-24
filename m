Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C8606A31E
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DdbDjXZt
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DC923E9EEA
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 17:29:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C7DE3E986C
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 17:29:40 +0100 (CET)
Received: from mail-dl2-x04.google.com (mail-dl2-x04.google.com
 [IPv6:2607:f8b0:4864:38::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 96BEC1400BEA
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 17:29:40 +0100 (CET)
Received: by mail-dl2-x04.google.com with SMTP id
 a92af1059eb24-1b573ae2265so281790c88.1
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 08:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795537779; x=1796142579; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ITpH3gPuAnRueEJCN5IKwZNKqSoW6WlY3NEFVNxM3m0=;
 b=DdbDjXZtSopP0PN+dm1IC3tnp86QPOzmePDfsKLJ39FdWNSEbbIhLpCZk8BznZH0cl
 Fy+9lkE32sw92YwhFcKd7W1lWaBLoQ5PQz2DKjQQC23Vd7wJaTQlVp66c50WsJBD9OfX
 rLdbmy1OjwatYT2jKtZtx5Wpypg1FJahMC+R/M5YSMAeYsVmjB8f3/NKWeXNh2L+mg/q
 tZtHC60DfH7X2wGxqv5+4CkDWPWxUxE1d2IEyDGZ5f0dAC9+Y7zdIj+6xmVm5IDAEG00
 OXKULr4gVCJsYXChbutSH8Tk5QhU7+E23kfiuv57sg2YOUhkw1e2YWCE9SwaQv/7A4V9
 okwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795537779; x=1796142579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ITpH3gPuAnRueEJCN5IKwZNKqSoW6WlY3NEFVNxM3m0=;
 b=rA7x7GOvQDYSr5n+GMJKMLN0aQKniVQXdoeqZaEc5HRVaRJoaarxBiqGSOy2WWylnM
 95H5fjiqQpjdHpGmfoOu6p80HivTcPpmBn30pUKksP8ClIVkvk+23f/E+wIAeqeJvQLp
 fGnw6cHnhhmr6TuDbOX0ELBftOYOLMCTax9SPxrNoUpqYaiv+7pc6F16Sftkk0X61JUQ
 7EgWqCRM0pvMFpjKLR7rX7j6PAnN1Oo27qFibP2ehjpIOChsQrkiiH3PwrE1deQqYVKS
 QM/jfphv0DtJpPVZJbFqebMaBBo/1DN9HyyMy9MCrKuqIjt81d0j4ZDoYD71gmHPVSha
 yd3A==
X-Gm-Message-State: APuU4Z8kqn9WZhR6w+mE8LgDvzz8VH0h7Uhhb8il0ETVsp10Z2WMDdQW
 ipY0tA6/iKbOcs6RAyYF8Fn1Ze55uFA/4kY0TtrdkQ5C/KXzfliHTj0G
X-Gm-Gg: AZFdTZd5ang8OVw1rHbYNqSOLiO2t/0YTErOk3jVpEgXtSbE+TPKrvzqdtELy3kPS56
 wDQauF0sXwfV+89s3lBQGpmdOXGwuBJfTO5GvX8Ke3tBQdMYF1wCdY3IeKsgmj63QNLyVSycTlP
 R6NyiecCS9kzujA0dgc52Xxv/14drWslXV5T83YSvOM9p1JQHZh/NcU25RSrlx8jAyeKETfuqO7
 oFpAgRXYCqimwbOXP0sry5j186P4J0bYNhlbElwBCwsBoxeoT5gli0nPccrydbEPzyva/2IBRAN
 Ad2Ur9vXRKcsmIGUtvkPz1NurvExY8YL6MErQHsb7pm++btMtTEvH5kN0hsY2UzQSTWUFribCqD
 KDuvgAbzwyKLUQlUyz0r3QmaXVRAkIgemOz03OLH7bDVbowQrbGISlS4iH1Sb51naIdQ4atIBYT
 IXa36uhrvDsxMQE4tQsC4idjbVt4GMikH4F+oKcpCsCaUOfn0BQOESOxCuOKuy59K9DNTlrRVrL
 xgyWJfBs+ETCIQCZYYmq8CRj2f/JCml61COrhf5rCe+lzi0Jsy9IGfdydX5Qi/p+/T6AnpThzUa
 PRhlAFcFt+Xrr2eSF+QEpCG61/rKA2xCPCafvbGbEkxsGgc1In29sIwiHNiGWb1+QHBlhNPiDId
 aFmSBt1hx6mo5XlZYzE0JlHdszgXURh5KMsSxeS++q78=
X-Received: by 2002:a05:7022:f8c:b0:1b3:a89c:c456 with SMTP id
 a92af1059eb24-1b55689eab5mr18914695c88.6.1795537778593; 
 Tue, 24 Nov 2026 08:29:38 -0800 (PST)
Received: from
 runnervm0hi8g.buumwhvxvqyupaxsrmke3llhkg.phxx.internal.cloudapp.net
 ([134.33.71.151]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556840494sm36698124c88.12.2026.11.24.08.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:29:37 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Pradeep Susarla <pradeep.susarla@gmail.com>
Date: Tue, 24 Nov 2026 16:29:36 +0000
Message-ID: <20261124162936.3732-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124131237.53712-1-pradeep.susarla@gmail.com>
References: <20261124131237.53712-1-pradeep.susarla@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] migrate_pages01: Convert to new API
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

Hi Pradeep,

On Tue Nov 24 13:12:37 2026 +0000, Pradeep Susarla <pradeep.susarla@gmail.com> wrote:
> migrate_pages01: Convert to new API

> +	if (!SAFE_FORK()) {
> +		SAFE_SETUID(ltpuser->pw_uid);
> +		TST_EXP_FAIL(sys_migrate_pages(parent_pid, sane_max_node,
> +					       sane_old_nodes, sane_new_nodes),
> +			     EPERM, "migrate_pages() of root process as %s",
> +			     ltpuser->pw_name);
> +		exit(0);
> +	}
> +
> +	tst_reap_children();

The explicit tst_reap_children() call is redundant because the LTP test
framework automatically reaps child processes after each test invocation.
Drop the tst_reap_children() call here.

> +static void run(void)
> +{
> +	verify_sane_nodes();
> +	verify_invalid_pid();
> +	verify_invalid_masksize();
> +	verify_invalid_mem();
> +	verify_invalid_nodes();
> +	verify_invalid_perm();
> +}

Instead of defining separate verify_*() functions called manually from
run() with .test_all, define a struct tcase array and dispatch the test
cases through .test and .tcnt = ARRAY_SIZE(tcases).

>  #else
> -int main(void)
> -{
> -	tst_brkm(TCONF, NULL, NUMA_ERROR_MSG);
> -}
> +TST_TEST_TCONF(NUMA_ERROR_MSG);
>  #endif

TST_TEST_TCONF() requires a human-readable string literal instead of a
macro constant like NUMA_ERROR_MSG, e.g.
TST_TEST_TCONF("requires libnuma >= 2").

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
