Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA81CDB47E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 14:54:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BC533CE72E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 16:54:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00F003C8889
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 16:53:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E41271A0196F
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 16:53:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C42491F74C;
 Thu, 12 Oct 2023 14:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697122433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6wF2TnpDOH1vez+au+uhgBsKs6XXHM3tYC7kg6u5rSM=;
 b=Qp3HQih3kj1vOHENm0o5ihqrr8ngtUfeNPM3Ebf1evkR59lfvD3hy9NVMKr7UqoHMidF51
 BloQh2W1uiGd4++qUsdZ/slOOjRiHamIKMU6le1xzu+WyUzgvlUixRaLXxh6aOlLa4Edlo
 gZxY7Ha3/9kzTUF0/dbE12R00mxk67k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697122433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6wF2TnpDOH1vez+au+uhgBsKs6XXHM3tYC7kg6u5rSM=;
 b=z7uwGpSfppkg++B648TrspouKQYZHVr9pom+g+DOwiPXxTOGeSpwhVrNOCtqgbaV1LDJl5
 PYSzPgnHJ/Bis8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE041139F9;
 Thu, 12 Oct 2023 14:53:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hL0DKYEIKGWpIwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 Oct 2023 14:53:53 +0000
Date: Thu, 12 Oct 2023 16:54:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <ZSgIrcu2A5eC_OvZ@yuki>
References: <20231012103916.30712-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231012103916.30712-1-rpalethorpe@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-5.78 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.18)[96.08%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add setsockopt10 TLS ULP UAF CVE-2023-0461
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
> +#include "tst_test.h"
> +
> +#ifdef HAVE_LINUX_TLS_H
> +
> +#include <linux/tls.h>
> +#include "netinet/in.h"
> +#include "netinet/tcp.h"
> +#include "tst_checkpoint.h"
> +#include "tst_net.h"
> +#include "tst_safe_net.h"
> +#include "tst_taint.h"
> +
> +static struct tls12_crypto_info_aes_gcm_128 opts = {
> +	.info = {
> +		.version = TLS_1_2_VERSION,
> +		.cipher_type = TLS_CIPHER_AES_GCM_128,
> +	},
> +	.iv = { 'i', 'v' },
> +	.key = { 'k', 'e', 'y' },
> +	.salt = { 's', 'a', 'l', 't' },
> +	.rec_seq = { 'r', 'e', 'c', 's' },
> +};
> +
> +static struct sockaddr_in tcp0_addr, tcp1_addr;
> +static const struct sockaddr unspec_addr = {
> +	.sa_family = AF_UNSPEC
> +};
> +
> +static int tcp0_sk, tcp1_sk, tcp2_sk, tcp3_sk;
> +
> +static void setup(void)
> +{
> +	tst_init_sockaddr_inet(&tcp0_addr, "127.0.0.1", 0x7c90);
> +	tst_init_sockaddr_inet(&tcp1_addr, "127.0.0.1", 0x7c91);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (tcp0_sk > 0)
> +		SAFE_CLOSE(tcp0_sk);
> +	if (tcp1_sk > 0)
> +		SAFE_CLOSE(tcp1_sk);
> +	if (tcp2_sk > 0)
> +		SAFE_CLOSE(tcp2_sk);
> +	if (tcp3_sk > 0)
> +		SAFE_CLOSE(tcp3_sk);
> +}
> +
> +static void child(void)
> +{
> +	tst_res(TINFO, "child: Listen for tcp1 connection");
> +	tcp0_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> +	SAFE_BIND(tcp0_sk, (struct sockaddr *)&tcp0_addr, sizeof(tcp0_addr));
> +	SAFE_LISTEN(tcp0_sk, 1);
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	tcp3_sk = SAFE_ACCEPT(tcp0_sk, NULL, 0);
> +	TST_CHECKPOINT_WAIT(1);
> +	SAFE_CLOSE(tcp3_sk);
> +	SAFE_CLOSE(tcp0_sk);
> +
> +	tcp3_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> +	TST_CHECKPOINT_WAIT(2);
> +
> +	tst_res(TINFO, "child: connect for tcp2 connection");
> +	TEST(connect(tcp3_sk, (struct sockaddr *)&tcp1_addr, sizeof(tcp1_addr)));
> +
> +	if (TST_RET == -1) {
> +		tst_res(TINFO | TTERRNO, "child: could not connect to tcp1");
> +		return;
> +	}
> +
> +	TST_CHECKPOINT_WAIT(3);
> +}
> +
> +static void run(void)
> +{
> +	const pid_t child_pid = SAFE_FORK();
> +
> +	if (child_pid == 0) {
> +		child();
> +		return;
> +	}
> +
> +	tcp1_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	tst_res(TINFO, "parent: Connect for tcp0 connection");
> +	SAFE_CONNECT(tcp1_sk, (struct sockaddr *)&tcp0_addr, sizeof(tcp0_addr));
> +	TEST(setsockopt(tcp1_sk, SOL_TCP, TCP_ULP, "tls", 3));
> +
> +	if (TST_RET == -1 && TST_ERR == ENOENT)
> +		tst_brk(TCONF | TTERRNO, "parent: setsockopt failed: The TLS module is probably not loaded");

Should we set .needs_drivers for the test so that it only attempts to
run either if TLS is compiled in or could be modprobed as a module?

> +	else if (TST_RET == -1)
> +		tst_brk(TBROK | TTERRNO, "parent: setsockopt failed");
> +
> +	SAFE_SETSOCKOPT(tcp1_sk, SOL_TLS, TLS_TX, &opts, sizeof(opts));
> +	TST_CHECKPOINT_WAKE(1);
> +
> +	tst_res(TINFO, "parent: Disconnect by setting unspec address");
> +	SAFE_CONNECT(tcp1_sk, &unspec_addr, sizeof(unspec_addr));
> +	SAFE_BIND(tcp1_sk, (struct sockaddr *)&tcp1_addr, sizeof(tcp1_addr));
> +
> +	TEST(listen(tcp1_sk, 1));
> +
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EINVAL)
> +			tst_res(TPASS | TTERRNO, "parent: Can't listen on disconnected TLS socket");
> +		else
> +			tst_res(TCONF | TTERRNO, "parent: Can't listen on disconnected TLS socket, but the errno is not EINVAL as expected");
> +
> +		TST_CHECKPOINT_WAKE(2);
> +		goto out;
> +	}
> +
> +	tst_res(TINFO, "parent: Can listen on disconnected TLS socket");
> +	TST_CHECKPOINT_WAKE(2);
> +
> +	tcp2_sk = SAFE_ACCEPT(tcp1_sk, NULL, 0);
> +	SAFE_CLOSE(tcp2_sk);
> +
> +	tst_res(TINFO, "parent: Attempting double free, because we set cipher options this should result in an crash");
> +	SAFE_CLOSE(tcp1_sk);
> +
> +	TST_CHECKPOINT_WAKE(3);
> +	usleep(0);

Did you forget this here?

> +	if (tst_taint_check())
> +		tst_res(TFAIL, "Kernel is tainted");
> +	else
> +		tst_res(TCONF, "No kernel taint or crash, maybe the kernel can clone the TLS-ULP context now?");

If you set up .taint_check this is going to be redundant since we print
TFAIL in the test library in that case.

> +out:
> +	tst_reap_children();
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.taint_check = TST_TAINT_W | TST_TAINT_D,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_TLS",
> +		NULL
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "2c02d41d71f90"},
> +		{"CVE", "2023-0461"},
> +		{}
> +	}
> +};
> +
> +#else
> +
> +TST_TEST_TCONF("linux/tls.h missing, we assume your system is too old");
> +
> +#endif
> -- 
> 2.40.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
