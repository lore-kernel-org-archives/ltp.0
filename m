Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0FDC433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 08:27:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D97573C2652
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 09:27:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15FD73C0551
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 09:27:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6D28C600072
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 09:27:21 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8383421B3A
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 08:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638865640;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aD09kEcqVrkSw39F8wB3+0Bzyz7h645LH74w3JWmdb8=;
 b=Hvjf2G4tp9Gu8DQfUcb+yU+tHCspNfCR9eENnjushmv6BPgCEi/BQKLurNwujGkUohxZWU
 lsX0VAofyCpEq4SZuhYJrsIQnC0L9dysYFWzG27VpG16uiyqyciTNeS5w0IyuTHAqyoFyL
 QD5r6Nz9CqoW76cxDOp1Cw4aOglut5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638865640;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aD09kEcqVrkSw39F8wB3+0Bzyz7h645LH74w3JWmdb8=;
 b=F3wByhefasXkLjZtkFinSAw51K4I37ZiTsgtLSW1Hg/ejWTKPeCWrP3/qMPj5XrZg8E5Az
 Sn4lsUft+ZL64kDA==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3F22FA3B88;
 Tue,  7 Dec 2021 08:27:20 +0000 (UTC)
References: <20211201162401.12725-1-rpalethorpe@suse.com>
 <20211201162401.12725-2-rpalethorpe@suse.com> <Ya4xA4DTIP1DpHW4@yuki>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 07 Dec 2021 08:22:27 +0000
In-reply-to: <Ya4xA4DTIP1DpHW4@yuki>
Message-ID: <875ys0ddln.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] check: Add LTP-005 null termination check on
 test.tags
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
>> This does not explicitly check for zero at the end of an array. For
>> one thing the zero is implicit when one writes '{}'. We just get an
>> empty expression list. When one writes '{NULL, 0}', we get an implicit
>
> I would vote for dropping the part that checks for implicit cats so that
> we unify all code on {} for sentinels. I guess that all we would have to
> do is to drop the loop and only check if the list is empty.

Yes, indeed, it probably simplifies things a lot more than is
immediately obvious as well. I will reroll.

>
> Other than that the code looks good to me:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
