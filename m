Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333F0C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 08:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788512053; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=t+tPDrkda4uUQlbqtfFN0F8xSI5bPkZcInK1UohHcIQ=;
 b=kJ9gLRBNfCPJI4dZycZh7bSwFfMLxI8rfbhvKS4t+w+GBdlyHkIc7r38RetiFNieG45CS
 fZ04FzX1ieYy/vxKfz0mUXu7iT54H8UTnEh5MbRa61hCuvKeB9fdSdWjBwiTfLaco3U3v/l
 ljJCxLol9OaoywtBJeAObkPyq6L6C0w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5DB13E93BD
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:54:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 109FE3E9364
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:53:55 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CAA751400761
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:53:54 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48444ec4fe2so456691f8f.0
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 01:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788512034; x=1789116834; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=TsAL1W633Zuwv4HX3up4zM9KkwPOr7jfiKyHFInYb6jqyipAhnrCG7TLBvNwGNP3F2
 u2c0vDpulhI0wpz5rPBmfXqIXUXmQLCEgF5q/Ipfrks4pNSDayEK6kzCLGmUP9KGXDn8
 u1AFgqnrGal1VVlQkCmWeAqFv1SxgydsfNP+9ijAwcr6/rUu2Wt95byc6gBzOEZ4bjtL
 oWz67VMzMjIuXThKVJSZUMX9SAiZLbmB8DeFTn42dkp/40zQgwEBWX75zetu4MEAWOXU
 XeN5H4+Z3tUB4DmbERbZzC6ZEP+6WOdprLSsskzB/QHwKCDCyMSPwoaYTQKzacSEpWLq
 OHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788512034; x=1789116834;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=TQruLW6zbg5HeDmcICJGJ+a0TF1IXg/YQn3ZmEfYpTyixzEI2VtflfpGRUTnwqkXNI
 Ed7xo0mMMXfQQ7R+9JDtUVjMPSNR6y8RzzOfPpg+UgbDbJtq9YayxJ2031k1kq1dsCs3
 SfRdoJhE9Kp6LH8azjwyWUsiMaiwcPkVMmYTOhAH+rMZ6+rJ+CQ7IMS8aqd+07ZlXz5q
 vB7jaGcu8C/zwDLFREViq+1kmVfZP7wv9EXk88+pVFtHJHzsSg7TlaPagrQ+i7kxyYzg
 u6567pVPuciulLavCU+LyWv2XXxjfZibrLp8hr5b/2IJER2TkH7AwXYgMWh2K/jB3AhY
 0iJA==
X-Gm-Message-State: AFuF++myq1ILVWQOCnHyzeDydEdRFl+nlrrEiln3XNHC5s/MvNDb4cE2
 mucrpBKZjlPXm5/W9uJcTh8ajZIgvEsFcIX2YP5j4iC6j+vmkdWFi2qf/cr7AIwzfr4=
X-Gm-Gg: AYBFou3YpDEhG5WQqoyi1mR+miGI4Al6zZkq9LzV1YIlzLmIMCVmIzeMnuUNWdhFXbg
 mlGszUwgcxVp6NOYdwrlMaHqpFY1MuPbXwkAGcjN83qNPU8UQMH3HdE7MJ81oF7ksOVvZC+u7Ym
 Jon5rRRD6icR/136SMCwNAhlGOEb83D72U10FlynnSOHz2hbLvZrsd6Erz8dfuiNJkofuG/agZx
 JlIRPl+YbbS9pcveJn/EaETaAIDTkjrIOfU8lORuAjGdupjL8w7j9efrH/Wgae4zZOcksE4X9Nr
 OrWOQ7G+JnRTl7CiRzXEFa7kYGnZ0DHHhd/F9ktqAezSoAiNJlTlmWIwg7M1di9DOXPYIjVUpa6
 7vdZGp4knqHzqVi203U4S+IIvNwdQR9b93FLWATeROE2uHOQn7mMyak3P3yWWBCk1G14XWO8Q90
 kK+xAFhWxe0FcF+tUHXbMP7LDglPlA5k7AdecUtjfsGOX03MhZinYCT4zLsU7/j09INO9s7XyMH
 jMox82A83yc
X-Received: by 2002:a05:6000:4819:b0:482:fc30:a1b4 with SMTP id
 ffacd0b85a97d-4858704686dmr9395987f8f.5.1788512034090; 
 Fri, 04 Sep 2026 01:53:54 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c5bc5sm5030521f8f.24.2026.09.04.01.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 01:53:53 -0700 (PDT)
Message-ID: <6a9a8721.332d3c56.a539c.7f74@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260902025816.3915-1-wegao@suse.com>
Date: Fri, 04 Sep 2026 08:53:52 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mmapstress06: Use memory.high in cgroup v2 to
 start swapping early
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
