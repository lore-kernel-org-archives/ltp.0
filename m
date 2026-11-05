Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4D606A619
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IXuoNgU0
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4B3F3CF603
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 16:58:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 351513CEC3E
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 16:58:37 +0100 (CET)
Received: from mail-pz2-x03.google.com (mail-pz2-x03.google.com
 [IPv6:2607:f8b0:4864:3b::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B7A221400BEF
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 16:58:36 +0100 (CET)
Received: by mail-pz2-x03.google.com with SMTP id
 41be03b00d2f7-cd5f0803c1eso688593a12.1
 for <ltp@lists.linux.it>; Thu, 05 Nov 2026 07:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793894315; x=1794499115; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+kD6CWNN8x0fQ4NJP512GDdDIqBOQRcDFw3k9EdgEMU=;
 b=IXuoNgU0XGRCTFcPkabXwE8BrD5vFX2imXWneR9jYsAi0/bhtjl2fP9/Aat+PdJgor
 UJUrJ1fI1HdwnMIa06K+DOhqc4pAiYZIT6S9XhF6xnJpCO2LBaNGnWlJRHnWcd4hlnib
 l7GJkaN2v7y7qTlM2jvq4IQzkQwMjnvCxBHhn8QKl4BzX9U0TtI9jkR/sZ9lfQxIWueM
 SepHYco+LC/kiNOKfTXOAJPNUeAZfWe3VM2Y4nheJCQNkRA+IN95/fZ6kjcPtPAg3NZz
 xd9WKOYz/Xtmnkeskz2lStM5P3uq8F0rG/7RAEPjATeciudS83h9JaLR+YfoiYlgLZVj
 B8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793894315; x=1794499115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+kD6CWNN8x0fQ4NJP512GDdDIqBOQRcDFw3k9EdgEMU=;
 b=sH/D4Fz4Rx4fteU43LF4zd0mUoUADGcpG8sGJ5CkZ46zLCuWrGhHm1qcHpyxqcC/HS
 vD/Rmf7aj+rJGqFMZJULkTTsDc5oaUJAtKBu7tFhhTKk913kUEB010l5PW39C3Ed/06O
 igQTUGwm2bIQ1+y9s4VAeyzZmA8+lYgomXTg5wTJVoqmsLLSi2s9wGdQvM1S2kJ+c8rn
 ZW+hYM7yxLdGbJso6GS3SPRiMBnEdCFo2bx9UGstIL+ME/GMhoj0hrN3DhjBh0r7fhZs
 Q+8JtadL0FYEvpWsmEXkgn6BewPS2Ckcw13IMihbKkUQ07O2Y+WKBbtsJiVOLwKuT56q
 wplg==
X-Gm-Message-State: APuU4Z8E6ntfk05n/cpnlM1bAOvsfqdXAgi5V6Uo7XAu6d9WvPr+e42A
 cQ8QjMvnfrWG67/hz24nPP5QT5ovgJj9Ole8gbXZTraD2ITTLBEmYF+woGANjfB+kVQ=
X-Gm-Gg: AYBFou00RjLvZBHc5c9Q4zS4Px0lWahU41IxbbVSvtPzS1mX1ZSRkt3nTqDBw+5WApH
 +JlObP58jMCR0NNuUBxxgs4nC0y/bS7YYVql8uS2gwsopWJRsdMgpe49+LjhLC02mOXOgdvjDxB
 Ndi9923Zc6PzRHLj9z52ziSnj9n94E2ZTvJ1X37ppyyb1Hbs428CzIbcfv1yLZTYlol9UaisI5V
 iP6d01X7ndpq5/vegYFiiPfmI4GVbPQWiB9p2kivFq9w/4qQ+8mhCg+HFL/J/xSvi4mq5MILNJX
 g242sAXGwYP+dRSTF/M2k5EhrdfwF1yMAtqmm7HtkJsNR8h3IMNJNVv4dUEaxU2GTRbfX3gSn0a
 zODIDJf+Nn9sVfji98VwJnBIgSqNGT4HuXrXIOkFKLSHc1P85CIKFEXuuw8n4lvtzZx5jUvc3zX
 PhUn56LpK5HINVQMAavjpLrUOblJbD6duLY5GufoTZk988Za6Czbtt1Bp9tNppcScz9Kr6pJNax
 dT7NcDXrRhhz48yw4CCG5s2FSm+wXeLHFgFKe5VsQN8H62u9MMa7QwqqS2+wC9C7jbIAkKCRKxG
 hRjc9OY/swiL2Kr+1E2WEVzBstoL0ozZya3B8pFCGz0BoFBjYaTN41Ftd6d3Q5HeE8AIG5kvurw
 BkNBxtn7yUpnjvF5AX32fAl2g86pCA7APTOK6cBhu
X-Received: by 2002:a05:6a00:c0c4:10b0:8b1:d612:e945 with SMTP id
 d2e1a72fcca58-8b1d612eeb3mr2065644b3a.52.1793894314721; 
 Thu, 05 Nov 2026 07:58:34 -0800 (PST)
Received: from
 runnervmnwato.nnnncg5mxsqethhd2lfabujhpb.xx.internal.cloudapp.net
 ([4.154.239.87]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b097fdf387sm2184519b3a.5.2026.11.05.07.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 07:58:34 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Xuewen Wang <wangxuewen_ky@163.com>
Date: Thu,  5 Nov 2026 15:58:33 +0000
Message-ID: <20261105155833.3675-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105104639.996329-1-wangxuewen_ky@163.com>
References: <20261105104639.996329-1-wangxuewen_ky@163.com>
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
Subject: Re: [LTP] testcases: sysfs: Add sys_thp02
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

Hi Xuewen,

On Thu, Nov 5, 2026 at 6:46 PM, Xuewen Wang <wangxuewen@kylinos.cn> wrote:
> testcases: sysfs: Add sys_thp02

> +/*\
> + * Sanity checks for the multi-size Transparent HugePage (mTHP) attributes
> + * exported under /sys/kernel/mm/transparent_hugepage/hugepages-*kB/.

The unescaped '*kB' after '-' in the reStructuredText doc comment is parsed
as an unclosed emphasis start-string. Use 'hugepages-<size>kB/' (matching the
next paragraph) or wrap the path in double backticks.

> +	if (is_anon)
> +		TST_SYSFS_ASSERT_CHOICE(enabled_allowed, NULL, 0,
> +					PATH_MM_THP "/%s/enabled", dir);
> +
> +	if (is_shmem)
> +		TST_SYSFS_ASSERT_CHOICE(shmem_allowed, NULL, 0,
> +					PATH_MM_THP "/%s/shmem_enabled", dir);
> +
> +	for (i = 0; any_stats[i]; i++) {
> +		TST_SYSFS_ASSERT_RANGEUU_SILENT(0, ULONG_MAX,
> +						PATH_MM_THP "/%s/stats/%s",
> +						dir, any_stats[i]);
> +	}
> +
> +	if (is_anon) {

These two 'if' statements have multi-line bodies without curly braces and
duplicate the 'if (is_anon)' and 'if (is_shmem)' blocks immediately below.
Move the TST_SYSFS_ASSERT_CHOICE() calls into the braced 'if (is_anon)' and
'if (is_shmem)' blocks below (or add curly braces).

> +static void run(void)
> +{
> +	DIR *d;
> +	struct dirent *ent;
> +	int found = 0;
> +
> +	d = TST_SYSFS_TRY_OPENDIR(PATH_MM_THP);

'found_pmd' is a file-scope static variable that is set to 1 in check_size()
and never reset at the start of run(), so it stays set across '-i'
iterations. Reset 'found_pmd = 0;' at the beginning of run().

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
