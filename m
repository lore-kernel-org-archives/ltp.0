Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A75C43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 07:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782977884; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=IjBgwlUbGi6G7ZN1+XoOSpnsvG8nDDKTlM+2MMRboY6par7Md7hyAOOBLkMuc2HYFgtBq
 jtPRm2eFMzQlLFun8pog/cOmorpm+h8XQ+oTuwD/KCYJB5o8Gxy7Zqw9RdvGUzWMhzMkq/8
 O7g+UASjFC6hN6ze5/uDcsXh5VEGYLw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1B9F3E4A05
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 09:38:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2414E3C5583
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 09:37:43 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7AB50140097A
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 09:37:37 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-475cb71a4ebso1410327f8f.0
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 00:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782977857; x=1783582657; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Mb6qzqW41mWanHnAJtcU2849Vzxa/5MZ7III5B+jXSfb6RQITGzfitO1W3BECvqMzs
 KfoWtwCEcbyzdGKDiBO/agMRdPPc3Lp6pvov3u8GLW+vIIFkGeT548FhoEjZGHL5Keqb
 Y346EdTP1UGy8m/rEqtvB7rPEb69wuLg+WR0ODqHmS0pVuLDivRKILcK2m/OUM9tp0Xb
 QNuD90ZBjtFyPPiR16M+00vM1/WO+0mFjztO3AUHEkzxMARvNwBnAF+L/hp05Wp6fMIS
 uSHkoemVnq7qxSBqhRVb3Z3VWbez6w/XEL2yAy7/vNN52u0L/4qfq9fTcmazYqbRloK9
 3WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782977857; x=1783582657;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=OAAQQOPcDClhbH3Rl9zIdbFAjcwuTUvz/wiMEFKi7sUktfby0BcgKekWRUQisB4qN4
 Vx2YRYUWvIsx2ZWjxmM600jgLG5k/C+tSjEtmJngQHK3Y61VIlpHh2ysqu6JKd7xNXlI
 ZgQd4fqNPjsTqs/mZ0+kQdjBVkfJUn5hdnz/rvSI4GbSPzTqbbphyXpl9Sta0z7pcpDO
 YpOtfmm/+mCVFfuVfSP+50aQhTbFiUIRbqdhVLA+fh16jZJDA5LZgTdctG7wEiTlDaPh
 43YGYpbVdUgHVKdJRzjxvfHBFlsK1ANks8uXn6kh4ZzAtl/iE75cjsPQJA5YZHXscFmj
 Cv/w==
X-Gm-Message-State: AOJu0Yx/WtXXckvMtVMXlkihkPLageT32izCXTI1YsFO2QwiejhtTj2k
 RkDafViYn6VEQ/D1Nke9Lnh/pvPYX762+6srJFs7g4CUJ4cEhPDgPv2h2sYpEqUZ6RLRMAEq6cs
 6PvSb0791yg==
X-Gm-Gg: AfdE7cn4KPQlR3e85DnZHjNe1iGuTFNXQ8Ge2VocgLHFhqqy0gVBGU2skd8rRhMOyXc
 7eLyHykYRmJIJ+Z5gwvIFsOSCtiQnYBW+gA+vjH6XYNVWSN5egmE+iPvTH7+6YFW+3AvEL6G9JB
 /a9TeB4vz4+rcI8DsKYmyqpOZYWb0RBguzmhz8FKb9f+lmfC8EoDxFpsrJNInUaTuIg5d2Wasim
 qn21Wh/+uSmxclVP8O9w02kh0WG3g8MIajygK8LeUeOh1s1QBMolhPDtpyTUxX/AwOwcwcvadAG
 b15mzvyNm/cGiF/soHN7aWJICiU11qp0OUCoh/UzK0FU1JJ2SDh6hs+dRwgYBz3Zse731ZbMfDn
 I0nyODPhOaAp/D6RHA2YISVWR3bI0lQ6QMkPBmjqKbgOgWe+uqTTjJ8PXVcJnxd0v3N2oMdCO+F
 cCNmJN5hUThpZ8xX1e6fCOgvncmPe81VNUDL5bjcAEcRc/sijsh7EElqCumbm+NxPalhxRo1pzF
 YOwKlMBLzN/iYJ4Rh80b+rg
X-Received: by 2002:a05:6000:61e:b0:475:f0c2:75a5 with SMTP id
 ffacd0b85a97d-4775ac9f7b3mr7426526f8f.54.1782977856820; 
 Thu, 02 Jul 2026 00:37:36 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a44d7sm6178957f8f.9.2026.07.02.00.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 00:37:36 -0700 (PDT)
Message-ID: <6a461540.53cb9477.d1886.a4fe@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20260702042505.389515-1-wakel@google.com>
Date: Thu, 02 Jul 2026 07:37:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/lsm_list_modules02: Log unrecognized LSM
 IDs with TINFO instead of TBROK
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
Cc: Wake Liu <wakel@google.com>, r.kothari@samsung.corp-partner.google.com,
 ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
