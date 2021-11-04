Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E759FC433F5
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 10:25:51 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E271A60EC0
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 10:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E271A60EC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2042E3C7824
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 11:25:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 307633C55CE
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 11:25:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BC2BF200DE2
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 11:25:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8619D218B0;
 Thu,  4 Nov 2021 10:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636021536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zONXgggSl3QWOA3g9teId4GmFAubacsXfpxDspQldKM=;
 b=Q7f7ROlYOnm5qMIDMlSJH+G3n0MkURZPBq+CBms9XjJ9R9Emai/71hKehMbRlgeNDR+g5D
 EzVwH4TDFjzPAdRDqJ3CLxCNjxF0mr+DKiwZX/bZhAsDP4BlR83dng0RlMX6cRdNzgCRR9
 q5yYVk0+Ej7BlATZSe/f/HBTNmT+t6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636021536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zONXgggSl3QWOA3g9teId4GmFAubacsXfpxDspQldKM=;
 b=QiNXSfp7szsRPhiTc7+BjkQBaQKqZrzYZhsaot2PeDXMVbnoKaAceQr3nZm0S9g6reCdQ1
 USEj5V9ABa6n1VBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73EBD13BD4;
 Thu,  4 Nov 2021 10:25:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iIZdGyC1g2F+QwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 04 Nov 2021 10:25:36 +0000
Date: Thu, 4 Nov 2021 11:26:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YYO1WZh7Kz+en5nY@yuki>
References: <20190615042048.29839-1-liwang@redhat.com> <877ddpo35n.fsf@suse.de>
 <CAEemH2fDxJ1xQ9qNejHDxv0p_Cx2cq5LsXTesuhAEBrDe43Hmg@mail.gmail.com>
 <YYKYR4kspdlXuoDB@yuki>
 <CAEemH2e4sp_CYbAF05EA80Y1ggVG6yjRFp=-4EOudGBjTh7Wkg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e4sp_CYbAF05EA80Y1ggVG6yjRFp=-4EOudGBjTh7Wkg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib: adding .arch field in tst_test
 structure
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
> > least array of supported architectures in the test_test structure would
> > be a good addition.
> >
> 
> I guess defining .arch as a string and making a valid check will be enough.
> Array for that sounds a bit complicated in use.

Quite the opposite, it should be an array of strings, so that it's easy
to work with such as:

	.supported_archs = (const char *const []){"x86_64", "ppc64le", NULL},

We can put it into a single string delimited by a space, but that would
be more complicated to work with.

> > However the hard part would be keeping the actual code and metadata in
> > sync, we still have to keep the ifdefs in the code.
> >
> 
> Yes, some inline assemble require ifdefs.
> 
> Btw, I look back at the reviews and find Jan said:
>     "I can see how tst_on_arch() would be useful. Test is valid
>      on all arches, but needs different input/constants/code/etc."
> 
> That may be a slight reason for keeping tst_on_arch.

I guess that we should reviewe the code we have, I guess that there are
a few tests where we can get rid of a few ifdefs by doing the checks
dynamically.

Also I guess that it would be slightly easier to work with as an enum,
so that we can do:

	switch (tst_arch) {
	case TST_X86_64:
		...
	break;
	case TST_PPC64_LE:
		...
	break;
	default:
		...
	break;
	}

instead of:
	if (!strcmp(tst_arch, "x86_64"))
		...
	else if (!strmcp(tst_arch, ...)))
		...
	else
		...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
