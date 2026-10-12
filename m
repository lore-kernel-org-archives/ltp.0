Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FB3CA9ED0
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 16:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791821502; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=Yh/N7mu7FxETR0Ivv9eHz/QMtzSl/fk5q3mAVOwsdTz/69zQGyX83ZRzB0bAh5QikcEyP
 VsCHjgT536zbm2CJcMjpybucDKMkKZiY4f/YIqPQ/r6yf+8qBlSa9K+ot3gaMSlWWMxCD2T
 ruzJZ4bSRGLkzgDCq1pISEyfXSI4Ryw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B46EB3EB131
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 18:11:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 502FA3E5830
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 18:11:24 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E1CFB200938
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 18:11:23 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48c411d6615so1433238f8f.3
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791821483; x=1792426283; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=eeD2p4eVIPUpXv7XcoUq94ZPXU72Beg2BoKUNoXeD35+wQN3x28k6lghtIrXlVMRI8
 kkwiWLuCu8+IkrP+AteTbXDERIvjuFul+ii2ng4nwASdHzsLJUD18P1VyHyRqfMEypkB
 zm6X5jZRCnb4CuKPaaDJkDLxiJfLrZlfCT8+YOgwU4K5MGCKvE2N7tElXBeUTrHLveOQ
 bmXrmGKLMwUysNOjP4HMR1wQjOMx2fi8k/508JpHXDdDZioSA+pj+o4cwWlgN9KJIg5N
 e2IwM4HKY7TxQAcFfArjTItGyMHXOVcwEGFGwPjjU39tjNFEPEQaKIe9yuqJErL499jp
 Jvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791821483; x=1792426283;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=VcoVMP904OerVLJzTsp7kcR/eiKo3/Yt6gg5ahPgMzX6wjH9wlLE5hh3uYtvuPAHf+
 C2c+4XnPGT02zAxn3BcAtKDDUoAFInTj8nlE/HaCn6qpnZ5zHcgsEOF0z5jY844LoRk+
 ei83SWSnHwyGde9qim0Est4n8+JCEaMjB3glrobYBIDIFGP3ePz6/yjtnY+ZAOxmpm3H
 z+v7tV2Zt8NbSkgUrPZgyhHN1GivTHEdM4eODt+9CPFF6k3aAZ/HHTlPlzIqmhawzimT
 BtPWnJYf4EbUeOOZKxjFvY3Fp4gmKMp9KtWPGo0p2kGBNz24VAua6i6e2S9kOfJs92HB
 O5tg==
X-Gm-Message-State: AFq9FYIGV2EPb/usgmgSfIEmAMTR40puTDVglR6dthaPo35Rm2y46hYK
 nAvh2ItmtF4pMIKCgaZgF/mH7Lwt1mG/gANbtoMbBBZALJc4lEuT3D/MKC5PuCvYdR93KfBxZtF
 r42AgBibmno9i
X-Gm-Gg: AYBFou1gtyYsNnKWpxltQcvfs/cvjkUbbXORv6cGwyXQOaUtrN6CN/9uIz05aN+ITXi
 ayvhHe6xBY305GE5Ogc+D9bp0xo1Y4dPRurKvraV4mdqDgmtZhMVn5au2uI/RTi7cGZtj0bq17j
 xHYmeYcSp0kIlrq5fBL5v+0bdGE4bGFh7yB9pgtoWnmpRXJv+jj+wMJSLW/r/DFWSTmQrmF2PfK
 Ker5pRC007ghuRZjPZfmju3X9e248Jfq1H8NJgf4hn0F7vqXY4BS52jyj/xpK5I+jyW3sUk5jX5
 T8LTLiXfJhv/p8N25dsLA36rIgQiC7/si7TMqUdhnC3oswABazUTLHuoEqvTF27Vskgn1YgmwfA
 ppLNLRh3MZnFvxkzdY4Aqxv+lt8WW935OEBfDqpDTmvvrcYF1wEytdZrEI/MNmnfo/0/kOs4L3n
 3ttPNgHfbY9ycW9o7J2Osj+PgMFkt1yOWSdGpL363wMFy9DBZGaAoLh+8i8sg5L5EuYs/Ww8Gtr
 Se7+fieMB5NddKkNu2j1XiMBXSp6+LH680f2AqEwgoi+IwfzQNeg03mqlF3tz2VrPFfZyvYjz26
 xg==
X-Received: by 2002:a05:6000:2dc8:b0:48b:119e:dc71 with SMTP id
 ffacd0b85a97d-48ddf7b15b0mr1380258f8f.5.1791821483149; 
 Mon, 12 Oct 2026 09:11:23 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab4edfsm280502f8f.26.2026.10.12.09.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 09:11:21 -0700 (PDT)
Message-ID: <jPSSxqoDxSJTh982FF5cJKg7IimBeARt0xVt@localhost.localdomain>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20261007-fix_leftovers-v1-0-63a1e7acd0e6@suse.com>
Date: Mon, 12 Oct 2026 16:11:20 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] Clean up various repository leftovers
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
