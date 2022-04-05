Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311A1C433EF
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 06:49:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E7DF3CA41D
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 08:49:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EE443C5785
 for <ltp@lists.linux.it>; Tue,  5 Apr 2022 08:49:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C0DC010006B2
 for <ltp@lists.linux.it>; Tue,  5 Apr 2022 08:49:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AFBF41F38A;
 Tue,  5 Apr 2022 06:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649141349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X0OlnvCPqllCQv/nl/L6Ds+aW8Bj0ds8YGWewVILZ2w=;
 b=Mv4ClthvWEaGbFgO0vr+c5r77serOot8Yp4d/BixbozW2nrICFkSoUNRqHNMlWE6lvAxvW
 ZobgiXPgajP0FtdIyL7Ien5/Ksl6n/azbDczba/CUIhD5aCjcF7WIyV+ap96tCUMNsjTE6
 KtPnANzEpwD7LGlzrHRCqD70yaqjKvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649141349;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X0OlnvCPqllCQv/nl/L6Ds+aW8Bj0ds8YGWewVILZ2w=;
 b=axQh9B7GA85JwXq3KH81eBUNI2TfvehuCop+N8ZJTwTqUaQ8+/kIuXbAuKNofKLCGUOi5h
 cJY0So9HIT+bScAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A79FD13A30;
 Tue,  5 Apr 2022 06:49:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EjC1KGXmS2IGYAAAMHmgww
 (envelope-from <blezhepekov@suse.de>); Tue, 05 Apr 2022 06:49:09 +0000
MIME-Version: 1.0
Date: Tue, 05 Apr 2022 09:49:09 +0300
From: blezhepekov <blezhepekov@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
In-Reply-To: <YitrrpkBJheQdUAa@yuki>
References: <20220311123957.30998-1-blezhepekov@suse.de>
 <YitrrpkBJheQdUAa@yuki>
User-Agent: Roundcube Webmail
Message-ID: <4adefcd96534fd7623cec275355c5063@suse.de>
X-Sender: blezhepekov@suse.de
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] kernel/pty06: Skip test when TTY not available
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

On 2022-03-11 17:33, Cyril Hrubis wrote:
> Hi!
>> Since TTYs under test are hardcoded, they
>> might not be available in some systems.
> 
> Is the system you are running the tests on completely without ttys?
> 
>> Signed-off-by: Bogdan Lezhepekov <blezhepekov@suse.de>
>> ---
>>  testcases/kernel/pty/pty06.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>> 
>> diff --git a/testcases/kernel/pty/pty06.c 
>> b/testcases/kernel/pty/pty06.c
>> index b621f584f..250c38f6b 100644
>> --- a/testcases/kernel/pty/pty06.c
>> +++ b/testcases/kernel/pty/pty06.c
>> @@ -45,8 +45,6 @@ static struct tst_fzsync_pair fzp;
>> 
>>  static void *open_close(void *unused)
>>  {
>> -	sprintf(tty_path_b, "/dev/tty%d", test_tty_port);
>> -
>>  	while (tst_fzsync_run_b(&fzp)) {
>>  		tst_fzsync_start_race_b(&fzp);
>>  		int fd = SAFE_OPEN(tty_path_b, O_RDWR);
>> @@ -60,7 +58,6 @@ static void *open_close(void *unused)
>> 
>>  static void do_test(void)
>>  {
>> -	sprintf(tty_path_a, "/dev/tty%d", test_tty_port + 1);
>>  	int fd = SAFE_OPEN(tty_path_a, O_RDWR);
>> 
>>  	tst_fzsync_pair_reset(&fzp, open_close);
>> @@ -80,6 +77,12 @@ static void do_test(void)
>> 
>>  static void setup(void)
>>  {
>> +	sprintf(tty_path_a, "/dev/tty%d", test_tty_port + 1);
>> +	sprintf(tty_path_b, "/dev/tty%d", test_tty_port);
>> +
>> +	if (access(tty_path_a, F_OK) != 0 || access(tty_path_b, F_OK) != 0)
>> +		tst_brk(TCONF, "TTY(s) under test not available in system");
> 
> There is no need for the != 0 could be simplified just to:
> 
> 	if (access(...) || access(...))
> 		tst_brk(TCONF, ...);
> 
>>  	tst_fzsync_pair_init(&fzp);
>>  }
>> 
>> --
>> 2.35.1
>> 
>> 
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp

Hi Cyril,

Sorry for the delayed reply. I see the test requires an emulated 
terminal (ttyX), whilst our system supports serial console only (ttySX).

What would be your recommendation, does it make sense to switch to 
ttySX? I wasn't sure about it, so disabling seemed more logical.

Thanks,
Bogdan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
