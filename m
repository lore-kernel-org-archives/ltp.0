Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0B0D44160
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765534855; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=1ymXR9tPWF2uyy0njGDP71EaDxG4l7/ErpKOP3Tm1a4=;
 b=AppmenATBjVkfD4sh0EVZXiEoBLNLEbY1y2T77XO7nTQL3zEK+nbuP4ZQyatin+eppmZ8
 Wn5m4VYYjysSxmF0DOiWEShCjpNsuLPn0Sp9mWLdXz/k8D9eHl+CydShx9WkwviaQJuMiww
 D96JmfbkfZFsylq6b/MwmEnaDahkvFs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD0C03C829D
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 11:20:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8F053C5373
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 11:20:31 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3A4951000D5C
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 11:20:31 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so7952095e9.3
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 02:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765534830; x=1766139630; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUEtPRCeErGpLgYDTSpV9NoGpzn0URRZgMyTOdkV9+Q=;
 b=LwKE0KjeTk2nw253vWmlFCgtRegQWq/qJIH4OgyYtvRt/iq9GLWgXCAO4AvPXunlyk
 ZBvGv75g1ZLnmI2hkTEdSeGCaEtYmSNDt3MHdKup8vzmfXwItqNKXRi3kn15SSDZkUwl
 Ved6sYDmw0gWwtj0amVck9fvBf6WeFljOjpE7JGEfONFSm5UfTV3R7Ti7utnOVheCmwZ
 EBsVoAeN3GvG6oOXDsj3Gx7rbrMHAnIGr90nfDG1DkZQ0SgHtDfKRX4InXqZNSvAPwMc
 RJ0MnmWY0m+k2b9ku5v99NiQcuCaXJ9tPXuLTVk5ImdH3Ze7uNcE4vPF0LlLPWXY9c02
 ouig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765534830; x=1766139630;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pUEtPRCeErGpLgYDTSpV9NoGpzn0URRZgMyTOdkV9+Q=;
 b=PVNe4QItUPn2GzuIBtZQPYaGsz9spfUFgzRYaYvof4ptRCG1b/puWp2+NBHv+PBbJc
 IcgEDne2j1n7Y1GvEm7Vp9XF1CBFbzXy4HRPQUarjur+wpzfFNzsapkmRkoX8bO2zmsP
 4UGfswEt6HENBl6KNRyd2eNZPyCQsT1bATvErFEbSMScnUI1l/2eOhY4L2FFNeqOLHfO
 qJ5LkTnt8Gv4BAl0pEQ7FG1bYdhUX529SJt8O3D7H24F7H0DjdTQfsCJKBs9W/UaYwUx
 rtkG/UAyGRSRnVgHyBJpHSWZ1Wd707Y53V/pnThs/6x7Xzfz4OVXfmHNW9u5d0zoZa/m
 d+zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsTlzBWow+5I7lehOmi+chQWnQ1IBwIpnlqbpErtuShwqH6Vxks23F7E0uLSskaoFjCl8=@lists.linux.it
X-Gm-Message-State: AOJu0YxU6kXJT59OESB2QwVdMT3jtwr/HUJYor+BAwDUH6u1Q8l0oOZ1
 kPsj3Jvi3oFh2+QioY3iGgmasBEJxzK0FAoJaW5YVY3SZNSFdTGmbqnN1hMoQu2JSqw=
X-Gm-Gg: AY/fxX53db4fiCbyOytIbKbAu8Ce3gZp0GkWFHIR1aR15SXqdoSoPvqnIQeIeSE+WU9
 /8A3wT+AfMWaF/MZ1HV2vLuRdyjIOWogyQFnkfFqYKD0vEqz6XoHLfW1szE+7d5+J3WSzSTGyrl
 KMDaOUyb1fDUVO8yE1sPT05uSFJGHKvzqAykETJR2wBpm5d+sBrBZJSzXN/wdejH18y5qbESugP
 3KsLbM2s7FIpCT9y/OkGKhDjiTuI+uhIqSS2EKfIpOmAw+uZaILJfLWvaaytk/EOx9P/BBI2etc
 w2RLSnAebK28B7hzMM1DQDBfQ1qHZdT5KwQ+MWtrDcBf1evw2M8tb7c6FAchgkpp5KOnytxi+qi
 d0W2Zhn77kfnKOrBpNDNnPinA9X+wriroHphx2i+0jTw5CNb+rEwN0hFEMwsiUozxTHX742QWpW
 aml2jImONUFh/3/Y76igc=
X-Google-Smtp-Source: AGHT+IHIxnZzAtTwJzFypcRjRviGqyNKVu/3qD3Q2pE315c0+F2jVbJGuODC0meTbbLXxeINk5mbtA==
X-Received: by 2002:a05:600c:1986:b0:471:1716:11c4 with SMTP id
 5b1f17b1804b1-47a8f917549mr11653135e9.34.1765534826037; 
 Fri, 12 Dec 2025 02:20:26 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f7676ffsm24305145e9.4.2025.12.12.02.20.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 02:20:25 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 12 Dec 2025 11:20:25 +0100
Message-Id: <DEW5V1ML52WA.205SQ15DUQQDF@suse.com>
To: "Terry Tritton" <terry.tritton@linaro.org>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251209211629.95436-1-terry.tritton@linaro.org>
In-Reply-To: <20251209211629.95436-1-terry.tritton@linaro.org>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd02-06: Add CONFIG_USER_NS and
 CONFIG_PID_NS to needs_kconfigs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Obviously correct, thanks.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
