Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A69710AB82A
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 21:36:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FA233D6D28
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 22:36:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9DF43C67DC
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 22:36:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6E4A7600805
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 22:36:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8D2C04D2E2;
 Thu, 26 Mar 2026 21:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774560960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwGZerOoh067rd7usfnk2V4EVkeyptM7AIcWv5Oj2SQ=;
 b=QnbVQ0rgZgCOh/VwmLmR8qQujqpA+CYcjIk4qOoWs2dBMjqaFsViT3I7F6WEqGcBPlcAW+
 zO9oee6/nI8ANEFS3JbuQ+Fg8phLCs/HD6PJrUP6SxkBXQlHZkFLy2BOyfk7EH45OkkuOW
 6Ab9TukyHUU4phB/aBb2vsrK9BNKYBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774560960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwGZerOoh067rd7usfnk2V4EVkeyptM7AIcWv5Oj2SQ=;
 b=ay/yL9ewoWENNM+1GqEFupENfczbPEzwh8Fq8FqS5UJyKB10rzrkXei9C2OTvP59iWjHnn
 EFtcR4xj77YZWwBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QnbVQ0rg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ay/yL9ew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774560960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwGZerOoh067rd7usfnk2V4EVkeyptM7AIcWv5Oj2SQ=;
 b=QnbVQ0rgZgCOh/VwmLmR8qQujqpA+CYcjIk4qOoWs2dBMjqaFsViT3I7F6WEqGcBPlcAW+
 zO9oee6/nI8ANEFS3JbuQ+Fg8phLCs/HD6PJrUP6SxkBXQlHZkFLy2BOyfk7EH45OkkuOW
 6Ab9TukyHUU4phB/aBb2vsrK9BNKYBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774560960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwGZerOoh067rd7usfnk2V4EVkeyptM7AIcWv5Oj2SQ=;
 b=ay/yL9ewoWENNM+1GqEFupENfczbPEzwh8Fq8FqS5UJyKB10rzrkXei9C2OTvP59iWjHnn
 EFtcR4xj77YZWwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 674754A0A6;
 Thu, 26 Mar 2026 21:36:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ge3MFsCmxWngXAAAD6G6ig
 (envelope-from <rbranco@suse.de>); Thu, 26 Mar 2026 21:36:00 +0000
Message-ID: <41b27c72-ac8c-4f4d-93e3-39928af34031@suse.de>
Date: Thu, 26 Mar 2026 22:35:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20260326125216.159239-1-pvorel@suse.cz>
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <20260326125216.159239-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,suse.cz:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8D2C04D2E2
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd03.c: Require kernel 6.1
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



On 3/26/26 1:52 PM, Petr Vorel wrote:
> Required kernel functionality was added in kernel 6.1 (not 6.11)
> 2d5de004e009 ("userfaultfd: add /dev/userfaultfd for fine grained access control")
>
> Because it's a new kernel functionality which has not been backported to
> enterprise kernels we can simplify check with just .min_kver.
>
> Fixes: b63ab54aee ("userfaultfd: Do not use min_kver as gate for test")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi all,
>
> @Li I suppose RHEL kernel haven't backport this.
>
> Kind regards,
> Petr
>
>   testcases/kernel/syscalls/userfaultfd/userfaultfd03.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
> index b65f39ecab..dd4354be6f 100644
> --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
> @@ -24,15 +24,6 @@ static char *page;
>   static void *copy_page;
>   static int uffd;
>   
> -static void setup(void)
> -{
> -	if (access("/dev/userfaultfd", F_OK) != 0) {
> -		int res = (tst_kvercmp(6, 1, 0) < 0) ? TCONF : TBROK;
> -
> -		tst_brk(res, "/dev/userfaultfd not found");
> -	}
> -}
> -
>   static int open_userfaultfd(int flags)
>   {
>   	int fd, fd2;
> @@ -127,8 +118,8 @@ static void run(void)
>   
>   static struct tst_test test = {
>   	.needs_root = 1,
> -	.setup = setup,
>   	.test_all = run,
> +	.min_kver = "6.1",
>   	.needs_kconfigs = (const char *[]) {
>   		"CONFIG_USERFAULTFD=y",
>   		NULL
Reviewed-by: Ricardo Branco <rbranco@suse.de>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
