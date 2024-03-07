Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E4FC54E4A
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 23:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709853698; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xe4xkAqA4i8HA+SwVzYQWwPcCHD9ySIKgD7Vj+/cylo=;
 b=IbAAd3fKnR7rwK9mu4y6PUhvFOCmDpUfH/aQ8wztxbse1GGyTJBt4ZBIlmgQdxIVqXmIY
 QlcCK7v1EYHrbNv24OkTYBPJjB1AmtiiNNnxlWTG9heIahr6NU8cHvxl8VFVflp1gBNB/h/
 8t/JYUMotLULkWr84gKfDXVd0dHVd3Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C29D3D0BC9
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 00:21:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 401F33C3320
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 00:21:16 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3788B1A0146F
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 00:21:15 +0100 (CET)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d208be133bso2449381fa.2
 for <ltp@lists.linux.it>; Thu, 07 Mar 2024 15:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1709853674; x=1710458474; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H0fEYqCcaevbk/SRDWQxYm+qLgmqwkSDlSlDe0Q9AZs=;
 b=QikWXMkR4rGw+NDwg7A6ZFTBId8ext3pC8joDDhfQNDrv1vmLaSNX2s4tSoLRkLjP8
 yqgEp1tlYGPiKTwgeDTxedmXr22Fn/jFCtcd3dZa0tVkNyPXzBH599xmwyT9Je9Fqadh
 HdTEAWOBbyB3zeyx/R4LJvG5dvqCe1+9xScLafkjwLfH8TV1/+KeqKy/xG8/+NVdZ5rd
 Xbb7CyvrWRSX4BoFu8OFcFXclXfVignu5ihxtZQE/tN8h2HuYQx3timsoNjjgp6wvhfQ
 Lkz58XATWuw9qsJdPoQ+OnEfZtrzhUcBnNpiwg+LyfwNnOQ5Ux3JYX735+/+XdEmGoFA
 kAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709853674; x=1710458474;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0fEYqCcaevbk/SRDWQxYm+qLgmqwkSDlSlDe0Q9AZs=;
 b=tH+EzrshpPAIsaLEoXqWjj1HyXH3XiPKINGr3N3bYPhlYuVuVC+2bngi267u1Me6p/
 pIFJ1hHneKSqEBkbPQk5B705vVMkEY/6D4KUROuyyCFmWUDi6nLqFPNTfY2z1e+5h+w3
 nUxZPueip+/0SsgreUX/bUcqW6jrn/kvDjbZ4bS363hwZHAuw0Ey5cP0nMl9+AdADVsk
 lla1YQl7iQNDWdRp/mRVIC7qtV5F0Km6JCpOEz5q7ViWNhWNZ68qQ31spTI/gkn2Y/QR
 IFIYYQp09eNcfR1K26BqJOCLXq+6k6Li060QgZzn3L1BQEJOoKknoJHtMlpVFdfPJN8B
 x33g==
X-Gm-Message-State: AOJu0Yz7gNJZUkm4qFJ2RSIafeLb6I20SCdaojGrCmL1dE6rZ39+XQxs
 UQGJ3Pd93BB+eA/PXFM5D0N9pVP4ebixlpzd2jV77YtQhZu1h4plPJvLQst60XE3PjSWPd4O2xQ
 =
X-Google-Smtp-Source: AGHT+IG2e5BmEpj1nKHkknxGMgNKWeO2qAB+fKVLE5c1MLYEzlstQE7NRewdbVwVTUlWo2bI/xxo9A==
X-Received: by 2002:a05:651c:2113:b0:2d2:329f:7a7e with SMTP id
 a19-20020a05651c211300b002d2329f7a7emr2365177ljq.6.1709853674412; 
 Thu, 07 Mar 2024 15:21:14 -0800 (PST)
Received: from wegao ([223.72.60.77]) by smtp.gmail.com with ESMTPSA id
 x189-20020a6263c6000000b006e48d5eb886sm13622198pfb.115.2024.03.07.15.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 15:21:13 -0800 (PST)
Date: Thu, 7 Mar 2024 18:21:06 -0500
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZepL4jcbj6zmc0E1@wegao>
References: <20240306104609.17141-1-wegao@suse.com>
 <6285aaad-79ca-4d7c-8be0-6d846d165df2@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6285aaad-79ca-4d7c-8be0-6d846d165df2@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] chdir01.c: set umask to 0 within setup
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

On Thu, Mar 07, 2024 at 04:18:35PM +0100, Martin Doucha wrote:
> Hi,
> you're trying to fix a vfat mount quirk. We should fix that in the LTP
> library instead, e.g. by setting umask(0) and then restoring the original
> value inside safe_mount().

Thanks for your feedback.

For chdir case i just use Petr's below suggestion(Detail info you can check patch link 
in below):

"2) tests, which set .mount_device = 1 and have more restrictive umask will not
work. Workaround would be to not use it and mount manually in the setup().
Or, reset umask with umask(0)."

https://patchwork.ozlabs.org/project/ltp/patch/20240219134845.22171-1-wegao@suse.com/


BTW: for similar issues we also do fix within test file in stead of lib such as:
https://patchwork.ozlabs.org/project/ltp/patch/20240303103105.13401-1-wegao@suse.com/
https://patchwork.ozlabs.org/project/ltp/patch/20240301102347.3035546-1-liwang@redhat.com/


> -- 
> Martin Doucha   mdoucha@suse.cz
> SW Quality Engineer
> SUSE LINUX, s.r.o.
> CORSO IIa
> Krizikova 148/34
> 186 00 Prague 8
> Czech Republic
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
