Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BBDC5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 11:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786361344; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=OAAEHVEfBnuYVTvsP0fEFwSX9T/baO65Ncx+0aGrrg+1xYXqRXgvDVgtESUtdpKdIw1PU
 Nh0b8L8CqSMm96MoWOyG8FqxCqoDxJpj2nS4vptRCBLUzB1R2zVxyqJpIe0vD/OWITFkrRN
 dzWrCF2xkvmL8q/SkRe82/3SCiTMNFU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45D0C3CEE34
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 13:29:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26B173CC251
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 13:28:42 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B79F560012D
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 13:28:41 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so16364525e9.3
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786361321; x=1786966121; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=d+5MkSe4HNBbsFK78OA0UPPGbW5Jfp7BDoV8PsLb6svCJT3XYvwKo/s3oy4sQ2DRPR
 GQjthTPeZEBhpjBqG1xmMLVig0u3M+pGRAE/mpNUnBfbwRzsChASsed2IATPIWRbDPeb
 Rad0uCDHSStyRjgJB5EO2f7WT4I9/uFg//g8fcfpY62wNdW+nbHfLyz3Ihf/cevz2rWp
 130Gkd91qc+MT/v6NIVPtTjabjeoNNk8eTZ0LPqcE0glIFM1yPwfFAo9OqZbkF0ljo5n
 LS6GrgbcA/LnqOGMjkWG0xVHeXuSWLUEIjEL7o6/LC2XFBSo9K8o8rYbzLh5C64Kb1R+
 ofhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786361321; x=1786966121;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=UOfnXHXGqIOTfjUsrRLeNvhOCdN2CRNpiVNVC4fJCi57KmVl8k34t/Oof09XnvIKEo
 wzQ+b47BbRk/YP7uhZKXjyX9+/LfPdoSvKSuvlCulBoEx1obP4gLl+rjkOkJD0BfYUeH
 cK36WgxOSWKtS1IHbOEP3RrN7JlgMLabmYTqXjWV52ttRTuWI0LsZEIjiHy/GN2Uq++T
 niZ38KUgqfVFgZeDElcHr7b9hrY0xoeKClfG5AqQmpSt/8s+6/6VNfmfjrzLTHQ4keUL
 ejrs9K2gdUZ/8no+pHglSi1oAG8heHvv+mUdlkM2eZ28TBBZR/Yu+yRn+MOAzmZXlXQP
 M9+g==
X-Gm-Message-State: AOJu0YweOls28hR4Bube06ojqK9FE8O4EHxA1MXI8HUbILkP8v4XU8H4
 12yVs5JczcSOWLB5p/EMlTz05RHeFs8KX2L49cHIsr+W1jIu12CH3osFl49BWvJMpus=
X-Gm-Gg: AR+sD11AEKHyl7iROVYUBctPvE30MseWgOqrNVqCxKtDuXSbOGKyrgJkfCMBsbfMyQh
 9f6uiQSpK4bqvoAdsNjgELmGN+DvVcqVGF+52tqCk616BlFW7JRgU/FCgUsgU0uA1lmqImoEts8
 lrU3cbHINm07wIINyIK8FvKrcDtpRNyu5+rO9n2M9NFeQu2BbOOLS99vzlmp71W7Ah98Plqo+hv
 Pn0ND6fKP84Pwn9Ub/EwT+hsd3D4sLu5DkU6szC0aapsbWi8lhM2S7l1rA6jF3/+0qukCg1GGHC
 HY3T5nPfae1P6XHKRzPPkeEZs4ppoP0Gde7VkebKIHFPWlrPuiLzZoGcGQqfY6oenDylbO0JDCu
 SbzmjkE92L+zfrhkmStF+ld1iHtwMCUuJGo58b3sdSKRIrSmkfN9mNeb22mUvz+A2Q2ew458sHQ
 fNH6+tHRTkLRVgfX8lrFUDt+Ojk5F5Zc9K6cTsMHvP0pQ9ZLDMLBSrK6ZB7QDhl2X0totoiHS7Q
 gxfheEY
X-Received: by 2002:a05:600c:354a:b0:499:726b:7375 with SMTP id
 5b1f17b1804b1-499726b73c4mr17354095e9.14.1786361321058; 
 Mon, 10 Aug 2026 04:28:41 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995bdca3ddsm231985845e9.1.2026.08.10.04.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 04:28:40 -0700 (PDT)
Message-ID: <6a79b5e8.fe7f0a4c.268f4c.f440@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260806-cve-2026-64600-v6-1-26c11513c75a@suse.com>
Date: Mon, 10 Aug 2026 11:28:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] cve: reproducer for cve-2026-64600
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
