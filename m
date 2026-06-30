Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8848C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 16:53:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0AA13E4EF6
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 18:53:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2EBB3E4B09
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 18:53:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1B80D1000487
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 18:53:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 72525736BD;
 Tue, 30 Jun 2026 16:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782838405;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GsyG8rO2/j84HXDRqx3CMkvIpdVTzdHdKBYQa+jDMPE=;
 b=bHCeto9uS3HQ6mjdhtaJwJi4q3kmlEVGRFlM6O0Nt7xWV7RyidoXaQz2OrAiZViwerc0iu
 uDvN4S4NT4r93T+obpvXWXR1AVD1GwIfe8qqBTQK6gAFiKoBMioHnF0RTC55cyG4C7kOLa
 NiyEcrEjSFiIXCq6b/8kZbmttUU+hcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782838405;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GsyG8rO2/j84HXDRqx3CMkvIpdVTzdHdKBYQa+jDMPE=;
 b=LfKEKxObzyL/qW9Og2IdNdzq8wYICO6OCb81ScrPAydvJpGSPc+JNiajR6YWeoEJU0saOz
 FwUCl5z8lRxsLLBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782838405;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GsyG8rO2/j84HXDRqx3CMkvIpdVTzdHdKBYQa+jDMPE=;
 b=bHCeto9uS3HQ6mjdhtaJwJi4q3kmlEVGRFlM6O0Nt7xWV7RyidoXaQz2OrAiZViwerc0iu
 uDvN4S4NT4r93T+obpvXWXR1AVD1GwIfe8qqBTQK6gAFiKoBMioHnF0RTC55cyG4C7kOLa
 NiyEcrEjSFiIXCq6b/8kZbmttUU+hcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782838405;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GsyG8rO2/j84HXDRqx3CMkvIpdVTzdHdKBYQa+jDMPE=;
 b=LfKEKxObzyL/qW9Og2IdNdzq8wYICO6OCb81ScrPAydvJpGSPc+JNiajR6YWeoEJU0saOz
 FwUCl5z8lRxsLLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2536C779A8;
 Tue, 30 Jun 2026 16:53:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2G9VBYX0Q2pYEQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jun 2026 16:53:25 +0000
Date: Tue, 30 Jun 2026 18:53:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260630165315.GB474697@pevik>
References: <20260630-landlock_udp-v1-1-21a740209f70@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260630-landlock_udp-v1-1-21a740209f70@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] landlock08: add UDP bind/connect test variants
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> Extend the network test to cover the LANDLOCK_ACCESS_NET_BIND_UDP and
> LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP access rights introduced with
> Landlock ABI v10, alongside the existing TCP rights.

Implements: https://github.com/linux-test-project/ltp/issues/1333

Also why not to mention that it's from kernel 7.2? Saves test reviewers to
search for it.

...
> +++ b/testcases/kernel/syscalls/landlock/landlock08.c
> @@ -5,67 +5,103 @@

>  /*\
>   * Verify the landlock support for bind()/connect() syscalls in IPV4 and IPV6
> - * protocols. In particular, check that bind() is assigning the address only on
> - * the TCP port enforced by LANDLOCK_ACCESS_NET_BIND_TCP and check that
> - * connect() is connecting only to a specific TCP port enforced by
> - * LANDLOCK_ACCESS_NET_CONNECT_TCP.
> + * protocols, using both TCP and UDP. In particular, check that bind() is
> + * assigning the address only on the port enforced by
> + * LANDLOCK_ACCESS_NET_BIND_TCP / LANDLOCK_ACCESS_NET_BIND_UDP and check that
> + * connect() is connecting only to a specific port enforced by
> + * LANDLOCK_ACCESS_NET_CONNECT_TCP / LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP.
> + *
> + * TCP rules are available since Landlock ABI v4, while UDP rules are available
> + * since Landlock ABI v10.
Also here I'd add the versions.

>   *
>   * [Algorithm]
>   *
> - * Repeat the following procedure for IPV4 and IPV6:
> + * Repeat the following procedure for {TCP, UDP} x {IPV4, IPV6}:
>   *
>   * - create a socket on PORT1, bind() it and check if it passes
> - * - enforce the current sandbox with LANDLOCK_ACCESS_NET_BIND_TCP on PORT1
> + * - enforce the current sandbox with the BIND access right on PORT1
>   * - create a socket on PORT1, bind() it and check if it passes
>   * - create a socket on PORT2, bind() it and check if it fails
>   *
>   * - create a server listening on PORT1
>   * - create a socket on PORT1, connect() to it and check if it passes
> - * - enforce the current sandbox with LANDLOCK_ACCESS_NET_CONNECT_TCP on PORT1
> + * - enforce the current sandbox with the CONNECT access right on PORT1
>   * - create a socket on PORT1, connect() to it and check if it passes
>   * - create a socket on PORT2, connect() to it and check if it fails
>   */

>  #include "landlock_common.h"

> -static int variants[] = {
> -	AF_INET,
> -	AF_INET6,
> +static struct tcase {
> +	int family;
> +	int type;
> +	uint64_t bind_access;
> +	uint64_t connect_access;
> +	int min_abi;
> +	const char *desc;
> +} variants[] = {
> +	{
> +		AF_INET, SOCK_STREAM,
> +		LANDLOCK_ACCESS_NET_BIND_TCP,
> +		LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +		4, "TCP/IPV4"
very nit: IPv4
> +	},
> +	{
> +		AF_INET6, SOCK_STREAM,
> +		LANDLOCK_ACCESS_NET_BIND_TCP,
> +		LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +		4, "TCP/IPV6"
IPv6
(and below)

> +	},
> +	{
> +		AF_INET, SOCK_DGRAM,
> +		LANDLOCK_ACCESS_NET_BIND_UDP,
> +		LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
> +		10, "UDP/IPV4"
> +	},
> +	{
> +		AF_INET6, SOCK_DGRAM,
> +		LANDLOCK_ACCESS_NET_BIND_UDP,
> +		LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
> +		10, "UDP/IPV6"
> +	},
>  };
...

> -static void test_connect(const int addr_family, const in_port_t port,
> +static void test_connect(const struct tcase *tc, const in_port_t port,
>  	const int exp_err)
>  {
>  	struct socket_data socket;
>  	struct sockaddr *addr = NULL;

> -	create_socket(&socket, addr_family, port);
> -	getsocket_addr(&socket, addr_family, &addr);
> +	create_socket(&socket, tc->family, port, tc->type);
> +	getsocket_addr(&socket, tc->family, &addr);

>  	if (exp_err) {
>  		TST_EXP_FAIL(
> @@ -102,13 +138,14 @@ static void test_connect(const int addr_family, const in_port_t port,
>  	SAFE_CLOSE(socket.fd);
>  }

> -static int check_ipv6_support(void)
> +static int check_family_support(const struct tcase *tc)
>  {
>  	int fd;

> -	fd = socket(AF_INET6, SOCK_STREAM, 0);
> +	fd = socket(tc->family, tc->type, 0);
>  	if (fd == -1 && errno == EAFNOSUPPORT) {
> -		tst_res(TCONF, "IPv6 not supported in kernel");
> +		tst_res(TCONF, "%s address family not supported in kernel",
> +			tc->family == AF_INET ? "IPV4" : "IPV6");
+1 (but again very nit IPv[46])

...
>  static void setup(void)
>  {
> -	if (verify_landlock_is_enabled() < 4)
> +	landlock_abi = verify_landlock_is_enabled();
> +	if (landlock_abi < 4)
>  		tst_brk(TCONF, "Landlock network is not supported");

>  	addr_port = TST_GET_UNUSED_PORT(AF_INET, SOCK_STREAM);

Also agent complains about checking UDP port separately seems to be valid to me.

The rest LGTM.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
