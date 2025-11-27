Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C8CD11183
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 10:31:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDB863CC81F
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 11:31:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87C453CA7B4
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 11:31:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EAB3C10009CE
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 11:31:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1C32833693;
 Thu, 27 Nov 2025 10:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764239487;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V/gGwzYnc9J8KYbTPuooGTrQqn6X0tnrM0hiEZopca8=;
 b=QssInMXGPbc1VLX5pfcykvnADMaI1JF0b0LF9naMDTmW+3b/iQg6pCtd0g5arVqVVxerIP
 06YwAf8/JscO08wTbjE+jN3kaghYy8d0bkppKsix2/T4Tfdi//HESQWXq/LIXdX1/o/XdL
 RuqS7rhciXLQxg0O9vKejVlgYVoP8/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764239487;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V/gGwzYnc9J8KYbTPuooGTrQqn6X0tnrM0hiEZopca8=;
 b=lQ6j/ucTuvrk7SN1k48dee7jrEEfEQx+8k+9bjQqeC2UGxyX1AbL7+vPIf/xSjLy/qgGaC
 6kEtc4JN5SAKJxBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764239487;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V/gGwzYnc9J8KYbTPuooGTrQqn6X0tnrM0hiEZopca8=;
 b=QssInMXGPbc1VLX5pfcykvnADMaI1JF0b0LF9naMDTmW+3b/iQg6pCtd0g5arVqVVxerIP
 06YwAf8/JscO08wTbjE+jN3kaghYy8d0bkppKsix2/T4Tfdi//HESQWXq/LIXdX1/o/XdL
 RuqS7rhciXLQxg0O9vKejVlgYVoP8/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764239487;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V/gGwzYnc9J8KYbTPuooGTrQqn6X0tnrM0hiEZopca8=;
 b=lQ6j/ucTuvrk7SN1k48dee7jrEEfEQx+8k+9bjQqeC2UGxyX1AbL7+vPIf/xSjLy/qgGaC
 6kEtc4JN5SAKJxBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F276D3EA63;
 Thu, 27 Nov 2025 10:31:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g9tGOX4oKGlLIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Nov 2025 10:31:26 +0000
Date: Thu, 27 Nov 2025 11:31:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Pavithra <pavrampu@linux.ibm.com>
Message-ID: <20251127103125.GA227467@pevik>
References: <20251127072231.2104445-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251127072231.2104445-1-pavrampu@linux.ibm.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] Adding new function read_maps required for
 hugemmap40.
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

Hi Pavithra, Geetika,

> Function to read and parse the '/proc/self/maps' file to debug memory-related issues.

First of all, do you plan to use read_maps() in other hugemmap tests? Otherwise
it does not make sense to add it to hugetlb.c library.

> Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
> ---
>  testcases/kernel/mem/hugetlb/lib/hugetlb.c | 42 ++++++++++++++++++++++
>  testcases/kernel/mem/hugetlb/lib/hugetlb.h |  1 +
>  2 files changed, 43 insertions(+)

> diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
> index 6a2976a53..fdd745eda 100644
> --- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
> +++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
> @@ -141,3 +141,45 @@ void update_shm_size(size_t * shm_size)
>  		*shm_size = shmmax;
>  	}
>  }
> +
> +#define MAPS_BUF_SZ 4096
NOTE: we usually use BUFSIZ (from <stdio.h>) for these purposes.
nit: we usually have definitions at the top. (I know this file has #define
RANDOM_CONSTANT 0x1234ABCD, but this file is outdated, not following LTP
standards.)

> +int read_maps(unsigned long addr, char *buf)
> +{
> +        FILE *f;
> +        char line[MAPS_BUF_SZ];
> +        char *tmp;
> +
> +        f = fopen("/proc/self/maps", "r");

> +        if (!f) {
nit: we have SAFE_FOPEN(), this check is not needed. See my commit today:
https://github.com/linux-test-project/ltp/commit/f3803d4bfabe4da10d9fc1824df5b10c249dbed6
and please rebase your next version.

> +                tst_res(TFAIL, "Failed to open /proc/self/maps: %s\n", strerror(errno));
Even we did not have not have safe function, failure like this we consider hard
and use tst_brk(TBROK | TERRNO) to quit whole testing.
> +                return -1;
> +        }
> +
> +        while (1) {
> +                unsigned long start, end, off, ino;
> +                int ret;
> +
> +                tmp = fgets(line, MAPS_BUF_SZ, f);
> +                if (!tmp)
> +                        break;

Using
while (fgets(line, BUFSIZ, f) != NULL) {

is much simpler than having char *tmp just for checking.

> +
> +                buf[0] = '\0';
Why this? That's IMHO unnecessary.

> +                ret = sscanf(line, "%lx-%lx %*s %lx %*s %ld %255s",
> +                             &start, &end, &off, &ino,
> +                             buf);
> +                if ((ret < 4) || (ret > 5)) {
> +                        tst_res(TFAIL, "Couldn't parse /proc/self/maps line: %s\n",
> +                                        line);
> +                        fclose(f);
> +                        return -1;

FYI we can also have FILE_LINES_SCANF() and SAFE_FILE_LINES_SCANF() macros,
which wraps file_lines_scanf() from lib/safe_file_ops.c which uses vsscanf().
I believe it could be used for the task you want to achieve.
> +                }
> +
> +                if ((start <= addr) && (addr < end)) {
> +                        fclose(f);
> +                        return 1;
> +                }
> +        }
> +
> +        fclose(f);
> +        return 0;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
