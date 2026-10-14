Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00ECCC6B24
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 07:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791962030; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=w82p6GhcEVFG7nEtSwxzdDseLh2fLxbx/qz4jTiMbBA=;
 b=Crmj/OhIPefYq408Sjcai5FbfLP2DYwwJ/W7/sfQtSI+Uvhduh0eo5WvoaggwC8hKVjn2
 00xkcao1b7nBTTI9b7fQR7Fba6mHYNI7qpjHTQDNe+QsqF6S0/v+3OP9wKRqcMyr9pPgyta
 1vpt5cfZgCHSX6sFXvebyKEJl5cW2yQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 036B53E2B30
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 09:13:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71BC23E2B30
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 09:13:30 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6C057200208
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 09:13:29 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a16c399641so36988025e9.2
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 00:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791962009; x=1792566809; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ob+DjeHLeOBsl8lDAnshog3Y1QN7XOMG4J97E8pJauc=;
 b=LWysiuPaes5VwdUIeZkjKN8OH6FNkJ6pRIbA2g3xMmySUq3rc3SIiqisaprvuCsv0v
 PubM1164PAO0oNY6Dc1Frw+S8Ktr2xyWJZziD15umL0bEcAPDELCYBenvlGdghfXMVTh
 GT02fOiauDkvyW8uhTQtiRQDehDidZnNXsbEQpQMRG1G/cGebXJnS2tcc4q9sky+PQzP
 0Ke63s6kBDYPz7i20oVuIusEYW6CdEXeFDBDo9CW6K7OYxV2+nuFnCqkFjZnfCqXA40Q
 0E+OcA6WbuCUKbicqGGDboIX48L6KmYl0Gopq4SC7L8ra68lBRoHvstZi/U5uf0e0vIj
 zzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791962009; x=1792566809;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ob+DjeHLeOBsl8lDAnshog3Y1QN7XOMG4J97E8pJauc=;
 b=IrHbnW9NRIPuF7wnrIen6JAv+wV/dvAt5hwtxr4tX5y2EAQvumagVT/l/pJ4FAJ7mK
 62zZl28Isy+XJ5wnpt++oI+YH1mwKrEGfhR3EPEcntqAe8JkUYLMTDCRN1eahjkKKV7x
 IP/cIKQ1PUj2Q5vNcZEJXFabPCL0SnC7DrA0LXIpshjhVDrcqekuz+HCpiVanMXVv8KE
 RqxbFqOpKQyE6vjF0oCNzWOusKY8pWQxqflZHEYoqahFwi3remNAaXK37nWfe9NdDtFx
 Kvs0vCkJd4hETiloRgm1Aab+2E/OoKzdVC7cI0Cm3xJ8AvUgh45xJTdbkhe3S5Ys/NAv
 YhUQ==
X-Gm-Message-State: AFq9FYIgSq/DNUhCUVO3T0vfjcpWLY4p+iTOOLLZlgx+MwTN03RIx1rk
 GdAVUBhS9HN8CUokrd3GnVLaUpoPutQIOLIUf2VA1wxVtsMNdC4MR9Iqo3sjZGvSr7KaP0dey5t
 a9gfn3Tvpow==
X-Gm-Gg: AYBFou3SXIH53oHY9CKOMSOIUvhKUW67vnvFsz9pl4m29LWfw9SdMU/GZilOgCWpqRd
 1AumC1/1Q+aIAt0JqKBoe/Aa8xdOI6DutmzD28dn5QT9UXNBjbS+e2ztCEg7+kibr6FXh6kp+Hd
 meLK4CPUPHPJ+F2UVDVadmFEmIlwWlnp1l4up7efOLEsmGYtMTP03xH81XKJNi+xW+f2/5zTDAG
 Zyw8hYTSEX2vZCwYYc6JmA3PRcoLxaYjr3w2bK4XAX4Y8DaGNcnivLg72DctltiMBg/Cgboe2dl
 IQSLqv8HgwYa/pDWuDLrLImZ8h8XRFX5/5/O2I8Bi4ZZ4ntVYmASuCLD7OccBL3+Of+cGy7/tME
 WbRsS9sIgXvWh8IKcAMXkuxiXtKJPnZdQEHLSigrMD0uWT6V4r53QZe3M/ExZimaJSRBDAuCP7J
 u5qA4jFZ5Aa4pKIEWUHHTH70KOh3sLfsKaR8MArRaoHQZaLMzDMn6k54h8bQY00soJrrz7g2vNu
 hEvk+pokHcuMYaUIZ7hJbpD90C8aCKIlm+oBuTzb0dr++mRhXEloNrtPL+mUUo5jRmdZkg8IRjx
 vgQf6H3gOBrq
X-Received: by 2002:a05:600c:698d:b0:4a1:97c6:d2b4 with SMTP id
 5b1f17b1804b1-4a197c6d614mr220353715e9.15.1791962008505; 
 Wed, 14 Oct 2026 00:13:28 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm468733585e9.10.2026.10.14.00.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 00:13:28 -0700 (PDT)
Message-ID: <lPrzeOZgU1fMNKhK15I6cCnPk2b9oRZnJfxX@localhost.localdomain>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <as8MmB6eIyIh3tT2@linux.dev>
Date: Wed, 14 Oct 2026 07:13:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] tst_kconfig: add module mappings for
 vsock/vsock_loopback
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

> On Mon, Oct 12, 2026 at 03:51:32PM +0000, Andrea Cervesato wrote:
> > Hi Li,
> > 
> > > The test needs root only to load the modules; the reproducer runs as
> > > an ordinary nonroot process in the initial namespace, which can use
> > > loopback VSOCK on nonprivileged ports. Drop privileges to nobody after
> > > module loading and regain root in cleanup() so the modules can be
> > > unloaded.
> > 
> > Please drop the root _only_ if we are root, we shouldn'f force the test
> > to be root always, even when we are user.
> 
> After thinking it over, I'd prefer to leave this patch unchanged:
> 
> The test does need root, but not for the reproducer itself -- it needs
> root for setup and cleanup:
> 
>   - loading vsock_loopback requires CAP_SYS_MODULE;
>   - unloading it in cleanup() also requires CAP_SYS_MODULE.

yeah we need root for that. This is something we can't workaround.

So I would just avoid defining functions we use once. We can simply merge
them with setup/cleanup and keep the needs_root = 1.

Kind Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
