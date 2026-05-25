Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79229CD5BB1
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 19:43:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 249FF3E63B6
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 21:43:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F8223D56E0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:42:41 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C0F2060044B
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:42:40 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-516cbde40f2so48646311cf.3
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779738159; x=1780342959; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5hhHVgXfgZi7/X/JJRZKPleKjySx0Fpjr8bYXjxtPU=;
 b=XelQYQER/TSQttj9fH+JsI9srbdmcX9MITGVEB8zx9ApNx3Tf+JO3dK2TSI0Uv9W3l
 Hb6d7PcKaeLowve2LuEp37wfGBKF36XBuo5cjyPXmN8BWAjo/Vw0vMlP5AbGN1n5BcSi
 TuLLUpQkk+1sWcdidKt5rEaDxhd0+8ZBq6TlblkJNu6+8w6rq29HMC/C2BKAkcMrKkkU
 jUQewcGsMK/QbczvnzzXSCHycb3y5Jhd4ewrzmiCXABkiL8r4+0SeWJfL37gsuNtIJ+n
 0513gWPhjMxYqq5qK8FzfoepTQh9FYj6pjOIogPRfUO7JUPu10UMyhNElt+KJsdmWUCB
 D+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779738159; x=1780342959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l5hhHVgXfgZi7/X/JJRZKPleKjySx0Fpjr8bYXjxtPU=;
 b=PHdtEiviCFJtih8g8zTv4UEqKWaACh6FUS1GstOM9bKjFDBRCNT798MLOpy7vhNNxJ
 YxdTDTRHw/hBeR4lafNxZxaoJLmBs/s/hEOOe71TCqOVC7fBtJZowPsblCwhq4QUw22F
 ThPX9KB1fHpPx23ms4DcZr6uu2CsU/UVdHrfWqJKXinZQnpl5NH6FO6ZDf3NoijSL4K3
 hmR7K64YTLVcO5sz+zL+PEgfa91K7dztOhRPZicPnNtJwnW/jUlolVWtfDVHpteWQNEx
 FKSaaOkraJM03haeiWtBCmFPMM3Ok7e9dpT7RuT6OfKMdJ6dnq0f2C6CHI610LszZB/c
 +Rrw==
X-Gm-Message-State: AOJu0Yz/V3VeNXXLZBrKkyUfKC4xRN1vqtXDXXo6xJory1LG9SYDZget
 F52w+2bf0O6wY4+9tUhl39jDQWt3ll2ZmXj+HSBPyGuYrNTbHSOGo/QI
X-Gm-Gg: Acq92OEVRJ/n8Ku5DEQ9yXGCmAIjQ61ef+ITMTVD4BHD9l6cXKkky9omOUbYTk7f2LR
 CaWR36FzuLlup2Bxvh/19ZikTJwJwNOuYwETJkTS9pwUX3alz0ujO3Fj1pBDuzB8AFdZidwhZld
 nDujpdz+ZlEcHbOBAidD1xBVMAjztmLyv8Voz3h0dQG2iHiNCjH77RIDAVin4EMPteIK8elENb7
 FePvRI3vWeCsykatqLhsOMyVdzHuojmqlGGDHZfO3urp9TzOmfh6utiS2w+XVc6bbqzCGPNaCnV
 wl6IgOvEIhOhopQx4OVZEw5MIiW8+fjXzFMdQRf+DrFYYIXO7CM2NpMT0I94uNXEBxvwjCdsAMM
 j9+Y5RZnuMMAm3wT+a83/qdZlMEI1HbL8Zp+r07LjbyVx/4Lxrto9r94K4XUbz2t3YeJWZ17LnK
 F4P7vqRKjsxuV37GxkwXyUiCS4oTEDpEJumyOOhV++ShAW5BKY8GSWX6900nQP+p3KPmMv0w7/3
 MMKBdZlBv0qu85K6jnU1i6kQWUZx2fY37YG3Q==
X-Received: by 2002:a05:622a:1aa0:b0:516:de71:e216 with SMTP id
 d75a77b69052e-516de71e358mr189406681cf.1.1779738159443; 
 Mon, 25 May 2026 12:42:39 -0700 (PDT)
Received: from
 runnervmg397c.twwycwkaznxeznykkqsgfknjya.cx.internal.cloudapp.net
 ([9.234.149.84]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516d8d0a4e3sm99800451cf.29.2026.05.25.12.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 12:42:39 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Mon, 25 May 2026 19:42:38 +0000
Message-ID: <20260525194238.3953-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525190127.397779-1-avinesh.kumar@suse.com>
References: <20260525190127.397779-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] zram01: Specify filesystem type explicitly in mount
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

On Mon, 25 May 2026 21:01:23 +0200, Avinesh Kumar wrote:
> zram01: Specify filesystem type explicitly in mount

> -	for i in $(seq $dev_start $dev_end); do
> -		tst_res TINFO "mount /dev/zram$i"
> +	local i=$dev_start
> +	local fs
> +
> +	for fs in $zram_filesystems; do
> +		tst_res TINFO "mount /dev/zram$i ($fs)"
>  		mkdir zram$i
> -		ROD mount /dev/zram$i zram$i
> +		ROD mount -t "$fs" /dev/zram$i zram$i
>  		dev_mounted=$i
> +		i=$((i + 1))
>  	done

Nit: the rest of the file uses `$(($i + 1))` (e.g. zram_makefs). Prefer
`i=$(($i + 1))` here for consistency.

[...]

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/26416857886

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
