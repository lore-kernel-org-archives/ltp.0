Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31A3C46467
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 09:11:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B12673CCDCB
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 10:11:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A5173C2C7C
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 10:11:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 90988600064
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 10:11:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5CC7C455B;
 Wed,  4 Jan 2023 09:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672823476;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t/Rk0NNUJjtidoi36jHmnhjH0jVkePMWZwVa/Ua1vTo=;
 b=ZqrUn44xSV/ctnt4bw5stIYLArRWbTBGueuBEJKVDvzO/5xVAb8V+JOPXGDGNn72OC9Bh9
 AL3LnpOHdkR5fIX36Nw0FjbV0GmMYOwWw8YtmnADt4y19qjfYDJaP2ZXaiOEh1J7CJoSHo
 2JKlya7aN5WzvCJ0IxxwM8POOkFqArY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672823476;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t/Rk0NNUJjtidoi36jHmnhjH0jVkePMWZwVa/Ua1vTo=;
 b=T+WHumx45rTa2fOEqY1Rezd249w9q4vI7XPxSRqJUUc8F8DAbGJeMrVYY2dTJWKmsCkjfu
 QVzaoOIlMomNdiBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34F9D1342C;
 Wed,  4 Jan 2023 09:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EmdMC7RCtWMGMAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 04 Jan 2023 09:11:16 +0000
Date: Wed, 4 Jan 2023 10:11:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Y7VCssq333Y5QgPt@pevik>
References: <20230103124505.6611-1-pvorel@suse.cz>
 <CAEemH2c69cKYLFzivuCRNnpxB8sco-9LRhL8_EYw0i+Srp71CA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c69cKYLFzivuCRNnpxB8sco-9LRhL8_EYw0i+Srp71CA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] configure.ac: Require 2.64
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Mike Frysinger <vapier@gentoo.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Hi Petr,

> I see other places also used 2.61, do you think we need to correct them as
> well?
> (e.g. open-posix and realtime)

> $ git grep AC_PREREQ
> configure.ac:AC_PREREQ(2.61)
> testcases/open_posix_testsuite/configure.ac:AC_PREREQ(2.61)
> testcases/realtime/configure.ac:AC_PREREQ(2.61)

Sure, I could do that, but these independent projects actually work with older
version, that's why I didn't do that.

FYI realtime will go away, once I find time to port relevant tests to rt_tests
and openposix could one day become in separate git.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
