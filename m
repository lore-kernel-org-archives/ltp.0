Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246AB606A325
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=KbvWomVu;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AU1BVarY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795096131; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=x9j4MCj485w0QWMRboHx3Kn61yhuDlCH2Y6gQW/f8mA=;
 b=KbvWomVuwV0rZOUrjQzgRAVAKn/qxSYhPfoEL+L7JPGypvsiy+VnUOaV8b0P/FgXeVocV
 U7NvhPT1f1YD2T5jBhG1+cqRsSJ3yshyfOSXYAc6NfDTmNJusUWEkOJh64eokGVaLCkVFIW
 evjDW0eOfHOi+HaitL+7TjtjLxROPd0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7F223CEBFE
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 14:48:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80C973C2169
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 14:48:31 +0100 (CET)
Received: from mail-pg1-x545.google.com (mail-pg1-x545.google.com
 [IPv6:2607:f8b0:4864:20::545])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F08DA6002E8
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 14:48:30 +0100 (CET)
Received: by mail-pg1-x545.google.com with SMTP id
 41be03b00d2f7-cdb86c39250so1416268a12.2
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 05:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795096109; x=1795700909; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kgdusgzYL2gHv5ThrnjZNcC1d1SIEqS0YjTH/Jyn5/0=;
 b=AU1BVarYWju1jJy3rjNI/FbORukaUIeSnM6jgXQtAYy/E1rUHR4ynlzh90A6FVdP66
 yXDsIl70fwM96WdpyBsNW24GABxNpnsG+8NM1fWLswGkCt2WBtJtPUUaOrvVpQNUXzqG
 kQH3hq8vrScM/C9KvNVkyGodV16HZicSnPjqsTjpFxFOe0cJ/aCqjIYMoNKAzuqpzdN4
 O0EJ+sRQ/LsZ9b4cEwrFPGvbLgY8iXTJUBLfhw5ZGcD+mejRxBHuFKsiMb7bGoTJ6tGk
 TnlgGJ5i9pSXC7NLgbF4Gs2kzwMs3Qwp23K+iijsjScO1OscNzNWzAlY/EUbAH9hziaq
 XToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795096109; x=1795700909;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kgdusgzYL2gHv5ThrnjZNcC1d1SIEqS0YjTH/Jyn5/0=;
 b=EWlXgBTNIypEkfic+7f20HGWRo7BJpeZIQrLjQT/oznSVU054lwyAIQqjSdTROfvgG
 W+CRco8B3rj42BigPvzpMp7rngn67s2D66N09L48DbQhB4bQNBp0Q9tD271s3bUWmZya
 ADmsSxEHM96r+J1j3QSP9Vy1GfaHoeSoU4GP1QhhSpsljAUowKbbMBd7pcKYO7zpZnav
 YurxF8fECloRjP3Z/gTbyFOI+hHuu9GBf5Aq7NdRZ69BQagAGODw8s50UdAW9+o83Ydh
 8X5HMlcSBcOX8nlQdhuH8f7E1nfYaCPbrd8bjwobHvl0KZzEVN4p0Pb58nPfCEMP08es
 yuVg==
X-Forwarded-Encrypted: i=1;
 AL+hErG0EQOzVPv0P6+prgLKc2+EVHbsKBEbawzyWa/+pnokgo8W5Y3MdNsob+Dt4h/L21BJHoA=@lists.linux.it
X-Gm-Message-State: APuU4Z+3YLahR5PVt6nx/gbCY9a/ixES6tSBx2iMBPH683ujO3ulp5WD
 Mw0PIldRTglO3O4wh5tixmMOtb2G0h26fASKYCrnW+9EvpQdxLslUYvIKwuF+8CLJgBheECgzOc
 Tsw==
X-Received: from pffk17.prod.google.com ([2002:aa7:88d1:0:b0:8b7:600a:cc59])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6372:a713:b0:3dd:85a8:4c67
 with SMTP id adf61e73a8af0-3fe97aef9dfmr4702914637.46.1795096109006; Thu, 19
 Nov 2026 05:48:29 -0800 (PST)
Date: Thu, 19 Nov 2026 13:48:25 +0000
In-Reply-To: <CAGp7zX6g1F04g50OcY9L9JVt0jH7NdtcSPtNXjtYSCs98=y2fA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117125658.1743505-1-wakel@google.com>
 <CAGp7zX6g1F04g50OcY9L9JVt0jH7NdtcSPtNXjtYSCs98=y2fA@mail.gmail.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119134825.294248-1-wakel@google.com>
To: Avinesh Kumar <avinesh.kumar@suse.com>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inode01: Drop redundant 512MB dev_min_size
 requirement
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

On Thu, Nov 19, 2026 at 02:01:21PM +0100, Avinesh Kumar wrote:
> Unfortunately this change breaks things on tmpfs on systems with 64k
> pagesize, as library sets
>         if (!tst_test->dev_min_size)
>                 tmpfs_size = 32;
...
> so either we need to revert this patch or we can do this lib change
>
> (lib/tst_test.c)
>
> -       if (!tst_test->dev_min_size)
> -               tmpfs_size = 32;
> -       else
> +       if (!tst_test->dev_min_size) {
> +               /*
> +                * tmpfs charges its size in whole pages, so 32MB is only 512
> +                * pages with 64kB pages instead of 8192 with 4kB ones. Scale
> +                * it to keep the same page budget on every architecture.
> +                */
> +               tmpfs_size = 32 * MAX(getpagesize() / 4096, 1);
> +       } else {
>                  tmpfs_size = tdev.size;
> +       }

Thanks for catching this!

I agree with updating limit_tmpfs_mount_size() in lib/tst_test.c rather
than reverting. Reverting to .dev_min_size = 512 would bring back loop
backing file ENOSPC failures on storage-constrained systems (and even
.dev_min_size = 300 would only provide 4800 pages with 64kB pages, still
short of the 5460 non-empty files created at peak in inode01).

Scaling the default 32MB tmpfs limit by getpagesize() / 4096 keeps a
consistent 8192-page budget across 4kB (32MB), 16kB (128MB, which also
matters for 16kB-page Android kernels), and 64kB (512MB) systems while
preserving the 2x MemAvailable TCONF guard for low-memory machines.

Since the fix and comment are yours, will you be sending this as a
formal patch? Feel free to add my:

Reviewed-by: Wake Liu <wakel@google.com>

(Or let me know if you prefer that I send it out with your
Suggested-by.)

Thanks,
Wake

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
