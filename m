Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441ECCD6E57
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 09:57:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEF953E54F1
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 11:57:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 517333E1CF6
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 11:57:32 +0200 (CEST)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [95.215.58.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D4C5360063A
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 11:57:31 +0200 (CEST)
Date: Thu, 4 Jun 2026 17:57:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1780567051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V4jXDo1KedyuiKxoQU33pEQPmp5TvaScpvdEe1lLklY=;
 b=cIVuniAgioiSGKegfjxGHriuuWAupgfU2OcaqGwNt3gpk/JxbQP7o2eWufXtJjuD3OFlcq
 +Lk5VSzb488mx9dM9W6m3eT5o67+fvAFM0umQMxd90T21Iw15bBR64EPVQ3VWDQYpbSkua
 4DR5ojf4zewnwyaEo/uU8CNP3mit/Wc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aiFL8n8SMITbE-LZ@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20260604094200.21643-1-li.wang@linux.dev>
 <aiFKatipB8ypAsdf@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aiFKatipB8ypAsdf@yuki.lan>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] lib: Introduce tst_path_defs.h to
 consolidate system paths
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

Cyril Hrubis wrote:

> Hi!
> > +/* NETWORK */
> > +#define PATH_NET_IPV4				"/proc/sys/net/ipv4/"
> > +#define PATH_NET_IPV4_ICMP_RATELIMIT		"/proc/sys/net/ipv4/icmp_ratelimit"
> > +#define PATH_NET_IPV4_ICMP_RATEMASK		"/proc/sys/net/ipv4/icmp_ratemask"
> > +#define PATH_NET_IPV4_ICMP_ECHO_IGNORE_ALL	"/proc/sys/net/ipv4/icmp_echo_ignore_all"
> > +#define PATH_NET_IPV4_ICMP_MSGS_BURST		"/proc/sys/net/ipv4/icmp_msgs_burst"
> > +#define PATH_NET_IPV4_TCP_PROBE_INTERVAL	"/proc/sys/net/ipv4/tcp_probe_interval"
> > +#define PATH_NET_IPV4_TCP_KEEPALIVE_TIME	"/proc/sys/net/ipv4/tcp_keepalive_time"
> > +#define PATH_NET_IPV4_TCP_NOTSENT_LOWAT		"/proc/sys/net/ipv4/tcp_notsent_lowat"
> > +#define PATH_NET_IPV4_IP_LOCAL_RESERVED_PORTS	"/proc/sys/net/ipv4/ip_local_reserved_ports"
> 
> Maybe we can drop the NET here as well, the IPV4 is descriptive enough.
> e.g. PATH_IPV4_ICMP_RATELIMIT

Makes sense. I'll update that before merging and wait for a few more ACKs.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
