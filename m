Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6983EEB64DD
	for <ltp@archiver.kernel.org>; Wed,  9 Aug 2023 13:22:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A0863CB3BC
	for <ltp@archiver.kernel.org>; Wed,  9 Aug 2023 15:22:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D2B33C9984
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 15:22:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4A2621400E65
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 15:22:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ADE602185F;
 Wed,  9 Aug 2023 13:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691587324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfVY3QmHY9gwo5dMss7GouAd2Md+r8rjbFyjb2RrcrA=;
 b=ST96VhmgMMA3IoIzU8DCfdXSLF5zRK0YSK9Wp8F4BnIYMuO7ADifpG4bHzd4vl0XE9Skj1
 j6ARN9Y4B++6XMnE2zAOyMPiMasRGMLEMpjudq5vSbOby5GfnvNwPwqEppwShNKb+J2btx
 FJa5DXkuWGIM7i3otiEsrFhCy6OThe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691587324;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfVY3QmHY9gwo5dMss7GouAd2Md+r8rjbFyjb2RrcrA=;
 b=QKHC/+1GsFCwpjiFHH4478dK+e0RxhEkPxW5TdyoDC7NfFNeb0ifND1bl4J4HnJfrHOMeQ
 kUuvB2i4OFV5FCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3866713251;
 Wed,  9 Aug 2023 13:22:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LLhIBPyS02RvDAAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 09 Aug 2023 13:22:04 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Wed, 09 Aug 2023 18:52:02 +0530
Message-ID: <3275791.FnOadfsyHW@localhost>
Organization: SUSE
In-Reply-To: <CAEemH2dWNJjtbsWn7mf8aghjzMjuWq+XqZWUHw0nx0Vu-Uf7qA@mail.gmail.com>
References: <20230808153549.22777-1-akumar@suse.de>
 <CAEemH2dWNJjtbsWn7mf8aghjzMjuWq+XqZWUHw0nx0Vu-Uf7qA@mail.gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] sbrk01: Refactor the test using new LTP API
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

Hi Li,


> > -       tret = sbrk(test->increment);
> > -       TEST_ERRNO = errno;
> > +       tret = sbrk(tc->increment);
> > +       TST_ERR = errno;
> 
> Can we make use of the LTP test macro TESTPTR()?
> It has already given TST_RET_PRT and TST_ERR inside that.
> 
> See:
> https://github.com/linux-test-project/ltp/blob/master/include/tst_test_macro
> s.h#L30

Thank you for reviewing and pointing this out, I have sent the updated patches 
with TESTPTR() macro.


--
Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
