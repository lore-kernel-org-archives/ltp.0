Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDDBCD4F24
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 15:00:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFC913E5406
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 17:00:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 777A43D86E3
 for <ltp@lists.linux.it>; Wed, 13 May 2026 17:00:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 863E31400963
 for <ltp@lists.linux.it>; Wed, 13 May 2026 17:00:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E79CA7614E;
 Wed, 13 May 2026 15:00:05 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2F93593A9;
 Wed, 13 May 2026 15:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NmdrMfWRBGqhOwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 13 May 2026 15:00:05 +0000
Date: Wed, 13 May 2026 17:00:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <agSR86ObHrfu7mjP@yuki.lan>
References: <20260513-fragnesia-v1-1-80c5b3b09005@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260513-fragnesia-v1-1-80c5b3b09005@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: E79CA7614E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sockets/xfrm02: Add ESP-in-TCP page cache
 corruption test
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +#include "tst_net.h"
> +#include "tst_netdevice.h"
> +#include "lapi/tcp.h"
> +#include "lapi/splice.h"
> +
> +#define TESTFILE "pagecache_test"
> +#define DATA_SIZE 4096
> +
> +#define SPI 0x100
> +#define TCP_PORT 5556
> +#define IV_LEN 8
> +#define ESP_HDR_SIZE 16
> +#define AES_KEYLEN 16
> +#define SALT_LEN 4
> +#define KEYTOTAL (AES_KEYLEN + SALT_LEN)
> +
> +/* ESP-in-TCP frame prefix: 2-byte length + ESP header */
> +#define PREFIX_SIZE (2 + ESP_HDR_SIZE)
> +
> +#define XFRM_CMD \
> +	"ip xfrm state add" \
> +	" src ::1 dst ::1" \
> +	" proto esp spi 0x%08x" \
> +	" encap espintcp %d %d ::" \
> +	" aead 'rfc4106(gcm(aes))' %s 128" \
> +	" mode transport"
> +
> +static const uint8_t aead_key[KEYTOTAL] = {
> +	0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
> +	0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
> +	0x01, 0x02, 0x03, 0x04
> +};
> +
> +static uint8_t original[DATA_SIZE];
> +static int file_fd = -1;
> +static int srv_fd = -1;
> +
> +static void setup(void)
> +{
> +	char keyhex[KEYTOTAL * 2 + 3];
> +	char cmd[512];
> +	int i, ret;
> +
> +	tst_setup_netns();
> +	NETDEV_SET_STATE("lo", 1);
> +
> +	keyhex[0] = '0';
> +	keyhex[1] = 'x';
> +	for (i = 0; i < KEYTOTAL; i++)
> +		sprintf(keyhex + 2 + i * 2, "%02x", aead_key[i]);
> +
> +	snprintf(cmd, sizeof(cmd), XFRM_CMD, SPI, TCP_PORT, TCP_PORT, keyhex);
> +
> +	ret = tst_system(cmd);
> +	if (ret)
> +		tst_brk(TBROK, "Failed to install xfrm ESP-in-TCP state");

I do not like this part that much. We have tst_cmd() that is better than
tst_system() and also netlink library which could probably do the same.

Given that this is important we can go with this for now, but I would
like to see it fixed later.

> +	for (i = 0; i < DATA_SIZE; i++)
> +		original[i] = (uint8_t)(i & 0xff);
> +}
> +
> +static void try_corrupt(void)
> +{
> +	struct sockaddr_in6 addr = {
> +		.sin6_family = AF_INET6,
> +		.sin6_addr = IN6ADDR_LOOPBACK_INIT,
> +		.sin6_port = htons(TCP_PORT),
> +	};
> +	uint8_t prefix[PREFIX_SIZE];
> +	uint16_t frame_len;
> +	uint32_t spi_net, seq_net;
> +	char ulp[] = "espintcp";
> +	char drain;
> +	int acc_fd;
> +	loff_t off;
> +	pid_t pid;
> +	int status;
> +
> +	frame_len = htons(PREFIX_SIZE + DATA_SIZE);
> +	memcpy(prefix, &frame_len, 2);
> +
> +	spi_net = htonl(SPI);
> +	memcpy(prefix + 2, &spi_net, 4);
> +
> +	seq_net = htonl(1);
> +	memcpy(prefix + 6, &seq_net, 4);
> +
> +	memset(prefix + 10, 0xcc, IV_LEN);
> +
> +	srv_fd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, 0);
> +	SAFE_SETSOCKOPT_INT(srv_fd, SOL_SOCKET, SO_REUSEADDR, 1);
> +	SAFE_BIND(srv_fd, (struct sockaddr *)&addr, sizeof(addr));
> +	SAFE_LISTEN(srv_fd, 1);
> +
> +	pid = SAFE_FORK();
> +
> +	if (!pid) {
> +		int cli_fd, pipefd[2];
> +
> +		SAFE_CLOSE(srv_fd);
> +
> +		cli_fd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, 0);
> +		SAFE_SETSOCKOPT_INT(cli_fd, IPPROTO_TCP, TCP_NODELAY, 1);
> +		SAFE_CONNECT(cli_fd, (struct sockaddr *)&addr, sizeof(addr));
> +
> +		SAFE_SEND(1, cli_fd, prefix, sizeof(prefix), 0);
> +		SAFE_PIPE(pipefd);
> +
> +		off = 0;
> +		SAFE_SPLICE(file_fd, &off, pipefd[1], NULL, DATA_SIZE, 0);
> +
> +		/*
> +		 * Splice pipe into TCP socket. The kernel uses
> +		 * MSG_SPLICE_PAGES to keep page cache references in
> +		 * the skb. On loopback the receiver's ESP handler may
> +		 * decrypt in-place, corrupting the page cache. May
> +		 * fail on patched kernels.
> +		 */
> +		splice(pipefd[0], NULL, cli_fd, NULL, DATA_SIZE, 0);
> +
> +		SAFE_CLOSE(pipefd[0]);
> +		SAFE_CLOSE(pipefd[1]);
> +		SAFE_CLOSE(cli_fd);
> +
> +		TST_CHECKPOINT_WAKE(0);
> +		exit(0);
> +	}
> +
> +	acc_fd = SAFE_ACCEPT(srv_fd, NULL, NULL);
> +	SAFE_CLOSE(srv_fd);
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	SAFE_SETSOCKOPT(acc_fd, IPPROTO_TCP, TCP_ULP, ulp, sizeof(ulp));
> +
> +	/* Kick the espintcp strparser to process buffered ESP data */
> +	SAFE_RECV(0, acc_fd, &drain, 1, 0);
> +
> +	SAFE_CLOSE(acc_fd);
> +	SAFE_WAITPID(pid, &status, 0);

This WAITPID shouldn't be here, it will mask any errors from the SAFE_
macros in the child.

> +}
> +
> +static void run(void)
> +{
> +	uint8_t readback[DATA_SIZE];
> +
> +	file_fd = SAFE_OPEN(TESTFILE, O_WRONLY | O_CREAT, 0444);
> +	SAFE_WRITE(SAFE_WRITE_ALL, file_fd, original, DATA_SIZE);
> +	SAFE_CLOSE(file_fd);
> +
> +	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
> +	try_corrupt();
> +	SAFE_CLOSE(file_fd);
> +
> +	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
> +	SAFE_READ(1, file_fd, readback, sizeof(readback));
> +	SAFE_CLOSE(file_fd);
> +
> +	if (memcmp(readback, original, DATA_SIZE) != 0)
> +		tst_res(TFAIL, "Page cache corrupted via xfrm ESP-in-TCP splice");
> +	else
> +		tst_res(TPASS, "Page cache was not corrupted");
> +
> +	SAFE_UNLINK(TESTFILE);

Since we corrupted the page cache when the test fails maybe we should
drop it on failure here just in case?

I.e. write 1 to /proc/sys/vm/drop_caches?

> +}
> +
> +static void cleanup(void)
> +{
> +	if (srv_fd != -1)
> +		SAFE_CLOSE(srv_fd);
> +
> +	if (file_fd != -1)
> +		SAFE_CLOSE(file_fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_USER_NS=y",
> +		"CONFIG_NET_NS=y",
> +		"CONFIG_XFRM",
> +		"CONFIG_INET6_ESP",
> +		"CONFIG_INET6_ESPINTCP",
> +		"CONFIG_CRYPTO_GCM",
> +		NULL
> +	},
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
> +		{}
> +	},
> +	.needs_cmds = (struct tst_cmd[]) {
> +		{.cmd = "ip"},
> +		{}
> +	},
> +};
> 
> ---
> base-commit: e1fc50957c98ae4c27064756e063de0e7136cde3
> change-id: 20260513-fragnesia-9588d855becf
> 
> Best regards,
> -- 
> Andrea Cervesato <andrea.cervesato@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
