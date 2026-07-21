Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624F1C44532
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784647357; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=M3bNl2xvRCF23ar/DugicP1TnwMODP3VmRFHnEZbSVX60woCoIJ56+xM/uNI59+UWCv1u
 oFcn33EJhy8vJA3yUK22kUuVg2FG8JGmlKcJa/Ik4BtmCu8ECA2lsTvljlnON+bqf1RuZJ5
 wq247oL5XTkdZySI53w3juBD1OEzIOw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A0313E2E48
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 17:22:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 434363C0401
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 17:22:18 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 560391A010B6
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 17:22:17 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so1681663f8f.2
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784647336; x=1785252136; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=RQVzG1Tp4ObLeJ/ThthNT9SP9ImR0kwesUiUWzKXVy59yu1y6lGMcXDQDf6CKDG3p0
 tniKg3spen2Ck+wM3xqiZZYl8Hf+6q8N1K0hIHr5dH4MwYIhjz1KCxjmoTJ2GExHkwBq
 1lObGJ5YazP8MCBaI0wnc4CsZj0/edCysCs7GkFg3/EB5vV0NLphpzkERdJ2RTWpVOFr
 PIl1Th/MJPiIa4MV4AmmI2TPBEg88iLhpzEASv50l12wzsqdjkN2LuiSOpUqeHqAUcBR
 WdPU8u9+06mIJ91Mqb7VGAdT6VziabBULgg1f73N/ZWibBGi1T0JpTCAqfrCvAihI2Vf
 ixKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647336; x=1785252136;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=HG0wY4+cNZh5TdvPixyMpZPAzpzFi5UQlcPrphfcLs9cdGms5KlbalOTwenOA+Xa77
 LL3F1jhkZlPrw0g6SmXRdKzI4y7DnLZhNnBc7UR72RadJdy1RG3Ku7kgVqlWuTIhZx4m
 sHzooncztth3EF7uiRcfpslfxCtsyG8OTwh95v8K/9C5G+eAer3L4tOpkEeo11utNrkR
 ejVBlpYauTxQXRYttgx79CKgRRrgvwJBEgDpXe3fdzXb/fwrerCnLA/Upfo5AHLLV9Wp
 6ON+ZSVW3SI37ZLT1SJk9ai27Pp2lHKpPjI74DgI4MCpWM9wvFt0phmZEolo5jvej51C
 I5og==
X-Gm-Message-State: AOJu0YyfGTFSC0yseWdhYDgs2b8teVPjujJFZE+8cl7Ai9pUhLRmrD1A
 NJRjWUi1gzWC5AqDxXEmzyam3/w1Tuj7lK/4O2Z0UT19Nz3LjXcons+IAO7behsRagA=
X-Gm-Gg: AR+sD12QRFT4VcYGhYCTv7OmV64FRf8rYcD4F/aSmWfeI41VSl6jy7Mr7c7toJ9FeGg
 ju9nItXTP1YiRkSSkHYKq+mPZff1Sc0r71/D6e9ZReglFuujJ7BVddgze1xicDuBIV4gWSGvbOR
 1CwcA13BfpI19KrCNgVFXnyqxyyRIfdD15BaE217EYJdRO5sgO+oGxW87dM9QSm2YY+N4HSLvmT
 QXaxPJV780wYgieyh9G0HQLMlilugdNIZTn7i9SybPXx+ZUR92qjl3waHNO/8auIHOvSzo6e+RQ
 QkJrLb44wf+y/TEwja1fEdg+nJrWq8Re/vkqKzGji5A5dmOZaRuVjfkHFeIaFSgVr+pKbE3YC5l
 zV/ZdZY+w+X8ZeYRebPh7SQDd4J80UbvtmV2uKDRMXNKVToIExTlueQ/F8VgwJjCbPv5MtofYi4
 Q0PXj+Ci18NaFq6tgZ9cJgMXDVGQ==
X-Received: by 2002:a05:6000:4b09:b0:47f:812d:923e with SMTP id
 ffacd0b85a97d-47f812d9337mr3989386f8f.23.1784647336443; 
 Tue, 21 Jul 2026 08:22:16 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7ea1sm41283300f8f.24.2026.07.21.08.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:22:16 -0700 (PDT)
Message-ID: <6a5f8ea8.332d3c56.1900da.e46e@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260714-checkpatch_remove_rules-v1-1-b5c561f2dc16@suse.com>
Date: Tue, 21 Jul 2026 15:22:15 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] checkpatch: relax parenthesis style checks
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
