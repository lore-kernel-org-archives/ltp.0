Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D509C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 04:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785300766; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=cjfAhZxwW0VAGHOWfdyouXeXYIDsBFXmdduXYU4u7kc=;
 b=TNodS179nhREhDsLKQpZhYHtA05eBHwIom2Xnb3KN+pHHdTf8at2PDa/zQZ20GIF6cPTZ
 KlSWJbf5pr0a7VIuvaC7jnd3NeEPhmoUprUP146ibroZpB/ohGsBD/K1LQJVKYP4kzQ2/09
 9SaLOrg+Exm4MjgIAPNJfC8boOrnnNo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47B463E4A75
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 06:52:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01B483E13D6
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 06:52:25 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 677C51A007E4
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 06:52:24 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso3131795e9.1
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 21:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785300744; x=1785905544; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xtFwtowry6iTiOYwIcqjzkDGxVZb7LxDE2hFTRpWRjM=;
 b=fAdqJAmUPzuk5Yo737rEW996O+O1DtHIvuEffzbrqiuPPziOI1Y9gdxOmDQx1kDYkt
 4IKmmA0qV56V3CUMjr+SKAVhLy6pXNp/7CsG1wi7tQZkmvWcyAy189tRDSSJtdAHXwS7
 SvlaC33wVq4It7fot6Pp4jwcgtCciMzbgHt9facYK7DSM2hI56URe/3gpmEBfqh+8nFY
 NHaawworztvyie1QmSkJdgxEKZVu3I4xn6Y+ZBnJBTR1W1Gr5sxsusx6rJh7CWltN2+V
 FMOjh0whVe/AQBiYfdYq43nSQNJaf4bTNM8AfbQ9swT2qTaK/UWLce1ZpZALO4KhtzDD
 B2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785300744; x=1785905544;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xtFwtowry6iTiOYwIcqjzkDGxVZb7LxDE2hFTRpWRjM=;
 b=sDml5LgTQHL/XYYUVgSYlkCbPxi69lRBO/gmwnwLfo183HrTahE0oZNvEgh86oGWrF
 wzhdXMkpF/bMWSZsVk8M5C854exq4UsuVrLzFumcY3QEfySOeQs9rvGAbCdcy1Zxwat1
 o09G0Cmv7j1eWWWm450rPMtmw3s0CO1Fx0WGLCFABoY27v436svXSghxF67nab6L8jjl
 0CGEMXbgNteKYWx5P6/f9bEavg4wuUNebmd0JLv8N8fse3gIVMx2LaD9v9EH9JAabayB
 oi8PJS36v5Ea357kAKzlBFGRdODpw7DWjlSLOTqlXlNd2Im9e+AmRj6gHtp2v09OW52D
 0ZrQ==
X-Gm-Message-State: AOJu0YzuLAF7KShwikYgSOtYP6fIpK77XOiaWvgOG9kuEHYTeBOio9sh
 tYljV9BAFAd31YljZb7tdQdIut/xHlzpsEhlBVwfXOTC4XPARFhTTEz5oinfZzw5cw==
X-Gm-Gg: AR+sD12FjRdy8qYNCW0rfDMzT7bRrygYepH0BhFKJ1KZYukee7ovW/JHAUlxoVHAnqY
 vziwvb4px6g68j+HyPHX5t4E59adA1BYLqnbw7yLnLZctLc5iRzEUu5D58tJ9mPmYB1/OK0apB1
 G325nWpnijXGdP5d/vHaUSpusg/yA41WCo8ZMphkd50AhjS8wj551SKTo0dQRBt42FJXDgOs/do
 Kmn3yWK9OKTCfZoaIvucPwrK/JPRN4Nw+GX4zo8Y9jQSlJUB9BSSbKndoeXWWn/ERVnJWEVm1Cp
 StzJUArCY055DzcJOnoaUelAYdlBaqsth1j3ZvU5zrrTf8Trv3KN/1j/OOqDEa+xiqDBE2Ksvr8
 TeNt8wYLHUAJ5IqcCFwmGLE3tPkbOMsw1dqc28T2IHPqAg8Q0h0GC3qOpFfp0Mpo238hC8qYLSv
 8j6mHVfxQQfo1Xr23pIMgIIAnCbhSI3ng2wgiiqNfW9Qa89rEKtUEw1iOEx3ONG5fJNBwutCIzE
 oT57A==
X-Received: by 2002:a05:600c:b85:b0:495:6934:414c with SMTP id
 5b1f17b1804b1-496c656e6d8mr61491675e9.19.1785300743827; 
 Tue, 28 Jul 2026 21:52:23 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4976bd6e179sm31444655e9.9.2026.07.28.21.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 21:52:23 -0700 (PDT)
Date: Wed, 29 Jul 2026 04:52:22 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ammHBtLqRVJi9B26@autotest-wegao.qe.prg2.suse.org>
References: <6a68a078.dda25a5e.283880.f17c@mx.google.com>
 <6a68a9f8.16149c93.4e438.be9a@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a68a9f8.16149c93.4e438.be9a@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] min_free_kbytes: Handle transient memory drops in
 check_monitor
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Wei Gao via ltp <ltp@lists.linux.it>, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jul 28, 2026 at 01:09:11PM +0000, Andrea Cervesato wrote:
> I also forgot that maybe you can check the TST_RETRY_FUNC
> TST_RETRY_FN_EXP_BACKOFF usage. That might be suited for our usecase.
I think not suitable for our specific use case in the min_free_kbytes
since it implements exponential backoff. 

> 
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
