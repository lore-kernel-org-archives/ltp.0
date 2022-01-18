Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6FAC433EF
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 12:12:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA3B93C9698
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 13:12:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 873A23C575C
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 13:12:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EF43514002C5
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 13:12:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E0CC1F3A1;
 Tue, 18 Jan 2022 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642507920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O5wPwuyJAKh2Di61BgsGjOOWkm1KDW8uaNbO0k3zlbc=;
 b=wSW7IfXVof5F2mCo+uz70cK7J+HR3ZTE8r7wqBLRk0wCHFivmmMYqmzP5zkJKAowU+R4cn
 ul33Xyq6jYtjUtwpdGyL4WdIzpJVQaJDeDbmHy6Z6DZ4rkPasOBUi4fzVAGPEpdE8y7wF4
 5cJmTTb7SszfZxfhyOJWVNCBkhk62KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642507920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O5wPwuyJAKh2Di61BgsGjOOWkm1KDW8uaNbO0k3zlbc=;
 b=DxAfecF/oXSSELMFZ5skx/a54o1ZdkSQhb6DnyF7ecXSLAXicq2yOFNxmF0YkWSZUpe3+B
 sM8YJupgYOuhAvCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E6CE13B26;
 Tue, 18 Jan 2022 12:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ajDGAZCu5mH7aAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 18 Jan 2022 12:12:00 +0000
Message-ID: <aa8a3ca7-f2de-65d3-d8f3-8c553e02ddff@suse.cz>
Date: Tue, 18 Jan 2022 13:11:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20220118105044.547-1-andrea.cervesato@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220118105044.547-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Reduce default number of threads in
 dio_sparse.c
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
it'd have been better to move the defaults out of setup() in a separate
commit let's push it as is this time.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 18. 01. 22 11:50, Andrea Cervesato wrote:
> Initialized options out of setup and reduced default number of
> threads from 1000 to 16
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
> ---
>  testcases/kernel/io/ltp-aiodio/dio_sparse.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> index 929adbfba..8635df82f 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> @@ -33,11 +33,11 @@ static char *str_writesize;
>  static char *str_filesize;
>  static char *str_offset;
>  
> -static int numchildren;
> -static long long writesize;
> -static long long filesize;
> -static long long offset;
> -static long long alignment;
> +static int numchildren = 16;
> +static long long writesize = 1024;
> +static long long filesize = 100 * 1024 * 1024;
> +static long long offset = 0;
> +static long long alignment = 512;
>  
>  static void dio_sparse(int fd, int align, long long fs, int ws, long long off)
>  {
> @@ -60,12 +60,6 @@ static void setup(void)
>  {
>  	struct stat sb;
>  
> -	numchildren = 1000;
> -	writesize = 1024;
> -	filesize = 100 * 1024 * 1024;
> -	offset = 0;
> -	alignment = 512;
> -
>  	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
>  		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
>  
> @@ -129,7 +123,7 @@ static struct tst_test test = {
>  	.needs_tmpdir = 1,
>  	.forks_child = 1,
>  	.options = (struct tst_option[]) {
> -		{"n:", &str_numchildren, "Number of threads (default 1000)"},
> +		{"n:", &str_numchildren, "Number of threads (default 16)"},
>  		{"w:", &str_writesize, "Size of writing blocks (default 1K)"},
>  		{"s:", &str_filesize, "Size of file (default 100M)"},
>  		{"o:", &str_offset, "File offset (default 0)"},


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
