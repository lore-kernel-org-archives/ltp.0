Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707B1C79F89
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 11:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788781466; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=GWfyl3CcfFmIMplCjchiCGvYkBIbYQTv7mBvlw/+SwE=;
 b=BmkfF9I5yFq1IUKKJC6ltggweFSCIPTfVUgUauckkDAfDA7TKSPLmqKOg/yVtraqAUeCV
 Bthx1mB1GxkZGpK7s2pQLKV0yx1XwP+36Ac7AlnR3Gu+yGQmM1LbLDSf5BM8rgLQDccGHEQ
 MWABf0ZcbxoiDOCk3HHvdnOVc4jMJSM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87D983E8612
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 13:44:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C09DC3E5802
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 13:44:07 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 11422600824
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 13:44:07 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so3910568f8f.1
 for <ltp@lists.linux.it>; Mon, 07 Sep 2026 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788781446; x=1789386246; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S7n2AL3n1WgN2fvfxCXQ42Pl9tl3ernBYi9ThGYmsl4=;
 b=NzpHXBOqR0tyhS3dzSfMTVUQCk/M5gTHAYLFXkV5TN279vE+yjHOXyHmDoH/DOs5d7
 6C1IBdsFri8rVj7+x4NiFAs3dDbIXWyVmSKGoiOdU5ZCr9nekl0VpsUdxlImLrWM9r1s
 pI/NWn5jUvp/jlEsjfnj4EVmrdFI5oWz34YPOGKifS87wnN7HFQWpPHadVNgO/2yHNhC
 dZG1e9AYbZ90W0wGeXfdoXhvj+zEP6h7jUI8CMYj4jSqbzi3Kg+KXzdMjD7zUwFj6aqf
 NN0+Ra3Sgl0m4bRHX3ibpyvAJn/Lug1ubfD1CtwkqXqy6rVmjWwPDY21lUjQVlHGLThG
 mLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781446; x=1789386246;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S7n2AL3n1WgN2fvfxCXQ42Pl9tl3ernBYi9ThGYmsl4=;
 b=Iyuh/baGvKMJK3CpoLNxx1joxumQlzT5owG4WNBETgIUNwn0N65Yhf8F1SC2VCV2kI
 92VECBG24HcD1nfKHbSjQcJQ+QOyvzYdI/4hp6Oh4pi1xv95hB5ev2JuX3iXjVEE+HYh
 D+lhEbAFub+0Arq/1NcoV7+FDPenESfQjI18KPUx2XofGaNnGk/QRo4nCX3EfPdsYJMO
 d6RAaxXuY4q86+TMFt2+kwKjMV82ghY1n2dMK7alT2jLpTSw8fw++i5WtwGKWY/TfgJr
 Ll8A5BHEKg12Yblp2rd0+1QfBIgymYggLuPc1HjrKllyc0Zrgcl+vJ5oSnkYtgYcf6+P
 nyBA==
X-Gm-Message-State: AFuF++mSfmByekVIWzOjJ68jS9CTNn+Eg8qnwaq/HWNoVt7OaoIsX5nN
 RnZ91QwCYl5BpBB5m2vHkFn+1/YA6HQi7W3NJ1X0OSZCgMUUxFop0qYbrCohMMeFNvY=
X-Gm-Gg: AYBFou3l/k8qrHwmykXpN0tzb+rhTei7pXIFBShi70HbPWlcVTPUZyIpFfMyeTmXpN9
 0EDmXYS90SZyu614oSRmZvOSqD83rgDVCK6y0oyXbyRxHtTmYU9kBzlSdnbX+NvRCWspmyeYwgt
 k7YB1Yt6chZBAJqPaOS0IzQgvhV+1GefF1IDqj0HEAdvudLWcTvEvvtPlWI4OhmVcp2758IeX3m
 z8D5+29pVHJPbwgbNsYTidkrDbAJNIw+e/gjx8NCSFrt3Mhz6ypjpQnjDQkuI59V/FjasGPCtsL
 hIFt56Yuoceh0SWBt9DQfcnAmodVIenI+40ZymvklTLHHaNHzMjCoXHqQbErv0Xmrjnk0OQeP4P
 4fOneLG8gFGpfbm95a4prVNUfhTQ3mQNXxffYyljJWQR0whJ83xJvAQK0y5NjFFPtclkBjXlKJl
 ERZlI6jzWCXR0JIkA0A0SeTTlhZiaKWWGrm1bxTaaf8vx10AD5lc0pPUb0GEdWG4Oruy0V2iJdl
 PGrWNw3fmFJ6fv3rv8zWzpFTpWPt37znBad
X-Received: by 2002:a05:6000:4555:b0:484:36e6:d3f5 with SMTP id
 ffacd0b85a97d-485870919a6mr20801243f8f.20.1788781446313; 
 Mon, 07 Sep 2026 04:44:06 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883953cfsm23330178f8f.13.2026.09.07.04.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:44:05 -0700 (PDT)
Message-ID: <6a9ea385.cbade83c.ce0f4.856d@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ap6fQ11ieRK5FCjk@yuki.lan>
Date: Mon, 07 Sep 2026 11:44:04 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> We are supposed to produce another release at the end of the September,
> so as usuall please report which patches should be considered before the
> release.
> 
> As for me I would like to merge the sysfs testsuite, it has been
> reviewed and it's ready to be merged (with a few minor adjustments).

+1 feel free to merge. The earlier we do it, the higher is the chance we
will find bugs in automation (if any).

Personally I have quite a few patches I would like to merge before the
release.

coredump:
https://patchwork.kernel.org/project/ltp/list/?series=1157883

ghostlock reproducer:
https://patchwork.kernel.org/project/ltp/list/?series=1157677

swapon coverage:
https://patchwork.kernel.org/project/ltp/list/?series=1157115

MAP_32BIT coverage:
https://patchwork.kernel.org/project/ltp/list/?series=1153340

minimal kernel support:
https://patchwork.kernel.org/project/ltp/list/?series=1157773

There are also the keyctl coverage and the new new fchroot() testing
suite, but they are quite big. Up to you if you want to review 45
patches :-)

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
