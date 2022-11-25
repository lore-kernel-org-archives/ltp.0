Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF525C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 10:39:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBD893CC877
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:39:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33C463C67D6
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:39:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 659B41401120
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:39:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 46EC81F88C;
 Fri, 25 Nov 2022 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669372760;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P3iBIqF03kpsks2i0NmUoXe52ugg0f61Vnoc5CzuiuA=;
 b=AMxA6UlBCJgXF04l8P9OgVL/r+DXsN+6DlTmEF6L1G3Z/GCLB5kMppTVyJWiCls6wHzlXI
 bR5pviK4RpkRAw6e8amfS+bLJbL8xzxZenm7rWPY9cDcX8+OE75OAutrNEAHDIBdhbo5Bi
 2Q7TtKFTpnpnvhFmfPnnK2geOzzdHrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669372760;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P3iBIqF03kpsks2i0NmUoXe52ugg0f61Vnoc5CzuiuA=;
 b=yGf+n3mBq1Dg1cLykCy/3znlH/BDn7KD5OnssgSIccRpPvDjErt71GOdYzRDmcTkIDd2IJ
 8iuUs55NX3RnelDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B900813A08;
 Fri, 25 Nov 2022 10:39:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TBvRKVebgGOQcAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Nov 2022 10:39:19 +0000
Date: Fri, 25 Nov 2022 11:39:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y4CbVZ3MKmjG9x96@pevik>
References: <20221123103547.54246-1-david@redhat.com>
 <30abc28c-be3c-0f9e-0c2e-6614fdd30e0c@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <30abc28c-be3c-0f9e-0c2e-6614fdd30e0c@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] security/dirtyc0w_shmem: Add new test for
 CVE-2022-2590
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
Cc: ltp@lists.linux.it, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin, David,

> On 23. 11. 22 11:35, David Hildenbrand wrote:
> > +	uffdio_api.api = UFFD_API;
> > +	uffdio_api.features = UFFD_FEATURE_MINOR_SHMEM;
> > +	TEST(ioctl(uffd, UFFDIO_API, &uffdio_api));
> > +	if (TST_RET < 0) {

> One more thing, checking just the ioctl() return value here is not enough.
> You need to check that uffdio_api.features still includes the
> UFFD_FEATURE_MINOR_SHMEM flag after the call. PPC64 does not seem to support
> it on kernel 5.14 and the ioctl() still succeeds there.
Very good catch, thanks!

David, please send official patch (speedups merging). Thanks a lot!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
