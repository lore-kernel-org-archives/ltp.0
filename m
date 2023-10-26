Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD8BC25B6B
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 06:36:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CB5C3CCB37
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 08:36:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 315173C0932
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 08:36:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F31861000B0C
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 08:36:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C0521FDF9;
 Thu, 26 Oct 2023 06:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1698302179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oNJfgo3DVdbIruvW49CMuS7aZaReZGZ1yWL2R8pJWy4=;
 b=LobrGqCQ617bOvCHTeiqImwXIXSJX6uOQuM7mZTZ+k+nBXIsOEoZ7PbyYvZCyao4iggI6N
 rOiLbBXzLxv7cfdV/QH0JuGDQx1ZQUJIierc9DZLIYKZiL0FPtZ/ja5h+kSu4ehTSdG+DN
 JRtMMBi14ne+Cahq5dLqKj1VeDS7OG8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DA72133F5;
 Thu, 26 Oct 2023 06:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zGkbAuMIOmW5WQAAMHmgww
 (envelope-from <ybonatakis@suse.com>); Thu, 26 Oct 2023 06:36:19 +0000
References: <20231025110835.28832-1-mkittler@suse.de>
 <20231025110835.28832-5-mkittler@suse.de> <20231025221349.GD477570@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Oct 2023 08:34:58 +0200
Organization: Linux Private Site
In-reply-to: <20231025221349.GD477570@pevik>
Message-ID: <87lebpnb4v.fsf@>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.23 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-3.00)[-1.000]; HAS_ORG_HEADER(0.00)[];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; INVALID_MSGID(1.70)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.33)[75.80%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 4/4] Extend ioctl02 to test termio and termios
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
From: iob via ltp <ltp@lists.linux.it>
Reply-To: iob <ybonatakis@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Petr Vorel <pvorel@suse.cz> writes:

> Hi Marius
>
> ...
>> -	if (termio.c_iflag != (BRKINT | IGNPAR | INPCK | ISTRIP
>> -		 | ICRNL | IUCLC | IXON | IXANY | IXOFF)) {
>> -		tst_res(TFAIL, "iflag has incorrect value. %o",
>> -			 termio.c_iflag);
>> -		flag++;
>
>> +#define CMP_ATTR(tcexp, tcval, attr) \
>> +	do { \
>> +		if ((tcval).attr != (tcexp).attr) { \
>> +			tst_res(TINFO, #attr " has incorrect value %o", \
>> +				(tcval).attr); \
>> +			flag++; \
>> +		} \
>> +	} while (0)
>> +
>> +#define CECK_CONTROL_CHARS(tcval) \
Was this meant to named as CHECK_CONTROL_CHARS?


>> +	for (i = 0; i < NCC; i++) { \
>> +		if (i == VEOL2) { \
>> +			if (!(tcval).c_cc[i]) { \
>> +				continue; \
>> +			} else { \
>> +				tst_res(TFAIL, "control char %d has " \
>> +					 "incorrect value %d", i, (tcval).c_cc[i]); \
>> +				flag++; \
>> +				continue; \
>> +			} \
>> +		} \
>> +		if ((tcval).c_cc[i] != CSTART) { \
>> +			tst_res(TFAIL, "control char %d has incorrect " \
>> +				 "value %d.", i, (tcval).c_cc[i]); \
>> +			flag++; \
>> +		} \
>>  	}
>
> Could be this written as a function? Or what is the benefit of it?  Because
> readability suffers. (We prefer avoid macros, tst_test_macros.h is the exception
> due using kernel syscalls, but readability also suffers).
>
> I know you mentioned C++ in cover letter, but please no C++ :).
>
> Kind regards,
> Petr


-- 
Sent with my mu4e

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
