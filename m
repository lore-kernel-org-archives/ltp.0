Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C31CEFD214
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 09:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772011700; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nd2vSHerGJXeucl1FCXnL+e7KsGoWverN6YRh8R9GTo=;
 b=O6J0VPa55Uw6cGmoLWYXCFyjswg3U6KJJ7kM3rcTXtC4gsqf2kmKoXDRVRDwKx2aAuWyl
 YVKYs1lDAWkCdKSmhU3S4j47M4qKCV+rLt6xABoUlOp8Lind3W7ncjLbJvpmWFTtlwTZETR
 Ab+YgmloYZ/+laLaZcbTUAZHhKuRVSU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D24A83C6E52
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 10:28:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 440673C1AAA
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 10:27:58 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C592F200AD5
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 10:27:57 +0100 (CET)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4398e850783so412298f8f.0
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 01:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772011677; x=1772616477; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SPyvVsfQbpJpmIjTlzB6fHBGolcLGZCnfp7H6AhpILQ=;
 b=DvYbLordhVytkNFHjQWprzLjkbwVJ0oKgM8uLJw/hOP+uMpaPr5VqhNQsamjCJI//q
 glpHCCxv8/M6CnpMVzEKNW8cWYMmz+wBOAboHPJDjvLpRlpiR0o1cyQsgAvI6eWM2ZuX
 a3Ocy+q0VuZ18tnGjreDrBxGx7zwF8CZP7Afa5yNspweMTJgDnJX5rJZS2Pm7pb4BFnI
 FiG7B2zHbSBr+SPZMVKkLIAjaDUmWuu41ZNa3nUoDBXPw0kBoA52lk2bdhhiKVKwX6ZH
 +PdYnRBJFllPdbnhsQ5d1hwz7kxp4dIsrQn+f4sRWfNnOd4Id0dsLWSk+fza1uM7v0Jp
 SluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772011677; x=1772616477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPyvVsfQbpJpmIjTlzB6fHBGolcLGZCnfp7H6AhpILQ=;
 b=RNOrmPwkUn8ZOgW/I/9VysT8BM2Y8CeyuvScoQPt7pwIIh53iTcwPs24OOBBdXT8r8
 kalxm8TSLLSnmKaWOuJ37yRN6U+PQn/wIoHPUUt09tUPaZUjRWyBDQBNc+xlunrvcxld
 zWcv0RUkemJ29JlzSKFGX0uTeYj224ZZ1GmtSVdDMOG8hdf7f2SQVHnstZRqCQPOqmN9
 LiPyWpzUN1CmQFXx9uAu6bjU5NnWEXR0ZrIQd7m8gMRpFdGOEgvjwFYeC/lBqg1fLtm/
 UQuT/kmNPaDx6k/mr5YTlYtxGqk2C0svzMw9aCZfKIdVDT5HA5XVe+Ubge/1OapH6e+v
 4REQ==
X-Gm-Message-State: AOJu0Yx2/zrNuqqNR1vf7otJJRvolOtzrRq2aYQcxd5yCT6VQflA5Yaq
 k1NdzXSqCXNBJgsVa3iBv+C+x98/8ztB21ic/5YW3FWpPcbuzQ23rdODkCEtFGhAeQ==
X-Gm-Gg: ATEYQzz1KDVJ+lViwsxpSwKxH5tLfICd0Xhn9rBozv96wvfkVWQJNm90FwpdAHGJyV+
 Nn1aAAGgTsy8qWbjs8BSkglW0eHqZKkV3zJUvvrpKYPB/ltO0rsoRsKo3QVnKercKpfL4uTaFUu
 Rq59CNRgFj/e9IvGIn0OoKeq74h+wq6m3H3fsFfAgf+aHekbRQ4OW4isDgIvPti31bhYL5KbfkI
 UZH1kSJcvuA8QKKFIU06xvQWck02qlJbepcfh6uSG/S518VL43QR05qRdTMJeKP/lLQIceCQrwz
 neQ03RpSBWOejxx6g1BQdODL+si84GcvVAixrztKpdmaQVD+Z9vzNHwT4aQTmFerzLJGjgIXOey
 ri/eyYDk2HVZu6IK1T4KvRdGt9hcacYyMFaCsP1OEheDLhfJWdMYFXelkBclrBaV2gl1SrVcGMk
 Ndsxt0ZmCImhvGGi/0mPs0wxnoFxGNiDl272Z/fthG
X-Received: by 2002:a05:6000:604:b0:435:97f6:4f44 with SMTP id
 ffacd0b85a97d-4396f1a97fcmr30190506f8f.56.1772011677070; 
 Wed, 25 Feb 2026 01:27:57 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43986aa2f84sm10154800f8f.7.2026.02.25.01.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 01:27:56 -0800 (PST)
Date: Wed, 25 Feb 2026 09:27:55 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aZ7Am0YgYLK33spn@autotest-wegao.qe.prg2.suse.org>
References: <20250526143551.1321709-1-wegao@suse.com>
 <20250603214503.3792293-1-wegao@suse.com>
 <DEW4S4LXK0U5.RSZM163LCKXN@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DEW4S4LXK0U5.RSZM163LCKXN@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] fsconfig04.c: Check FSCONFIG_SET_PATH
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Dec 12, 2025 at 10:29:35AM +0100, Andrea Cervesato wrote:
> Hi!
> 
> please, re-read the previous reviews before submitting a new version,
> because there are still some issues not achieved.
> 
Thanks for take a look.
I think Cyril comments should be fixed in current version after recheck, so i move patch into
Needs Review in patchwork again.

> -- 
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
