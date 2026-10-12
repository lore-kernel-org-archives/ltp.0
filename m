Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4C2CA9ED1
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791821398; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Lh/SNohppZTcgjzji89CveYdMuGTKK4FDc3gFSLHPnU=;
 b=iBqIFtkIVqPPQ4eMOkv7tWoNpGKyRLDlKBbCF6hE0XyXfEGVwFei5aUeVzdFVHi5RxlnT
 EkjtGOTjv06biOXwm2Q1HKpb0w2NxDTm/sIHt2ybTh0tRzFpn38qkX94DetrthVQtIYcUWr
 8GP0zXS0pxUL4pMEOz/kpmMXwJuEsjk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4443F3EB136
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 18:09:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E95613E5830
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 18:09:37 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5DAC1600856
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 18:09:32 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a16af2a232so16817855e9.1
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791821372; x=1792426172; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H1KLF1bREGW8pS71+2JERwowUoqocYKb4GETHGV3IhU=;
 b=PGI5t4VacDYDU87WdOfafOrmYqDNdZrz2FHFtyibAzmZ9nGoOx/OcvPf5HzEIsHUGC
 CNUbTo54ZOZrq4iliI9Msh+zYVVgCLRXTZNjI0M8IhY+OjcgC5BGBvMHNi6IPTGoRtU4
 hiA9kg4asVd7equOzvPi3CSk/K2Js4TwPiQw8WQyneQidtuZEQkfaSXYnN7fY2EE2Dcv
 sztkRqPVp2TBGYW9RkdhDMFCi01CQCf9IKPaEstGBQISna8/IkB3DJVfDoRfPWcQC243
 76o5Fj1qkHUHH8A4tQwvUXilcx+7tsFjNf7FynEktwVwoxU7GwkB9JD6cHTXAeo8F9rn
 yELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791821372; x=1792426172;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=H1KLF1bREGW8pS71+2JERwowUoqocYKb4GETHGV3IhU=;
 b=MjfPv55egwoFx48/sexzqbc1ngeXwDWyOPYc+P2P8liHd8kD4pql6xLhfw6vbHOuCk
 X02PiVwr/UzcZtdFELkgKYaOPzNBY503M0urHItpUGRhxQh5f5pNGmlGiEKxL0tPGP1k
 3oExBFZBZTtpQFPCyZRe6QK7vx5rqLNXJ7zBWiMPME5jt1nmnvkdt9OJQcJJkTpXLJm6
 WTWcF7ycQVWJMJTne6POdrdLMDVTFdREZ/A1ZaepA0fxAvVYqZRv//YZubJvutwORELe
 k4WDHx74AqhCdEJm9jnim07wLf2RRzJ2tYnDQT213Bpzxt4ONqXp7cqYmRsnf69rrh2L
 vbaw==
X-Gm-Message-State: AFq9FYLlJncndxl4L/qwxfEv+BBh1xOMAXymsleg7hHkR8ErGPPleXER
 Kdkb9VH8E4Be9e49PsWiazrrdlxej6/FL9hCJMiL1VldKiEFCyHMRXkw0iiUe1kWaC0=
X-Gm-Gg: AYBFou3NEARDR00JrxSly4hky0zm+dwSmyjJ8kHNONHEYPEoLQr4pz4y5Tf0Fp9H7vL
 NhhcyOGi38norrhh3fCSPXV+CM89YKih4POOV3mH3RyqXY/ZMospbtRFN/g94OJQ2BzKkcaPYzi
 tse6yPAHdVrgTLjQIkiY1Lgkv4zI5Obxd04/RBWcHLVpMDCMThF/vcxK0eVJsr3T1Fpvy5dAUCF
 oqKorOKOfRhGBpYb3++NR2pebFAGFEmyATDZX7xlFFfCxDved2Ma/p0fd15U/Gx+5Cu2hyq4HQq
 BFLteSEdAtZ2YOcZkS69pkMgqqytxoLUeThgdzaMzwAk8ovxinAOAIMxog+nA70VZ0gyiawcgMj
 wsAqzOxOwflQGIzLG8i5ciarkknNESSzOVUSYFH/jtVCyS9oxmV7Jv0ipzZMEnK9mcqDygP3FQa
 +Mtoxb/4iXPwOIgukknVcDo3p9f5kYIAFCHdcGgYwYza9z5Cr8UE4koPwIynXRZvhauNcGvRdpM
 rcd5Vyv0wHbx+71GhZ94XUFNXfnlTQlD7aNIbZwEW7a/3uVxR/DPsV/uO7H6JQC/97622uWS0H7
 oc2RiZpTlDVI
X-Received: by 2002:a05:600c:3f06:b0:49f:ce78:356f with SMTP id
 5b1f17b1804b1-4a18e4ca2acmr193128725e9.32.1791821371578; 
 Mon, 12 Oct 2026 09:09:31 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19f318c31sm81707215e9.3.2026.10.12.09.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 09:09:30 -0700 (PDT)
Message-ID: <KAcS5WJbQyPKbiDel0IQZfd4x2rnMBTRIRb9@localhost.localdomain>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <20261010033622.68927-3-li.wang@linux.dev>
Date: Mon, 12 Oct 2026 16:09:29 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] tst_kconfig: load and unload kernel
 modules for CONFIG_*=m
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

> +static const char *module_name_for_config(const char *cfg)
> +{
> +	size_t i;
> +
> +	for (i = 0; config_module_maps[i].config; i++) {
> +		if (!strcmp(config_module_maps[i].config, cfg))
> +			return config_module_maps[i].module_name;
> +	}
> +
> +	return NULL;
> +}

This is used only once, we don't need to define a new function.
We can leave it inside kconfig_module_record().

> +
> +static void kconfig_module_record(const char *cfg)
> +{
> +	unsigned int i;
> +	const char *mod = module_name_for_config(cfg);
> +
> +	if (!mod)
> +		return;
> +
> +	if (tst_module_is_loaded(mod))
> +		return;
> +
> +	for (i = 0; i < loaded_module_count; i++) {
> +		if (!strcmp(loaded_modules[i], mod))
> +			return;
> +	}
> +
> +	if (loaded_module_count < MAX_LOADED_MODULES)
> +		loaded_modules[loaded_module_count++] = mod;
> +}
> +
>  static inline int kconfig_parse_line(const char *line,
>                                       struct tst_kconfig_var *vars,
>                                       unsigned int vars_len)
> @@ -268,6 +307,8 @@ out:
>  				vars[i].choice = 'm';
>  				kconfig_runtime_check(&vars[i]);
>  				kconfig_module_check(&vars[i]);
> +				if (vars[i].choice == 'm')

This is better to have it inside kconfig_module_record() at the
very beginning as a gate.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
