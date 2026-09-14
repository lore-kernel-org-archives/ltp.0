Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41881C88E50
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 12:05:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08B343C00AF
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 14:05:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09F5D3C00AF
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 14:05:09 +0200 (CEST)
Received: from mail-qk2-x08.google.com (mail-qk2-x08.google.com
 [IPv6:2607:f8b0:4864:34::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 34C8E1A009A6
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 14:05:09 +0200 (CEST)
Received: by mail-qk2-x08.google.com with SMTP id
 af79cd13be357-939fea05b69so131729585a.0
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789387508; x=1789992308; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oc5R18l49dgXJKYTFHXigOrrw98OPSCA6WlEynHUhrQ=;
 b=FLqr/kmHJByW54nKPl5sf472w65mRJOJDhfb0MwoED1a+zPr+gUq0IEfZOat/oQ8Na
 ass7m9leCetut2QsZM53q/RiMzgFYCMjSBMwouIdXiIj4HiQTHSbAOdJF2ZP+h/VRPTO
 bmpwJ8nG7gjcTo3TVuBcjXwfo8WHjQ9mkYyBDArrnQytr2heWswCLYPS9RnnShfjPMrZ
 4PSnn/RiMoLMlkJbAdnNGW+MvNusps4fDqKj4ylT4By4NuFE3Mi+xlG8XT5MlhCw7mcu
 AW4g7M2Akd+Du75gKOgPd1ywW4uMq5iqS+JZxqY7tus7Pzw4fOu5774AQ+IngTCZzsrt
 y5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789387508; x=1789992308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oc5R18l49dgXJKYTFHXigOrrw98OPSCA6WlEynHUhrQ=;
 b=DSX6HTRMatFs6q/NBumr15WPLv/g4/H18omafm0xXKWoRJJUT0bgj3/MgZXQNxBAOJ
 wCDPLo0CrZNpWZuzYHu/WFzVWVa6Ria1MNRFrSFbVt/AmtDX4JgGlyeueoYC/Ob4zONJ
 pDwiSOvTZ3B+aO1YQpzTNLLYsZcJv2bJKZOmhFz+nLm66riuHbyPO16bLo7hfIlz5WgK
 Lr+YKEYbE4xKO5kBbjAugOTX+/HzvfKJUKfj51wvfqf3Q58yYTDlA7sNVLEQ+c4Pr5C3
 agxw99XlMHJ1mdeAwVCQDEqGyNGNR2IzxU6rHV/5UH83KXjoYr4VRT8yjIC+7GsMGy01
 YEgg==
X-Gm-Message-State: AFuF++lknKRf/jjtuRpSuz3WMIPnOlVoGhQzPIoy7SR7UavrECYaPcag
 zkQ0ssmxUTnbFE6COVgOCPn+blWsIqXl0Kk+P9hpO7Fb7q5+l84GAzml
X-Gm-Gg: AYBFou2EHC2pR8TV+QKWcDccIDtSNskRGaLCzkzm9oF3T5V74bHdCnBKo0W9IKsE1tk
 CQ2+oclylZtN2WbexNZiwDvI3J5yeYr0ErnVtXC1oxBZELs9dugXqgvbgITIo/gsclUyFqF+KIC
 r3ocds/Wpp8aeF9F9CQcAUF2VRxTdefR+TfQQ7i9S4GNzSzADWAgN3FSwPz4OxZpjuqkkIztjcC
 0jVqdVmtulwrgYRwNwMtP1UWoncYYqyjxgdLcB5Uj3unKgvRiDBTiZwep6D0sVKl0W8LXm5Z8j/
 oCboyHr2soRFhz2KpZU2WQt5DlTOl+aiCpHM07sz0yIO3xWt9flPHSZObuumvcV5Y1vVnsom439
 2qoDcKgpeeNRTw3J2ytflmWJN8ACpyHyAsJBiAkBCATmEoi/MtUj7/BNTEgWJJGPz5x4f3m+7Fo
 n+bpz6vYcDoWkMkfK3MEy7wfKgZ7ehhYplja/GQaQUhQrA3Jh1RYeqCenHx6wo1ltrsz0TviyBI
 IywV+LR/bsmO2Nq5ZZXIOL/JrFe4s5Gvf9Bj2HKBkmcXHFrQZYWthsd0JpVHl3VW25I0TEgmMkn
 tRVJCfG1Ag==
X-Received: by 2002:a05:620a:6504:b0:939:fce2:d4b6 with SMTP id
 af79cd13be357-93a299c8856mr320559285a.38.1789387507679; 
 Mon, 14 Sep 2026 05:05:07 -0700 (PDT)
Received: from
 runnervmlun5p.pkiwiyq2oyfulktwfhbrosnyua.bx.internal.cloudapp.net
 ([172.214.44.1]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939e7f1a2e7sm987288085a.8.2026.09.14.05.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 05:05:07 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Mon, 14 Sep 2026 12:05:06 +0000
Message-ID: <20260914120506.15388-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914092517.879141-2-piotr.kubaj@intel.com>
References: <20260914092517.879141-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: add tst_test.needs_debugfs flag
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

Hi Piotr,

On Mon Sep 14 11:25:14 2026 +0200, Piotr Kubaj <piotr.kubaj@intel.com> wrote:
> lib: add tst_test.needs_debugfs flag

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
