Return-Path: <SRS0=5Ww9=PQ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A41C433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 09:54:10 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C37360FC0
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 09:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C37360FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB8BF3C6C49
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 11:54:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B07A3C6AD3
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 11:53:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3081A20E758
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 11:53:56 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D2EDC21965
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1635414835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZHBqKx85NEoa7OJl3CGsusb3cXUWEQi52TX1GQwIfOA=;
 b=ejNF/1wMyF6bTwEhhAFuGn0HqGRzqBgm9BRgvPJJ0eOqnOqe50E+dRxJ6bnUAdlRoYcE43
 lU08pBr6cvz1jbmVDjVt87raPWudeeWB28PBXeLlFuRIkgw+lfNvIadJOPbSWN1QS3bdu9
 bz+WX9AKYBFHG6pf+MSw1ukVxCtYGLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1635414835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZHBqKx85NEoa7OJl3CGsusb3cXUWEQi52TX1GQwIfOA=;
 b=FBAG1zzWlii+PE9/i9c6M4cdIqvt0QTL6p1F825jxcEq3ZCm++ul3UhgOMs2GkeaCIi7qF
 bNufmJgB+hSeUFDA==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 824ACA3B83;
 Thu, 28 Oct 2021 09:53:55 +0000 (UTC)
References: <20211018154800.11013-1-chrubis@suse.cz>
 <87tuh2poue.fsf@suse.de> <YXlYwi7+VUIitM7H@yuki>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Oct 2021 09:11:09 +0100
In-reply-to: <YXlYwi7+VUIitM7H@yuki>
Message-ID: <87pmrppj9u.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/7] docparse improvements
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
>> It's unfortunate that before starting this effort and the checker that
>> we didn't know about tree-sitter (although Sparse may still be the best
>> choice for the checker).
>> 
>> Tree-sitter can parse C into an AST and can easily be vendored into LTP:
>> https://tree-sitter.github.io/tree-sitter/using-parsers#building-the-library
>> 
>> Then we just need to work on the level of the AST. It also has a query
>> language. This should allow the initial matching to be done on a high
>> level.
>
> The only worry that I have about this would be speed, currently the code
> I wrote takes a few second to process thousands of C files in LTP, that
> is because we take a lot of shortcuts and ignore all the stuff we do not
> need. Full parser that builds AST would be orders of magnitude slower,
> so before we attempt to use it it should be benchmarked properly to see
> if it's fast enough.

It's incredibly fast, it has no trouble parsing the entire kernel.

Weggli uses tree-sitter

https://github.com/googleprojectzero/weggli

rich@g78 ~/q/ltp (master)> time weggli '_ verify_alarm(_) { exit(0); }' .
/home/rich/qa/ltp/./testcases/kernel/syscalls/alarm/alarm03.c:21
static void verify_alarm(void)
{
	pid_t pid;

	TEST(alarm(100));

..
		} else {
			tst_res(TPASS,
				"alarm(100), fork, alarm(0) child's "
				"alarm returned %ld", TST_RET);
		}
		exit(0);
	}

	TEST(alarm(0));
	if (TST_RET != 100) {
		tst_res(TFAIL,
..
}
/home/rich/qa/ltp/./testcases/kernel/syscalls/alarm/alarm07.c:20
static void verify_alarm(void)
{
	pid_t pid;
	alarm_cnt = 0;

	TEST(alarm(1));
..
			tst_res(TPASS, "alarm() request cleared in child");
		} else {
			tst_res(TFAIL, "alarm() request not cleared in "
				"child; alarms received:%d", alarm_cnt);
		}
		exit(0);
	}

	if (alarm_cnt != 1)
		tst_res(TFAIL, "Sigalarms in parent %i, expected 1", alarm_cnt);
	else
..
}

________________________________________________________
Executed in   49.35 millis    fish           external
   usr time  110.88 millis    0.00 millis  110.88 millis
   sys time   87.44 millis    1.20 millis   86.24 millis

>
>> If we continue down the path of hand parsing C, then it will most likely
>> result in constant tweaks and additions.
>
> Well I would say that this patchset is the last addition for the parser,
> if we ever need anything more complex we should really switch to
> something else. On the other hand I do not think that we will ever need
> more complexity in the parser than this, as long as we keep things
> sane.

This closes the door on a lot of options for no upside AFAICT. We have
two tools (Sparse and tree-sitter) that can be (or have been) vendored
and will parse a large subset of C. Sparse goes a step further allowing
control flow analysis. The usual reasons for reinventing the wheel are
not present.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
