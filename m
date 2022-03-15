Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E87C433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 12:54:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13FC33C9319
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 13:54:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E04C3C2C02
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:54:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D7297600977
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:54:13 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0E7A91F397
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647348853;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZbBiJSGS3ri69T5UkeQT5U75qUO50t5fqOwI6xOeOlI=;
 b=zUItQ630VHpfXWJ21VU3VsuL4u3zs26Fyelsh7iCsZ3Qfbs4pFHfhFsZTKXkXYWn3a7h9h
 gWJCbN6paZQWUl1EzDVjHoK0rbd2G58cvW26HUhc3IX5poebt2NYbmVBUUj1uhWwSgXd5y
 uPDbgxCuqNxXSqLSFHDftP85MJrjYJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647348853;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZbBiJSGS3ri69T5UkeQT5U75qUO50t5fqOwI6xOeOlI=;
 b=D2Y+FyKZxq2tw3FrFNb/BZocfYEh+lzPuI/12e8TzWyyNbng5CW62bXCsFKQJ7sXVP2t0J
 gWK5NW5L67GAhHCg==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D7293A3B92;
 Tue, 15 Mar 2022 12:54:12 +0000 (UTC)
References: <20220314130630.9378-1-rpalethorpe@suse.com>
 <YjBZAUelR7ExR83A@pevik>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Mar 2022 12:53:54 +0000
In-reply-to: <YjBZAUelR7ExR83A@pevik>
Message-ID: <87sfrj5qc1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tools/sparse-ltp: Check all struct arrays in
 tst_test for ending {}
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

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> Check for null termination on tst_test.save_restore and all the other
>> struct arrays in tst_test. They are all null terminated.
>
>> Also prevents a segfault when scalar NULL is used as the final entry
>> and print a helpful error message instead.
>
> thanks for this! LGTM.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr

Thanks merged!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
