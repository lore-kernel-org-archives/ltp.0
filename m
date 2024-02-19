Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48000C48BF8
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 17:16:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 963F23D0B28
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 18:16:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB2013C06DF
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 18:15:54 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6653E602510
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 18:15:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B425D220ED;
 Mon, 19 Feb 2024 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708362951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Cr0xxwkGbPzzGG/az3n7FbfOcSMfCBvX8YxikEDoqSk=;
 b=X4I9Iyvqo7YkyusNcWIbz97Rwq2P176dmxDsac2IWwNAesS9EtpD/Hk08EXP4T3ezJwkbq
 C2SGP0s1sMUvwYLHP9L0UiDioCzxhzuGOL4ebtVyfZ+kms/xpCS3t2hv/I6EC2lwcsplEh
 CG9Y90Bc+abmboQBtli7Pe9zlJaOPlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708362951;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Cr0xxwkGbPzzGG/az3n7FbfOcSMfCBvX8YxikEDoqSk=;
 b=rUITLvoNf1SpschFgAJoZ7Ndkd8rHno0cLT4AQT/JG8wuTROq1uin8846g9/FMyeDz83NE
 6uWpI7QxUxuYOEBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708362951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Cr0xxwkGbPzzGG/az3n7FbfOcSMfCBvX8YxikEDoqSk=;
 b=X4I9Iyvqo7YkyusNcWIbz97Rwq2P176dmxDsac2IWwNAesS9EtpD/Hk08EXP4T3ezJwkbq
 C2SGP0s1sMUvwYLHP9L0UiDioCzxhzuGOL4ebtVyfZ+kms/xpCS3t2hv/I6EC2lwcsplEh
 CG9Y90Bc+abmboQBtli7Pe9zlJaOPlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708362951;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Cr0xxwkGbPzzGG/az3n7FbfOcSMfCBvX8YxikEDoqSk=;
 b=rUITLvoNf1SpschFgAJoZ7Ndkd8rHno0cLT4AQT/JG8wuTROq1uin8846g9/FMyeDz83NE
 6uWpI7QxUxuYOEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A547213647;
 Mon, 19 Feb 2024 17:15:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lOGTJ8eM02UPDgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Mon, 19 Feb 2024 17:15:51 +0000
Message-ID: <86169685-b118-4186-951f-7919796dcb93@suse.cz>
Date: Mon, 19 Feb 2024 18:15:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20240219134030.12693-1-mdoucha@suse.cz>
 <20240219160922.GB1021019@pevik>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20240219160922.GB1021019@pevik>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X4I9Iyvq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rUITLvoN
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 XM_UA_NO_VERSION(0.01)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B425D220ED
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open07: Convert to new API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 19. 02. 24 17:09, Petr Vorel wrote:
> Hi Martin,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Few minor things below, can be fixed before merge.
> 
> ...
>>   #define _GNU_SOURCE		/* for O_NOFOLLOW */
> nit: This now works without _GNU_SOURCE (we compile with -std=gnu99 and it would
> work for whatever gnu*).
> 
>> -#include <stdio.h>
>> -#include <errno.h>
>> -#include <sys/types.h>
>>   #include <sys/stat.h>
> nit: IMHO <sys/stat.h> was not needed even in the old API version.

Good catch x2. <sys/stat.h> is needed for umask() but it's included 
through tst_safe_macros.h

> 
>> -#include <fcntl.h>
>> -#include "test.h"
>> -#include "safe_macros.h"
> ...
>> +#include "tst_test.h"
>> +#include "tst_safe_macros.h"
>> +
>> +#define TESTFILE "testfile"
>> +#define TESTDIR "testdir"
>> +#define SYMFILE1 "symfile1"
>> +#define SYMFILE2 "symfile2"
>> +#define SYMDIR1 "symdir1"
>> +#define SYMDIR2 "symdir2"
>> +#define PASSFILE "symdir1/testfile"
>> +
>> +static int fd = -1;
> nit: any reason for -1? (We don't check the input.)

I planned to have a cleanup() where the fd would be checked and closed 
if needed. But it wasn't needed in the end and I forgot to remove the 
initialization. The variable can be moved inside setup(). Should I send v2?

> 
>> +static struct testcase {
>> +	const char *path;
>> +	int err;
>> +	const char *desc;
>> +} testcase_list[] = {
>> +	{SYMFILE1, ELOOP, "open(O_NOFOLLOW) a symlink to file"},
>> +	{SYMFILE2, ELOOP, "open(O_NOFOLLOW) a double symlink to file"},
>> +	{SYMDIR1, ELOOP, "open(O_NOFOLLOW) a symlink to directory"},
>> +	{SYMDIR2, ELOOP, "open(O_NOFOLLOW) a double symlink to directory"},
>> +	{PASSFILE, 0, "open(O_NOFOLLOW) a file in symlinked directory"},
> 
> ...
>> +static void setup(void)
>>   {
>> -	char file1[100], file2[100];
>> -
>> -	sprintf(file1, "open11.3.%d", getpid());
>> -	sprintf(file2, "open12.4.%d", getpid());
>> -	SAFE_MKDIR(cleanup, file1, 00700);
>> +	umask(0);
>> +	fd = SAFE_CREAT(TESTFILE, 0644);
>> +	SAFE_CLOSE(fd);
>> +	SAFE_MKDIR(TESTDIR, 0755);
> 
>> -	SAFE_SYMLINK(cleanup, file1, file2);
>> +	SAFE_SYMLINK(TESTFILE, SYMFILE1);
>> +	SAFE_SYMLINK(SYMFILE1, SYMFILE2);
>> +	SAFE_SYMLINK(TESTDIR, SYMDIR1);
>> +	SAFE_SYMLINK(SYMDIR1, SYMDIR2);
> 
>> -	strcpy(TC[4].filename, file2);
>> -	strcat(TC[4].filename, "/");
>> +	fd = SAFE_CREAT(PASSFILE, 0644);
>> +	SAFE_CLOSE(fd);
>>   }
> 
>> -static void setup(void)
>> +static void run(unsigned int n)
>>   {
>> -	umask(0);
>> +	const struct testcase *tc = testcase_list + n;
> 
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> +	TST_RET = -1;
> nit: IMHO this is not needed (we have 0 for stdin, right? Therefore open()
> should not get 0 and check below is correct).

Zero is still a valid file descriptor whether it's used or not. On the 
other hand, TST_RET will be set by open() in both branches below so the 
initialization is not needed at all.

> 
> Kind regards,
> Petr
> 
>> -	TEST_PAUSE;
>> +	if (tc->err) {
>> +		TST_EXP_FAIL2(open(tc->path, O_NOFOLLOW | O_RDONLY), tc->err,
>> +			"%s", tc->desc);
>> +	} else {
>> +		TST_EXP_FD(open(tc->path, O_NOFOLLOW | O_RDONLY),
>> +			"%s", tc->desc);
>> +	}
> 
>> -	tst_tmpdir();
>> +	if (TST_RET >= 0)
>> +		SAFE_CLOSE(TST_RET);
>>   }
> 
> ...
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.test = run,
>> +	.tcnt = ARRAY_SIZE(testcase_list),
>> +	.needs_tmpdir = 1
>> +};

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
