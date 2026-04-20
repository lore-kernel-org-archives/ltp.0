Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F609F5580B
	for <ltp@archiver.kernel.org>; Mon, 20 Apr 2026 10:54:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 902F23E2D9C
	for <ltp@archiver.kernel.org>; Mon, 20 Apr 2026 12:54:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC1703E2DBE
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 12:53:50 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 578272005E7
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 12:53:50 +0200 (CEST)
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7dbcf927395so1581325a34.0
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 03:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776682429; x=1777287229; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWg7US8CYih96kIix8TniK9Vg1fsJNrdy9o3hW4jzx8=;
 b=LIk/By1Gk7PjbuqJohoKVbysJ85zcgaK/oVKAUAT/5hZwIZcFgDAmHwmjm6EVLeteB
 bb6+sYPwuZaXteB+vdXqKfZkKkGhdiPRC8NugFNGVFZ07pVzsftD/btdM4eFlu0QbiUG
 3gfDvT4zzKQYJXsA1+2Zu0/uN/0a4hYTFPikJysipqc9YKCh4S1rStI0GVQaDF1FBTxO
 BESx6KcYwSPHNXKftFuNKHWdkibMRpqbXucU7HCgo8R5TDoioN1Kcb7mGBuPOmLhx7Lf
 jcnKbrSBqOYik/fYP9oni8KAxNr9gS1xy15BVU2jIzpqAz2R2bqCrIlVIpUnM/Pted/3
 itJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776682429; x=1777287229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YWg7US8CYih96kIix8TniK9Vg1fsJNrdy9o3hW4jzx8=;
 b=fI4Mu2aiXiNvq/Bd2K6Kqv34pKxUqRXm/CZexwkCZxDrY+vChHREaR7MIDvzUbQ8ub
 ZMK4eTVnb8x/9Dsg379o20qwofKCMs8hfJZw19fiUQdncTlnDQ2uqeVvF6nE0rJ7pASo
 8W+OeEc52qtLkehebZ8vMQkjpDw/om4NZw61nnsH8IN+6DMBMjXuAMG5rA8wIe4FigAZ
 26lhXB1Uo8U6zNsjj3VGG7Vr/jcNkGywdO12fGdpp1l8WOUjzCveGyHXRmfRfqagwWV7
 NHS9CqGivRqrqYBFj8+0wDyrzhogOZzid/zGwxqUYvquVhBc4ZIaRYmZXpKQEYUgONTw
 Z4iw==
X-Gm-Message-State: AOJu0YxZhXY4ncM+t/li+xFEihPPYid3GpaJkg4Cnh3DzZYkjUoRT/oC
 o5fem+s3woRKWxiIK+sdlR8SE1da0qePWGtkYLpSV9Kg30zFt/1+eZQd
X-Gm-Gg: AeBDiet3DDM/VX8kTdBWv15wFtf3DU+rnQO0BXdG5Sl1jVnUj9WPYTtKu0OxR93iBA1
 G4Z1liqr9AV/tbqLaTIMqybfbvL+RUltjezvEninbyic5NMW5aCYHzJVOvItoQZfV4geXIvRrVj
 Fo8dxQAOXEqFZfh7mGvHA3VGkN6WvFP4tFczSgIWr5gerACGd8kBS6PrnOURhtUgAnLQ0o0lhgS
 mQqVKyx9xwzUnAtkua07vVNf5suHZgGyS7fVSJupXC9e0QTjvP7tO4mNqZIMizQZz30m8HzRHz2
 43/Hq59gR+Ro13fNkK6xandFBJuaulGMkNgNrDybk634DgASqqpERfF8pxmScpWyVsmWQCpPk0m
 hw1772zgsXi+TGL0Lg8848285vF9qAIOaLo6196IdyWUApkjrZYG+uCXmYoJBeFI1yg06wfcuSF
 aNDrKwB/VZhWPUnYuKC+gHFj8UEzkpXp/+4nwCQmvH3w8BDzIQMJKPDB7Kni0oRT/6mJ4eDGiGR
 aT9v4IOaSnDqswklXYGtyUlvZjEYz7kxdBDz3W7meIchxyIdPs=
X-Received: by 2002:a05:6830:8288:b0:7d7:faef:fa0 with SMTP id
 46e09a7af769-7dc94d9b166mr7649932a34.3.1776682428982; 
 Mon, 20 Apr 2026 03:53:48 -0700 (PDT)
Received: from
 runnervmeorf1.uoxgeqwf1rvuphsuibavjeiadh.gx.internal.cloudapp.net
 ([20.118.245.160]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc97616c11sm8109295a34.25.2026.04.20.03.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 03:53:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Mon, 20 Apr 2026 10:53:47 +0000
Message-ID: <20260420105347.3893-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420094437.731979-2-piotr.kubaj@intel.com>
References: <20260420094437.731979-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] high_freq_hwp_cap_cppc.c: new test
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

On Mon, 20 Apr 2026, Piotr Kubaj wrote:
> high_freq_hwp_cap_cppc.c: new test

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
