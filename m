Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F41FA3745
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 09:07:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 765CE3CAD45
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 10:07:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F2503CA408
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 10:07:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 48DA5100079C
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 10:07:33 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 52690339CA
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 09:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667293653;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=opVuGjY45rBSlDngPaBHYLTW50wLJK87NqBkQ9GQMg0=;
 b=pddZfM3qB62UFA9iIW/vtbV9VK83lU1bQj8pJwXt4gULMRf3DugF1SL9ABEweLU4d2pgvf
 QfX+PxBVMPsTzDTpEUakiPDqYRzdd0NXFPc0MBvGsiFxhAYoUYTTczNTmGYYmYLiDfw6TX
 gyPpSwqAGFa/2EQng7OaRSCpHxil52g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667293653;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=opVuGjY45rBSlDngPaBHYLTW50wLJK87NqBkQ9GQMg0=;
 b=tL4gyv4biLS0mbERjzC7Ug7mPbcUDhC246sOKkJ9ioiYfqgMUwjTYl1xf+1C9tobulBPwq
 ZBbDdkRaGTBDWzBQ==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id CB53E2C141;
 Tue,  1 Nov 2022 09:07:32 +0000 (UTC)
References: <20221027140954.4094-1-akumar@suse.de> <87tu3kb098.fsf@suse.de>
 <Y2BA6UBSrVQS6HiI@pevik>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 01 Nov 2022 09:03:00 +0000
Organization: Linux Private Site
In-reply-to: <Y2BA6UBSrVQS6HiI@pevik>
Message-ID: <87tu3j9h64.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid02: using -1 as invalid fsuid for
 setfsuid()
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

>> Hello,
>
>> Avinesh Kumar <akumar@suse.de> writes:
>
>> > a uid which does not have an entry in the /etc/passwd
>> > file is not really an invalid fsuid for setfsuid(), so changing
>> > the test to use -1 as an invalid fsuid.
>> > And second setfsuid(-1) call is to verify that preceding call has
>> > actually failed and there is no change in the fsuid.
>
>> I think the original test is flawed and testing what using -1 does is
>> not very interesting as the kernel uses standard boilerplate to deal
>> with this.
>
>> AFAICT we don't test what happens if a non-root user tries to set the
>> fsuid to a uid that is not the euid, ruid or saved uid or 0/-1.
>
>> Possibly that is something for a new test though.
>
> Ah, sorry, I overlooked this, merged now.

No problem, I think that is the correct thing to do. I'll leave it to
Avinesh or someone else to extend the test (or not).

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
