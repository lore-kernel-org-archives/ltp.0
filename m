Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1F0CC6B2D
	for <ltp@archiver.kernel.org>; Thu, 15 Oct 2026 02:22:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92A763E6BDB
	for <ltp@archiver.kernel.org>; Thu, 15 Oct 2026 04:22:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBF543E28A6
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 04:22:24 +0200 (CEST)
Received: from mta0.migadu.com (out-213.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::d5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A5C1D600F14
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 04:22:22 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=cc0PO24NeJU1xj1ZYGuo8xx+4Oea1E7mKgFlvsfMCyk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792030942; v=1; x=1792635742;
 b=RJcLH5Cmu1nixoRqbgIb0/wMj+6cqQPaKhMPr4sS4nnAW6Xzos4R5m0QFaQVykvyqwQGdXos
 pv1cNHYZN6OSR53JUAhKUPC0F+Od3PhPqFnL8Dg04OFbUAwEA95E0UrURPvQ452/8tdJASy1SCr
 T4yR26qEDG5/jDmiPG3L/crk=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 8d91efc598758df5;
 Thu, 15 Oct 2026 02:22:21 +0000
X-Mizu-Trace-ID: 8d91efc598758df5
X-Migadu-Flow: FLOW_OUT
Date: Thu, 15 Oct 2026 10:22:19 +0800
From: Li Wang <li.wang@linux.dev>
To: Wake Liu <wakel@google.com>
Message-ID: <atA4roTkggDPCrDA@linux.dev>
Mail-Followup-To: Wake Liu <wakel@google.com>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.com>
References: <20261014061202.56362-1-li.wang@linux.dev>
 <20261014061202.56362-5-li.wang@linux.dev>
 <20261014-keyctl23-tst-modprobe-1-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261014-keyctl23-tst-modprobe-1-wakel@google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Li,
> 
> > Drop the explicit tst_modprobe() calls, and the now unused
> > tst_module.h includes, from:
> >
> > - cve-2026-46331.c: sch_ingress, cls_matchall, act_pedit
> > - sctphantom.c: sctp
> > - keyctl29.c: x509_key_parser
> > - keyctl30.c: pkcs8_key_parser
> 
> Could you please drop the tst_modprobe() call from keyctl23.c in this
> patch as well?
> 
> keyctl23 still calls tst_modprobe("x509_key_parser", NULL) in setup(),
> but it requires CONFIG_X509_CERTIFICATE_PARSER=y, so the parser is
> always built in and there is nothing to load. With the call gone, the
> tst_module.h include and the "Requires root (CAP_SYS_MODULE) to load
> the x509_key_parser module" line in the doc comment can go as well.
> 
> On most distributions the call is harmless, since modprobe returns 0
> for built-in modules, but on Android it breaks the test. Without -d,
> Android's modprobe scans /lib/modules/, which does not exist on Android
> devices, so it always fails and tst_modprobe() turns that into TBROK:
> 
>   modprobe: Failed to scan dir /lib/modules/: No such file or directory
>   lib/tst_cmd.c:114: TBROK: 'modprobe' exited with a non-zero code 1
> 
> keyctl29 fails the same way today, and this series fixes it since
> modprobe is no longer called when the parser is built in. With keyctl23
> covered too, we can re-enable both tests in Android VTS. If you would
> rather keep this series as is, I can send a separate patch for keyctl23.

Thank you Wake for the feedback, sure I can add keyctl23 into this patch in v5.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
