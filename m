Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAB6C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784014672; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=gNCqiHYXRkWVz/nT+ek1UTTR9qZSB+lLwY5Sy4hEmkyomaYbZktDhJm+yAnz7M9wixCWO
 EDVk0YdSrLLlLcpX8SlQGlGxzMRDJFSG4vmXljE1d+jfZn5SPGhdMWiBrR3TcdIlhhGRFpb
 xhRYRJys0sz62cUMPPVIyjh1SCm2K8o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2398C3E2603
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 09:37:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3EFF3E010C
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 09:37:31 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6951F6003BD
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 09:37:31 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so29331055e9.1
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 00:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784014651; x=1784619451; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=JnpYlxBgnxiCgmk/AA5tjUIMoEaFixdhSJzQ9vgL6fhYhYmG8XCRg4+5IGA/uS1tYJ
 MaFfKmxuxHOUoh25RHBUUGNzO+ZfpTxaH7xX4FJDdDHpkWRDc7rx2KCCajcDw6B0GCGo
 3fq2MYcBc7aUsh2EFCK+dmAUH00ounAUTncLldDRDSbrqGRxORO98YLNq3uDo3p9tNga
 38wX+erpqc2ePJhEXK9+gqtm7DdkQl4AsV9FPz4L6ugtuH0u810sRgXieVCrpHMXByA2
 HHcp1SoP01o/OUKS/YTVfn93eU8zo5YKHeEVxr1uxBdYsTOs/qgWkF9R3xlELBDxmsXF
 y2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784014651; x=1784619451;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=L7r4D+dpSERZS0DjvLXJTJDC2xvSvwtE3kh8B+7ANfqJANNcH6aj9M/rI62Jk6b2e7
 Ye8W4bXLOv5Sy3PBAyqx4cW6KS+Q4mQIkEQzkowuCANDzSDD5OO9gT0b+hpFDy41VKCz
 AaT9yygoUNGC+pHpoB8vnfc3CD2MclbXkr3Qs+ftM95joJBJXBnXrU/72VSUgx/pfZtZ
 E0q8V8vjpa1KHSKVszYAJCEfgqjHIinT7Ql2HbKeI6ufLdHu8+/o+9vw5zYPhsQB6QXs
 RqjCDALoEHSo4WwHZIzAYsSgIFFaSjLX9fP+eDfLQ2DgOvsF52UJcIc2NLqxlX40DuVL
 36lA==
X-Gm-Message-State: AOJu0Yy1wGl4DpbChit/xaa7iXhObzz/5e6DFpEtm1n88U0XDCfDPCuu
 43WWqtssAUkCktXNvL/uqPfzTIzDV1KMfVXQmBOP3/oyJAbm2qQIDK4I4vs8SZtv83w=
X-Gm-Gg: AfdE7cl6dayk2TYSafGYGSVYJVjBC84Km+zz5gNW3PU1FSyeGCafJB3r8ExpQIS8ZoM
 xKYRB0lKINNeK75ST+HiZ+FrAlorDHvInO0c0KKaIJA/WkJhFUsWIzT4NJUd1gVy8Ql7fYqKumk
 njeUCJqRSdb0hlMwA1g4yfbvaRUtlUm3z1l8A2569YIdQ55uVJgcgjEsnFW7cha3cf84eujtf44
 Un4D/RvhUIrv2U27kZnJT9Mb3RrIEV2p3DDPbgjvCgnETq2TZOYdaNtx2SHgV4rHB7Jq8YQLWG7
 cmlNMgL/lQuVtPJHUGkkl2GiVXEnrelF4Ux86hefHpO9Fa8t61j1JAyCaYXMoOALtyi0u928vbz
 jV6DrbBxfDhQHdC51f3OXx8Ck/tL6jlK5imNVus0vwYqzblksW5DgL0upq1xX7NsrLtbCYwfQAr
 j81qM1weMLtUTnojmcxj0mqLg2LFB/3SEx6tK6
X-Received: by 2002:a05:600c:3143:b0:492:5e22:ef18 with SMTP id
 5b1f17b1804b1-493f87ebbbemr128115855e9.9.1784014650689; 
 Tue, 14 Jul 2026 00:37:30 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635aa34sm5715546f8f.15.2026.07.14.00.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 00:37:30 -0700 (PDT)
Message-ID: <6a55e73a.e3bf8d97.b22d2.ba59@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260706-fix_make_check_landlock-v2-1-4949150d17e4@suse.com>
Date: Tue, 14 Jul 2026 07:37:29 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] landlock: fix make check warnings/errors
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
