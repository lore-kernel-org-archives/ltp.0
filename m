Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1568C77B7A
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 09:17:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D2903CD428
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 11:16:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D99543CB28B
 for <ltp@lists.linux.it>; Thu, 18 May 2023 11:16:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 36D4B1400E12
 for <ltp@lists.linux.it>; Thu, 18 May 2023 11:16:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E47F1F8C2;
 Thu, 18 May 2023 09:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684401408;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLNI1kGboPxciWbbyUeNnCP7vTC60YL2olAvSULfp+E=;
 b=B6SQqDociKoP3FEqKiVImTlq/oXerDlauJxdydpBObqgAcfSml36UloJ3e+GyrsCd0MeYj
 450MsSP5peps6D3fK3O/MOR/KgWfjoyN1KN1htHOZaIO5NG6+2JN3JolY262GJ71yIqmqh
 AUeGyz7aycBROZh+g74acfA+sn6FCx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684401408;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLNI1kGboPxciWbbyUeNnCP7vTC60YL2olAvSULfp+E=;
 b=gAkkeC5YvilCWIfcdyisPJvm/b1YPM8kr/Pi++6wuqDyZk5Tvih/5LRKtzJ/0L0FaW4gVC
 Ua3GKtDK3el4z/DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0754D138F5;
 Thu, 18 May 2023 09:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YX6vAADtZWSdUAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 18 May 2023 09:16:48 +0000
Date: Thu, 18 May 2023 11:53:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230518095349.GB6467@pevik>
References: <20230517153642.26919-1-mdoucha@suse.cz>
 <20230517153642.26919-7-mdoucha@suse.cz>
 <20230517232054.GE8914@pevik>
 <a2faae19-778f-a41f-a487-bd4faf67aee1@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a2faae19-778f-a41f-a487-bd4faf67aee1@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/7] KVM: Add STGI/CLGI intercept constants
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
Cc: ltp@lists.linux.it, Nicolai Stange <nstange@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 18. 05. 23 1:20, Petr Vorel wrote:
> > Hi Martin,

> > > +++ b/testcases/kernel/kvm/include/kvm_x86_svm.h
> > > @@ -39,6 +39,8 @@
> > >   #define SVM_INTERCEPT_VMRUN 0x80
> > >   #define SVM_INTERCEPT_VMLOAD 0x82
> > >   #define SVM_INTERCEPT_VMSAVE 0x83
> > > +#define SVM_INTERCEPT_STGI 0x84
> > SVM_INTERCEPT_STGI is not used anywhere.

> I know. Let's keep it anyway. But maybe I should also add SVM_EXIT constants
> in v2?

It's a detail, but yeah it'd make more sense.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
