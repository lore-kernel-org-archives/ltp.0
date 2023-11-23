Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518A7C5AD4C
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 15:05:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 671A13D017A
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 16:05:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1FA03CEFCE
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 16:05:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B7FBE601107
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 16:05:11 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A008F1FD8D
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 15:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700751910;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1Oo0oGQOadiG3TwVWqmvxqKfMxS/K/GCzMTbhzCDyg=;
 b=rlSUf+p0b6SJtYsq0WYp0kD5hfivZnQUeyxzhdD0fwS/Yy+EDFLstNhwSWIActjfF1GexD
 79ZmZSQOaKgPC3utZWUQ/fohA3CInfyIz2lrCNWr/Iu5/vJ/703rT6uCfDKONI70/LBMZB
 JHCOXgx2yt1K923NJaKc+URTYorqmSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700751910;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1Oo0oGQOadiG3TwVWqmvxqKfMxS/K/GCzMTbhzCDyg=;
 b=ub48+EgN8aqLt3hDaBGeIgbb9MGrm+UX26AvMQX3C0DvfHHzMUS3jA5WIyPERDsW7ikwuW
 gucnhDwnUmY5xCDg==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0EBFD2CCC6;
 Thu, 23 Nov 2023 10:29:01 +0000 (UTC)
References: <20230921054821.12855-1-akumar@suse.de>
 <20231009080131.GA370124@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 23 Nov 2023 10:27:12 +0000
Organization: Linux Private Site
In-reply-to: <20231009080131.GA370124@pevik>
Message-ID: <87h6lc9310.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++++++
Authentication-Results: smtp-out2.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [16.13 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 NEURAL_SPAM_SHORT(3.00)[1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(1.20)[suse.de];
 R_SPF_SOFTFAIL(4.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 VIOLATED_DIRECT_SPF(3.50)[];
 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-1.16)[88.77%]
X-Rspamd-Queue-Id: A008F1FD8D
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/mmap04: Validate mapping perms in
 /proc/self/maps
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

Petr Vorel <pvorel@suse.cz> writes:

> Hi Avinesh,
>
>> Validating the various combinations of prot+flags arguments in mmap()
>> call and parsing the /proc/self/maps file to verifying resulting mapping
>> has the permission bits as requested in mmap() call.
>
> LGTM + you fixed all Cyril's comments.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> ...
>> +	if (!strcmp(perms, tc->exp_perms))
>> +		tst_res(TPASS, "mapping permissions in /proc matched: %s", perms);
>> +	else
>> +		tst_res(TFAIL, "mapping permissions in /proc mismatched,"
>> +						" expected: %s, found: %s",
>> +						tc->exp_perms, perms);
> Very nit: I wouldn't split the string. IMHO it's better to have easier git
> grepping, than follow 80 line rules. Also checkpatch does not complain
> on this:

+1

>
> 	else
> 		tst_res(TFAIL,
> 			"mapping permissions in /proc mismatched, expected: %s, found: %s",
> 			tc->exp_perms, perms);
>
> This can be fixed before merge.
>
> Kind regards,
> Petr

Please merge :-)

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
