Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BCBC433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 11:53:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C78C3CA50F
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 13:53:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65BB43C00C2
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 13:53:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BBC106005D2
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 13:53:36 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 07536210F5
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649678015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ohlZc0zz2G9rXIy8nnI3JCsJBWMIy6REhThcZAEDg8s=;
 b=BSbYZOzD+YDD+22INulkl1yGVXAAS9zHt3Ui3ApnR6xe+P+oEDpeFVHvarJIzweL+GA2q+
 MxhUwQDU+lMX2o17cLBQ+FCW3ddp/km7dXFcCDZ1ym6l3n6incJkLZpfhXKHLPq2O8WIzn
 GeKjb5C+iG1zAyNdBLLPP4o9PhMloD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649678015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ohlZc0zz2G9rXIy8nnI3JCsJBWMIy6REhThcZAEDg8s=;
 b=af+xk1QMp9eK6M7qAq5fWL+i2YdsoUtX8ouLl7OSYRt3joV1fL5/HxuPAHML1ekGYN7HpT
 QinNIHacaR1TRHBQ==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C07E1A3B92;
 Mon, 11 Apr 2022 11:53:34 +0000 (UTC)
References: <20220311123957.30998-1-blezhepekov@suse.de>
 <YitrrpkBJheQdUAa@yuki> <4adefcd96534fd7623cec275355c5063@suse.de>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: blezhepekov <blezhepekov@suse.de>
Date: Mon, 11 Apr 2022 12:25:16 +0100
In-reply-to: <4adefcd96534fd7623cec275355c5063@suse.de>
Message-ID: <877d7vhm4i.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Bogdan,

blezhepekov <blezhepekov@suse.de> writes:

> On 2022-03-11 17:33, Cyril Hrubis wrote:
>> Hi!
>>> Since TTYs under test are hardcoded, they
>>> might not be available in some systems.
>> Is the system you are running the tests on completely without ttys?
>> 
>>> Signed-off-by: Bogdan Lezhepekov <blezhepekov@suse.de>
>>> ---
>>>  testcases/kernel/pty/pty06.c | 9 ++++++---
>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>> diff --git a/testcases/kernel/pty/pty06.c 
>>> b/testcases/kernel/pty/pty06.c
>>> index b621f584f..250c38f6b 100644
>>> --- a/testcases/kernel/pty/pty06.c
>>> +++ b/testcases/kernel/pty/pty06.c
>>> @@ -45,8 +45,6 @@ static struct tst_fzsync_pair fzp;
>>>  static void *open_close(void *unused)
>>>  {
>>> -	sprintf(tty_path_b, "/dev/tty%d", test_tty_port);
>>> -
>>>  	while (tst_fzsync_run_b(&fzp)) {
>>>  		tst_fzsync_start_race_b(&fzp);
>>>  		int fd = SAFE_OPEN(tty_path_b, O_RDWR);
>>> @@ -60,7 +58,6 @@ static void *open_close(void *unused)
>>>  static void do_test(void)
>>>  {
>>> -	sprintf(tty_path_a, "/dev/tty%d", test_tty_port + 1);
>>>  	int fd = SAFE_OPEN(tty_path_a, O_RDWR);
>>>  	tst_fzsync_pair_reset(&fzp, open_close);
>>> @@ -80,6 +77,12 @@ static void do_test(void)
>>>  static void setup(void)
>>>  {
>>> +	sprintf(tty_path_a, "/dev/tty%d", test_tty_port + 1);
>>> +	sprintf(tty_path_b, "/dev/tty%d", test_tty_port);
>>> +
>>> +	if (access(tty_path_a, F_OK) != 0 || access(tty_path_b, F_OK) != 0)
>>> +		tst_brk(TCONF, "TTY(s) under test not available in system");
>> There is no need for the != 0 could be simplified just to:
>> 	if (access(...) || access(...))
>> 		tst_brk(TCONF, ...);
>> 
>>>  	tst_fzsync_pair_init(&fzp);
>>>  }
>>> --
>>> 2.35.1
>>> 
>>> --
>>> Mailing list info: https://lists.linux.it/listinfo/ltp
>
> Hi Cyril,
>
> Sorry for the delayed reply. I see the test requires an emulated
> terminal (ttyX), whilst our system supports serial console only
> (ttySX).
>
> What would be your recommendation, does it make sense to switch to
> ttySX? I wasn't sure about it, so disabling seemed more logical.

No, I think this only applies to graphical VTs. I'm not sure if it is
possible to create one on a system without real graphics.

Unless someone has an answer to the above, I think it is enough for now
to address Cyril's access comments and post a V2.

>
> Thanks,
> Bogdan


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
