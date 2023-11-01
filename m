Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9041BC4332F
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 08:06:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58F043CE060
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 09:06:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 528753C2B3E
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 09:06:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 435661A0199B
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 09:06:35 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id CBFA521A85;
 Wed,  1 Nov 2023 08:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698825994;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+cJHdorrEqsfOev8KubW/WJIlR+g9I4vxZ5K23bVB2k=;
 b=d5KWEuP4aKtQAPoQ99WAMj+F+qzliZdO3+mDr0ITf+nQJdf9cKPWcxCezyk1gH8HjDPsKp
 bgeqKhbeTDUkL+jRLBFDMMcMhGK0VBjz6uWIGrwQhvUPWjMzR1jEOXEOl5krcmgsOx62E0
 2rIdSNjOBSDZ3R6xKfdfYocmZpRAsP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698825994;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+cJHdorrEqsfOev8KubW/WJIlR+g9I4vxZ5K23bVB2k=;
 b=Ed7Eb95cL6CYyuUH+nokW0GKKHHzac5KG08CkgPXefuXQe6GsllXwEMJjvDw1tS7nEzeHu
 X40MaRm5xzM4WmCQ==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4A0352CFFD;
 Wed,  1 Nov 2023 08:06:34 +0000 (UTC)
References: <20230911094043.25511-1-andrea.cervesato@suse.de>
 <87edhrvx3r.fsf@suse.de> <ZUE1MWuiU63iK3IU@yuki>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 01 Nov 2023 08:01:46 +0000
Organization: Linux Private Site
In-reply-to: <ZUE1MWuiU63iK3IU@yuki>
Message-ID: <87v8alsxrq.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor getdtablesize01 using new LTP API
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
>> > +static void setup(void)
>> >  {
>> > +	int fd;
>> > +
>> > +	fd = SAFE_CREAT(FILENAME, 0644);
>> > +	SAFE_CLOSE(fd);
>> >  }
>> > +
>> > +static struct tst_test test = {
>> > +	.test_all = run,
>> > +	.setup = setup,
>> > +	.needs_tmpdir = 1,
>> 
>> This tests the underlying file system to some extent, so we should test
>> all available file systems.
>
> As far as I can tell it does not actually. This is a compatibility
> function for od unixes and the name is literrally 'get descriptor table
> size' so I suppose that it once returned the size of the array allocated
> for the process to store file descritptors into.
>
> So I supose that the only sensible approach is to call the function and
> check that it returns a sane value.

+1

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
