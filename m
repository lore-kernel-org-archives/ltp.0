Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E9AC433F5
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 13:44:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 323233C9351
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 14:44:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38EAA3C00C2
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 14:44:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 824C41400FBD
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 14:44:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B9B4C1F397;
 Tue, 15 Mar 2022 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647351869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rce+whTZr8H8zRnMzl/789iy7J4VjxudKM+DIf9v/hQ=;
 b=hMHVPJI/OAeVqTnbSMM4hDG3Ndr6SiDVYS8qvRxH7dO/zLLwVIIvcEvNr07Ifi55z60f61
 SiwLXRKKhv8UOG4EnoYbkJcUy3V3jant1SseqHdcJ9T5rY4nyqffwhdiXyDLnbaUlo3k0s
 Te25+cIAWXbYeULfNiN8Nxftp+IOUL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647351869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rce+whTZr8H8zRnMzl/789iy7J4VjxudKM+DIf9v/hQ=;
 b=WzSaM+AQxQp5iT0uVffCyMN67sGIR9GWmwG+nuNtWVnS6BYRrqnd6b1ieCif30q8G0ITXN
 vqEMTWiiHFN3LcBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A36CE13B4E;
 Tue, 15 Mar 2022 13:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id x77eJj2YMGJxcwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 15 Mar 2022 13:44:29 +0000
Message-ID: <f55747f8-2505-b2e8-41c0-79f4b895faaa@suse.cz>
Date: Tue, 15 Mar 2022 14:44:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220315094901.5855-1-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220315094901.5855-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] quotactl: Check for missing quota_v2 module
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
I've verified that this patch fixes the missing module issues on SLE
kernel-default-base.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 15. 03. 22 10:49, Petr Vorel wrote:
> openSUSE JeOS allowed installation without quota_v2 (they were in
> kernel-default, but by default kernel-default-base with smaller subset
> of kernel modules is installed).
> 
> Therefore check for the module for all tests which require CONFIG_QFMT_V2
> config and remove now redundant CONFIG_QFMT_V2 check.
> 
> Fixes: https://bugzilla.opensuse.org/show_bug.cgi?id=1196585
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1->v2:
> * remove CONFIG_QFMT_V2 check
> 
>  testcases/kernel/syscalls/quotactl/quotactl01.c | 4 ++--
>  testcases/kernel/syscalls/quotactl/quotactl04.c | 4 ++--
>  testcases/kernel/syscalls/quotactl/quotactl06.c | 4 ++--
>  testcases/kernel/syscalls/quotactl/quotactl08.c | 4 ++--
>  testcases/kernel/syscalls/quotactl/quotactl09.c | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
> index 561e5030fe..63f6e9181c 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl01.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
> @@ -213,8 +213,8 @@ static void verify_quota(unsigned int n)
>  
>  static struct tst_test test = {
>  	.needs_root = 1,
> -	.needs_kconfigs = (const char *[]) {
> -		"CONFIG_QFMT_V2",
> +	.needs_drivers = (const char *const []) {
> +		"quota_v2",
>  		NULL
>  	},
>  	.test = verify_quota,
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
> index 55da282705..fdd1c9b502 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl04.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
> @@ -162,8 +162,8 @@ static void verify_quota(unsigned int n)
>  
>  static struct tst_test test = {
>  	.needs_root = 1,
> -	.needs_kconfigs = (const char *[]) {
> -		"CONFIG_QFMT_V2",
> +	.needs_drivers = (const char *const []) {
> +		"quota_v2",
>  		NULL
>  	},
>  	.min_kver = "4.10", /* commit 689c958cbe6b (ext4: add project quota support) */
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
> index 87715237f5..feb475022d 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
> @@ -216,8 +216,8 @@ static void cleanup(void)
>  static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
> -	.needs_kconfigs = (const char *[]) {
> -		"CONFIG_QFMT_V2",
> +	.needs_drivers = (const char *const []) {
> +		"quota_v2",
>  		NULL
>  	},
>  	.tcnt = ARRAY_SIZE(tcases),
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
> index 3793867f23..da1d62a32f 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl08.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
> @@ -208,8 +208,8 @@ static void verify_quota(unsigned int n)
>  
>  static struct tst_test test = {
>  	.needs_root = 1,
> -	.needs_kconfigs = (const char *[]) {
> -		"CONFIG_QFMT_V2",
> +	.needs_drivers = (const char *const []) {
> +		"quota_v2",
>  		NULL
>  	},
>  	.test = verify_quota,
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl09.c b/testcases/kernel/syscalls/quotactl/quotactl09.c
> index 8b959909ca..9a03bff5f4 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl09.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
> @@ -170,8 +170,8 @@ static void cleanup(void)
>  static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
> -	.needs_kconfigs = (const char *[]) {
> -		"CONFIG_QFMT_V2",
> +	.needs_drivers = (const char *const []) {
> +		"quota_v2",
>  		NULL
>  	},
>  	.tcnt = ARRAY_SIZE(tcases),


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
