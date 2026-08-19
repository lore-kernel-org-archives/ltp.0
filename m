Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D5EC5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 02:13:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB2C73CD59B
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 04:13:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67D343CC0A7
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 04:13:18 +0200 (CEST)
Received: from mta1.migadu.com (out-138.mta1.migadu.com
 [IPv6:2001:41d0:203:375::8a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D449C1000900
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 04:13:16 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=UVmUPgXT88Pk1tJD7cz/UTa+WrG5AgcY/tGXuRWqeRI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787105596; v=1; x=1787710396;
 b=HKNlcN3dmuosehAK3uM79468W11ZzKnWDj8+RCygokykttjsuOQKj2DJAhvb8NOMn+FWtdIe
 Zk5X5hvKS9vqrGwn8ZPdUDkvw76vw0iw6EiSrvZxDnnVA1WcIowjcHpxFEWo6ttWdT1mUpILeLf
 8RZSd8cBzOJks/tS3Cmljis4=
X-Envelope-To: ltp@lists.linux.it
Received: from localhost (60.247.5.98)
 by smtp.migadu.com with ESMTPS id 7877aff30362282f;
 Wed, 19 Aug 2026 02:13:16 +0000
X-Migadu-Flow: FLOW_OUT
Date: Wed, 19 Aug 2026 10:13:12 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aoUROJGM1mDGTqjA@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20260818141311.1265557-1-chrubis@suse.cz>
 <20260818141311.1265557-24-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260818141311.1265557-24-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> +static void run(void)
> +{
> +	struct netdev_state s0, s1, s2;
> +
> +	read_state(&s0);
> +	check_state(&s0, 1, "up", "tun attached and up");
> +
> +	SAFE_CLOSE(tun_fd);

Here I got intermittent fails in local test:

  sys_net_common.h:32: TFAIL: st->operstate (up) != operstate (down)

The possible reason is kernel asynchronous update race condition.
The test reads operstate immediately after closing the FD, catching
the stale "up" state before the kernel's background workqueue has
time to update it to "down".

Maybe we can add a polling mechanism with a timeout to wait for
the operstate to transition.

--- a/testcases/kernel/sysfs/class/net/sys_net04.c
+++ b/testcases/kernel/sysfs/class/net/sys_net04.c
@@ -153,6 +153,12 @@ static void check_tun_vs_tap_type(void)
        TST_SYSFS_EXP_EQ_LI(6, "/sys/class/net/" IFNAME_TAP "/addr_len");
 }

+static int check_operstate(struct netdev_state *st, const char *expected_state)
+{
+       read_state(st);
+       return strcmp(st->operstate, expected_state);
+}
+
 static void run(void)
 {
        struct netdev_state s0, s1, s2;
@@ -161,12 +167,14 @@ static void run(void)
        check_state(&s0, 1, "up", "tun attached and up");

        SAFE_CLOSE(tun_fd);
+       TST_RETRY_FUNC(check_operstate(&s1, "down"), !);
        read_state(&s1);
        check_state(&s1, 0, "down", "tun detached");
        check_state_delta(&s0, &s1, 0, 1, "detach transition");

        tun_fd = open_tun(IFNAME_TUN, IFF_TUN | IFF_NO_PI);
        read_state(&s2);
+       TST_RETRY_FUNC(check_operstate(&s2, "up"), !);
        check_state(&s2, 1, "up", "tun reattached");
        check_state_delta(&s1, &s2, 1, 0, "reattach transition");


> +	read_state(&s1);
> +	check_state(&s1, 0, "down", "tun detached");
> +	check_state_delta(&s0, &s1, 0, 1, "detach transition");
> +
> +	tun_fd = open_tun(IFNAME_TUN, IFF_TUN | IFF_NO_PI);
> +	read_state(&s2);
> +	check_state(&s2, 1, "up", "tun reattached");

Here also fail:

  sys_net_common.h:32: TFAIL: st->operstate (down) != operstate (up)


> +	check_state_delta(&s1, &s2, 1, 0, "reattach transition");
> +
> +	check_mtu_valid(68);
> +	check_mtu_valid(1500);
> +	check_mtu_valid(9000);
> +	check_mtu_valid(65535);
> +	check_mtu_invalid("-1");
> +	check_mtu_invalid("0");
> +	check_mtu_invalid("67");
> +	check_mtu_invalid("70000");
> +
> +	check_tun_flags();
> +	check_owner_group();
> +	check_tun_vs_tap_type();
> +}

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
