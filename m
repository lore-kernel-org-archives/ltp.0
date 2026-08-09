Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFE8C5AC80
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 16:38:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A60F33C7370
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 18:38:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 645723C29D9
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 18:38:40 +0200 (CEST)
Received: from mail-oi2-x03.google.com (mail-oi2-x03.google.com
 [IPv6:2607:f8b0:4864:32::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E6E2D2000D0
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 18:38:39 +0200 (CEST)
Received: by mail-oi2-x03.google.com with SMTP id
 5614622812f47-495f936d5ecso400715b6e.0
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786293518; x=1786898318; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/eaAUhu6aHzxs9hjre23h5zrEIYQXQjmiDKpqVm1Peg=;
 b=lAAf8ipP/xlwXGnIU1t4h024tUynoi3RMjkIKvnApSBeWRtCmgTgcGsi9Y36feQA44
 9dAaYM3uEVK4f6nS23urpItVvFoNz+GE1neF7t16dbUluLdvArUttgXQ8FiRAv61+vzt
 N4wZHi/gBfnXJsYlMKCrRl69zpOyJX1x2s8MAhtGtlDjH1HrCYSbKCJRHzVSZNtBW80g
 2lzEX7mavS1qkioLjzo1Zbs9eLh9AoO5VX8CLllbiq9p/3aY9xtrMuSX2bMYkROZkQqT
 YPq/za/WeeXxxZz3FpMSGSekZ8mKX5P/+vieMGk8ZfN8ffHhroMCDNW6Vhpm62i7aesm
 ljnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786293518; x=1786898318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/eaAUhu6aHzxs9hjre23h5zrEIYQXQjmiDKpqVm1Peg=;
 b=Pkcr0STlS9dqDyS7tU8VAZWaIXQMdx68pzZ53N8dUSumMpKwLBx7A4ExS1KTSPGRUr
 b4mXofnxBC3MC9gH6Py9KUfl1zVoaled0BFoDLHcnl7W25oIAzXZw3Yij82jRwcibYEP
 Dpx4xH7UsOb3cuGEI7kJG6fJMbMbAejQJWTwdp0ydUllqiOfHk3vDhmF2/CUjzyJJRJ5
 uYmWG1WLUF/gpkQLbkkrpas0AHa8fkpCuYVWZN3qUNcDBh8tE2Rhbd/zez8oGGHtjmjc
 fKRHJyo0LNAbIUvfSYsH8Rq5n9UGJABXzeFLWNv3Kc+JSSnI8OsP6SoCaV6poK6aNHbk
 73+Q==
X-Gm-Message-State: AOJu0YxVrZWwBk20md5kYi6gBxutRkZiY3gwl/1LPQE9VR67POlllo3L
 QMfkJxnyJBJjNJm8sP4v8D5ma08jRFwPuHqzvQdXkmoKjr+5Sq1g0Ju6
X-Gm-Gg: AR+sD13aEKAXJStdNCga5EF4FGIQc2RsDwj15WF3wc5RhKhCourDiOvu+JavN/sIiww
 O550Y+3GFQ2fAL1yV5wK36OlQ9tKtnWatyCHb2xqxbeJMAP2c790+fp4SXGCPLYHYN+zL/kguUp
 0+wcbEyQfzp3JehKhIt/aUihREwxYOu/Si5YaaIqcZzyV02FCQ0i3OUil+PS+an6ndGO/mm4zDQ
 VLZwyMg+7hAvChxoW3KuE1xr/DMAONOd3j85gWXtcyFmlaHrC6ha+H0BqOqfGEF0SMwgdtZpZmb
 TBppRf/oKpYbCu+DsKqzc11i6tIl5AeAfJw7nJgQQ7UL5dckjrmTEOCy73VJMARAZQCdNQt7TH4
 svrQg+uHwLtZyNQmpiuLautdBLFsxkLO46ZQ6QcCEzAQvuIfk0R4ZtH9DNZ4Scu8Rb9M1JMa/+u
 IckFVLE778jQwPvcNUgQZsf9eDOSGI34ZUzz0iKapw1KUip8eNhnT/XP/vUMjoGX2QBrlW4J0ht
 +Z+x9ZlWCZ3YUsWDCrMJYZXjnIQttPj72bC0VLanjI0kXdE95IrP3T1zzkxZ+vLsLx2jnjQM2XQ
X-Received: by 2002:a05:6820:987:b0:6aa:e573:9ce0 with SMTP id
 006d021491bc7-6ae96d0b246mr21031555eaf.16.1786293518489; 
 Sun, 09 Aug 2026 09:38:38 -0700 (PDT)
Received: from
 runnervmvrwv9.mbrvyqtikzxedkwvaf01wtqthd.gx.internal.cloudapp.net
 ([20.106.22.225]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bbbdba8sm7173535eaf.1.2026.08.09.09.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 09:38:37 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sun,  9 Aug 2026 16:38:36 +0000
Message-ID: <20260809163836.8800-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809162202.1811452-1-pavrampu@linux.ibm.com>
References: <20260809162202.1811452-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota
 accounting
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

Hi Pavithra,

On Sun, 9 Aug 2026, Pavithra wrote:
> hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota accounting

> 		if (expected == QUOTA_FAIL &&
> 		    (errno == ENOMEM || errno == ENOSPC)) {

Could these checks require ENOMEM rather than also accepting ENOSPC?
The documented behavior is ENOMEM, and hugetlbfs_file_mmap() deliberately
returns ENOMEM when hugetlb_reserve_pages() rejects the reservation.
Accepting ENOSPC here and in the COW check can hide an errno regression.

> 	a = mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0);

Could this and the second tested mmap() call use TESTPTR() or an appropriate
TST_EXP_* wrapper? Subject syscalls should use the LTP result macros so the
return value and errno are captured consistently.

> 	char path[PATH_MAX + 32];

Could this use PATH_MAX? LTP path buffers should use PATH_MAX rather than a
custom larger size, and this constructed path is already bounded.

> +/hugetlb/hugemmap/hugemmap33

Could this entry move to
testcases/kernel/mem/hugetlb/hugemmap/.gitignore? New test binaries should be
ignored in their own leaf test directory rather than a parent directory.

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
