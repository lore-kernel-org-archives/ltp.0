Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C89CF65DE
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 11:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769425830; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9cQZV8ohzE66tPjV6BiLvkaH10fxRtazGwMKMz582cY=;
 b=kCI2pl9xCYFO7/JSsA8rCbYq6qmNZnfdRobwdA22dXvQQfw+7VIkSGv9FtGomHBpOebXK
 Z6BIZQHbh78GtLXRt98q4CO8LaHPmEURUMuSNfqHlIvBXyaKeGtQekFmzLp5Eqpo4wVVUd6
 bIGyGtOQSYm80oXuW8Czs7Oe4uVc2Yw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 615873C2E7C
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 12:10:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8290B3C01A4
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 12:10:05 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0136A600856
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 12:10:04 +0100 (CET)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8715a4d9fdso537310466b.0
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 03:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1769425804; x=1770030604; darn=lists.linux.it;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRm+MTWlpNycU2HYBWQYYB+RsCT33snembNC+n9ZFNU=;
 b=WApFDCw+WmGiX/IfJxSm92pFlQoOdftTb4RNegbrIvDjH5sPkKZ6YnzlENFqG8qOgO
 gmUFBAFjGwOFzrdpGmGe7l3ZOgh0G64ezi+ED+l4YQEoPZI1PBYYFZlH9RnIQAqdclkk
 qBNjTsEcKsdjcx4DzAaF4/ZXvmiVTdqdDLY7S7GOMqFvUiNXthCKpqM0pMutwpOXaveA
 ptxeH+2pENouzlU4qpriFBjvbO6vLcxR/2QmKCftELKgPyTfjWpzeKVTHGqEiZnrgj9l
 CIPWzfxSvLe6JhtNNrdtHpKvXUSRE/Y9RfHbrTragUMzlqibh8DKVlDRczO+vPMGHyaD
 pQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769425804; x=1770030604;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eRm+MTWlpNycU2HYBWQYYB+RsCT33snembNC+n9ZFNU=;
 b=rddOUsMPsTrcPeRqhp896EOAhu9vt7fryMJK0tkFO1duiWUBiqRpNzpkTxnPTL5W9V
 Tw402kBbP+mVyM18zhEtaQh2eiimk8mIZp9Bd81jOvRNYc9A1VQpsAnYBe6Lbpx6PqKT
 0wBtn2pnNd1AADK0qU8XuoTbcZKKR1ZaBqvFrcvCXwcOLeCZ+moVKdSuXhwnJ+Csptmn
 2iTtGZ1f4z6ObJS0aJ1xWb+ZjGk1VttfWC/ByBj81UyWnt0xBj+rS5I1RHcg070sCTiB
 2Ea/dkZl3w5J6psauQSzeR7+41MEZeEJlLeDjxvr79H2JAlT0xYZydQZoWACk9XniQYY
 SoNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMewZtEBLbjZflJbs1yPX+GTBv2RzAyIaqGgIsSSPPH3mc4xDhErizcHh79MTKgIgjf0c=@lists.linux.it
X-Gm-Message-State: AOJu0YzI5pqWjb6aJvretIZM6H8m6SHxxGcVe+hxPu/PWzM9MZc/7WkU
 yo/A9wBOAaM3LEY5ukt6IeJ8sWpiOtXkzLLz+fRA46N7R4krBXJvQwJ4D0IuTogiAus=
X-Gm-Gg: AZuq6aILi6xbKL8idVENEje069m60S0+FSJGFyD9wPyfyjRelwYrqE2e/rA+3C3v2Uq
 STTMIXkc6yvUwkd3YfsCARIt3q/GdoZb4sGupWT7N2wqEs4uwCJPQs3gopVQnpw5SgC2B+iQZIw
 XR2EZWUVoVrhhtbdm8zHBapPy8iJ7frmwd7CVG2ae4kSZZAwm+BG4IYqaAPUvIGYzv2fKH4IH/X
 NOPySt0Vt5xu9XFMG1lzGkp6OmmlsNFwWL9JDGcTTNZJcnzaYTAcW+CNK6ZnLfs4BxShoA360EX
 KpH6ALkxV2bCwa5vQrnnAAjpdjDpzn1asMhNjo8fpo2R6yY6DjSrCr73cspRgZ1M/mV8mhHkuv1
 YKhSmR2mab2wU063eO+VP3aREmtBuKtfH5/zDyFaonKsJWinUkPhe/GhXCEnknDbjkL4YjqOhQ/
 2NYlgqKPMFoM6d7BA1uCrpLzv/6A6obx+5bYxy0hl5eNThmUlPIIxZkIK1CfEeWBLrn5s4QLDGl
 dkd7Ts=
X-Received: by 2002:a17:907:3f18:b0:b88:7431:3942 with SMTP id
 a640c23a62f3a-b8d2e71276dmr317282766b.33.1769425804312; 
 Mon, 26 Jan 2026 03:10:04 -0800 (PST)
Received: from localhost
 (p200300ef2f1649001c626999955e52c8.dip0.t-ipconnect.de.
 [2003:ef:2f16:4900:1c62:6999:955e:52c8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b6fc4c5sm627695466b.40.2026.01.26.03.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 03:10:03 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 26 Jan 2026 12:10:02 +0100
Message-Id: <DFYH3K2R65UI.21K7LYNOY4KR8@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20260123-fix_dio_sparse_slow-v1-1-65bd0dc0d52f@suse.com>
 <20260123175629.GA358728@pevik> <DFYDWAQTUSSA.PXU6P9MZPDRW@suse.com>
 <20260126100721.GA56703@pevik>
In-Reply-To: <20260126100721.GA56703@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] io: fix really slow dio_sparse on certain systems
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon Jan 26, 2026 at 11:07 AM CET, Petr Vorel wrote:
> > Hi!
>
>
> > > LGTM. IMHO good for a release.
>
>
> > Should I merge it with your review tag? I also noticed that I forgot to
> > update the default value in the test options. I send v2, then we should
> > merge it if possible because this issue causes test to complete in 4
> > hours on certain systems.
>
> +1. Please Cc me, I'll add my RBT in v2.
>
> Kind regards,
> Petr


Sorry that was sent already without CC, you can find it in the ML.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
