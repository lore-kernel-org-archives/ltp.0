Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3F606A31C
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=rz0cGunz;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CQvUJdYH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795058739; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4/DmeqLbi/6lb0E5vEqx1yZwm7MONvX2G9cmu9toTVI=;
 b=rz0cGunzMJgWdgBJo2G6jdJSpINAnRf7Rx8Os4EIrkwLno0pfZ6PIeR5pwAugkdrlNY+8
 6mfDXZqkGkQiaRtbrmi/SFlPBm/EEcQQio3cHt0DmXINMDc1tkFkF0c/IeAymM+8NyPDHbP
 6cSBUJpkkw4J1QqjAOUYsi1oV0pH3jo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C00253E6CF3
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 04:25:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E6FD3E2268
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 04:25:18 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9393A10007C4
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 04:25:17 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso17097135e9.3
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 19:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1795058717; x=1795663517; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mtr387as4Z5yfSQrUhKUSKNntGPoHlpkt6qZnSK25bE=;
 b=CQvUJdYHmcDaskRslQx0Sv0GyZ8uJCCK8uopnDlqrHnFUH2m2aHVebaTspsgCDgpjx
 4K+1e1NAyZJSA1Psu7G3wOAQGeRlfOyW01ApI6i7DAQNqY2HJFYMx5GKHUFaHu1+oXvb
 spdaetJVewbWErNdIn3DF9ZNKr2ObofI6dj7E+IJqghq8sxWm96yOcWE5zKeR7Hn4A3N
 gIdjJdbx5fDrD6VGQifWMaaJTUn9k2jZwY/oHL2HdYWTKGYt3Rzudyni+/wG03ACc6//
 DD2sFnHHHBp9RXsaKTeynG0PEKzL3NOVeIn4RMGj1Qna8Pqy4DnJxJ23/ryvX2pNHonD
 HqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795058717; x=1795663517;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mtr387as4Z5yfSQrUhKUSKNntGPoHlpkt6qZnSK25bE=;
 b=E7TJj5rfSw6XKjmd5HZQY2u/uU6JQGE6fh4mO0CtG6atVSM4mMG1eJYoCKFEH/74yg
 NaZjr8oOwMlhtVgBnlv1S1qcZ0eCaeUiVoN6nnsmvWkxmVKiJEGSHonV2TE0tTiNvn7i
 pnfMS2nRsj83EB5cxOF8PwUQ1KBZhvbvy7avZPLKGlP7WAXCP/bS59vUXhvXvEMz4B0e
 G68zOiz1t/PxO1dCdVdGY+kGblLaGo7KNE7AVso6chrNmBbb3e36djElAgrMcO5qV3zZ
 wmiINEfebkoAsJy1mJ9RZJPY1ahnGkxq76Xt7GZGyvzbqQ01L2wo4BxmP1MLyXjcqkR5
 Oiqg==
X-Gm-Message-State: APuU4Z+vF1Ah6fbRVX91wOkU2kihScFrZdTpsmgSSJC5Yeihn9sxs7y/
 IepQnOSjf3OccLaAVwNUUcsUNHGzc2cBZptyw5PZqwwH7sye1nu3bBa0G9cfyoFaBw==
X-Gm-Gg: AYBFou1u7nf1qhAuwWNDpJH0hNmktIBVFuiSYqPdhZN/bPip97qj90G0l4BY1wfAOqX
 zPwEeFdBWj9uk7iROUf+FFkBiG9z4joAlO0o1FcZLXJT/WCTDNx7rGpPkWJ7GpDTUajMgxCqbi9
 xu0s27n10MzAfEMp8tIDTNFfQv9qTAUBKNlU7Tdwu6kVOb4adturW7d5fYGr3+a5+0UEmUnKKFh
 vUxwVJVDOTuVfkkKhe/LGzwbZnYZvoHX2tYQL0BiCoMoO4U7kCbPjmaAxyRK6+7bl3iyzvW/Va1
 Axm0E/YdsDEw/iFs+KwmJNLv68o1ohV8ypiM/fQpE1TIzm0BIvnqbt1j/uaMekjK7KhgwWaSc9N
 WZ8WUTI+qzUHAEecSW6wcda+XPiiXIso6hFR3OkHhQf/+1kC4dgBN/a/Rrf1SZoQ8omocTCMJOJ
 fy+HhlnnqRZ839T58FKNAxBnECEKeY4o4Vn2MKPjkeDB6OIxleBr3peFDVR41jJcJ5A/F+lMTsk
 7+7AUH3jOeflo0+7E3Uc3U+oiXS0yJNvuTJ8tgHuTL4uJ7BlwALC6bsZt6q96K0jOdFqBk5/4Wx
 E+X5WhYLDNsP0qCcPnxR4PeGGKwyxqTHE8CDhjnNzoKPRA6G9uWPUkk5hR8jmE+pb/s2vxj56MW
 Co9uptyooxUVnC3gwfvY6O+13mXAHPhIiGCs8OuBenvo4DZLwvO6dpsAHPdyX+yw=
X-Received: by 2002:a05:600c:3e14:b0:4bb:68c4:2044 with SMTP id
 5b1f17b1804b1-4bb7da1390bmr84376275e9.11.1795058716963; 
 Wed, 18 Nov 2026 19:25:16 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e06c73sm11195715e9.2.2026.11.18.19.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 19:25:16 -0800 (PST)
Date: Thu, 19 Nov 2026 03:25:15 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <av5sG0vF-T0TZ6qx@autotest-wegao.qe.prg2.suse.org>
References: <20261118101720.2838268-1-chrubis@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261118101720.2838268-1-chrubis@suse.cz>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sys_rtc01: TCONF on system time mismatch when
 STA_UNSYNC is unset
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
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
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Nov 18, 2026 at 11:17:20AM +0100, Cyril Hrubis wrote:
> It turns out that the STA_UNSYNC flag is set at boot and cleared by ntp,
> so we should skip the TFAIL when the flag is cleared, since that means
> that NTP have adjusted the system time and it's possibly out of sync
> with RTC.
> 
> Fixes: 3d11e5dd622e "sys_rtc01: Report TCONF on system time mismatch when STA_UNSYNC is set"

Very nit comments:
  Standard Fixes tag syntax encloses the commit title in parentheses:
  Fixes: 3d11e5dd622e ("sys_rtc01: Report TCONF on system time mismatch when STA_UNSYNC is set")

Reviewed-by: Wei Gao <wegao@suse.com>

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/sysfs/class/rtc/sys_rtc01.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/testcases/kernel/sysfs/class/rtc/sys_rtc01.c b/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
> index 0e1c69f95..4857d4a8b 100644
> --- a/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
> +++ b/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
> @@ -43,12 +43,9 @@
>   * test performs, so on a long-running system a purely fixed slack would
>   * eventually produce false failures even on perfectly healthy hardware.
>   *
> - * If the system was booted with an RTC that was off the current time and the
> - * system clock was later stepped in userspace via :manpage:`clock_settime(2)`
> - * or :manpage:`settimeofday(2)` without updating the RTC, the kernel sets
> - * STA_UNSYNC and CONFIG_RTC_SYSTOHC does not write the system clock back to
> - * the RTC while hctosys remains 1. Report TCONF instead of TFAIL when
> - * since_epoch diverges from system time while STA_UNSYNC is set.
> + * If system time was corrected by NTP the kernel clears STA_UNSYNC flag.
> + * Report TCONF instead of TFAIL when since_epoch diverges from system time
> + * when STA_UNSYNC is not set.
>   *
>   * Under virtualization the slack is additionally multiplied, since a VM's
>   * clock (and thus its emulated RTC) commonly lags real time by tens of
> @@ -112,14 +109,14 @@ static long read_hctosys(const char *name)
>  	return TST_SYSFS_READ_LI(PATH_CLASS_RTC "/%s/hctosys", name);
>  }
>  
> -static int is_clock_unsynced(void)
> +static int clock_is_synced(void)
>  {
>  	struct timex tx = { .modes = 0 };
>  
>  	if (adjtimex(&tx) == -1)
>  		tst_brk(TBROK | TERRNO, "adjtimex() failed");
>  
> -	return !!(tx.status & STA_UNSYNC);
> +	return !(tx.status & STA_UNSYNC);
>  }
>  
>  static void read_rtc_snapshot(const char *name, char *date, size_t date_size,
> @@ -217,9 +214,9 @@ static void check_rtc(const char *name, int any_hctosys)
>  			"%s: since_epoch (%lld), system time (%lld), diff %llds <= slack %lds",
>  			name, (long long)since_epoch, (long long)sys_epoch,
>  			diff, slack);
> -	} else if (is_clock_unsynced()) {
> +	} else if (clock_is_synced()) {
>  		tst_res(TCONF,
> -			"%s: since_epoch (%lld), system time (%lld), diff %llds > slack %lds (STA_UNSYNC is set)",
> +			"%s: since_epoch (%lld), system time (%lld), diff %llds > slack %lds (STA_UNSYNC is not set)",
>  			name, (long long)since_epoch, (long long)sys_epoch,
>  			diff, slack);
>  	} else {
> -- 
> 2.55.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
