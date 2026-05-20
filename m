Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2609CD4F3D
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 14:19:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 561753C734F
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 16:19:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C43F3C7179
 for <ltp@lists.linux.it>; Wed, 20 May 2026 16:19:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 26D3C200B00
 for <ltp@lists.linux.it>; Wed, 20 May 2026 16:19:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A1F076711E;
 Wed, 20 May 2026 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779286743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cefg9m7WHtLnQS9o50gnRNXWQ2gHh8pBD4TOx5hKt8Q=;
 b=EX+lE//5BoH2bnZBz5udv6gxArjGHX/YuRvbuYd6X0jsTOZqiYrEsHr8n2rbAEvAXrpUCr
 DxdukBUFXGmi2OgVRXh+C4HB5qT63IUdABbMYTb83SLi0BzBOJlX88PsVx8XQSo1E7sG2L
 fKT0+33cETYqB6uaSPBKp+sUKYIn4MQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779286743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cefg9m7WHtLnQS9o50gnRNXWQ2gHh8pBD4TOx5hKt8Q=;
 b=Sdh39ZM86tOl9PiZFlSlra9RVW64JACTsNhEZ1sLZ8yLeBQCXhbIew61jwFCDtJUhJxst0
 PZK9uAMrixDNcaDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779286739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cefg9m7WHtLnQS9o50gnRNXWQ2gHh8pBD4TOx5hKt8Q=;
 b=rh7jVDTabh9JnjX/kWviQ7LTBQqcw79CoSDnwBB0POWLv5fJ88RLNEIOdaNxoCE1pwKaSE
 i1Pbt60QE/+kA9eC/C5A1xRZWfY9cH9VopDBazq5w59iCfTFSMgOiRXUHHXsPrwS0oozws
 Pz0plOH3sllPs6+5oEx2Xg5tpO9Zjz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779286739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cefg9m7WHtLnQS9o50gnRNXWQ2gHh8pBD4TOx5hKt8Q=;
 b=LOZOuv1sE6UgTYjsxq0JCS/Es8Hp8DjS7FvDrrggoPDB51Bwtn5Rwqrt5qs6g7HggcAFUN
 eWPpMo5BjolgRTBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96338593AA;
 Wed, 20 May 2026 14:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NChIJNPCDWrEcQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 20 May 2026 14:18:59 +0000
Message-ID: <a17d2c76-3b48-480a-bf2b-39fa49cbf952@suse.cz>
Date: Wed, 20 May 2026 16:18:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260518-fragnesia-variant-v1-1-45b9df38cc78@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20260518-fragnesia-variant-v1-1-45b9df38cc78@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sockets/xfrm03: Add skb_segment SKBFL_SHARED_FRAG
 stripping test
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
one minor suggestion below, otherwise:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>


I've tried to simplify the namespace setup but I haven't found a usable 
kernel build where I could verify that the reproducer still fails even 
though esp6 variant of Fragnesia is already fixed. I can only find 
kernels where both CVE variants are fixed or present. We should revisit 
this after Labs conf.

On 5/18/26 09:27, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Verify that skb_segment() does not strip the SKBFL_SHARED_FRAG flag
> from page-cache fragments when splitting GRO-coalesced packets,
> allowing ESP-in-TCP to decrypt in-place and corrupt read-only file
> data.
> 
> The test creates a three-namespace topology (sender - middle -
> receiver) connected via veth pairs, disables GSO/TSO/GRO on the
> middle-to-receiver link to force skb_segment(), installs an
> ESP-in-TCP xfrm SA in the receiver, splices known file data through
> the forwarding path, and verifies the page cache was not corrupted.
> 
> Reproducer based on:
> https://github.com/v12-security/pocs/tree/main/fragnesia-5db89c99566fc
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   runtest/cve                          |   1 +
>   testcases/network/sockets/.gitignore |   1 +
>   testcases/network/sockets/xfrm03.c   | 325 +++++++++++++++++++++++++++++++++++
>   3 files changed, 327 insertions(+)
> 
> diff --git a/runtest/cve b/runtest/cve
> index 74ee8e9ba4287a99dbf0412921acb11a5be53283..a5952b56c48771def1032efdf0cbe3847f7dc23c 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -96,3 +96,4 @@ cve-2025-21756 cve-2025-21756
>   cve-2026-31431 af_alg08
>   cve-2026-43284 xfrm01
>   cve-2026-46300 xfrm02
> +cve-2026-46300-skb-segment xfrm03
> diff --git a/testcases/network/sockets/.gitignore b/testcases/network/sockets/.gitignore
> index 35bc0462b676b041d9a5b52a37fded973d0157a9..3e8962bbf34c8574460c032cf9eb3b38a55eb697 100644
> --- a/testcases/network/sockets/.gitignore
> +++ b/testcases/network/sockets/.gitignore
> @@ -1,2 +1,3 @@
>   /xfrm01
>   /xfrm02
> +/xfrm03
> diff --git a/testcases/network/sockets/xfrm03.c b/testcases/network/sockets/xfrm03.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..de6042e8ad8a806dcdaa152785511731a02cbeb0
> --- /dev/null
> +++ b/testcases/network/sockets/xfrm03.c
> @@ -0,0 +1,325 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Verify that skb_segment() does not strip the SKBFL_SHARED_FRAG flag
> + * from page-cache fragments when splitting GRO-coalesced packets,
> + * causing ESP-in-TCP to decrypt in-place and corrupt read-only file
> + * data.
> + *
> + * When file data is spliced into a TCP socket, the kernel references
> + * page-cache pages directly in the skb and marks them with
> + * SKBFL_SHARED_FRAG. If the packet traverses a forwarding path where
> + * GRO coalesces segments on ingress and skb_segment() splits them on
> + * egress (because GSO is disabled), skb_segment() incorrectly strips
> + * SKBFL_SHARED_FRAG from the child segments. When the receiver has
> + * TCP_ULP "espintcp" enabled, the ESP handler decrypts in-place on
> + * page-cache pages, corrupting the cached file contents.
> + *
> + * The test creates three network namespaces connected via veth pairs
> + * (sender - middle - receiver), disables GSO/TSO/GRO on the
> + * middle-to-receiver link to force skb_segment(), installs an
> + * ESP-in-TCP xfrm SA in the receiver, writes known data to a
> + * read-only file, splices it into a TCP socket from the sender,
> + * enables espintcp ULP on the receiver side, and verifies the page
> + * cache was not corrupted.
> + *
> + * Reproducer based on:
> + * https://github.com/v12-security/pocs/tree/main/fragnesia-5db89c99566fc
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <linux/ethtool.h>
> +#include <linux/sockios.h>
> +#include <net/if.h>
> +
> +#include "tst_test.h"
> +#include "tst_net.h"
> +#include "tst_netdevice.h"
> +#include "lapi/tcp.h"
> +#include "lapi/splice.h"
> +#include "lapi/sched.h"
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
> +#define PREFIX_SIZE (2 + ESP_HDR_SIZE)
> +#define NETMASK 24
> +
> +#define SENDER_ADDR   0x0a000101 /* 10.0.1.1 */
> +#define MIDDLE_ADDR1  0x0a000102 /* 10.0.1.2 */
> +#define MIDDLE_ADDR2  0x0a000201 /* 10.0.2.1 */
> +#define RECEIVER_ADDR 0x0a000202 /* 10.0.2.2 */
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
> +static int middlens = -1;
> +static int senderns = -1;
> +static int receiverns = -1;
> +
> +static void disable_offloads(const char *ifname)
> +{
> +	struct ifreq ifr;
> +	struct ethtool_value val = { .data = 0 };
> +	int fd;
> +
> +	fd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
> +
> +	memset(&ifr, 0, sizeof(ifr));
> +	strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
> +	ifr.ifr_data = (void *)&val;
> +
> +	val.cmd = ETHTOOL_SGSO;
> +	SAFE_IOCTL(fd, SIOCETHTOOL, &ifr);
> +
> +	val.cmd = ETHTOOL_STSO;
> +	SAFE_IOCTL(fd, SIOCETHTOOL, &ifr);
> +
> +	val.cmd = ETHTOOL_SGRO;
> +	SAFE_IOCTL(fd, SIOCETHTOOL, &ifr);
> +
> +	SAFE_CLOSE(fd);
> +}
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
> +	CREATE_VETH_PAIR("veth_m1", "veth_s");
> +	CREATE_VETH_PAIR("veth_m2", "veth_r");
> +
> +	NETDEV_ADD_ADDRESS_INET("veth_m1", htonl(MIDDLE_ADDR1), NETMASK, 0);
> +	NETDEV_ADD_ADDRESS_INET("veth_m2", htonl(MIDDLE_ADDR2), NETMASK, 0);
> +	NETDEV_SET_STATE("veth_m1", 1);
> +	NETDEV_SET_STATE("veth_m2", 1);
> +
> +	SAFE_FILE_PRINTF("/proc/sys/net/ipv4/ip_forward", "1");
> +	disable_offloads("veth_m2");
> +
> +	middlens = SAFE_OPEN("/proc/self/ns/net", O_RDONLY);
> +
> +	SAFE_UNSHARE(CLONE_NEWNET);
> +	senderns = SAFE_OPEN("/proc/self/ns/net", O_RDONLY);
> +	SAFE_SETNS(middlens, CLONE_NEWNET);
> +	NETDEV_CHANGE_NS_FD("veth_s", senderns);
> +
> +	SAFE_SETNS(senderns, CLONE_NEWNET);
> +	NETDEV_SET_STATE("lo", 1);
> +	NETDEV_ADD_ADDRESS_INET("veth_s", htonl(SENDER_ADDR), NETMASK, 0);
> +	NETDEV_SET_STATE("veth_s", 1);
> +	NETDEV_ADD_ROUTE_INET("veth_s", 0, 0, 0, 0, htonl(MIDDLE_ADDR1));
> +	SAFE_SETNS(middlens, CLONE_NEWNET);
> +
> +	SAFE_UNSHARE(CLONE_NEWNET);
> +	receiverns = SAFE_OPEN("/proc/self/ns/net", O_RDONLY);
> +	SAFE_SETNS(middlens, CLONE_NEWNET);
> +	NETDEV_CHANGE_NS_FD("veth_r", receiverns);
> +
> +	SAFE_SETNS(receiverns, CLONE_NEWNET);
> +	NETDEV_SET_STATE("lo", 1);
> +	NETDEV_ADD_ADDRESS_INET("veth_r", htonl(RECEIVER_ADDR), NETMASK, 0);
> +	NETDEV_SET_STATE("veth_r", 1);
> +	NETDEV_ADD_ROUTE_INET("veth_r", 0, 0, 0, 0, htonl(MIDDLE_ADDR2));
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
> +		"src", "10.0.2.2", "dst", "10.0.2.2",
> +		"proto", "esp", "spi", spihex,
> +		"encap", "espintcp", port_str, port_str, "0.0.0.0",
> +		"aead", "rfc4106(gcm(aes))", keyhex, "128",
> +		"mode", "transport",
> +		NULL
> +	};
> +
> +	ret = tst_cmd(xfrm_cmd, NULL, NULL, TST_CMD_PASS_RETVAL);
> +	if (ret)
> +		tst_brk(TBROK, "Failed to install xfrm ESP-in-TCP state");

Please change the TBROK to TCONF. Older kernels don't support espintcp 
even though they have the necessary kernel modules. We should revisit 
this command later and convert it to direct rtnetlink request in order 
to correctly handle other errors than missing protocol support.

> +
> +	SAFE_SETNS(middlens, CLONE_NEWNET);
> +
> +	for (i = 0; i < DATA_SIZE; i++)
> +		original[i] = (uint8_t)(i & 0xff);
> +}
> +
> +static void try_corrupt(void)
> +{
> +	struct sockaddr_in addr = {
> +		.sin_family = AF_INET,
> +		.sin_addr.s_addr = htonl(RECEIVER_ADDR),
> +		.sin_port = htons(TCP_PORT),
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
> +	SAFE_SETNS(receiverns, CLONE_NEWNET);
> +
> +	srv_fd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> +	SAFE_SETSOCKOPT_INT(srv_fd, SOL_SOCKET, SO_REUSEADDR, 1);
> +	SAFE_BIND(srv_fd, (struct sockaddr *)&addr, sizeof(addr));
> +	SAFE_LISTEN(srv_fd, 1);
> +
> +	if (!SAFE_FORK()) {
> +		int cli_fd, pipefd[2];
> +
> +		SAFE_CLOSE(srv_fd);
> +		SAFE_SETNS(senderns, CLONE_NEWNET);
> +
> +		cli_fd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> +		SAFE_SETSOCKOPT_INT(cli_fd, IPPROTO_TCP, TCP_NODELAY, 1);
> +		SAFE_CONNECT(cli_fd, (struct sockaddr *)&addr, sizeof(addr));
> +
> +		SAFE_SEND(1, cli_fd, prefix, sizeof(prefix), 0);
> +		SAFE_PIPE(pipefd);
> +
> +		SAFE_POSIX_FADVISE(file_fd, 0, 0, POSIX_FADV_DONTNEED);
> +
> +		off = 0;
> +		SAFE_SPLICE(file_fd, &off, pipefd[1], NULL, DATA_SIZE, 0);
> +
> +		/*
> +		 * Splice pipe into TCP socket. On the forwarding
> +		 * path, skb_segment() may strip SKBFL_SHARED_FRAG,
> +		 * allowing in-place ESP decrypt on page cache pages.
> +		 * May fail on patched kernels.
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
> +	acc_fd = SAFE_ACCEPT(srv_fd, NULL, NULL);
> +	SAFE_CLOSE(srv_fd);
> +
> +	tst_reap_children();
> +
> +	SAFE_SETSOCKOPT(acc_fd, IPPROTO_TCP, TCP_ULP, ulp, sizeof(ulp));
> +
> +	/* Let the espintcp strparser process buffered ESP data */
> +	usleep(30000);
> +
> +	SAFE_CLOSE(acc_fd);
> +
> +	SAFE_SETNS(middlens, CLONE_NEWNET);
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
> +		tst_res(TFAIL, "Page cache corrupted via skb_segment ESP-in-TCP forwarding");
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
> +
> +	if (receiverns != -1)
> +		SAFE_CLOSE(receiverns);
> +
> +	if (senderns != -1)
> +		SAFE_CLOSE(senderns);
> +
> +	if (middlens != -1)
> +		SAFE_CLOSE(middlens);
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
> +		"CONFIG_VETH",
> +		"CONFIG_XFRM",
> +		"CONFIG_INET_ESP",
> +		"CONFIG_INET_ESPINTCP",
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
> +	.tags = (const struct tst_tag[]) {
> +		{"CVE", "2026-46300"},
> +		{}
> +	},
> +};
> 
> ---
> base-commit: 8cd7644a52e348393d453d0ec5bf9424ea31a4cc
> change-id: 20260517-fragnesia-variant-8d026f8c0730
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
