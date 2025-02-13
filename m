Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACFBC021A0
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 12:49:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B15153C9A79
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 13:49:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDFA43C9A74;
 Thu, 13 Feb 2025 13:48:55 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5771710165F4;
 Thu, 13 Feb 2025 13:48:52 +0100 (CET)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220d28c215eso10612265ad.1; 
 Thu, 13 Feb 2025 04:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739450930; x=1740055730;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:dkim-signature:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PARIfcxp4Eu6vyNvXULkBZgE5FaGcIdFmGKEGgCPT+Y=;
 b=VYvUxMaQeugPY2Q0eAoFWAnMFBYmfvj4upfwkA1RqCbENBhppG7LXSl4MFarRrEhdr
 GHmUmQH5BHibVYQ7UdY7n1G0eZw3GwKCMP2JVIWTEQh3KcWd3XkuKuBbmIGg2emML8lC
 NJG6k+vRmTm8261ua0KhC08ZF5HrlPXRyA4d+V7MZ4aaYV3L/cfxQMnOaQK2Xu1plU4W
 O9BNReaPYhOMho27z9k1u2wgB0OGjA1W2cEI1w+K/uDnMNtBj2UPeuAhumOgnJqdXhwE
 j0SVjhWXKPxTPJTY4UdmqjOha09MeKUFOvw0k8v2zUBET87GAFQom4yeL2HY5n7NiXMa
 qWTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKfIpyzn0Rlchy0bCIjrgIRjT56usoIeAGNxRxPlhGvPiD8vxvN2v9tiHU0ezH9hI2ONU=@lists.linux.it
X-Gm-Message-State: AOJu0YwFWygC2rrKISBzYHyx+J3h7KR/ML040bLhB+4rzjvnauuueDwY
 87iyjlyxJY8X7GIrv6sw3NeULtTkF7gcn8MQjOxRJh4m6Mmm/yngVhwa6d+JC/I=
X-Gm-Gg: ASbGncs7JHoBUACWhV/hxwNsuu4lHc2s2k5HmtQRz6211suxO5I8BhbM6L+BPAvXwyh
 qGzzFSBn9cuoYxhQkt+X1/cYkuzQlp7UKJpBebGs85j6/jspTlUonAqzdIT23/ziFT9ZRLqDZ7k
 MdkbQw7r2YP1mMovgf9kBvmz7of1bc+bduERH13iS7LeAq995WrkRGzRwWyThKkcZ1hKedk9IQm
 ScOFAGxyuFYevIPmGDHG/5oupCfPcCpJj9jHFwWGRoREqgLZybsnVQI4S7xsU+y/4vuFo1xhNbu
 ygWmk2BB2w==
X-Google-Smtp-Source: AGHT+IGXAH2Y76ov2D4ULrCXyLyZveumhgimfMwXjMt+HPPwiQ9eT2HrMUXMuzo4to6uiC7aA3Re9Q==
X-Received: by 2002:a05:6a21:7a93:b0:1e1:96d9:a7db with SMTP id
 adf61e73a8af0-1ee6b2e1dd3mr6170428637.4.1739450929837; 
 Thu, 13 Feb 2025 04:48:49 -0800 (PST)
Received: from mail.marliere.net ([2604:a880:4:1d0::7f5:6000])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5813a6f0sm981198a12.25.2025.02.13.04.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 04:48:49 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2025; t=1739450928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PARIfcxp4Eu6vyNvXULkBZgE5FaGcIdFmGKEGgCPT+Y=;
 b=bFthpvq9r5E9jRSaqjaFaMKH7sH5HMFbmlsO3VMBA/Y62vemQxXsy5rc3gcVQyKD2E3eiZ
 Yk5HxF5reFUPxnTRgkIKUqKPQnebksAoZmkjhGWjtdtxywUYum+7d/kTWAGpiaQ1A2QIjo
 +GolNML0CIHviPNUGX+bTh5hlzav0goK2Gc9yzLCasBCxrKg6EO/mTusAaxZEMdu1ipj2C
 dny/vcvEqIvEMPiYKlXC/yz/r2FI6qy6ir+sQJGGAKJTPcSpPuejRjdygS4Te0nuaErm4V
 WqpbemmKj59A/RYeKSpsKlFCyP6QP3Up9tPk64WswWynOfPghOYWbCsYNWjhfQ==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Mime-Version: 1.0
Date: Thu, 13 Feb 2025 09:48:44 -0300
Message-Id: <D7RBW3C1993Z.2F0MWK8SORBO4@marliere.net>
To: "Cyril Hrubis" <chrubis@suse.cz>, <ltp@lists.linux.it>
References: <20250212131618.6810-1-chrubis@suse.cz>
 <20250212131618.6810-2-chrubis@suse.cz>
In-Reply-To: <20250212131618.6810-2-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] metaparse: Add shell test parser
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
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed Feb 12, 2025 at 10:16 AM -03, Cyril Hrubis wrote:
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  metadata/.gitignore     |   1 +
>  metadata/Makefile       |   4 +-
>  metadata/metaparse-sh.c | 127 ++++++++++++++++++++++++++++++++++++++++
>  metadata/parse.sh       |  13 ++++
>  4 files changed, 143 insertions(+), 2 deletions(-)
>  create mode 100644 metadata/metaparse-sh.c
>
> diff --git a/metadata/.gitignore b/metadata/.gitignore
> index 07d2fd6ff..bb6399e5c 100644
> --- a/metadata/.gitignore
> +++ b/metadata/.gitignore
> @@ -1,2 +1,3 @@
>  metaparse
> +metaparse-sh
>  ltp.json
> diff --git a/metadata/Makefile b/metadata/Makefile
> index 522af4270..641657318 100644
> --- a/metadata/Makefile
> +++ b/metadata/Makefile
> @@ -7,12 +7,12 @@ include $(top_srcdir)/include/mk/env_pre.mk
>  include $(top_srcdir)/include/mk/functions.mk
>  
>  MAKE_TARGETS		:= ltp.json
> -HOST_MAKE_TARGETS	:= metaparse
> +HOST_MAKE_TARGETS	:= metaparse metaparse-sh
>  INSTALL_DIR		= metadata
>  
>  .PHONY: ltp.json
>  
> -ltp.json: metaparse
> +ltp.json: metaparse metaparse-sh
>  	$(abs_srcdir)/parse.sh > ltp.json
>  ifeq ($(WITH_METADATA),yes)
>  	mkdir -p $(abs_top_builddir)/docparse
> diff --git a/metadata/metaparse-sh.c b/metadata/metaparse-sh.c
> new file mode 100644
> index 000000000..9eb38f583
> --- /dev/null
> +++ b/metadata/metaparse-sh.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <libgen.h>
> +
> +#include "data_storage.h"
> +
> +static int started;
> +
> +static void json_start(char *path)
> +{
> +	if (started)
> +		return;
> +
> +	started = 1;
> +
> +	printf("   \"%s\": {\n", basename(path));
> +}
> +
> +static void json_finish(const char *path)
> +{
> +	if (!started)
> +		return;
> +
> +	printf("   \"fname\": \"%s\"\n", path);
> +	printf("  }");
> +}
> +
> +enum state {
> +	NONE,
> +	START,
> +	DOC_FIRST,
> +	DOC,
> +	ENV_START,
> +	ENV_FIRST,
> +	ENV
> +};
> +
> +static void parse_shell(char *path)
> +{
> +	char line[4096];
> +	FILE *f = fopen(path, "r");
> +	enum state state = NONE;
> +
> +	while (fgets(line, sizeof(line), f)) {
> +		/* Strip newline */
> +		line[strlen(line)-1] = 0;
> +
> +		switch (state) {
> +		case NONE:
> +			if (!strcmp(line, "# ---"))
> +				state = START;
> +		break;
> +		case START:
> +			if (!strcmp(line, "# doc")) {
> +				json_start(path);
> +				state = DOC_FIRST;
> +				printf("   \"doc\": [\n");
> +			} else if (!strcmp(line, "# env")) {
> +				json_start(path);
> +				state = ENV_START;
> +			} else {
> +				state = NONE;
> +			}
> +		break;
> +		case DOC:
> +		case DOC_FIRST:
> +			if (!strcmp(line, "# ---")) {
> +				state = NONE;
> +				printf("\n   ],\n");
> +				continue;
> +			}
> +
> +			if (state == DOC_FIRST)
> +				state = DOC;
> +			else
> +				printf(",\n");
> +
> +			data_fprintf_esc(stdout, 4, line+2);
> +		break;
> +		case ENV_START:
> +			if (!strcmp(line, "# {")) {
> +				state = ENV_FIRST;
> +			} else {
> +				fprintf(stderr,
> +				        "%s: Invalid line in JSON block '%s'",
> +					path, line);
> +			}
> +		break;
> +		case ENV:
> +		case ENV_FIRST:
> +			if (!strcmp(line, "# }")) {
> +				state = NONE;
> +				printf(",\n");
> +				continue;
> +			}
> +
> +

nit: double blank line here

> +			if (state == ENV_FIRST)
> +				state = ENV;
> +			else
> +				printf("\n");
> +
> +			line[0] = ' ';
> +			line[1] = ' ';
> +
> +			printf("%s", line);
> +		break;
> +		}
> +	}
> +
> +	json_finish(path);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int i;
> +
> +	for (i = 1; i < argc; i++)
> +		parse_shell(argv[i]);
> +
> +	return 0;
> +}
> diff --git a/metadata/parse.sh b/metadata/parse.sh
> index 7db2e2415..45776e4d0 100755
> --- a/metadata/parse.sh
> +++ b/metadata/parse.sh
> @@ -42,6 +42,19 @@ EOF
>  	fi
>  done
>  
> +for test in `find testcases/ -not -path "testcases/lib/*" -name '*.sh'|sort`; do
> +	a=$($top_builddir/metadata/metaparse-sh "$test")
> +	if [ -n "$a" ]; then
> +		if [ -z "$first" ]; then
> +			echo ','
> +		fi
> +		first=
> +		cat <<EOF
> +$a
> +EOF
> +	fi
> +done
> +
>  echo
>  echo ' }'
>  echo '}'


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
