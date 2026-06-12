Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4C5CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 12:22:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B91D23E5E55
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 14:22:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A98F3E1CF6
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 14:22:42 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 917B360025C
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 14:22:42 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-304d7f31215so874038eec.1
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781266961; x=1781871761; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02SHUCu2q4DnBVH2whGdjE3pq561uweOykdtSDZgams=;
 b=KjBfjQ6bNMQj79GU/Tj5cUlqxPvTbe1+7r5lMtGYPEmRea64xtqjJ/0kL5NORNdD7n
 QHIhL5Jkm64obMuxLroK/XCRdXcTnqDmQJbALvo++LfRIXwxvwhrFMxCRH3kOU3edSIZ
 Ek8FrCuA1Hi769y87Aa49ar42Rjn4WVyPXYCigxBWH+Mh4ViCryjUgjHZvUdJEFFIHsq
 WvxvTeomVwDJcrKKAYfPtts+WFawn07Lpe8nVx8BmFuu8U3MZQoKW80nt1fFtSi4iYdx
 Af+8tFtNvwh3dCGr1mR4gAr0XALjsfw95p1+EfGuBSiRnoYewYBGfJYqRKcF+TDed6b9
 +S4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781266961; x=1781871761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=02SHUCu2q4DnBVH2whGdjE3pq561uweOykdtSDZgams=;
 b=WHxSS6h7MaVD43fbJAnSLFfuD6q/IrqXbmUBkGXIQKMYiGpztu5U++Li4/lrJ/54T+
 WYlmnOHhzc7sXydEvTIAE1NOVLqbDw+jYtyH99AvuFe56Ip3wVbJ+TVa7cVnSJPwvVzZ
 pAZcg37NP7pcqoft6KDI+c6eKFJAnabHwF+Spu58bC13WZxfCDmUbBKSY5uVs/qd2+Aw
 B3SB1nBd6cUKPOVgbQpXC30BcwHL+STsANE45RBsyRlTniT+87IyLJ6zy2EW1G4rdseZ
 CUZuKg/S5wjx7U987ccUBL89poYrpdR6B4D852Pu1SmJga7eXK2q3q0OmgBbLcZn6DKR
 eA+A==
X-Gm-Message-State: AOJu0Yy01odSeXzJTXYt+pvc3cZCC0uoY1KOnPwJIEYzTFqKeeoduPrq
 AbeH530NUTaL9LHM3SyBG4gb8tEBNjkyuJQqirt6YaxcHr8GkwJTf5lz
X-Gm-Gg: Acq92OFZbuwZTOrVCM8wMceaMvUzIju7cs2rtriGhNanA4Tw6zmrB2UXKe3637CUW5M
 JoiE7eIrDFFmPfkHgsAcGToCEYtu1heGWFlXjIn7fDz/VSp4W1WnzM0dWexdneKhT+9tpxZYTIN
 REplgFK6I0Hlk2NF8kA3d17et2i57YBp/o4/5IddMhYBfjFGGuWgI1YIScbus2oLt+XGtGvGm8T
 i8Jyeej+4sykDPJCJXJ+3ryTve1/lm3g1LgVu5JMjOc3BM5f/UVVbCbK1PW+F5U0GJjfZE0a8u3
 TnRoyCeDP/JdJh7GJc4hKfo9f0MP8OTqJKvWAYiThC80E+bvXSSPzJtoE9bezyPjs3UjEhkmzy/
 Pr2b7GCoJqUssHGFofcowCtDAitBmkLKaCF9ET5/UxICe0gZYOKED8QK7fKYeZpmiS2d2xwCxB1
 SKwACWDajdBVboW40q2PGBSoEAKO7hT04n0Wn/sjbE67aQRK4CmIir7YBHlJgEC2VoOVuLgxjNu
 cJsORJvSAQ5GAOOzPLMMz7P4H8CXJEZNJNDJ9lqSUA804Xp
X-Received: by 2002:a05:7301:9c8e:b0:304:997c:d47a with SMTP id
 5a478bee46e88-3081ff71b81mr1561883eec.10.1781266960668; 
 Fri, 12 Jun 2026 05:22:40 -0700 (PDT)
Received: from
 runnervm1li68.aygp4ywqhuguzgdq0r011xmwyc.dx.internal.cloudapp.net
 ([52.159.246.2]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb9a138sm4081930eec.31.2026.06.12.05.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 05:22:40 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 12 Jun 2026 12:22:38 +0000
Message-ID: <20260612122238.3910-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612-fix_clone11_min_kver-v2-1-90cfb4b687fb@suse.com>
References: <20260612-fix_clone11_min_kver-v2-1-90cfb4b687fb@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clone11: skip CLONE_NEWCGROUP on kernels < 4.6
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

On Fri, 12 Jun 2026 11:58:26 +0200, Andrea Cervesato wrote:
> clone11: skip CLONE_NEWCGROUP on kernels < 4.6

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
