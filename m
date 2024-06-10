Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4A6C27C5E
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 13:14:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC6AA3D0B4E
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 15:14:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F05D23C9430
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 15:13:52 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 791F2201DA0
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 15:13:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 744751F7EF;
 Mon, 10 Jun 2024 13:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718025230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zrv9Nq7S5TiiElnAEn4q6rUX3+LztZMAjwfcpR6JBFo=;
 b=rNTHh4Vz9SyGOOk41i3eLmdbGWD/gAfMeKiNkmDuCERf38etYFZ2L9iNWxvDe55fnyIbWJ
 9XKnao81lkp7ehNlrJ8ek/baCNFG+7WmViYUasIEWqSGvPG/MHSjeflgr/M9huIYnGcw5X
 3/pTXiNPTb+REibMb+725/rZ2jSlzKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718025230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zrv9Nq7S5TiiElnAEn4q6rUX3+LztZMAjwfcpR6JBFo=;
 b=4gT7bTtNnBHKTYD0qEAHWlZ/wt4MK7oZtDqbSfMmhhinUFOmScMoaiNJYKbm6aAywDv+O7
 nFydSRDy+t+TjKAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rNTHh4Vz;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4gT7bTtN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718025230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zrv9Nq7S5TiiElnAEn4q6rUX3+LztZMAjwfcpR6JBFo=;
 b=rNTHh4Vz9SyGOOk41i3eLmdbGWD/gAfMeKiNkmDuCERf38etYFZ2L9iNWxvDe55fnyIbWJ
 9XKnao81lkp7ehNlrJ8ek/baCNFG+7WmViYUasIEWqSGvPG/MHSjeflgr/M9huIYnGcw5X
 3/pTXiNPTb+REibMb+725/rZ2jSlzKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718025230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zrv9Nq7S5TiiElnAEn4q6rUX3+LztZMAjwfcpR6JBFo=;
 b=4gT7bTtNnBHKTYD0qEAHWlZ/wt4MK7oZtDqbSfMmhhinUFOmScMoaiNJYKbm6aAywDv+O7
 nFydSRDy+t+TjKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A7D013A51;
 Mon, 10 Jun 2024 13:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Kt6iFA78ZmbxLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Jun 2024 13:13:50 +0000
Date: Mon, 10 Jun 2024 15:13:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240610131348.GA732398@pevik>
References: <20240607-shutdown-v2-0-a09ce3290ee1@suse.com>
 <20240607-shutdown-v2-1-a09ce3290ee1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240607-shutdown-v2-1-a09ce3290ee1@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 744751F7EF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Add shutdown01 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

TL;DR: generally LGTM, I have few minor details, which I offer to fix before
merge (diff below).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +++ b/testcases/kernel/syscalls/shutdown/shutdown01.c
...
> +static struct tcase {
> +	int shutdown_op;
> +	int recv_flag;
> +	int recv_err;
> +	int send_flag;
> +	int send_err;
> +	char *flag_str;
> +} tcases[] = {
> +	{SHUT_RD, 0, 0, 0, 0, "SHUT_RD"},
> +	{SHUT_WR, MSG_DONTWAIT, EWOULDBLOCK, MSG_NOSIGNAL, EPIPE, "SHUT_WR"},
> +	{SHUT_RDWR, 0, 0, MSG_NOSIGNAL, EPIPE, "SHUT_RDWR"}

Would you mind to use
1) designated initializers (e.g. .recv_flag = MSG_DONTWAIT,)
2) stringify macro

IMHO it helps readability, that's why it's often used.

#define OP_DESC(x) .shutdown_op = x, .desc = #x
static struct tcase {
	int shutdown_op;
	int recv_flag;
	int recv_err;
	int send_flag;
	int send_err;
	char *desc;
} tcases[] = {
	{OP_DESC(SHUT_RD)},
	{OP_DESC(SHUT_WR), .recv_flag = MSG_DONTWAIT, .recv_err = EWOULDBLOCK,
		.send_flag = MSG_NOSIGNAL, .send_err = EPIPE},
	{OP_DESC(SHUT_RDWR), .send_flag = MSG_NOSIGNAL, .send_err = EPIPE}
};

> +};
> +
> +static struct sockaddr_un *sock_addr;
> +
> +static void run_server(void)
> +{
> +	int server_sock;
> +
> +	server_sock = SAFE_SOCKET(sock_addr->sun_family, SOCK_STREAM, 0);
> +
> +	SAFE_BIND(server_sock,
> +		(struct sockaddr *)sock_addr,
> +		sizeof(struct sockaddr_un));
> +	SAFE_LISTEN(server_sock, 10);
> +
> +	tst_res(TINFO, "Running server on socket file");
> +
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +
> +	SAFE_CLOSE(server_sock);
> +	SAFE_UNLINK(SOCKETFILE);
> +}
> +
> +static int start_test(void)
> +{
> +	int client_sock;
> +
> +	if (!SAFE_FORK()) {
> +		run_server();
> +		_exit(0);
> +	}
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	tst_res(TINFO, "Connecting to the server");
> +
> +	client_sock = SAFE_SOCKET(sock_addr->sun_family, SOCK_STREAM, 0);
> +	SAFE_CONNECT(client_sock,
> +		(struct sockaddr *)sock_addr,
> +		sizeof(struct sockaddr_un));
> +
> +	return client_sock;
> +}
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int client_sock;
> +	char buff[MSGSIZE] = {0};
> +
> +	client_sock = start_test();
> +
> +	tst_res(TINFO, "Testing %s flag", tc->flag_str);
> +
> +	TST_EXP_PASS(shutdown(client_sock, tc->shutdown_op));
> +
> +	if (!tc->recv_err)
> +		SAFE_RECV(0, client_sock, buff, MSGSIZE, tc->recv_flag);
> +	else
> +		TST_EXP_FAIL(recv(client_sock, buff, MSGSIZE, tc->recv_flag), tc->recv_err);

very nit:

	if (tc->recv_err)
		TST_EXP_FAIL(recv(client_sock, buff, MSGSIZE, tc->recv_flag), tc->recv_err);
	else
		SAFE_RECV(0, client_sock, buff, MSGSIZE, tc->recv_flag);

If you agree, I can merge with following changes.

Kind regards,
Petr

diff --git testcases/kernel/syscalls/shutdown/shutdown01.c testcases/kernel/syscalls/shutdown/shutdown01.c
index ba3853d9c..8e58f23e6 100644
--- testcases/kernel/syscalls/shutdown/shutdown01.c
+++ testcases/kernel/syscalls/shutdown/shutdown01.c
@@ -19,17 +19,19 @@
 #define MSGSIZE 4
 #define SOCKETFILE "socket"
 
+#define OP_DESC(x) .shutdown_op = x, .desc = #x
 static struct tcase {
 	int shutdown_op;
 	int recv_flag;
 	int recv_err;
 	int send_flag;
 	int send_err;
-	char *flag_str;
+	char *desc;
 } tcases[] = {
-	{SHUT_RD, 0, 0, 0, 0, "SHUT_RD"},
-	{SHUT_WR, MSG_DONTWAIT, EWOULDBLOCK, MSG_NOSIGNAL, EPIPE, "SHUT_WR"},
-	{SHUT_RDWR, 0, 0, MSG_NOSIGNAL, EPIPE, "SHUT_RDWR"}
+	{OP_DESC(SHUT_RD)},
+	{OP_DESC(SHUT_WR), .recv_flag = MSG_DONTWAIT, .recv_err = EWOULDBLOCK,
+		.send_flag = MSG_NOSIGNAL, .send_err = EPIPE},
+	{OP_DESC(SHUT_RDWR), .send_flag = MSG_NOSIGNAL, .send_err = EPIPE}
 };
 
 static struct sockaddr_un *sock_addr;
@@ -82,23 +84,22 @@ static void run(unsigned int n)
 
 	client_sock = start_test();
 
-	tst_res(TINFO, "Testing %s flag", tc->flag_str);
+	tst_res(TINFO, "Testing %s flag", tc->desc);
 
 	TST_EXP_PASS(shutdown(client_sock, tc->shutdown_op));
 
-	if (!tc->recv_err)
-		SAFE_RECV(0, client_sock, buff, MSGSIZE, tc->recv_flag);
-	else
+	if (tc->recv_err)
 		TST_EXP_FAIL(recv(client_sock, buff, MSGSIZE, tc->recv_flag), tc->recv_err);
-
-	if (!tc->send_err)
-		SAFE_SEND(MSGSIZE, client_sock, buff, MSGSIZE, tc->send_flag);
 	else
+		SAFE_RECV(0, client_sock, buff, MSGSIZE, tc->recv_flag);
+
+	if (tc->send_err)
 		TST_EXP_FAIL(send(client_sock, buff, MSGSIZE, tc->send_flag), tc->send_err);
+	else
+		SAFE_SEND(MSGSIZE, client_sock, buff, MSGSIZE, tc->send_flag);
 
 	SAFE_CLOSE(client_sock);
 	TST_CHECKPOINT_WAKE(0);
-
 }
 
 static void setup(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
