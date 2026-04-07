Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD1FFEEF49
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 14:57:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B0B23E2E7E
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 16:57:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAF893E16E7
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 16:56:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F364810007FB
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 16:56:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66E4C4E4B4;
 Tue,  7 Apr 2026 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775573813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/53PZCjTpqMsDnuteM0z2BeGCNHRli+3tylngxxcXNY=;
 b=VAgAl43kWWYfFTgAOmK+pmGFv4T06kiEozNP5IUD4lBLMQ46PkG/CekkzZNlTKLJOHrCTi
 yRMv7EW6jvtVMELAvesje/vFYMTkCCiALCY6m0ZslyUC3bi75vBrFFMAaTf70ZF7+Juced
 lU8g4fh5bwKsPrZUcq1Fizd07ukPVKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775573813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/53PZCjTpqMsDnuteM0z2BeGCNHRli+3tylngxxcXNY=;
 b=v3QonF0/4SDYyZPD4khabpLp2V1oF8Sgc8sBTrtExTs62QcMS+uLm4eKVCqGwnnkGKmVMC
 C88eWGQgB7iqyCDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775573813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/53PZCjTpqMsDnuteM0z2BeGCNHRli+3tylngxxcXNY=;
 b=VAgAl43kWWYfFTgAOmK+pmGFv4T06kiEozNP5IUD4lBLMQ46PkG/CekkzZNlTKLJOHrCTi
 yRMv7EW6jvtVMELAvesje/vFYMTkCCiALCY6m0ZslyUC3bi75vBrFFMAaTf70ZF7+Juced
 lU8g4fh5bwKsPrZUcq1Fizd07ukPVKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775573813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/53PZCjTpqMsDnuteM0z2BeGCNHRli+3tylngxxcXNY=;
 b=v3QonF0/4SDYyZPD4khabpLp2V1oF8Sgc8sBTrtExTs62QcMS+uLm4eKVCqGwnnkGKmVMC
 C88eWGQgB7iqyCDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54F804A0B0;
 Tue,  7 Apr 2026 14:56:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KOvQEzUb1WnDLAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Apr 2026 14:56:53 +0000
Date: Tue, 7 Apr 2026 16:57:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <adUbPyRUYPPzh38a@yuki.lan>
References: <20260304-stream_refactoring-v2-0-3e48ada8ff1a@suse.com>
 <20260304-stream_refactoring-v2-2-3e48ada8ff1a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260304-stream_refactoring-v2-2-3e48ada8ff1a@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/6] fs: rewrite stream01 test using new API
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
> +static void read_file(const char *file, const char *str, size_t n)
> +{
> +	char buf[n];
> +	FILE *stream;
> +	size_t len;
>  
> -#define PASSED 1
> -#define FAILED 0
> +	memset(buf, 0, sizeof(buf));
>  
> -/* XXX: add setup and cleanup. */
> +	stream = SAFE_FOPEN(file, "r");
> +	len = SAFE_FREAD(buf, n, n, stream);

Huh, we pass buffer of size n but ask it to read n * n bytes? That does
not seem to be right.

Also the buffer must always be bigger than n to allow the fread() to
read more bytes that we wrote, in a case that the file was written into
intcorrectly. So we need something like:

	char buf[128];

	...

	len = SAFE_FREAD(buf, 1, sizeof(buf), stream);

> +	SAFE_FCLOSE(stream);
>  
> -char progname[] = "stream01()";
> -char tempfile1[40] = "";
> -char tempfile2[40] = "";
> +	TST_EXP_EXPR(len == n, "Read the entire %s file buffer", file);
> +	TST_EXP_EQ_STRN(buf, str, len);
> +}
>  
> -/*--------------------------------------------------------------------*/
> -int main(int ac, char *av[])
> +static void run(void)
>  {
>  	FILE *stream;
> -	char buf[10];
> -	int i;
> -	int lc;
> -
> -	/*
> -	 * parse standard options
> -	 */
> -	tst_parse_opts(ac, av, NULL, NULL);
>  
> -	local_flag = PASSED;
> -	tst_tmpdir();
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +	tst_res(TINFO, "Write %s file", FILENAME1);
> +	stream = SAFE_FOPEN(FILENAME1, "a+");
> +	SAFE_FWRITE(buff_file1, strlen(buff_file1), 3, stream);
>  
> -		sprintf(tempfile1, "stream011.%d", getpid());
> -		sprintf(tempfile2, "stream012.%d", getpid());
> -	/*--------------------------------------------------------------------*/
> -		//block0:
> -		if ((stream = fopen(tempfile1, "a+")) == NULL) {
> -			tst_brkm(TFAIL, NULL, "fopen(%s) a+ failed: %s",
> -				 tempfile1,
> -				 strerror(errno));
> -		}
> -		fwrite("a", 1, 1, stream);
> -		if ((stream = freopen(tempfile2, "a+", stream)) == NULL) {
> -			tst_brkm(TFAIL | TERRNO, NULL, "freopen(%s) a+ failed",
> -				 tempfile2);
> -		}
> -		fwrite("a", 1, 1, stream);
> -		fclose(stream);
> +	tst_res(TINFO, "Write %s file streaming into %s file", FILENAME2, FILENAME1);
> +	stream = SAFE_FREOPEN(FILENAME2, "a+", stream);
> +	SAFE_FWRITE(buff_file2, strlen(buff_file2), 3, stream);

And here as well we ask to write strlen(buff_fiel2) * 3
bytes but the buff_file2 is only 3 characters.

> +	SAFE_FCLOSE(stream);
>  
> -		local_flag = PASSED;
> +	read_file(FILENAME1, buff_file1, 3);
> +	read_file(FILENAME2, buff_file2, 3);
>  
> -	/*--------------------------------------------------------------------*/
> -		unlink(tempfile1);
> -		unlink(tempfile2);
> -
> -	}			/* end for */
> -	tst_rmdir();
> -	tst_exit();
> +	SAFE_UNLINK(FILENAME1);
> +	SAFE_UNLINK(FILENAME2);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_tmpdir = 1,
> +};
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
