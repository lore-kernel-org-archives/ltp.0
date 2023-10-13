Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F67FCDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 08:32:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1487C3CD3CD
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 10:32:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EDC63C8894
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 10:31:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F05E814098A3
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 10:31:53 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5199C1FD82
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 08:31:53 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id F37962CB45;
 Fri, 13 Oct 2023 08:31:52 +0000 (UTC)
References: <20231012103916.30712-1-rpalethorpe@suse.com>
 <ZSgIrcu2A5eC_OvZ@yuki>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Oct 2023 08:45:08 +0100
Organization: Linux Private Site
In-reply-to: <ZSgIrcu2A5eC_OvZ@yuki>
Message-ID: <87y1g6ylc9.fsf@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5199C1FD82
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> +#include "tst_test.h"
>> +
>> +#ifdef HAVE_LINUX_TLS_H
>> +
>> +#include <linux/tls.h>
>> +#include "netinet/in.h"
>> +#include "netinet/tcp.h"
>> +#include "tst_checkpoint.h"
>> +#include "tst_net.h"
>> +#include "tst_safe_net.h"
>> +#include "tst_taint.h"
>> +
>> +static struct tls12_crypto_info_aes_gcm_128 opts = {
>> +	.info = {
>> +		.version = TLS_1_2_VERSION,
>> +		.cipher_type = TLS_CIPHER_AES_GCM_128,
>> +	},
>> +	.iv = { 'i', 'v' },
>> +	.key = { 'k', 'e', 'y' },
>> +	.salt = { 's', 'a', 'l', 't' },
>> +	.rec_seq = { 'r', 'e', 'c', 's' },
>> +};
>> +
>> +static struct sockaddr_in tcp0_addr, tcp1_addr;
>> +static const struct sockaddr unspec_addr = {
>> +	.sa_family = AF_UNSPEC
>> +};
>> +
>> +static int tcp0_sk, tcp1_sk, tcp2_sk, tcp3_sk;
>> +
>> +static void setup(void)
>> +{
>> +	tst_init_sockaddr_inet(&tcp0_addr, "127.0.0.1", 0x7c90);
>> +	tst_init_sockaddr_inet(&tcp1_addr, "127.0.0.1", 0x7c91);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (tcp0_sk > 0)
>> +		SAFE_CLOSE(tcp0_sk);
>> +	if (tcp1_sk > 0)
>> +		SAFE_CLOSE(tcp1_sk);
>> +	if (tcp2_sk > 0)
>> +		SAFE_CLOSE(tcp2_sk);
>> +	if (tcp3_sk > 0)
>> +		SAFE_CLOSE(tcp3_sk);
>> +}
>> +
>> +static void child(void)
>> +{
>> +	tst_res(TINFO, "child: Listen for tcp1 connection");
>> +	tcp0_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
>> +	SAFE_BIND(tcp0_sk, (struct sockaddr *)&tcp0_addr, sizeof(tcp0_addr));
>> +	SAFE_LISTEN(tcp0_sk, 1);
>> +	TST_CHECKPOINT_WAKE(0);
>> +
>> +	tcp3_sk = SAFE_ACCEPT(tcp0_sk, NULL, 0);
>> +	TST_CHECKPOINT_WAIT(1);
>> +	SAFE_CLOSE(tcp3_sk);
>> +	SAFE_CLOSE(tcp0_sk);
>> +
>> +	tcp3_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
>> +	TST_CHECKPOINT_WAIT(2);
>> +
>> +	tst_res(TINFO, "child: connect for tcp2 connection");
>> +	TEST(connect(tcp3_sk, (struct sockaddr *)&tcp1_addr, sizeof(tcp1_addr)));
>> +
>> +	if (TST_RET == -1) {
>> +		tst_res(TINFO | TTERRNO, "child: could not connect to tcp1");
>> +		return;
>> +	}
>> +
>> +	TST_CHECKPOINT_WAIT(3);
>> +}
>> +
>> +static void run(void)
>> +{
>> +	const pid_t child_pid = SAFE_FORK();
>> +
>> +	if (child_pid == 0) {
>> +		child();
>> +		return;
>> +	}
>> +
>> +	tcp1_sk = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
>> +	TST_CHECKPOINT_WAIT(0);
>> +
>> +	tst_res(TINFO, "parent: Connect for tcp0 connection");
>> +	SAFE_CONNECT(tcp1_sk, (struct sockaddr *)&tcp0_addr, sizeof(tcp0_addr));
>> +	TEST(setsockopt(tcp1_sk, SOL_TCP, TCP_ULP, "tls", 3));
>> +
>> +	if (TST_RET == -1 && TST_ERR == ENOENT)
>> +		tst_brk(TCONF | TTERRNO, "parent: setsockopt failed: The TLS module is probably not loaded");
>
> Should we set .needs_drivers for the test so that it only attempts to
> run either if TLS is compiled in or could be modprobed as a module?

Yes if it worked :-D, although I would still want to keep the above check. I
tried it and noticed a number of problems.

On NixOS:

$ ./setsockopt10
tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
tst_kernel.c:110: TWARN: expected file /lib/modules/6.5.5/modules.dep does not exist or not a file
tst_kernel.c:110: TWARN: expected file /lib/modules/6.5.5/modules.builtin does not exist or not a file
tst_test.c:1195: TCONF: tls driver not available
$ lsmod | grep tls
tls                   151552  0

We have a special switch for Android which disables the check, but it is
not just Android. Granted NixOS is really wierd by desktop standards,
but we have ALP and embedded systems to think about.

AFAICT the test library does not do a modprobe if the driver is
missing. Some tests (e.g. zram, CAN) do that and then claim to require
modprobe. This is not good, those tests do not need modprobe if the
module is loaded or compiled in.

Perhaps if the check in tst_kernel fails for any reason we could just do
a modprobe (or use the configured kernel usermode helper if it is
set). If that fails we just carry on, like for Android. That's a
seperate patch though IMO. Once we have a solution for that, this test
can have needs_drivers added.

>
>> +	else if (TST_RET == -1)
>> +		tst_brk(TBROK | TTERRNO, "parent: setsockopt failed");
>> +
>> +	SAFE_SETSOCKOPT(tcp1_sk, SOL_TLS, TLS_TX, &opts, sizeof(opts));
>> +	TST_CHECKPOINT_WAKE(1);
>> +
>> +	tst_res(TINFO, "parent: Disconnect by setting unspec address");
>> +	SAFE_CONNECT(tcp1_sk, &unspec_addr, sizeof(unspec_addr));
>> +	SAFE_BIND(tcp1_sk, (struct sockaddr *)&tcp1_addr, sizeof(tcp1_addr));
>> +
>> +	TEST(listen(tcp1_sk, 1));
>> +
>> +	if (TST_RET == -1) {
>> +		if (TST_ERR == EINVAL)
>> +			tst_res(TPASS | TTERRNO, "parent: Can't listen on disconnected TLS socket");
>> +		else
>> + tst_res(TCONF | TTERRNO, "parent: Can't listen on disconnected TLS
>> socket, but the errno is not EINVAL as expected");
>> +
>> +		TST_CHECKPOINT_WAKE(2);
>> +		goto out;
>> +	}
>> +
>> +	tst_res(TINFO, "parent: Can listen on disconnected TLS socket");
>> +	TST_CHECKPOINT_WAKE(2);
>> +
>> +	tcp2_sk = SAFE_ACCEPT(tcp1_sk, NULL, 0);
>> +	SAFE_CLOSE(tcp2_sk);
>> +
>> + tst_res(TINFO, "parent: Attempting double free, because we set
>> cipher options this should result in an crash");
>> +	SAFE_CLOSE(tcp1_sk);
>> +
>> +	TST_CHECKPOINT_WAKE(3);
>> +	usleep(0);
>
> Did you forget this here?

It's supposed to give the kernel chance to propagate the taint or
panic. Which stops it from printing there was no kernel taint in
parallel with the kernel splat. It appears to work on my test system.

>
>> +	if (tst_taint_check())
>> +		tst_res(TFAIL, "Kernel is tainted");
>> +	else
>> +		tst_res(TCONF, "No kernel taint or crash, maybe the kernel can clone the TLS-ULP context now?");
>
> If you set up .taint_check this is going to be redundant since we print
> TFAIL in the test library in that case.

In that case we can unconditionally do TCONF and it'll be overridden by
fail and the resulting panic. Or it will be prevented by the panic.

>
>> +out:
>> +	tst_reap_children();
>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_all = run,
>> +	.forks_child = 1,
>> +	.needs_checkpoints = 1,
>> +	.taint_check = TST_TAINT_W | TST_TAINT_D,
>> +	.needs_kconfigs = (const char *[]) {
>> +		"CONFIG_TLS",
>> +		NULL
>> +	},
>> +	.tags = (const struct tst_tag[]) {
>> +		{"linux-git", "2c02d41d71f90"},
>> +		{"CVE", "2023-0461"},
>> +		{}
>> +	}
>> +};
>> +
>> +#else
>> +
>> +TST_TEST_TCONF("linux/tls.h missing, we assume your system is too old");
>> +
>> +#endif
>> -- 
>> 2.40.1
>> 
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
