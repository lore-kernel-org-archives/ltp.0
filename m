Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23302FC981D
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 08:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774860861; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=3dwzG1t4HYOfeoBlBftZu5oujYZ5F58i9VEMHB0VYe4=;
 b=VorhGK0aicctq8cMSDRnnBrw6Ob5+1uMraBUP4yOL7/BQ6Lt6RdkmbHWh6G5k67GAxU2W
 Ib9hnSzRdr0NHnY+unFEQsagzdPzM5Q0qMBBXCaqV7oZ02ltziuNl97hBx88iofp6IZDiR0
 KIS0AXTOy6PYCLUBYwtnP4MHjePZwU0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB9243DD9D3
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:54:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D2BE3CB8BA
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:53:58 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6A0F81400DAA
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:53:58 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d02a71526so177094f8f.3
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 01:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774860838; x=1775465638; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=64GbewoHLjoAiV/LRJTNQg6+oLgavubnTv01iB9pJLU=;
 b=C9o19mASOYs8Gidn009ZsD3U6+UW+jwo97ExuKFnh7mrQg6qdPX1Mwx5wBIgJHnnBm
 AOnUObyxvPYr1QNKYDEqJw1WoEKxhB8Am++YcGen45WLKJ+vPU5YC0KU7jfSLpEdvsMB
 fvmjuAU+LMsd5uI/7onyygMM8CgBErIlOn0DjJvBQKQybTAeZy9+QqAiVEKdMp+LjyLM
 EJpEl4W5Nw/10hBmVqKdBwSa+g+ZxGJb+ks7rI91fuQNwWpFjSHCJml+fTLXXPd0Wevt
 SOTnWAq6bqN1Co3mU5KyNCdVtxIXM9AMR/YmKaLOI6lw3IC73dvGMkrCRLzPRQlw1QnZ
 Qh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774860838; x=1775465638;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64GbewoHLjoAiV/LRJTNQg6+oLgavubnTv01iB9pJLU=;
 b=gcffDZ/BmhXH0ZqnWWbHU7YO4aB37HbNYCqVaE6577+ZSgcx14i4fLmFs30oC102tl
 NtmHK3ifhfZPWr/iHBQI978EM3XvJxPlLuEWySwiwFvzE/qDN9gPCnxxbb1LJiZVppSq
 A6W46jdXIU7c7kKtfJ0XoQPvTtH6vi9stlYku4VEK5wHJoHcceDgUjV/tEWEnWFIl9ep
 fhy8F0eTs1XRwI/S+pYTTVA0Qb6m1paM8BywJNgjRvdBFCdSSU6Sg9ileenv5ZQIFErg
 o6u8ShKTjh/W8ZBsccj1DhS6pt2eu+Xg6O5/hnLPOsg+DNI2EooZoEiWfLzMGOEXK21V
 IzzA==
X-Gm-Message-State: AOJu0YzkMyQKmOhWcMb/o4k1Ek1NJqhOODXtZnL7SyTMM3gkHaA+BJJi
 7FtNXQAeH++Kj63pd7gHPtGVcp+NiInlDrNPxjWAaiJvL+PYW83vhvhRRtta52Pl124=
X-Gm-Gg: ATEYQzyW8IBsSfEqND+3HmiJfL9mv5WDbtPcAxMj6s5vUuKu+oB20T1Y5qFb8Z3zjyB
 FYulxMtEGqbmErAhD1jTjzkdtZbZdO3ORfrcpNG65VzsK99zuOMNmFrhObm2G72HPqC+0qNPQSQ
 jDp0hl+danYwnbJKTauY/0o/UIoZsbrQ9ODlSHCLPCfdaITncYROSEWShLM4atrhHxyo7jYOX0v
 aZMbKguaTO73/0QMjixoyEXGsb6FbpMwRVnY0rJihbw8U1dTt5VzDK1v6xHbh/MYmp49KGMS0uH
 t96O5tE5XoFjgtbOQPZ7ThVUuywuwEudpHhIC270kzufQnf/DadylpytIVJUJJmyBlK120H1U0i
 C82bH0VTQba/vSqKvRbh96zsX7Tu6B/kobrIMutkgMwPpannwavEBk/We8cgS+HboQyKGvr1iXP
 9FM2+dv8YmWTNlNBSj8YglpLQTS6L1QVkKi8Ddn/7WVZ8dPaz917/jsTptRmeFGR6gHtfJRKsjv
 iwkl3JA6YHSzvhXjcSJeEoo8nP5jCJYdCg=
X-Received: by 2002:a05:6000:2dc5:b0:439:ac6b:dd38 with SMTP id
 ffacd0b85a97d-43b9ea4ad2fmr19792908f8f.31.1774860837733; 
 Mon, 30 Mar 2026 01:53:57 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf257cbc3sm17313225f8f.35.2026.03.30.01.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 01:53:57 -0700 (PDT)
Message-ID: <69ca3a25.5d0a0220.18f3f2.a38a@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260327173252.1112192-5-pvorel@suse.cz>
Date: Mon, 30 Mar 2026 08:53:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/4] doc: newlib_tests: Update debugging
 parameters
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

Hi Petr,

> +Both ``-D`` parameter and ``LTP_DEBUG``  support the following verbosity levels:

Double space before "support".

The rest looks good:

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
