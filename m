Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5875CA9EBE
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 15:50:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB6653E2D2D
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 17:50:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9674B3CD635
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 17:50:32 +0200 (CEST)
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3E2D8600054
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 17:50:32 +0200 (CEST)
Received: by mail-oi2-x07.google.com with SMTP id
 5614622812f47-4b39374fdafso28683b6e.1
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791647431; x=1792252231; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d+tJvyshTmxMIbT81NwaXonuU9CgfwRFWTI9sddRl44=;
 b=HuMm+HSmCr0XS8B7gtOgAM25qNo7KvI/bTETU5kjSyvjgbFtBVXfPggDkpZWU3Qbns
 gWKetx3WKVGwZkyHHhv/w66A6Dn01NTbJZGi759GI/xkGgLe5KZt43G4USJB55RIHTmC
 kkE3tKKlu97gs4qUiu437o940iM2y/mID7SyTLpud58FeAgI9mFnfiwpe5qHQxnf1IGk
 Dv6H2aKqC6hiqzv7S/Rd5t0p/hn0MLL2d3bt2d15v3tZ0tHP2C9xXpTGhhFRKWlUcm6p
 5iECpv23jTarLeFjeR1pobYeblzYKeQ+RiVQDCrLQMLmydYqenMYsX5sAW/5hG7kA23A
 AB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791647431; x=1792252231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d+tJvyshTmxMIbT81NwaXonuU9CgfwRFWTI9sddRl44=;
 b=fsCJaka2tmOmmINGWT5zH1ANseZokb+mZKgWo4XIwugm7Sly1eoEhL9uixcoe0cdQY
 OlfCAnYW/eMKvjJ2th8aBVfPKjbjNmwE1C3Cz/dJY60Pid+PARCO90YkcupNEiRIT7C8
 dAQH652Eu//YssevEMR02yhFPL2J04k1JQkxci7Qe7t44nA3z29Cbzu0rtgeUs4qD7Yb
 HBcJXW06RgWJa9tvJtFtlPujY8o9ktoi7HBt5gw8oBfuqITkIyaer/kwI39mVkfjic+3
 QPJnMIWiOL8LUzUwGnrPBxUZlo+yymbY4PeAz4Nke+DixxldtowkYaRnqIIGl87S0mQh
 ikhg==
X-Gm-Message-State: AFq9FYLTejaj2CBuU3aFb49loVpVOibbPgOLdop/2t78QNfAe9VlVYyx
 KCt2aMHKqpHt8ypJZUGIV3/kOJ/dBbRugI937HEkdHxD8rBnAbw6LrRJ
X-Gm-Gg: AYBFou3uhlm5jAqRTHuGE0ScUzH9H95yqP+PrjPJYu7B0YOTXPTdACXIVGXgJ/FAc26
 EJRY9t8nDahDuFITug0Hn3AqXRIAX+Efn6UZsOuuQ3w82H8h4t5568TV/6GbMjAq53PiE1wRdP8
 dYTJHpJhHDD0pJS2Mt6v8UeOs5nCmJRF9HPGKMfoh2cOkZ9FfwLtRVTakJvvJe2Z5s1tVgqCk5K
 5brbJfD3cG/Zqq9cWkU/vU8DqGX34DEOrmovpQ8WE8c9SgNuWvpRfeEgpkJBkARkDEv7CgGJIbI
 O1KolsmVdl2zBXzpCFXyy5c8Wo/C1NjFkXvvz2ZQCQPko2FM0iMDTaywDp3SfEAEmLntgrApMV5
 HhitVjjYoN14km2QQA6CbOMRACShSCBaaWsrDPMg6ndPgRs3hVazomtTSyKsDsh9G0xdZHm9cER
 9ARvS0qEek9nyj4Kj9hDjDgLwH42mtXmv+MsFsEb7nV2IGvJ6cqRNRZHXNq08Fn0oOdNMUkLo6g
 4XmU5fTMkiTQLYVHyccy9uEgfXr7+YGZ+VlBsdnyq6yFBaPd6WWeOYZDavQx+hCPM12l1iMOrw1
 mUkMdjokrubfvvc=
X-Received: by 2002:a05:6808:1583:b0:4b8:46e3:e221 with SMTP id
 5614622812f47-50c516e4584mr2827402b6e.13.1791647430525; 
 Sat, 10 Oct 2026 08:50:30 -0700 (PDT)
Received: from
 runnervmmprz5.ogp5orqxw5hebnftzouy3dnlea.jx.internal.cloudapp.net
 ([172.215.147.163]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c17d84e77sm5302701b6e.7.2026.10.10.08.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 08:50:30 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Huaisheng Ye <yehuaisheng@open-hieco.net>
Date: Sat, 10 Oct 2026 15:50:29 +0000
Message-ID: <20261010155029.9146-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010095155.117953-2-yehuaisheng@open-hieco.net>
References: <20261010095155.117953-2-yehuaisheng@open-hieco.net>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap10: Account for memory policy in mmap counter
 checks
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

Hi Huaisheng,

On 2026-10-10, Huaisheng Ye wrote:
> hugemmap10: Account for memory policy in mmap counter checks

--- [PATCH 1/3] ---

> +	mode &= ~MPOL_MODE_FLAGS;
> +	/* Hugetlb ignores a bind policy that no longer overlaps the cpuset. */
> +	use_bind = mode == MPOL_BIND &&
> +		nodemasks_intersect(policy_nodemask, cpuset_nodemask, maxnode);

Medium: get_mempolicy() returns the original user mask for
MPOL_F_RELATIVE_NODES, not physical node IDs. With cpuset {1,2}, relative
bind {0}, and one free hugepage on node 2 only, this falls back to the
whole cpuset and predicts zero surplus although the effective bind node
1 needs one surplus page. Preserve the mode flags and resolve the
relative mask against allowed memory nodes, including folding, before
intersecting it or applying the fallback.

--- [PATCH 2/3] ---

>  hugemmap10 hugemmap10
> +hugemmap10 hugemmap10 -n

Medium: both variants use the same runtest identifier, which Kirk uses
for session restore and reboot recovery. If the default invocation
completes before an interruption, the pending -n invocation is also
considered completed and skipped. Give it a distinct identifier, for
example "hugemmap10_noreserve hugemmap10 -n".

--- [PATCH 3/3] ---

> +	/* An unreserved private mapping creates its reservation on fault. */

Low: MAP_NORESERVE faults allocate unreserved hugepages; they do not
create a hugetlb mapping reservation. hugetlb_reserve_pages() returns
before creating the private reservation map, and HugePages_Rsvd stays
unchanged, as this branch's er = prev_resv already expects. Describe this
as fault-time allocation in the comment and commit message.

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
