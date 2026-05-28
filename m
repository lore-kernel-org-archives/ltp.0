Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FE8CD6E44
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 10:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779965357; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=BDq7aBIsm6fw+yxG/8z3zJ6DJsBpNUYekhGp6kW2SvZ46t4S3co4Wezmqtt94fcmg10ry
 AWLuzzeeYCitYvdaB0N0kN9XP2C0ezxoZU0+VA+wKnJfyxRvUiVPs/IQcL773qnfM50X/68
 QjZoTdDmO5+Jd0fMQ2u3YLbURO6s24M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4EAF3CE89A
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 12:49:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FB833C8CBD
 for <ltp@lists.linux.it>; Thu, 28 May 2026 12:48:55 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 27D6D140054B
 for <ltp@lists.linux.it>; Thu, 28 May 2026 12:48:55 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49041fb8c23so50094245e9.0
 for <ltp@lists.linux.it>; Thu, 28 May 2026 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779965334; x=1780570134; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=B5/Ncr2kd0E1XlVxQg26Ht8CaVQRE4t1wvCeAidEwsmlC1xwwnbmErOlzRixLGCeNy
 TusglzfLFwq1K0tK9rNfJO/Rl/BRbCUZi+lInm+R2ZET5PNGs1aG2Z7jYWk3Y3Pq9Hd6
 NS4S29wwB+hHkp21A8lidFNRVctYSpzIFSAAUwfAG4A+RIVv3ywUOhLSmu2x1ICcTgPk
 K1fFsjjBGojAkgl/+9dMMZu4YS7JGheak+/j7697GSEBG3XYLPk+5xymVE8LdOXfRqkK
 tcMX83Gk4DDArqsEV/Jj/HPR2NumjNtXgr2UEVXDMdkvnYEgct3R4gzlkl/dP+eX7Pg5
 dVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779965334; x=1780570134;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=ryCIgo09fLhUPn3cfnovwy+rHPnwpxpoy/3V/7kgxxxaMJGAVOrHe0+bcX5Eqy/NL8
 A7Z7ZVrgcm4jHHMVkE20HlEwZxw2c7wgtsPViG9PJPjLMeFzQhZ8L0zdUtGLe5FVsgqu
 ulZS6BjjBpglbWQ4hhvu+jlkWbFPNwDhDROEJOjyU9zWENS35wjzi8w7wDYphRgNAcVj
 vjsLI9A9GsKCLjWEJitFNW8FwtREfuVyBRWS2h9+uvqvbLgkKN8eSQNWk1pWhvCMi8/V
 xCFkHmzWLdI7cxfzkU62eyi5n9rsVpzbQ0qNMR57adkMqirGfZU1VmlTgaJjBNgmAbHK
 Y7Hw==
X-Gm-Message-State: AOJu0YyMJTz666d2wJDztYGjBjQq0NUZSGs7Wme22qCGRgZATVlNvIwX
 Idux+mGize/C0WFmxT5hZ1DYGb3L8TH2MH8qd5XmJ8lGb3rxYisTji5ul3+RqbIOBPw=
X-Gm-Gg: Acq92OE7AhKFskjf0Ay83dJnDPg4zAoY5VrSKkMQyLcYksxrL6/zEnSf5y8NuavkADR
 2MqJwxuxjh/ekzg2+7c5NOSuZw3op4eWAgsLzD1Zn9omZvCBgKL7VDfldL5CV3IZgZFiHihAnkb
 KJTvUSYhmGENWM3iFXnNOf4UebOS8YgykiPMSO9Ta1Ui7zEoh6f9r6jSABkuLkp81E223LAiVm2
 Gt7ox5AqVyC5JuvENTLdFr+FqjivSspAF9faV9qrQ24c7K+oefFIbPyUj9gcaJJbv1hAX1Z+HvB
 9YXk91Jn/HcM4h3roBjFXcPr2VCY3FJIqzOxL2I95Wy3GB9038MMCdhOEhG+Avm6B87tF6T67cA
 vZF1ztLdykg2k+Ce6IpSnOjlFGpcpGd5TMCRO9SUzPZUFFoLJ2/TSS8FOUs5fdAWiV4fF3XxEax
 OuZPH1VnSUi6OvYHkeS9lHJ5iS6K6obbQUehXmwL4cpKMu/8lfvTY=
X-Received: by 2002:a05:600c:a30d:b0:48e:5d91:cfe3 with SMTP id
 5b1f17b1804b1-490424ac7bcmr332869295e9.1.1779965334310; 
 Thu, 28 May 2026 03:48:54 -0700 (PDT)
Received: from localhost.localdomain ([80.255.5.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909235d43esm55291645e9.1.2026.05.28.03.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:48:53 -0700 (PDT)
Message-ID: <6a181d95.f4f4081c.50587.af15@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260528102757.398375-1-pvorel@suse.cz>
Date: Thu, 28 May 2026 10:48:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] checkpatch: Disable more kernel specific
 checks
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
