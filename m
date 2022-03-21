Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1687C433F5
	for <ltp@archiver.kernel.org>; Mon, 21 Mar 2022 16:28:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B01023C8145
	for <ltp@archiver.kernel.org>; Mon, 21 Mar 2022 17:28:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C59923C67E3
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 17:28:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1C894140007E
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 17:28:38 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 60C7B210F1
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647880118;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NUM+HqjkK+nU7U25apdkQAH39nLRShaL7k/HZus2T8o=;
 b=kOydByWPka8p5xajylOSdYm8NJp3EnLT2XYbNXhOd7BZwaXVE132mcPzLbUjZQ6LX5L3es
 uWb4uXObwJvs0fEJ4M8hpi+ffuCnNgJ99Knrnv2MjFkImPCPE7FbZ1HSXBzABCNQMAf11I
 yCtHKQU+ySmVOJqzaYY/ybhX4+2JSOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647880118;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NUM+HqjkK+nU7U25apdkQAH39nLRShaL7k/HZus2T8o=;
 b=6TwAK9IAgP2ZfzQcR3VC+d9gjQSFfh17cuffTo1V05gdBWFQKwy93I9bpvKid1yoJregOf
 gE5I7XBjNnK2O6CA==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1FF54A3BF0;
 Mon, 21 Mar 2022 16:28:38 +0000 (UTC)
References: <20220310105533.3012-1-chrubis@suse.cz> <YinZzNWCiKalyWhd@yuki>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Mar 2022 15:48:08 +0000
In-reply-to: <YinZzNWCiKalyWhd@yuki>
Message-ID: <87ee2vclsf.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/waitid10: Fix on ARM,
 PPC and possibly others
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

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> While integer division by zero does trap on x86_64 and causes the SIGFPE
>> signal to be delivered it's not the case on all architecutes. At least
>> on ARM and PPC64LE division by zero simply returns undefined result
>> instead.

Nit picking: even with this patch we are still testing undefined
behaviour.

   There are six signals that can be delivered as a consequence of a
   hardware exception: SIGBUS, SIGEMT, SIGFPE, SIGILL, SIGSEGV, and
   SIGTRAP.  Which of these signals is delivered, for any given
   hard- ware exception, is not documented and does not always make
   sense.

If dividing by zero produces SIGEMT then it's still valid according to
the specification. FPE does stand for floating point exception, but we
are dividing integers.

>> 
>> This patch adds raise(SIGFPE) at the end of the child as a fallback to
>> make sure the process is killed with the right signal on all
>> architectures.
>> 
>> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>> ---
>>  testcases/kernel/syscalls/waitid/waitid10.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
>> index 869ef18bd..8c351d120 100644
>> --- a/testcases/kernel/syscalls/waitid/waitid10.c
>> +++ b/testcases/kernel/syscalls/waitid/waitid10.c
>> @@ -28,7 +28,10 @@ static void run(void)
>>  		volatile int a, zero = 0;
>>  
>>  		a = 1 / zero;
>> -		exit(a);
>> +
>> +		tst_res(TINFO, "Division by zero didn't trap, raising SIGFPE");
>
> This patch inroduces 'set but not used' warning for the a variable so
> maybe the message should look like:
>
> 		tst_res(TINFO, "1/0 = %i raising SIGFPE", a);
>
>> +		raise(SIGFPE);

I'm wondering if we should branch on the architecture. If it's x86[_64]
then we only do divide by zero as it's reasonable to think that if the
signal is not raised then this is a bug.

>>  	}
>>  
>>  	TST_EXP_PASS(waitid(P_ALL, 0, infop, WEXITED));
>> -- 
>> 2.34.1
>> 
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
