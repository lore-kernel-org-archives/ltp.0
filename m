Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537CCC7115B
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 09:03:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DD593CC848
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 11:03:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79DCB3CC794
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 11:03:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CBB7D6009C9
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 11:03:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0FE8021165;
 Fri, 20 Jun 2025 09:03:40 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F009B136BA;
 Fri, 20 Jun 2025 09:03:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h6ioOesjVWivawAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Jun 2025 09:03:39 +0000
Date: Fri, 20 Jun 2025 11:04:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aFUkEQXv7Wcy0lvv@yuki.lan>
References: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
 <aDcRHXhOBcqVDp05@yuki.lan>
 <CAEemH2f6qeojmFXfisc-_o3iFbda98p2JCVAV_K09gbKtVQp1g@mail.gmail.com>
 <CAEemH2f8B5aJffcnbkYsr9j5KfZutgQkken8vbokNhsu19C8MA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f8B5aJffcnbkYsr9j5KfZutgQkken8vbokNhsu19C8MA@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 0FE8021165
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Reduce .runtime for Long-Running Tests ?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> After a round of experiments and internal discussions (thanks to
> Ian Wien for sharing his thoughts with me), we think that making
> LTP_RUNTIME_MUL support floating point numbers [0, 1] may
> a possible way to reduce the .runtime values set in tests.
> 
> For example, setting LTP_RUNTIME_MUL to 0.1 can obviously
> reduce the test time of 600 seconds to 60 seconds.
> 
> One may think that reducing the .runtime value in aproduction
> environment is potentially risky, and to some extent the answer
> is yes.
> 
> But looking back, LTP is triggered very frequently in CI and various
> production flows, so to compensate for this loss, we can use floating
> point LTP_RUNTIME_MUL only in designated quick CI, instead of
> using it in daily tests. This will help cover more scenarios.

Having reduced runtime for CI makes sense, as you said you are making up
for the reduction by the number of testruns. It may not work well for
fuzzy sync though where we depend on having good enough sampling period.

Also limiting the smallest multiplier to be 0.1 or so does make sense. I
assume that if we set it to 0.01 or smaller most tests with runtime
woudn't even execute.

> From our CI report, use 0.1 in runtime_mul find a few failures in the round
> down problem with nice05.c (.runtime = 3), this is a defect of
> multply_runtime().
> Also, another preadv203 possible failure related this. But they are tiny
> issues. And the rest .runtime tests so far no obvious problem on that.

I guess that we need to make sure that the runtime stays positive. So
maybe we need something as:

runtime = MAX(2, tst_test->runtime * runtime_mul)

> So I would like to start the work from this point to reduce execution time.

Sounds good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
