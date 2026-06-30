Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546ACC43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 08:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782806460; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=jKt1n1QOpfEo5U2kqowXI0Q6wA4sTBCLc4ZfaCXokas=;
 b=EhAMg6eA87qn3+PVP1+eyFuAfyqwuoowVUySSO32P6HTJx971loWZYz/T0mbyXbom9F2J
 lCnPY77+8H9lAvgc89eFhtgrZvxq/PRyttkknLDzMragW4RY+WYu/0Ro0xIEQLmZRHOR6d6
 c3l5NewHgUtsfjDng6u2DXiQJKhDqJY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3BC43E2F5A
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 10:01:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23D753E2F4D
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 10:00:39 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 933F0600BC5
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 10:00:39 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493a97fad2fso20471665e9.0
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782806439; x=1783411239; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lAMcP2rRvCoG5IDXYOENwfssxzFsFymViK4NmULqGyo=;
 b=MDMd7M32psprtePHnC9PAm9yNLVxbm0sM+AHbGZhrzKyWL4BNNyMLZU94AbfaaN9ht
 mFujtWyCK+lTHecTVgUZ1P9h5QVwSV0CQuyG/9BSorO35ANAEYVfFAcT7+WQOzcYBKKy
 QfGAC0Y7ezka2wQl6isq4LkD2blAdNXcUAqGDVH9Z0sPh8sjNIDgtQiEVsTJ8X9xFXRl
 QjbsZ6jx6SIazRKXaHaIfNRCocZdEtlocwPOZUln5vEnsCLC8zw5Nu6YPjuyfXhVDQTl
 eU2n8K9YeLR+MYgtNM82XHEf0EvYQizMyBjReST24idNtgZTYg+PIPLNlgyKaqlxtwtl
 jSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782806439; x=1783411239;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAMcP2rRvCoG5IDXYOENwfssxzFsFymViK4NmULqGyo=;
 b=sv2ltzO1bo9ycBn/zCyFig/eZMN3Fjxsir/29S/P+fyuXKbDHp+Wx+mI/CKC7tOXeM
 oepIJ+Yu6ki6b+SWgVv0PH4qu1GYp9+ehH7of3qTlmC/hBmo2Eg3MaYHlcsUC51dh+GY
 /wgdXgzN3VTBkIGMZHQGirQ8QiltTI+iqlWMVIQ8mjkIVPq38rtvDtasyUJLu387LhVQ
 cfvQZ5SB/QB/FyAIzFFjajs3PacY4DnmRAApdaeBFdfaRP1KFr4AsCaIhjK5jSARo0S0
 9Zr6zBjKnTeEFiRW7SVEGpgXSWid1ACyhDqlVjezUAk/yr/AOQeyDs1TxgmO8utbKLze
 GBMQ==
X-Gm-Message-State: AOJu0Yw6524Q/ChkL6XGxTVcXQ5pWZj5vAAde88D5R5sNRkbiizpxNlV
 KslrbIfANeQ0uFmLpdsSAzpqcWCrlFwtMkh5yqk+vwVELtNJltiYYxW9SP9RjgKW7kc=
X-Gm-Gg: AfdE7cnDcObl9uuwguJit6v97wWLIP4Mh/DgP0VRN7xXG9aJ5hCDgsGvmQGwPYHDXWH
 0aSrkQi2PAJPAvBarB8T15+5LeHpAFbNuUKmbGMWcsx0ejKRPU3deG0WpQaZxskzIN3+O5oFYuN
 KTmEzwX/OqPG1tHKuErUAc9e6mN7hFXoEPR8RgDDW2zQ6mMeg7JIikTfJtdEWzGWBUndfG4je6j
 CdoDAI3+VkQ7VxiVEkHy9kNI9eFOh2T0TssCiMIZqDOmckogLbDqnJkh0CVZRBlvv9bBnnirdFV
 MIH4lFuQCgXdU0kr9Vgc849A4luUBo7/ZDEYgHG//F+lovU6ht1AeG2sHVvWXWJIhTdAvBJRFuG
 zDuv5WpVwCQnlkcv09FsL7+vCkAFTbtN/Sxoqglb++Z1TgKkx76hSO3vbu5utq1bmsJb+vV7tD/
 5itpzZEVWSLBQTKou0JRMqp7wREF0iodwDCjUaIIxSfTuzBUoqX7MM2MiDi/CmCdbbKl+O/Kjiq
 oU6IVNAMOFSIXGaFdvXtxEII+nbCmz8J/F4kAvreYK1UMb/4JLdT84tli3QJehUtFA=
X-Received: by 2002:a05:600c:8b0d:b0:490:4663:691b with SMTP id
 5b1f17b1804b1-493b827e8f8mr39240725e9.7.1782806438828; 
 Tue, 30 Jun 2026 01:00:38 -0700 (PDT)
Received: from p200300ef2f13eb00680747d6cefceff6.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8ccc7d7sm51901675e9.2.2026.06.30.01.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:00:38 -0700 (PDT)
Message-ID: <6a4377a6.51d65a57.19e759.3280@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260429105644.986278-1-pvorel@suse.cz>
Date: Tue, 30 Jun 2026 08:00:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Move runtest/irq into runtest/kernel_misc
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
Cc: Tim Bird <tim.bird@sony.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

any news about this? Can we mege it?

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
