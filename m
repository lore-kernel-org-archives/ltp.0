Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F12D2D0E6
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 12:26:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D0523C6335
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 13:26:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEC323C5BAE
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 13:26:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2EC666003BA
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 13:26:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC2775BCDC;
 Tue, 13 Jan 2026 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768307158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x4jrJ8I6fPIwLXaz5xhq8YI/1sMHR3N4D2S6Y0Ub0Sk=;
 b=atYbskBjS+5l5qoVM6y0u5gX6pTfKfX/FUwkEJJTk1kWNoAi0tP9t+z1MeosZMcx8XEEEX
 vAOQWoPm/8Qv7Pn5cLar+qv8OVl7yjCfI9sm9Lk3XSx9WBdtzAwKcRSnpetBaWCFe/FWQZ
 Q0NZDG66SAAwiKtEsDnwpPGUIYPUP0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768307158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x4jrJ8I6fPIwLXaz5xhq8YI/1sMHR3N4D2S6Y0Ub0Sk=;
 b=gG60ynGbClUXLgH1BABye51j6pk9oUzdUBOBK37hCUg4bIWdvSjysqjl+u4mAGAT4Iru6H
 cqFc90LBYlLaPBCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768307158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x4jrJ8I6fPIwLXaz5xhq8YI/1sMHR3N4D2S6Y0Ub0Sk=;
 b=atYbskBjS+5l5qoVM6y0u5gX6pTfKfX/FUwkEJJTk1kWNoAi0tP9t+z1MeosZMcx8XEEEX
 vAOQWoPm/8Qv7Pn5cLar+qv8OVl7yjCfI9sm9Lk3XSx9WBdtzAwKcRSnpetBaWCFe/FWQZ
 Q0NZDG66SAAwiKtEsDnwpPGUIYPUP0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768307158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x4jrJ8I6fPIwLXaz5xhq8YI/1sMHR3N4D2S6Y0Ub0Sk=;
 b=gG60ynGbClUXLgH1BABye51j6pk9oUzdUBOBK37hCUg4bIWdvSjysqjl+u4mAGAT4Iru6H
 cqFc90LBYlLaPBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8E903EA63;
 Tue, 13 Jan 2026 12:25:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UA5lKNY5ZmliUgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 13 Jan 2026 12:25:58 +0000
Date: Tue, 13 Jan 2026 13:25:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Liu Jian <liujian56@huawei.com>
Message-ID: <20260113122557.GA318506@pevik>
References: <20260112015047.2184003-1-liujian56@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260112015047.2184003-1-liujian56@huawei.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[huawei.com:email]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCPT_COUNT_FIVE(0.00)[5]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] rpc: create valid fd to pass libtirpc
 validation
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
Cc: linux-nfs@vger.kernel.org, Steve Dickson <SteveD@redhat.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

[ Cc Steve and linux-nfs ]

> The testcase(rpc_svc_destroy, rpc_svcfd_create, rpc_xprt_register,
> rpc_xprt_unregister) was failing due to an invalid fd, which
> caused libtirpc's internal validation to reject the operation.
> This change ensures a valid socket fd is created and can pass the
> validation checks in libtirpc.

+ I would also like to know more details about the failure (libtirpc version, or
do you still use Sun RPC from old glibc, distro, arch, ...).

Because while we have some problems with some of these tests, I'm not sure if
connecting to 127.0.0.1 is a valid approach. And if it is, should it be used in
more tests? Also rpc_svc_destroy_stress.c and rpc_svcfd_create_limits.c use
svcfd_create().

Below are few minor implementation details. First, maybe add a common header,
with code in the function which would be used? But it can be done later (RPC
test code is really awful, more duplicity will not make it worse).

> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
> v2: Fix a compilation error on Alpine.
>  .../rpc_svc_destroy.c                         | 27 +++++++++++++++++++
>  .../rpc_svcfd_create.c                        | 26 ++++++++++++++++++
>  .../rpc_xprt_register.c                       | 25 +++++++++++++++++
>  .../rpc_xprt_unregister.c                     | 25 +++++++++++++++++
>  4 files changed, 103 insertions(+)

> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
> index 22e560843..b9240ccba 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
> @@ -30,6 +30,12 @@
>  #include <time.h>
>  #include <rpc/rpc.h>

> +#include <unistd.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <string.h>
> +
>  //Standard define
>  #define PROCNUM 1
>  #define VERSNUM 1
> @@ -43,6 +49,27 @@ int main(void)
>  	int test_status = 1;	//Default test result set to FAILED
>  	int fd = 0;
>  	SVCXPRT *svcr = NULL;
> +	struct sockaddr_in server_addr;
> +
> +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> +	if (fd < 0) {
> +		printf("socket creation failed");
Maybe fprintf(stderr, ...) or perror()?

> +		return test_status;
> +	}
> +
> +	memset(&server_addr, 0, sizeof(server_addr));

Maybe just:
struct sockaddr_in server_addr = {0};
instead of memset() ?

> +	server_addr.sin_family = AF_INET;
> +	server_addr.sin_port = htons(9001);
> +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
> +		printf("inet_pton failed");
> +		close(fd);
> +		return test_status;
> +	}
> +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
> +		printf("connect failed");
> +		close(fd);
Funny that all testsuites don't close fd, but not closing single fd is not that
problematic.

Kind regards,
Petr

> +		return test_status;
> +	}

>  	//First of all, create a server
>  	svcr = svcfd_create(fd, 0, 0);
> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/rpc_svcfd_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/rpc_svcfd_create.c
> index f0d89ba48..ea4418961 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/rpc_svcfd_create.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/rpc_svcfd_create.c
> @@ -29,6 +29,11 @@
>  #include <stdlib.h>
>  #include <time.h>
>  #include <rpc/rpc.h>
> +#include <unistd.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <string.h>

>  //Standard define
>  #define PROCNUM 1
> @@ -43,6 +48,27 @@ int main(void)
>  	int test_status = 1;	//Default test result set to FAILED
>  	int fd = 0;
>  	SVCXPRT *svcr = NULL;
> +	struct sockaddr_in server_addr;
> +
> +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> +	if (fd < 0) {
> +		printf("socket creation failed");
> +		return test_status;
> +	}
> +
> +	memset(&server_addr, 0, sizeof(server_addr));
> +	server_addr.sin_family = AF_INET;
> +	server_addr.sin_port = htons(9001);
> +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
> +		printf("inet_pton failed");
> +		close(fd);
> +		return test_status;
> +	}
> +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
> +		printf("connect failed");
> +		close(fd);
> +		return test_status;
> +	}

>  	//create a server
>  	svcr = svcfd_create(fd, 0, 0);
> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
> index b10a1ce5e..a40dad7fe 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
> @@ -31,6 +31,10 @@
>  #include <rpc/rpc.h>
>  #include <sys/types.h>
>  #include <sys/socket.h>
> +#include <unistd.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <string.h>

>  //Standard define
>  #define PROCNUM 1
> @@ -45,6 +49,27 @@ int main(void)
>  	int test_status = 1;	//Default test result set to FAILED
>  	SVCXPRT *svcr = NULL;
>  	int fd = 0;
> +	struct sockaddr_in server_addr;
> +
> +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> +	if (fd < 0) {
> +		printf("socket creation failed");
> +		return test_status;
> +	}
> +
> +	memset(&server_addr, 0, sizeof(server_addr));
> +	server_addr.sin_family = AF_INET;
> +	server_addr.sin_port = htons(9001);
> +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
> +		printf("inet_pton failed");
> +		close(fd);
> +		return test_status;
> +	}
> +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
> +		printf("connect failed");
> +		close(fd);
> +		return test_status;
> +	}

>  	//create a server
>  	svcr = svcfd_create(fd, 1024, 1024);
> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
> index 3b6130eaa..5ac51de41 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
> @@ -31,6 +31,10 @@
>  #include <rpc/rpc.h>
>  #include <sys/types.h>
>  #include <sys/socket.h>
> +#include <unistd.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <string.h>

>  //Standard define
>  #define PROCNUM 1
> @@ -49,6 +53,27 @@ int main(int argn, char *argc[])
>  	int test_status = 1;	//Default test result set to FAILED
>  	SVCXPRT *svcr = NULL;
>  	int fd = 0;
> +	struct sockaddr_in server_addr;
> +
> +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> +	if (fd < 0) {
> +		printf("socket creation failed");
> +		return test_status;
> +	}
> +
> +	memset(&server_addr, 0, sizeof(server_addr));
> +	server_addr.sin_family = AF_INET;
> +	server_addr.sin_port = htons(9001);
> +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
> +		printf("inet_pton failed");
> +		close(fd);
> +		return test_status;
> +	}
> +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
> +		printf("connect failed");
> +		close(fd);
> +		return test_status;
> +	}

>  	//create a server
>  	svcr = svcfd_create(fd, 1024, 1024);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
