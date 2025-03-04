Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DE7C021B8
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 13:24:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF7753C9FE0
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 14:24:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E2F23C19CC
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 14:24:09 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A54ED1422B68
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 14:24:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 17D1A21196;
 Tue,  4 Mar 2025 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741094647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KIvgQUCKFqqYPFzkr4dACYOYvZG5mya4HJ2L+d2xe8c=;
 b=G8B5Dvfh57opu9hOETcmxTcSfwtolHa1dG9pCseFBrAHkr9cIHFP08fsxnjcxAQtFewZza
 EMStIykZQDB2K+Inql558hVDU/ret0UF78u8MdlZU2uQFxC1VJKoLIpaSPM/KM/Ga58fh9
 UDVCgWtGxnmcvH3oqltU7hatJG+kMFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741094647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KIvgQUCKFqqYPFzkr4dACYOYvZG5mya4HJ2L+d2xe8c=;
 b=04BhCPX6o1RG2FYUNJB0K+PjgnQa06SXHUnJwCjkNEtdtzZVZ386/dwE0l5gjIvmH2iXwC
 Idj/okHXR7R/XhAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G8B5Dvfh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=04BhCPX6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741094647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KIvgQUCKFqqYPFzkr4dACYOYvZG5mya4HJ2L+d2xe8c=;
 b=G8B5Dvfh57opu9hOETcmxTcSfwtolHa1dG9pCseFBrAHkr9cIHFP08fsxnjcxAQtFewZza
 EMStIykZQDB2K+Inql558hVDU/ret0UF78u8MdlZU2uQFxC1VJKoLIpaSPM/KM/Ga58fh9
 UDVCgWtGxnmcvH3oqltU7hatJG+kMFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741094647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KIvgQUCKFqqYPFzkr4dACYOYvZG5mya4HJ2L+d2xe8c=;
 b=04BhCPX6o1RG2FYUNJB0K+PjgnQa06SXHUnJwCjkNEtdtzZVZ386/dwE0l5gjIvmH2iXwC
 Idj/okHXR7R/XhAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 095C413967;
 Tue,  4 Mar 2025 13:24:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gtOHAff+xme/HAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 04 Mar 2025 13:24:07 +0000
Date: Tue, 4 Mar 2025 14:24:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z8b_ASCxF6gTvanH@yuki.lan>
References: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
 <20250110-lsm-v2-6-bd38035f86bc@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250110-lsm-v2-6-bd38035f86bc@suse.com>
X-Rspamd-Queue-Id: 17D1A21196
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, linux.it:url, suse.cz:dkim, suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/7] Add lsm_list_modules02 test
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
> +#include "lsm_common.h"
> +
> +#define MAX_LSM_NUM 32
> +
> +static char lsm_names[MAX_LSM_NUM][BUFSIZ];
> +static size_t lsm_names_count;
> +static uint32_t page_size;
> +static uint64_t *ids;
> +static uint32_t *size;
> +
> +static void run(void)
> +{
> +	uint32_t lsm_num;
> +	size_t count;
> +
> +	memset(ids, 0, sizeof(uint64_t) * MAX_LSM_NUM);
> +	*size = page_size;
> +
> +	lsm_num = TST_EXP_POSITIVE(lsm_list_modules(ids, size, 0));

If we want to pass the size as page_size here the buffer passed to the
syscall would have to be page_size in size. The whole point of passing
the size here is to tell the kernel the size of the buffer it can use
and it's a pointer because kernel will return the size of the buffer it
used back.

> +
> +	TST_EXP_EQ_LI(lsm_num, lsm_names_count);
> +	TST_EXP_EQ_LI(*size, lsm_num * sizeof(uint64_t));
> +
> +	for (uint32_t i = 0; i < lsm_num; i++) {
> +		char *name = NULL;
> +
> +		switch (ids[i]) {
> +		case LSM_ID_CAPABILITY:
> +			name = "capability";
> +			break;
> +		case LSM_ID_SELINUX:
> +			name = "selinux";
> +			break;
> +		case LSM_ID_SMACK:
> +			name = "smack";
> +			break;
> +		case LSM_ID_TOMOYO:
> +			name = "tomoyo";
> +			break;
> +		case LSM_ID_APPARMOR:
> +			name = "apparmor";
> +			break;
> +		case LSM_ID_YAMA:
> +			name = "yama";
> +			break;
> +		case LSM_ID_LOADPIN:
> +			name = "loadpin";
> +			break;
> +		case LSM_ID_SAFESETID:
> +			name = "safesetid";
> +			break;
> +		case LSM_ID_LOCKDOWN:
> +			name = "lockdown";
> +			break;
> +		case LSM_ID_BPF:
> +			name = "bpf";
> +			break;
> +		case LSM_ID_LANDLOCK:
> +			name = "landlock";
> +			break;
> +		case LSM_ID_IMA:
> +			name = "ima";
> +			break;
> +		case LSM_ID_EVM:
> +			name = "evm";
> +			break;
> +		case LSM_ID_IPE:
> +			name = "ipe";
> +			break;
> +		default:
> +			break;
> +		}

I guess that it may be also a good idea to have an array where we would
record which LSM we have seen in the buffer to make sure that we didn't
get any of them twice.

I suppose that we can turn the lsm_names into a structure and add
counters there with:


struct lsm_name {
	int cnt;
	char name[MAX_LSM_NAME];
};

struct lsm_name lsm_names[MAX_LSM_NUM];

> +		if (!name)
> +			tst_brk(TBROK, "Unsupported LSM: %lu", ids[i]);
> +
> +		for (count = 0; count < lsm_names_count; count++) {
> +			if (!strcmp(name, lsm_names[count])) {
> +				tst_res(TPASS, "'%s' is enabled", name);

And then we can (assuming we zero the counters at the start of this
function) do:

				if (lsm_names[count].cnt)
					tst_res(TFAIL, "Duplicated LSM entry %s", lsm_names[count].name);

				lsm_names[count].cnt++;

> +				break;
> +			}
> +		}
> +
> +		if (count >= lsm_names_count)
> +			tst_res(TFAIL, "'%s' has not been found", name);
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	int fd;
> +	char *ptr;
> +	char data[BUFSIZ];
> +
> +	memset(data, 0, BUFSIZ);
> +
> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> +	fd = SAFE_OPEN("/sys/kernel/security/lsm", O_RDONLY);
> +	SAFE_READ(0, fd, data, BUFSIZ);
> +	SAFE_CLOSE(fd);
> +
> +	ptr = strtok(data, ",");
> +
> +	while (ptr != NULL) {
> +		strcpy(lsm_names[lsm_names_count], ptr);
> +		ptr = strtok(NULL, ",");
> +		lsm_names_count++;
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.min_kver = "6.8",
> +	.bufs = (struct tst_buffers []) {
> +		{&ids, .size = sizeof(uint64_t) * MAX_LSM_NUM},
> +		{&size, .size = sizeof(uint32_t)},
> +		{},
> +	},
> +};
> 
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
