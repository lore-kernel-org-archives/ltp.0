Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A853CD3423
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 08:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777883574; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=MmgtNJ+9irDy4m5p3VmxDtS2zIsK8IR//9T9hpGu5xg=;
 b=gKvQe/bJBvoHHgnZjYU6fU+slyZdrq5sdKDBz1Zz6l1veoqRYDcf9qBF7RpFfD1OSSTDK
 IuCs/MfOK8B34a6epYBam7pgCdRIREVd+HYBV5PZXgJNsShLREPU/oL8IPE1a8ClJE3EaPT
 AUmg75UdPxxxa6n8HG374GoqXccAxeA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBE9F3E4822
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 10:32:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A8E13E1869
 for <ltp@lists.linux.it>; Mon,  4 May 2026 10:32:28 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 550BE200209
 for <ltp@lists.linux.it>; Mon,  4 May 2026 10:32:27 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso43257325e9.1
 for <ltp@lists.linux.it>; Mon, 04 May 2026 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777883547; x=1778488347; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2XgwwfFDg+TvQbzpZV9CSE6gQUNf54deQPeHUxCiOTc=;
 b=bJooVi7hIyXMQqtPC9HXWuLuivK1TiyrTIs/ENlHALRgZi0An73RJBj7hYamNcnF54
 QlqNEtzGc8umAbmOVBEPqlw1jRZSSw4DnB0Np6jIo5eZNrOePW3huJUCnAPSP00HueGJ
 nFBKHNKuHlAwwx9UY1OQxUVT/AFCZAKXopRaVNR4eOzrKtvurixJFYUJ7GAQmZaCSlnR
 u6HpwIxELWTg2ndg3rqY50Zek+HFFmtea9/IxNtuIHSXD4Ll2t7jH3LAGj0kP5C/d03X
 MLkug5FwvHGrwZD5wcBZ1I3kHEqY52Xu6fT5xAzFabJIOHeFeV1fR4dsWJM+rmeZzCJQ
 +CXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777883547; x=1778488347;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2XgwwfFDg+TvQbzpZV9CSE6gQUNf54deQPeHUxCiOTc=;
 b=EPqKcMztzGgUxQIdSCTA5nEG7T9StBMdGquE5NMYNPBIClii1IJG70vP2b+nC0nDQm
 R8T6kusXYUrSiewONa0+RJBR4lfVCu2S5KTgPkwRIcsk5Ju3LVK4bg7CQvf/dKcqlM2C
 jIl6segqCrIPD+TbdzwYHNeyGWbyufn7tb/+FNOUi2bbefhKe8o1pQbYh4HOL1FCg9Go
 fEZT11gBGkkSp3jpRG4JaSyWV/0iHMQlmEhEVov7A2E6IpWoQT5KcTkMNkXuWeBod7Qz
 BDWaG5y5GRHEMqUmWUPrUosf8xR9g+ysVihSFNCCSKS6ttdh9CnvRq0YgUVGY6kY2BYl
 e1tg==
X-Gm-Message-State: AOJu0Yz+VxQ4hCpW+G32YzrVzFVSShYFOfLzJOrUegTkvHXCT92omP5o
 7hI5SbZHLJqcWM97YWKcbX5OPc0JOkklPEECmJGNREUEfXh5idRbdHPHJBnzs1FDN60=
X-Gm-Gg: AeBDies0PILRM7S6k9h5GOtCtN+GNvPhAQydi15/gsnH1+/oJUrAoA0JbctTV8ZE1hf
 CAXf0xC4aqiT4R6L1VXgpTEmwLychhrqwyBhn8R3bEW24JN9jRTo5eWegNXzPVdk1jBo3JMvroS
 P55cxgDxVIJV4OuW++f1ZLJ6cG/jGv0jMwjahXWjEyW1kHQ+nnDPxRcji6V35QaVBZzU3oRMY3h
 LBsfaD4u9/ErRz6f254FMBtO5PTI8C1uqWBZVk3m4BucUmxsvA24KtF/ZaXZsF261vx5UxxMsuO
 8o+qqVbx+auDLQPb0nk39rOJ0NGCqNYiG5fpMjKSfq3N6L/EzssY7lEkHz3IvrcbhGIOn6l4RAm
 0H7z6PSUH5ZLkRamrNQE3KeJ3aI4R4UntUrhiv+IeygSQOgwxV7zIvYrtsoF/PAqiJ6ShJYWbzX
 TEYfCTgFPa5EOyfRF7n6VqtD016ITcddb7r2DJn+YpArQxYiZ89bMRppaYuboWRFCAzgKL2Ft3W
 GoOh/cjqOK+FP4MGdazV8/HW1Xqa1HwooTld5XWAMEyg26bR6HTX5pi5XNHai28M/BxjqBSIqSk
 faT60Elg5jPL
X-Received: by 2002:a05:600c:8b11:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-48a970eafbemr128468645e9.9.1777883546635; 
 Mon, 04 May 2026 01:32:26 -0700 (PDT)
Received: from p200300ef2f4fc9000331e7693cdd8d05.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fee91b0sm102868595e9.4.2026.05.04.01.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 01:32:25 -0700 (PDT)
Message-ID: <69f85999.050a0220.f907a.1624@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <afNbfCcv83zeMsgZ@yuki.lan>
Date: Mon, 04 May 2026 08:32:25 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

Hi Cyril,

this needs to be merges since it's causing multiple issues:

https://patchwork.ozlabs.org/project/ltp/patch/20260429-fix_clock_settime_helper-v3-1-2608c39d8499@suse.com/

Best regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
