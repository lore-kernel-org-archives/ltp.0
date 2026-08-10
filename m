Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1C0C5AD7B
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 18:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786385693; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=nMIyTBON3J7yWLzLJ6nzFO73z2VZslYBiKrc66dHXfc=;
 b=OYNn6tu3umbOAq/ck1LnIOQNWN4FmdfYwN5kjZVVjreIhOVneK5n436lhLhjsjFSv9Dbd
 aRc0w3G4cQ2LEoC4VxXMyaLRHD5xlpG5MGoyzLQ5RamY+vP2sNjZAduX20MJn0KWSklwPV2
 JQdb6s3loJYhNVIgx7meLXPobXV1hZc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 181C53D0523
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 20:14:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65CF03CE2BE
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 20:14:32 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B23671A002E2
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 20:14:31 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-495590dde14so114965e9.0
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786385671; x=1786990471; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2/eEvxSwvLlMgd5nlrc889jnOkQPxx2aBGQW4zxZewM=;
 b=QQZqrEvD/DhthpHRchCtf+YaopIJTMxRoO4/wqC8iobQx67/1vjWcU9hwuJIEXDI+a
 4YBztLmdIxkpXncVeYG60wg5JqiH/uZRoAFepEQBBLzDYPyIIbiCSKdwgmfrCrrdqcrp
 gGkbLsVaN4kWB9B/64j+ipc8WqCfTIW8STIbrgupZSXQFPms3dx7i0cNiPSIOnCGAvUt
 Ms/1WsvnHD5Nn0lIbf4kqp4R1TIUCEnjkFBv2jrmczGyaT0Lk31pUpsMiVF4Z59cIL6h
 fXvJPS78oV+meTinLjRnAbRefSHQJbPB0adHB8n2j/Y1hGRXerrQ1bSvQagQb8I1Zt+n
 dIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786385671; x=1786990471;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2/eEvxSwvLlMgd5nlrc889jnOkQPxx2aBGQW4zxZewM=;
 b=cvfAEGqFXvSk/eRIjznz5EYX1s+iW9epV80C+GiGovPa1YakBPMv4eFObtOtEusrrX
 5tVHhj7gWzqZRYpHL7yRWUFOdnQZRoCxo7v7HDqVXQJGaEceyjxJvyrdGXcYoU6rUikj
 THCck09wEhKBZnrnh4pTD6H9jXKn7asLrQfwLPDjjEKuAg1bjmDqMu8LIRKdJ+xQUWjY
 pX1XjL+J1GMA/iNcwcawJrHOx79YAicNvF7iQTNo80icS0x4NW93V4LMVnrzTAz9WOol
 8xqSzceG5AEbIErx9C7ESZlk8uVCC9Bmtr/Dmumpcf2YoxyhRBpI1bR6mwA7GGt87dwW
 DDlw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxmAY0FoepPO7FZaVOkCG6ZF3Gyc+i+Fd3bD8XMyxNHdpihKVVED5et1rAw/D7kJL1Nh8=@lists.linux.it
X-Gm-Message-State: AOJu0YxSZO69fJAxEJZDZCoWY7xq5a0pIqfqLPjmsxmwiyHZL24uo+h9
 yhsoOsdxRRzStSGjxAru9qXFr5iUVCXYP9BD7L9/tqu5auXFgXHvLaEXvbpjakicu4o=
X-Gm-Gg: AR+sD1157bdAHhJSbdtQVbU+3H2Q+6x1OchLpISxGYzkU6WABSOUu5relwJsNPG7Ypf
 bcLB/WSRdKzsZKJdeTdeKduH2cgmRzm+LVlxjrcEfnBpLxwJydSx12aIe/eJ59RDxLIqtA90S2B
 sfbM7dH7TYXsVWZQnKWlVzrng+kq3rQQmwhhRyodb4wubXN6b9iPxEJjni0RGPr+wAjQZkgoGMX
 YZp6e4QPb126v2XvsPho88DOGuXxF1hMp8OWAH6QyoZ7zAGBROsjXVG6Gz27ePhukNTmutC/L9G
 tuLj6OljbTxBrkjciT715ldY8m+f2xOQvhMr/d91mfyczCFvfGCLgXbtH7MgGxkKNo7aBXN8glb
 XIzFTJSc2PQ8zdgkzE8nEe01q7JX/dq5XfSlQ8JAqeIV/ISCCQGPOuHE9wNf4joNxT34WlUBZ9T
 MSzXTFlwHLn9pzGF5BG7DP176WNYhAt7pXaz1rkW/aDd6x8rwdz6HPtJ7dQd2y64i9goHuGg==
X-Received: by 2002:a05:600d:15a:10b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-4994e73ce4fmr511258925e9.7.1786385670962; 
 Mon, 10 Aug 2026 11:14:30 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499740dbb03sm9560085e9.8.2026.08.10.11.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 11:14:30 -0700 (PDT)
Message-ID: <6a7a1506.e11288f4.339403.080c@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260810180620.GF1049677@pevik>
Date: Mon, 10 Aug 2026 18:14:29 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] cve/sctphantom: Add reproducer for
 CVE-2026-64564
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Nice reproducer, full of magic. Generally LGTM, few notes bellow?
> Acked-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> 
> > +static void setup(void)
> > +{
> > +	int fd;
> > +	const struct tst_path_val sysctls[] = {
> > +		{"/proc/sys/net/sctp/addip_enable", "1", TST_SR_TCONF},
> > +		{"/proc/sys/net/sctp/addip_noauth_enable", "1", TST_SR_TCONF},
> > +		{}
> > +	};
> Can't this be part of .save_restore in struct tst_test?

I had to move it inside setup/cleanup because we need to load sctp module
_before_ setting the addip_enable, which is available only after loading
the module.

> 
> > +	const struct tst_path_val *sysctl;
> > +
> > +	tst_modprobe("sctp", NULL);
> ...
> 
> > +
> > +/*
> > + * The freed transport is released by an RCU callback; once it is gone,
> > + * reading the association status dereferences the stale primary_path,
> > + * which KASAN reports as a use-after-free.
> > + */
> > +static void probe_uaf(void)
> > +{
> > +	uint8_t buf[512];
> > +	long delay = 1;
> > +	int i;
> > +
> > +	tst_res(TINFO, "probing the stale primary path via SCTP_STATUS");
> > +
> > +	for (i = 0; i < 12; i++) {
> > +		socklen_t len = sizeof(buf);
> > +
> > +		TEST(getsockopt(cli_fd, SOL_SCTP, SCTP_STATUS, buf, &len));
> What is the point of using TEST() macro here. Why not run getsockopt() directly?

Yeah I also removed it, but then messed up with undo history :-)
I will remove it again.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
