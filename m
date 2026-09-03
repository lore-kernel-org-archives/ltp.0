Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09638C624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 12:02:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 483E13EA80C
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 14:02:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 068473D86E3
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:01:50 +0200 (CEST)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9F03D6003FE
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:01:49 +0200 (CEST)
Received: by mail-qk2-x01.google.com with SMTP id
 d75a77b69052e-530178f21ffso14173981cf.1
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 05:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788436908; x=1789041708; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+uhw6oeX5+yHX/K0gQsNNstmpyS6dw8UtxUJ8s1ImZ4=;
 b=Ru+sRnoQl0N7LHkEYdcRSTeLxvsyoD80sO+tMop5R/eowp6dRvOo1KHKAgZABtBkYb
 f4KsiTIkVws8b9eVBqrrCxUAsEkIGDYdvulk1LcR4HF9tvbxqUiyQMBqM6T76dcFCl+u
 5VTVBHMhv33aANPZDXlT5paNUI333Qel1oZcUVybRZXrlMOh8kByVPPKxMf9koAvg26C
 dW/TEdUUtHeUM8jWx+mgrDpB2JXrCdn/6DpHwj1GBu18LZZ3uvlPQVYcqkmSDJ2YtQ6x
 H0MSV7kaw0zeVPEodXqFH4jnYJYwpn2us7ixdgLBGUFu9EUQtkIdWCadpM8GNZQ5QrGT
 Dz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788436908; x=1789041708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+uhw6oeX5+yHX/K0gQsNNstmpyS6dw8UtxUJ8s1ImZ4=;
 b=a1c6ntITdSyP3N7S1AUyhyKJCDx69csIwGmCVyJvOVfcH6f4pAL53hw8WaZ1xEz8yK
 sqk8LekEhsh4+Z0sdm3qLV3VtpryDzTt4WjiPP6R5OopGMX1MFFqWzNXMqQ5behWQRT3
 JJchKk22+aSbLbroKyyiwQNCq1/aBKHIi+5DQOVXvv7SiHutsEfjGnPzsCjL2WqwfJmC
 /p0pXEt/In0qfaW4KNcaE/vffufMU1gIvE6HOmLSMHWS7GOufVA+xSySClYUPQH6V1oo
 vy8L5n35QdiqWYsj3/sfOBfOq+scjXHqUsaCewh9S6qtOdlBe5eaFIIfaQqhxTTcuo4V
 sdvg==
X-Gm-Message-State: AFuF++kANorPZw23gj11nSxkhflmlJ50E2ZJqPKOMGNHbGUNn7CZshFE
 yfsUe6pESS4xmcZI6/YocE20kdCnLrsAiYEDBBfN4WI73a9n3bleUtGD
X-Gm-Gg: AYBFou1xfvwBjoUjgUd/zwUMbN2LSYDofLarTE/GOI8j5f8DoD7fZX/o77PneLcwlxK
 tziNF6EApfSSt2jBy34VCLJ7uIA2w/jpXZj2MUzYrwzx07vbE7WLLsWlgOWXNEYZ3EJ34pT03ak
 IP8msnpUdv4dGRft3+R0MIEii4BYEEf1HEmfx1L0Qh9uM+Ci+2wJFhOkkTtWabM1edzl4ZVs2Fe
 nqLMuDOV6Zy0GDXYYHz3MazUslXTigJoSVYs6VIXbfLNWbQI58IXc7n+fCj+rc15s6TIHroKsC5
 HxPYIqKfhrhPgAeCq2b/x6LbGRndB78UgLz/HojD5S6kfsdjHNQ4iTtfZzHciHyzeapxc7LKWyL
 UybvdnjSy2Vfe4eXtXE5PUMu+PL1YkvhaNkW/QAS41PkwujRt648R40zV6eK0yvCXiquL3w4tVn
 9vKZr91TO6G0QPIFSguVLsbY5ioIgdbFXT4j/6PbQ0RG1hzdPv34/rjXdSgTcpPIiNSoiwTydxX
 UI9qGlLiU0aiiFRqv/lWAnJJ5ykYbC2szBHaDf5yoG8M091HdqwN6qsim7oN6Bp5LnLQ8jEiAt0
X-Received: by 2002:a05:622a:4812:b0:52d:7b2a:93b with SMTP id
 d75a77b69052e-53036bf75cdmr149087791cf.9.1788436905672; 
 Thu, 03 Sep 2026 05:01:45 -0700 (PDT)
Received: from
 runnervmejwal.12xziortip3ehm5r4a2ohvh4oa.cx.internal.cloudapp.net
 ([20.109.38.166]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53033277f37sm42493771cf.30.2026.09.03.05.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 05:01:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu,  3 Sep 2026 12:01:42 +0000
Message-ID: <20260903120142.9093-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903-coredump-v5-1-2ea86fa29107@suse.com>
References: <20260903-coredump-v5-1-2ea86fa29107@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] coredump01: New core_pattern specifiers test
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

Hi Andrea,

On Thu, 3 Sep 2026, Andrea Cervesato wrote:
> coredump01: New core_pattern specifiers test

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
