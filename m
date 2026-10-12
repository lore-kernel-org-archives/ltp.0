Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A5ECA9EC5
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791820119; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=0WZBkxNz/HKrZsPpKwwNDMDTOG8OKvYO8/lTJf3dpvU=;
 b=kOCH5uUOPwNQy4Q2Cf+o3wwZoUoSj5m6w7VPa2CnxNtPwCrV183BBuUY8yaaxt/NgCKBr
 uU++0M03b9ArZu9SAp1fmziJRGuKmijrhiqEOqAayn5PSwk4hLwwIKEAC1NssFQy89uLxyO
 h6Mso2G7ciOCyusbjX/d8m1+h228r+w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 639B53EB5E3
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 17:48:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD2BC3EB5EF
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 17:48:16 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2F3F41400962
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 17:48:16 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49e73611928so25707295e9.1
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791820095; x=1792424895; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SxoF8RB+li1MjGDqctY4Qo6DFR36LtQHjPZ/CV4AfZo=;
 b=eQDBBg8paGrWNeBR9dtK/OtW6ws9GZD1UhgjZ9PvbKmzfRxJEV6qm80r3BmGHfmZ+u
 coTlp9hYa3S2RQM9SXHL4GD7QpEqqBSUH/8ulfa35K6owT6im1XWU38SPLlVz1/QPlGu
 LhOxTXXv0R02m+ygPMeDKgr9is2aCKUZKNh16gpYBtLtl5OXIOWRMbRaXS6TweRhjmEB
 59aGLjUq+DSFlAw+mhTtibNMhyQCO4v6GInsIuM2zapNlwfHPnKZBz71e/gjcFjaJXGZ
 QCC6c2FIHJtVCAtFuJpIUxxQG0etPnYEpS21z9ypcDhjtFqpQYGfnx+i7ZqWzssozasw
 lAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791820095; x=1792424895;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SxoF8RB+li1MjGDqctY4Qo6DFR36LtQHjPZ/CV4AfZo=;
 b=ES14heUjAkD6nUZG20uDR39GNhXXHO+zMwsl1snPbYbK9Mr8oYoIQQ7j7x2nc4ZuAX
 O1XGcS/v+q7rlCZtUKdn+4TKlQixDLzSX1b98AkwGgWT97bDhEEBGbaLOhxdyHCkpfwF
 Hb5sCmrEHL5tOGJk8sLO+UC57gtxFDSnsHt+y4fm3lVssfM32y3TpmIb7N8hjbKKApSb
 QCVJvS871Zx2+rRlc7ztuMRGLe3NbDt3uweoi7C3cIO63GnGfFdT7vRcV2sRBHpgegzz
 7f/Blq5Jsf2xqyCKsqVjAkDX8LCmIGYno/m3IBqY3OEhwYCVC0ira0/Q6OSHJNjf4wf6
 j3ew==
X-Gm-Message-State: AFq9FYL5CfLFdCbWZGpdwZscmsXDZOpWRhQC4uJ0ieGbjx6ITGhJNN89
 XAw0gn9rL/lvwvjoqw0z2r3ph1X8cHD7yZHCW2PFLqZ0hL0SBqs8z5L6YVfTqXFZ+7AOaHwI0ih
 jjVp4wESnyaWM
X-Gm-Gg: AYBFou2XPlU+ca7XhY+0TJl9S0jtuiDGJNqZSMV79uF8F9XgdiVWgubzGJHHZf2ztZ4
 QMQSoyuZ/9IuYUIkVOqUIEdVFLKNB+mgCWM746qLs66XXbo2b/3DtxuvMB+/s/orwmq73Rk2ABy
 CjV7RqGPc0BXB7l3IK6RRzKZ0QuVF6qb2DnQZ5VKYtYjwKUosDWSqevy8CTaYmWneQmRgwlwAlV
 kpIbzTpgBIKedkZXomSwNvdkxgfIwXOsr25Hn6v2VlCCoU2JYxBLZGLUXzlDNPcoLD2DJSMTqva
 rbqzPdsGQI98MlBewcClnXmxENS8+ei2k41bGdLDSzkN8D2oZA93QCOUdJLOyLSZ87MXeusVgxc
 qmLygar+bK16jp6wrmHfTf8dv6uIkxFNrLtY0AJ9FWMbZIlJ19EY7miOYo7J020Vkh6Urz/ZT/F
 G+rX3Ps97U3MLYWUMa0A9x006sduVmoj86n5GHzcI05NHE919MuY33Gl0/kTQzBuSqUlmWS+Flf
 U61Nk0oQxcAqcABuMnBWUn1zAOfJgtU/a1ELCYofhdp31Me8UX6eBG1VjmBHm8eejqAXeb+gdBo
 N/NCZD6DZ/8z
X-Received: by 2002:a05:600c:3e0b:b0:49f:fbad:29ae with SMTP id
 5b1f17b1804b1-4a18e4b1311mr181104105e9.17.1791820095323; 
 Mon, 12 Oct 2026 08:48:15 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a195002123sm285775765e9.1.2026.10.12.08.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:48:15 -0700 (PDT)
Message-ID: <oxUvYO8wV14vdPyltlLgB09i0ZBYZcJfi9qY@localhost.localdomain>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <20261010033622.68927-2-li.wang@linux.dev>
Date: Mon, 12 Oct 2026 15:48:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] lib: add module is loaded check
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

Hi Li,

> +
> +bool tst_module_is_loaded(const char *mod_name)
> +{
> +	char line[4096];
> +	size_t mod_len = strlen(mod_name);
> +	FILE *file;
> +
> +	file = fopen("/proc/modules", "r");
> +	if (!file)
> +		return false;

why not using SAFE_FILE_LINES_SCANF() ?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
