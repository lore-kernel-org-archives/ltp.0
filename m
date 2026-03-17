Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441A2FD7078
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773744194; h=message-id :
 to : date : subject : list-id : list-unsubscribe : list-archive :
 list-post : list-help : list-subscribe : from : reply-to :
 mime-version : content-type : content-transfer-encoding : sender :
 from; bh=c7KXMZb4Zmyl8tFjq8OXUQ2iGgmSAAGtd4vFad3WyBU=;
 b=DpNAWdaIapQwXgNita1lGr3TQvXI353JKkaQqvGPtDdn2nuK2cCflpXiAkmZocNJK3utk
 toH3DtyfutLEFOH75TJhWmDZAB6GEnzKazdiPBFHRzIb+Mx2x2QTA8MYX4kodjVbo9l5vYn
 3tRK7J2EohIL5pXuMQGmUJtrQz3zizg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0A473E1D3A
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 11:43:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34D203CB329
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 11:42:52 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 11D0E1A00A26
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 11:42:50 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so34008765e9.0
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 03:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773744170; x=1774348970; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:to:from:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NLNlQCp3FYYuQG1eTvx59Mqe1G9leZjhgkQi+RzuLdM=;
 b=MHZF0c9IbJ4OhrXlTwEB19hWhoMBOaQI1J8NkythFV1KnED8pK+5ftZL5GyGcMj74l
 NCtm9RR2GftK053ZmAOMikn9NRnqvKAs+GRTe/VjXjtpO89mB4RZ1tp/mBP2mTk9ZXdG
 gZmRhhEKNZiDHMUhCw9kt8KZKUi/CrWtTzY20hBEgz/rTj991U+pzpBOAiMI1zys/qmV
 YHyZawVZJ3bFEJlKiFIv3taAYi8ixz/1r8al/BhD4u/cncZyL9pn1ng+0gygjNmW7UWa
 3PFdTHoHhEM3RkUPu8sF/u7OuV8Y50EjruzCYciegf7lr+pb1jiFvM5xqKMJGJj4T2Ce
 uCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773744170; x=1774348970;
 h=date:content-transfer-encoding:subject:to:from:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NLNlQCp3FYYuQG1eTvx59Mqe1G9leZjhgkQi+RzuLdM=;
 b=Y5IUFpmoZmlu+K3cvmc2sDASsMaUqyS7ULeqeIsZysfrjRA204oIwPabdCcM9+IUDl
 sEw2iotGJMtOXxtD6a7giysW7SGMVDPMTdWPlveRUUMSFjj2cshhLrZ0vXs1dzC0cmgG
 fXNwhpA/2J/3zgX9j6bf9IaBCgj8s5495SE4Tck6gKJnN4CyOedhR3GNdFJ+9lYW5r3a
 TrGRXx3I6YUUL7fTWGOwdtf/O40nrqhgTa+VCeOD1Qp1Je/9dCeG3NHAM/N1t02mu1iP
 NVKJwhlm0dOJJ73AYBGcLQH1ATmyuWuMl85kVUzQNyxBNxt3T91n4WgPOJWD3CV8te/M
 c0lw==
X-Gm-Message-State: AOJu0Yznvsd2nRwoGGC9XPUcQg+UqF9Iztlz47lG+9nu5ev4R6qp2Hy0
 I0o8P8kNiEj80Jb9ROFKaY8zc9k2W/QIbVW/w384TjH8gk6dF5SbuFp+I7AeBR1tYRd8KSI8yH0
 968eSHbc=
X-Gm-Gg: ATEYQzy7CU1Qod01yAQtYKjeZVDN/Vpx2CrGvqhnczGRpII/SGbwxYz0dLKGaAo28BD
 vEEx1Guuf9r7s7gRi/Hmqs0zFybqjoWzo9eDJhYYRzUFEEOBDt1qns7MltlZXhpA9noLAWn2oJd
 H7jGJaUhzOaLdqm/mJWt3DUBCmNzYg99U+t+LRf4yALnBkrdeDIFBkVYT1FMZqF9Q3PVKk1DnVt
 MbNoCRO5OJbXq5N0ZhMCzajSPy7juFT9qduhRAt5gl19JL9gjpsvITKELvyu1g0+91L5Us/LJ2J
 /uPB5USFrVPP63qfrkaIn8Lc5b34FHFLlGVlmjy9UqQJmT0UcDFfKQPkCzXn//cGHEpRqSsYJaB
 qiVHig04HY4asH7QxgTletSmL7caw1S+KFSK1EEMwdhyI72W8626WKd093sw3iV5LAjfBFMXZYA
 yc1XKAKJdmubaIfc4vRcR/KPT9hVjzSCL3GCa25m2kkO1I+fIzhP97hfVwhm7Y0zu9ycJzunXQO
 BWrNzMmHI6RhXTh+NtpWCse0ExSh3Biht5sEpnPtfo0f2i/xQi1O6kxtAvivQJeLkvvn8p20hds
 ig==
X-Received: by 2002:a05:600c:64cd:b0:485:4533:9c47 with SMTP id
 5b1f17b1804b1-48556705203mr258906565e9.22.1773744169877; 
 Tue, 17 Mar 2026 03:42:49 -0700 (PDT)
Received: from p200300ef2f4fc9002549698ebd81b8fb.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856c2823afsm32412385e9.19.2026.03.17.03.42.49
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:42:49 -0700 (PDT)
Message-ID: <69b93029.050a0220.2e2929.5885@mx.google.com>
To: ltp@lists.linux.it
Date: Tue, 17 Mar 2026 10:42:49 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP old API conversion
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

so we still have ~200 patches to refactor and to move from old LTP API into
the new LTP API. That would be really useful for tests maintenance and long
term supports, such as the `runtest` removal and replacement with a smarter
tests filtering/grouping.

This is a tedious task that requires a huge amount of work and in the past
years we managed to convert hundreds of tests by hand, each one requiring
multiple reviews iterations.

It was overwhelming not only for developers, but also for reviewers who
were stucked by reviewing new patches + tests rewriting.

In 2026 we have the chance to accelerate this transition from old API to
new API using LLMs and, as we discussed in the yesterday LTP after release
meeting, we might be in the right way to start doing it (at least for
smaller tests).

I created a set of configurations and skills in my personal repo which can
be used to start this process: https://github.com/acerv/agents-config.
It's maily tested using Claude Code, since it's the model which perform
the best (at the moment), but any other model can be used.

I experimented with a list of tests that can be obtained with the following
command:

wc -l $(grep -R '"test\.h"' --include="*.c" testcases/kernel/ | cut -d: -f1) | sort -g

.. and tests conversion for tests which are smaller than 200 lines of code
requires minimal (if no) edit. I will continue to adapt the ltp-convert skill
in order to tweak and to improve this process for bigger tests.

~~ Said so..

.. since this process seems to be quite straight forward, and with the usage
of LLM we could easily generate hundreds of patches per month, we don't really
want to flood the ML with garbage and to overwhelm who's involved into
maintenance review.

How we should organize this job?
Should we set a maximum amount of tests refactoring per month?
How do we organize these patches? (i.e. with blocks of patches)

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
