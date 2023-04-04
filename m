Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5E8C761A6
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 11:15:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B275D3CAC31
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 13:15:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 397DB3C990E
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 13:15:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5F0056007A3
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 13:15:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB1DC20553;
 Tue,  4 Apr 2023 11:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680606909;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xlEEMgR5E/wwzSsqPpz8R7t+rO2RfacZFWu8kcMGJfQ=;
 b=0SmUudaroy77PMFTzfV1OQGv2zpm/p7IlMHcFUB69fsDmSxQ0NYa9QFEv0XgbtJDJ5Cbrh
 296xpU4oSoCjHzubbkjZRFcSej4Sf/I/PlFPJWJBjlCzDI4fECqdjVMt0KKUGtPcAogGrs
 wciWBbYTwVRxDHd5d4oAsTLCLacsw14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680606909;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xlEEMgR5E/wwzSsqPpz8R7t+rO2RfacZFWu8kcMGJfQ=;
 b=ErIsVmAcjD1qF0LJl9KOzlKTjN3x4IOO2MKdAW5NYA2Nc6TeE+dX1L1RwXqrz/kJlKM52k
 dev8HEAg4Gk+hxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CAEA1391A;
 Tue,  4 Apr 2023 11:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id N7CzHL0GLGQzdgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Apr 2023 11:15:09 +0000
Date: Tue, 4 Apr 2023 13:15:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, Jan Stancek <jstancek@redhat.com>,
 Cyril Hrubis <chrubis@suse.cz>,
 Paulson Raja L <lpaulsonraja@gmail.com>, ltp@lists.linux.it
Message-ID: <20230404111507.GA1269544@pevik>
References: <20230323121330.92244-1-paulson@zilogic.com>
 <20230324103334.GA557284@pevik>
 <CA+O3cCRGPfMP2EVigECgJ8c0Uo-yd7JUm64wSgvvgxoRqe7-Jw@mail.gmail.com>
 <CAEemH2e69a5DOq9eqJVau8YCENZchm8miOH3upQY_Pi6SUFyng@mail.gmail.com>
 <20230328081710.GB743322@pevik>
 <CAEemH2cKfGMdLHut7x5QfDkdsoX_stCzxXntei4msCRZ7PeBsA@mail.gmail.com>
 <20230328103951.GA755576@pevik> <20230404110751.GA1268429@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230404110751.GA1268429@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Added test for mmap() with MAP_SHARED_VALIDATE.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi all,

> FYI test fails on ppc64le: mmap() with MAP_SHARED_VALIDATE | (1 << 7) is
> supposed to fail with EOPNOTSUPP, but on ppc64le it fails with EFAULT.

> Obviously (1 << 7) being expected as invalid flag is not working well at least
> on ppc64le.  It might be something page size related or alignment. I was looking
> into SYSCALL_DEFINE6(mmap, ...) implementations. Although ppc64le implementation
> is not the same as most of implementations on other archs, in the end it also
> calls ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> shift) as the other
> archs. Any idea what could be a problem?

OK, 1 << 7 defined as MAP_LOCKED on ppc64le and mips. 1 << 9 looks to be working
on more archs, I'll send a patch.

Kind regards,
Petr

> Kind regards,
> Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
