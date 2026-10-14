Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686F0CC6B1D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791970339; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=CktlxyZdtAEaysqrzPX2I3VwfiuKE/YM28ac61VtLVQ=;
 b=Qql8t1L43pmF1+6u3ervOkdeE1WLt4itj5lPum4MG+DFiQSKroKu+UvAASS7+2xVXU+Gz
 62THws4tgXkwdU4/mcyLwfX3jOzS1pH2PkB2ISwEbXrajcr1RQVOTC0mvdKc0jQTFmiuPXd
 jjUUXXagIuJmynoBLJYtAiWkKL5K394=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5882D3E6A51
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 11:32:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B15F3E6A2D
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 11:32:00 +0200 (CEST)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com
 [IPv6:2607:f8b0:4864:20::445])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DBA7B6009CE
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 11:31:59 +0200 (CEST)
Received: by mail-pf1-x445.google.com with SMTP id
 d2e1a72fcca58-86261e66700so2771493b3a.3
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 02:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791970318; x=1792575118; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Bvagru/7/iBq/R0gxS8QE3+YjtgRJ0zx9XYodg1xVQ4=;
 b=wPQ+VCCp5rgiI/Pbb31xmV7ADVe7Q7QOWOpRIRsN6TMRZdPFir6K4fC4PwYXaF8k66
 gd9TenHI3/ip9D32C1Udl1aa+16W9JLoMd9ePeb3HZSQ6tbJN5u3sm93J4voxREmyAed
 yHGm+2zoGLTsnVqZlupUdwnkLepCopaWi288v5Hn3ebB+QJN39hh7ikoYSRHKZs5BhZk
 Xpep6+pnjv6EaNa9yWN8qVdDcrcATSwhEnMvberjzWFjCvghmMsod7jtcM974iRiN/Yy
 MiAJ9aqz2ruXZUs1UfiBxC6BQR+UVg57/fTr5Nw5DGDNJUou4qqjKKFq21z6VSXPL91H
 zQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970318; x=1792575118;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bvagru/7/iBq/R0gxS8QE3+YjtgRJ0zx9XYodg1xVQ4=;
 b=vLAZgty2OTRugp6n1Pa6z2Sx4Ugx6vAfxHlP109PWBQr1JelluJuZDJG/wTilh/D05
 24+Bt5oACPLcWPaBh9tnQFw5yLYD3p6kE/Cz/lMsCBH/xvCTLPwC4Iosf8Jo/GC7Hn/w
 28H6pVwASLFWSdPzCVFORrYT7p5LpZ+b0t8dpy6rS9y9jYpJz8Vmwd9ZtV1nmpHbgFV+
 SRq+UQBTvXIMVYQQtzXYwtJsen2+EeF1Nvuym+IJMDnYKFrKsNg6vYEC/Kgh4C9DK4hQ
 bF5ZK+RYdo0wm4fTXf4Tokou+sYRx78Gkespp5Gu8SPiG20zszxalf5gZVmS7N/R0fzY
 M5Iw==
X-Gm-Message-State: AFq9FYKQj0AmN5A+E8Ve1KobfqgF1ais6om0OBbXDF+7S72g8ni57EJE
 3sUJrxOWeqwV8HwdX1e6cNxX7B7VUIkTCki9pMpmWUwLdY/YYweWiPyMgKBaOzA5LH8fadVmjr2
 fRQ==
X-Received: from pfblu4.prod.google.com ([2002:a05:6a00:7484:b0:890:98a9:5812])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:b48:b0:88d:20ff:15c9
 with SMTP id d2e1a72fcca58-897c65413a0mr13546275b3a.17.1791970317924; Wed, 14
 Oct 2026 02:31:57 -0700 (PDT)
Date: Wed, 14 Oct 2026 09:31:55 +0000
In-Reply-To: <20261014061202.56362-5-li.wang@linux.dev>
Mime-Version: 1.0
References: <20261014061202.56362-1-li.wang@linux.dev>
 <20261014061202.56362-5-li.wang@linux.dev>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261014-keyctl23-tst-modprobe-1-wakel@google.com>
To: Li Wang <li.wang@linux.dev>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] testcases: drop manual tst_modprobe() now
 handled by tst_kconfig
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Drop the explicit tst_modprobe() calls, and the now unused
> tst_module.h includes, from:
>
> - cve-2026-46331.c: sch_ingress, cls_matchall, act_pedit
> - sctphantom.c: sctp
> - keyctl29.c: x509_key_parser
> - keyctl30.c: pkcs8_key_parser

Could you please drop the tst_modprobe() call from keyctl23.c in this
patch as well?

keyctl23 still calls tst_modprobe("x509_key_parser", NULL) in setup(),
but it requires CONFIG_X509_CERTIFICATE_PARSER=y, so the parser is
always built in and there is nothing to load. With the call gone, the
tst_module.h include and the "Requires root (CAP_SYS_MODULE) to load
the x509_key_parser module" line in the doc comment can go as well.

On most distributions the call is harmless, since modprobe returns 0
for built-in modules, but on Android it breaks the test. Without -d,
Android's modprobe scans /lib/modules/, which does not exist on Android
devices, so it always fails and tst_modprobe() turns that into TBROK:

  modprobe: Failed to scan dir /lib/modules/: No such file or directory
  lib/tst_cmd.c:114: TBROK: 'modprobe' exited with a non-zero code 1

keyctl29 fails the same way today, and this series fixes it since
modprobe is no longer called when the parser is built in. With keyctl23
covered too, we can re-enable both tests in Android VTS. If you would
rather keep this series as is, I can send a separate patch for keyctl23.

Thanks,
Wake

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
