Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3356C3ABC9
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 08:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747125153; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=wvzjxrBGPnNM9VGbQ40wBIKkReCVWNyTwhU2v5XPBP0=;
 b=R4h9pWOHyK1rklCrrns5HClFfjDuuglKwqvGmrX92mAWKnUMOXC/b8iei3dTG1gj22XpG
 4d3nKg0m0uNY5Y53u/huuH7eBxDTuq+hHRxEnbvvWtBlrvyTEVg4T3IaFUAvtQ5dZ3+782c
 bRdCfdZ5Devn7d3CCvqjHJlMQ7bK2k4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 307983CC315
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 10:32:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E57B3CB38F
 for <ltp@lists.linux.it>; Tue, 13 May 2025 10:32:11 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D0E976003BF
 for <ltp@lists.linux.it>; Tue, 13 May 2025 10:32:10 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a0bd7f4cd5so4548270f8f.0
 for <ltp@lists.linux.it>; Tue, 13 May 2025 01:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747125130; x=1747729930; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/9L9Tff3I9YhpHxfrJpJ2BOIM2q9/ExiqZWM1z4uLbQ=;
 b=HS9tNKZtLFFqCHtwSG9snHE1U1jIYHxcQLawtl9+lL3ufAHST4vARlzvmQO9nS8c+Z
 sPrQfo5fbay9M7MfC98PZrTaazLVRb2+MLM3DVjxlsQFHnR9hEmgOWbu+cjtaWlK1Nxe
 oi6ej0d/TXo5PjGqxIOEjum1tdTE9oQ4beoB1kquqIKwTtWh3TSaGz5pAFaSXFW33NSl
 GXmifrryOpBS7rRVKi7TsY8M9yaLVm65aPRMZB/b5b2o34YQTHpgpGA+eb+V8+MRJP4E
 E5AUl3hbojWdeuggym2hARQNtoh5M7O8uxfmaIW88Gqbo1qfn9H0B1iS8l0sEQr7AmoM
 zHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747125130; x=1747729930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9L9Tff3I9YhpHxfrJpJ2BOIM2q9/ExiqZWM1z4uLbQ=;
 b=pr1WEufiV1cyB2hts3EZkEP32iZm5Mn8HyGT5hAUAFcJiPT+JOftHTkhnVp1YVyDYa
 mRY0JdsHQ3+912C4/HoCMAgMQU0WAFWg4pJ5V2nRqi4xAmzOvS+m1efjNwBA0lh65IwB
 5wUiafSWYIzoD46+1akWrOiembEh9tkVzYafnayoDe7SkFeBujpygy9zp1jUIpRbdE+I
 uWRVZ2xeMDYWBkcU45F7CE76eCb2RVoOq6Lnv2Cu7MYKe8RzOotl1qiawzA/twW3ZHhk
 xtoFAowzh31iRyVWfaRyoAvJIsizulz533/gG0bsCGWEYzpXgRZS6Z7YBHyPc2hVll2d
 ZX+g==
X-Gm-Message-State: AOJu0YzooMk4FGfAXmd0sjOwopPfuy3vdP17yorTSIsg/oJEUDmDmuv/
 c0isBs15DsdY+29FEfO4I1AfOx8/h+U54Z+AfRUjJN8gL97lzTjys5KH955PcXV17Bd777/kgRW
 +cQ==
X-Gm-Gg: ASbGncss1l4ur5EiasZ/dRvvLEnIT3FjF8lYsgUxZiAmOXZU7HKmI02BA+eEpSarmuv
 949eet8X1aDk33tErkPsLbYI3HnkHZXWphWM30e0oQ9OiteOVgLGOIeipkdMkXQPAE6Lo81TWrE
 U/djn8undn+t50M8nFO+sCzXZ7CnzDehOOrQ3z/Pdv+KDzESqroEINniVNILucOztXO0Sp6HEpG
 LplmjkZP+qHjp/P+4p32LwJVzUNBfoosg1fcZfWRcMTLMaLcCA6VARlChpAN24lX7OyTVQkhp+V
 L5a1oHZUhnAUfVbHDjWmshPL6Gm7N4auEuPxCQHucpGc7bggr2FS96qkBVBtuQ==
X-Google-Smtp-Source: AGHT+IEnzdH69yAFwuLIsqQK49C9Ko+Hjl/8g1MCML3Mb73bNHj71v6jTczWHQ+100KVqVBYUk4Xkg==
X-Received: by 2002:a05:6000:2902:b0:3a0:7f9c:189a with SMTP id
 ffacd0b85a97d-3a1f638037dmr13764926f8f.0.1747125130130; 
 Tue, 13 May 2025 01:32:10 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828b491sm75465025ad.184.2025.05.13.01.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 01:32:09 -0700 (PDT)
Date: Tue, 13 May 2025 16:31:49 -0400
To: Li Wang <liwang@redhat.com>
Message-ID: <aCOsNW2hFJZOn3zH@MiWiFi-CR6608-srv>
References: <20250513050530.47541-1-liwang@redhat.com>
 <20250513050530.47541-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250513050530.47541-2-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] dirtyc0w_shmem: set child_needs_reinit
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

On Tue, May 13, 2025 at 01:05:30PM +0800, Li Wang wrote:
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
> index 64b187b35..4b31da831 100644
> --- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
> +++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
> @@ -104,6 +104,7 @@ static void cleanup(void)
>  
>  static struct tst_test test = {
>  	.needs_checkpoints = 1,
> +	.child_needs_reinit =1 ,
s/.child_needs_reinit =1 ,/.child_needs_reinit = 1,/

Do we still need this? Since .needs_checkpoints is already setted.
>  	.forks_child = 1,
>  	.needs_root = 1,
>  	.runtime = 120,
> -- 
> 2.49.0
> 
Thanks for your quick patchset :)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
