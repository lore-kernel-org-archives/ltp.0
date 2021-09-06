Return-Path: <SRS0=3a48=N4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FACC433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 13:01:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F3560F45
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 13:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46F3560F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4641F3C9520
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 15:01:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DFE33C25E9
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 15:01:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8E2921400980
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 15:01:08 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D816B220E7;
 Mon,  6 Sep 2021 13:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1630933267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wIUzE9pEdy7SjnFtKA4goRKqCIfBuD+Cxkum/bJKH+M=;
 b=t+dDbjNq00BlkgeIFDBrXmq1Q64THwbB6mXQ/SHxA+07ypO/P2eYUOJkpPgV2h4bNckT6H
 ogEeB91/X+Q/+qkPaS+WQ5L0HVG5lwDNdPwlmNx0zV6q7f73hj3xXh2dVVrSkSQz1v+RLL
 Yg5rjrPCTuP/BtR3ktoelLbZPjjD8eY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1630933267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wIUzE9pEdy7SjnFtKA4goRKqCIfBuD+Cxkum/bJKH+M=;
 b=yCDC9IjanHRtbA+3lQTmfNo/ZmBKBreaWl+Y34n6dYQLjZFKb+C9uDtRgZpCWImoK+6WtX
 YLKEJwElgF6uURBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C42CE1398F;
 Mon,  6 Sep 2021 13:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id +2nlLhMRNmFlOgAAGKfGzw
 (envelope-from <mdoucha@suse.cz>); Mon, 06 Sep 2021 13:01:07 +0000
Message-ID: <2ce3b46e-b503-a44d-8c16-819e587e217a@suse.cz>
Date: Mon, 6 Sep 2021 15:01:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20210903154848.18705-1-mdoucha@suse.cz>
 <20210903154848.18705-5-mdoucha@suse.cz> <YTYJUPFc75TuOJSb@yuki>
 <77fd98d9-5257-c1da-a01b-77d8cc1b6bce@suse.cz> <YTYOpPM5uupQrayf@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YTYOpPM5uupQrayf@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/7] syscalls/kill05: Use any two unprivileged
 users
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210906130107.TnlzfGyl90uYucwfjdkXRoAw-hNoZdxyw92PYjszBQA@z>

On 06. 09. 21 14:50, Cyril Hrubis wrote:
> Hi!
>>> I do wonder if we have to lookup the UIDs in this case. As long as I
>>> understand the test correctly we are testing that no signals are send to
>>> a process if the sender real of effective UID do not match either of
>>> real and saved set UIDs of the receiving process. If my understanding is
>>> correct we can just take two arbitrary UIDs that != 0 and the test
>>> should work just fine.
>>
>> We could just use UID 1 and 2 for this test but I'd rather not assume
>> that set*uid() functions allow setting unused UIDs. Even if it works
>> now, it could easily break in the future or on some special system auth
>> backends.
> 
> Don't we already depend on being able to use unused GID? How is this
> different?

We only set unused user/group IDs on files and directories using
chown(). That's perfectly safe because inode owner is just an arbitrary
number that doesn't need to exist as a real entry in the user/group
database. You can get the same result by creating the files under a
valid owner and then deleting the respective user/group so the system
has to be able to handle that situation.

But setting a non-existent UID/GID on a running process is different
because the kernel might try to look up some additional data in the
user/group database and block the credentials change if the lookup fails.

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
