Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD17C5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 02:28:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9740A3CD581
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 04:28:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E2473CC6AC
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 04:28:06 +0200 (CEST)
Received: from mta1.migadu.com (out-91.mta1.migadu.com
 [IPv6:2001:41d0:203:375::5b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3062A1400C76
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 04:28:03 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=asq01PCZBjU1DW7WxYFLqklbxqKwuSVzGZwaTiAjHcs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787106480; v=1; x=1787711280;
 b=Qe0mvR80tNwDuyxYSbR/yBlziUtYuBMUFhURwnV2eSXU36713CCQNJ50yFyCK/stFHnKN2cQ
 3aCv+ZHj5JTaquq9SbuNWrs6C5MzPcuNASiUq/n/FQqe08plSRvQFE3iArdDkMNZ49Yb1JtUawe
 Bgqw52DXe9iG+Y+/STlKiQcY=
X-Envelope-To: ltp@lists.linux.it
Received: from localhost (60.247.5.98)
 by smtp.migadu.com with ESMTPS id b577f32cfaf19201;
 Wed, 19 Aug 2026 02:27:59 +0000
X-Migadu-Flow: FLOW_OUT
Date: Wed, 19 Aug 2026 10:27:55 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <aoUUq8RtL_gWM8XT@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20260818141311.1265557-1-chrubis@suse.cz>
 <20260818141311.1265557-24-chrubis@suse.cz>
 <aoUROJGM1mDGTqjA@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aoUROJGM1mDGTqjA@linux.dev>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 23/31] testcases: sysfs: Add sys_net04
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Maybe we can add a polling mechanism with a timeout to wait for
> the operstate to transition.
> 
> --- a/testcases/kernel/sysfs/class/net/sys_net04.c
> +++ b/testcases/kernel/sysfs/class/net/sys_net04.c
> @@ -153,6 +153,12 @@ static void check_tun_vs_tap_type(void)
>         TST_SYSFS_EXP_EQ_LI(6, "/sys/class/net/" IFNAME_TAP "/addr_len");
>  }
> 
> +static int check_operstate(struct netdev_state *st, const char *expected_state)
> +{
> +       read_state(st);
> +       return strcmp(st->operstate, expected_state);
> +}
> +
>  static void run(void)
>  {
>         struct netdev_state s0, s1, s2;
> @@ -161,12 +167,14 @@ static void run(void)
>         check_state(&s0, 1, "up", "tun attached and up");
> 
>         SAFE_CLOSE(tun_fd);
> +       TST_RETRY_FUNC(check_operstate(&s1, "down"), !);

Using TST_RETVAL_EQ0 is easier to read:

  TST_RETRY_FUNC(check_operstate(&s1, "down"), TST_RETVAL_EQ0);

>         read_state(&s1);
>         check_state(&s1, 0, "down", "tun detached");
>         check_state_delta(&s0, &s1, 0, 1, "detach transition");
> 
>         tun_fd = open_tun(IFNAME_TUN, IFF_TUN | IFF_NO_PI);
>         read_state(&s2);
> +       TST_RETRY_FUNC(check_operstate(&s2, "up"), !);

  TST_RETRY_FUNC(check_operstate(&s2, "up"), TST_RETVAL_EQ0);

>         check_state(&s2, 1, "up", "tun reattached");
>         check_state_delta(&s1, &s2, 1, 0, "reattach transition");


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
