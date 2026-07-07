Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B2EC43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 03:34:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB2A23E5DFA
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 05:34:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD8733C72CC
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 05:34:19 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 647AD60083F
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 05:34:19 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8ea5b69e46bso3399616d6.1
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 20:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783395258; x=1784000058; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=02x5lgmdB6LDEVA5OGjGIEmW+aX2ybEV3pTUVKTbemw=;
 b=EBEeNQSaCnFHw3QVGwRRX+5CWZh8xCLis/Ns3Q2yLEFM8eGKGhaWhYBy7gYOOdlIYr
 Cvr+GiYsR1+J6+e3RINj+uE4HxI8ljuRd1kpbCUUL0oySR5RiZUqXjANxcqqsho6496J
 Vwn8Ed+GykawrlnImzVeGhWAhbU+SfpfnxdQGKZVjCPTXzb2/HfJnidtoKox/nTI8Uv1
 FeJ6ErcQSxWIwXVS/LjkRCD8tUsJ9kJIrHas4ebGmenulQhObUa7A1bDKGx/wDle8Ju7
 6jP3o3mArtreKYjCUXAADM1xtE6/fSXu9BQ/e7OqfrAqHVdebDEfgDR0B+VttgKOjzuB
 kARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783395258; x=1784000058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=02x5lgmdB6LDEVA5OGjGIEmW+aX2ybEV3pTUVKTbemw=;
 b=oXjNLnoVmd+JMTLCeFnGXxOmbBPhc7voo9lo1pcoLpXKu9mj1zmSlQf8ycwnQLNNPs
 gLrgHTttal7m5zuVWHYoEFLMjNjdKtmCkmVcdlSinLlRv5is5Bcs7A3WTAQayxbrpVUW
 7U+cu0wQ2EmfeP9FcGs1Cce6gX4jpOwO6BplQIHSzHrFHRaPiB2+hKkLN7s6u3mkJHuU
 WzoCW3/lB6FURHJ/0Ls/ZQjBoK7emMhXsexU1JjoXM5rhzm7wsLOzL9A/C9Hs7iISkSf
 buM58ItgIiZhu2ymzP2dHGOWBpUZuSZQkD9pr9bRTKWlUq36g7N3w9oBM9dRlM38AJUv
 LtkQ==
X-Gm-Message-State: AOJu0YxiN2SJYn2/b64WIowY4+57GSSbk5AOJly479K1aOx5iYf8pIWc
 wA2ZD0lAYXIRrWLBs2t72ei9NDYuKd6LRuf8k7bxA2FAJ7/2jrvz8j56
X-Gm-Gg: AfdE7cmh0AHFSJQDhXWDj3YnAxG71+W9VNzfJ2G7fVQDQvw3uqMBidyTwTaLg8d3Oyf
 feulhB8Xgu/KYN8ShqHOpXLVnmc9elopKKsoWe76+RBHu+bKximGUKVMrpOD+AuT2s+5Qo7crz7
 a0uXq2i73uDuMjLXF8tdC2GD8RdVTa1cOD8LtXjfQSeqKZXdGnZ4Nl/OeMH9B5TIFZfbnmNsEhU
 EwlL0jjMSemtUEwEJYiNy6H4jzldRpURJ0+Iz+QPdb5riMU6IXXUDs/m20B4h/S7wzonD2hAI/0
 h1SLiBkLJMd8wYMG+oLWAD0MPJCsq1tBD+dCo5KN4jBNH7PS4+OY2wdTrn4h3ga5fDlUYIv0CJa
 RqQpJuP+ZwbGe653WUF+0OmB+dten7uv/tIsfys3nt/rFmA5lp3o1yT/NM1IKGrl1x1g4BJqapd
 mrHBLuXhXm8wW+C3tGLVNoKDyErqqnIBvjnJoBrvzCQOrGfUzt1xtTPG+Jh6W3iq+Gc1gvIXBvz
 l35zp3rZNsCM6Idm+w+qN5bUjQ=
X-Received: by 2002:a05:620a:8399:b0:92b:6805:919b with SMTP id
 af79cd13be357-92ebb5a7401mr417938885a.67.1783395257861; 
 Mon, 06 Jul 2026 20:34:17 -0700 (PDT)
Received: from
 runnervmkkn4f.mdtce0mt4ome5kzwfyfkzdq1na.bx.internal.cloudapp.net
 ([74.235.90.82]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90cedfe0sm1112772485a.43.2026.07.06.20.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 20:34:17 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Tue,  7 Jul 2026 03:34:16 +0000
Message-ID: <20260707033416.4195-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707022959.24088-2-wegao@suse.com>
References: <20260707022959.24088-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: New library function tst_get_free_uid
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

Hi Wei,

On Tue, 07 Jul 2026 02:29:41 +0000, Wei Gao wrote:
> lib: New library function tst_get_free_uid

--- [PATCH 1/2] ---

> Add tst_get_free_uid() to dynamically find unused UIDs for tests.

The body restates what the subject already says.  What scenario or
test requires a dynamically allocated free UID that tst_get_uids()
cannot cover?

> +uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip);
> +#define tst_get_free_uid(skip) tst_get_free_uid_(__FILE__, __LINE__, (skip))

tst_get_free_uid_() is a new public function in lib/ and include/.
LTP documentation rules require a kernel-doc /** ... */ comment for
new public symbols there.  Something like:

  /**
   * tst_get_free_uid() - Find a UID not assigned to any user.
   * @skip: UID value to skip (pass 0 to skip none).
   *
   * Scans the password database for the first unused UID starting
   * from 1, skipping @skip.  Calls tst_brk(TBROK) if no free UID
   * is found or a lookup error occurs.
   *
   * Return: An unused uid_t value.
   */

> - * Find unassigned gid. The skip argument can be used to ignore e.g. the main
> + * Find unassigned uid/gid. The skip argument can be used to ignore e.g. the main
>   * group of a specific user in case it's not listed in the group file. If you
> - * do not need to skip any specific gid, simply set it to 0.
> + * do not need to skip any specific id, simply set it to 0.

"not listed in the group file" applies to GIDs only.  UIDs live in
the password database (/etc/passwd or NSS passwd).  The comment
should say "password or group file", or be split per-function.

> +uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip)
> +{
> +	uid_t ret;
> +
> +	errno = 0;
> +
> +	for (ret = 1; ret < MAX_UID; ret++) {
> +		if (ret == skip || getpwuid(ret))
> +			continue;
> +
> +		if (errno == 0 || errno == ENOENT || errno == ESRCH) {

POSIX requires callers to set errno = 0 before each call to
getpwuid() so that a NULL return with non-zero errno means error
rather than "entry not found".  The reset here is done once before
the loop.  If a successful getpwuid() call for an earlier UID leaves
errno non-zero (POSIX does not guarantee it is cleared on success),
the next NULL-returning call could be misclassified as an error and
trigger the tst_brk() path below.

A per-iteration reset:

  errno = 0;
  if (ret == skip || getpwuid(ret))
      continue;

would match the POSIX-recommended pattern and make the intent clear.

Verdict - Needs revision

Pre-existing issues:

tst_get_free_gid_() in lib/tst_uid.c has the same errno-reset issue
described above (errno set once before the loop, not before each
getgrgid() call).

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
