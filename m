Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D942CD6E57
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 09:50:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28A7F3E54DE
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 11:50:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D30DD3E1CF6
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 11:50:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7B248100052E
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 11:50:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 062A56802B;
 Thu,  4 Jun 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC923779A8;
 Thu,  4 Jun 2026 09:50:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yrSmOG1KIWoZXQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 04 Jun 2026 09:50:37 +0000
Date: Thu, 4 Jun 2026 11:50:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <li.wang@linux.dev>
Message-ID: <aiFKatipB8ypAsdf@yuki.lan>
References: <20260604094200.21643-1-li.wang@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260604094200.21643-1-li.wang@linux.dev>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 062A56802B
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

Hi!
> +/* NETWORK */
> +#define PATH_NET_IPV4				"/proc/sys/net/ipv4/"
> +#define PATH_NET_IPV4_ICMP_RATELIMIT		"/proc/sys/net/ipv4/icmp_ratelimit"
> +#define PATH_NET_IPV4_ICMP_RATEMASK		"/proc/sys/net/ipv4/icmp_ratemask"
> +#define PATH_NET_IPV4_ICMP_ECHO_IGNORE_ALL	"/proc/sys/net/ipv4/icmp_echo_ignore_all"
> +#define PATH_NET_IPV4_ICMP_MSGS_BURST		"/proc/sys/net/ipv4/icmp_msgs_burst"
> +#define PATH_NET_IPV4_TCP_PROBE_INTERVAL	"/proc/sys/net/ipv4/tcp_probe_interval"
> +#define PATH_NET_IPV4_TCP_KEEPALIVE_TIME	"/proc/sys/net/ipv4/tcp_keepalive_time"
> +#define PATH_NET_IPV4_TCP_NOTSENT_LOWAT		"/proc/sys/net/ipv4/tcp_notsent_lowat"
> +#define PATH_NET_IPV4_IP_LOCAL_RESERVED_PORTS	"/proc/sys/net/ipv4/ip_local_reserved_ports"

Maybe we can drop the NET here as well, the IPV4 is descriptive enough.
e.g. PATH_IPV4_ICMP_RATELIMIT


Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
