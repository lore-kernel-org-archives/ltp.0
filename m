Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC44CAC5B8
	for <ltp@archiver.kernel.org>; Mon,  6 Oct 2025 11:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1759750834; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Ith1d1gtB7MToeSQWZr1sa/chNISY4ZwjFs/7NzEvDg=;
 b=VEhySybkeVLrNzFWJsUcIfrEGeKGdw4gf9IFK43TJPSbtIhnETdGCbPDP6wJt6ZtHTf1C
 KY+1jgG9MLxtx5qg9SMgTXKlGXLX2Eu1F7oR8zrhpt4aRBWAjybc+qR6QgXPVWadw0fnX2A
 leYEK6Qua/h/sgA46zbmuoRDn2NJb/Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8197D3CE1E4
	for <ltp@archiver.kernel.org>; Mon,  6 Oct 2025 13:40:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6ACA43CDEFB
 for <ltp@lists.linux.it>; Mon,  6 Oct 2025 13:40:14 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DD47E60049B
 for <ltp@lists.linux.it>; Mon,  6 Oct 2025 13:40:13 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso3142111f8f.3
 for <ltp@lists.linux.it>; Mon, 06 Oct 2025 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1759750813; x=1760355613; darn=lists.linux.it;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R49g8QY1xucroMMOEO6d4D1yGD2g8xwBSsVF05J/x5w=;
 b=QbskFSysfEDGi4NXPlR/yyO1elxP6JFDWsJb5CdUflup2tjXgxATza1Gt9lOz6u/rJ
 J8l+lrW/xcBMXs7jQAETXM8kinMTWra+7EIgLzsaA2EoE0/CsA+LP5SknW83fKkXSnNp
 7+uUi9FEEUplx0pGU60amTCnN6XZDbR+T1XtwUd7xdAkyW7yT+e1JJ4x0zlwB52GTmCV
 Ys44zlPF2jqTmCliJRkIMDhgTNgGpB2ghjgunQXSYUtVX52burX/CxH2kRpOApNLNrpg
 HBvNAVjeC5JP+hK7REBfarDNa56QQaCtU6OOWwQ86/xgszab0+JdC7QTBrA0WtRCBzzp
 62Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759750813; x=1760355613;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R49g8QY1xucroMMOEO6d4D1yGD2g8xwBSsVF05J/x5w=;
 b=CmpBiH572MsdAnDGdanEb/e9AhwSNBKuakwNysyKsJ4oLJqMS18MwARlWTvfouqhQA
 pt5Lgk9Y0epMVvm5RfkxvnD6TvjfLdTaWme/+iZgejwi98qg7AQax6dktQGzJIES1fMT
 F6hvfoIWl0fttH7AukIXEHGxe2BercKH8uQkQQMUfZSqjX+6h0ZTIVf7MihM5tCBMPVL
 XK9P1szm/Dkr4Ss2ifto9gTE+9vL5QSWz8I7J9x8aEtinuCM01dwIRhZ/m04WdTyfcCV
 imVFV5n091oCYrVEIXKcK2Qg6bpTArxBonx3cpp6+q1vlhya77xAiJiEhj+gpkv9iiCG
 8Rmw==
X-Gm-Message-State: AOJu0YxLmWZmAt0n292UBLz6LZgZMCu++jaV59r8EizeNfIR9zm4QrHh
 jn6eZud3krgTwBLW+v4dyZDdIwtl0prDXI9lLrswRQ/UIEDYwXFejroOEnK26YYpWJA=
X-Gm-Gg: ASbGncuLpztQPyTihU2FWVc3XDSqmnFgu0sUAdVEQpCs1Ut/F/V5q+EO9Im39zHICka
 z08Eue2izsPgkYNdeAgKR9LwUvaP24hUuk5YIULtSgddZUFfXHDpAGsmwwEwdDb5U9dWWsk/YPp
 9gjYT9RknmA20JRdFtgLZaiG/LzZ2XWFRThMv2ItHICmSIgrRl6YfddYWo8C0bUOA+FrOHSWtFG
 IAhF1vIKRfQwLpayBu4h24v38gvcq4i1vyq8sSmSYcNK/AUi6iqUZvdNzskx3H6G5CqTul6KqJO
 5pfKh1+l6ovosdIjd/A8piqa13uAJmoGMuJqwpxuKY4AbXXEcEuJFEoamc/Gk+zqk+yGMQVP+tq
 she90DInvzTF7+8mMgwk/ZKZ71Dq/lX6SfOOKLUtysidOI9aROfVVqKkWgdubM4DnZfM=
X-Google-Smtp-Source: AGHT+IGUdcRuthm63D6/0iEkuYfLsSiFORtk/oTjNlASzFIuO8XZqZZ89Ep3hHIl0WerkJOQsS0n9g==
X-Received: by 2002:a05:6000:2407:b0:3e4:5717:368e with SMTP id
 ffacd0b85a97d-4256712a5d1mr7683492f8f.2.1759750813202; 
 Mon, 06 Oct 2025 04:40:13 -0700 (PDT)
Received: from localhost ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bdf533b8sm122938096d6.50.2025.10.06.04.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 04:40:12 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 06 Oct 2025 13:40:09 +0200
Message-Id: <DDB7LLBEXIQM.2KSWEVEFU0TVS@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.com>
X-Mailer: aerc 0.21.0
References: <20251002083701.315334-1-pvorel@suse.cz>
 <20251002083701.315334-3-pvorel@suse.cz>
 <DDB27F9FQ4B3.11FGF9PVV0DAE@suse.com> <20251006112136.GA82874@pevik>
In-Reply-To: <20251006112136.GA82874@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] ima_conditionals.sh: Split test by request
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> verify_measurement() writes into /sys/kernel/security/ima/policy which on
> kernels without CONFIG_IMA_WRITE_POLICY requires SUT reboot. Because LTP does
> not support any reboot, this needs to be handled after test finishes. That's why
> I separated the tests. This helps to cover more than the first test case out of
> four.

Now I see, this is clearly a corner case given by LTP limitations. I
think we should probably start to think about reboot flag then. Once the
PR for the new SUT will be implemented in kirk, it's time to work on
this.

-- 
Andrea Cervesato
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
