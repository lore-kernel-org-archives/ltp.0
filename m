Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40C606A31C
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 03:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NdDg5RUi
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 141AE3E4B54
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 04:36:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28B2E3E2BD2
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 04:36:31 +0100 (CET)
Received: from mta1.migadu.com (out-6.mta1.migadu.com [95.215.58.6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C37E120007A
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 04:36:30 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=mUX4YgWnSjWkN6xvaFGmnq686OwmQMugtAKNy3xPDNc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794195390; v=1; x=1794800190;
 b=NdDg5RUi9XQf+gmhtnKnxvYFfEqtFXvoM98A2tLh83TGMduPi/pCgOErgVw0u8Lg7EP/TxJs
 pU/cyJt6ZLMJdkbkp3P9bZu7xDcr5AcZ3HukDTwLPscLMq77l5ZBX6XhUqzSGNZ27Y+vADMEt3E
 imhQ6mvXo2OTjypQkOxKFBeM=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 8dfd8916eb4f840e;
 Mon, 09 Nov 2026 03:36:30 +0000
X-Mizu-Trace-ID: 8dfd8916eb4f840e
X-Migadu-Flow: FLOW_OUT
Date: Mon, 9 Nov 2026 11:36:27 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <avE_u-xM2qidlviB@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 wakel@google.com
References: <20261103075722.181317-1-li.wang@linux.dev>
 <20261103075722.181317-3-li.wang@linux.dev>
 <au3NIJatDEAIu23h@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <au3NIJatDEAIu23h@yuki.lan>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/4] tst_kconfig: load and unload kernel
 modules for CONFIG_*=m
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: wakel@google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > +		for (p = name; (p = strchr(p, '-')); )
> > +			*p = '_';
> 
> Wouldn't it be easier to enforce the module names to have only
> underscores?

Good point.

> > +		if (!syscall(__NR_delete_module, name, O_NONBLOCK))
> > +			continue;
> > +
> > +		switch (errno) {
> > +		case ENOENT:		/* already unloaded */
> > +		case EWOULDBLOCK:	/* in use */
> > +		case EBUSY:		/* still loading or unloading */
> > +		case ENOSYS:		/* no CONFIG_MODULE_UNLOAD */
> > +			break;
> > +		default:
> > +			tst_res(TWARN | TERRNO, "Failed to unload module '%s'", name);
> > +		}

> Why not 'modprobe -r' the main difference is that 'modprobe -r' removes
> all unused depended modules. If anything loaded as a dependency of the
> module we loaded we are not going to be able to remove the module this
> way.

That was intentional. modprobe -r also removes unused dependencies,
including ones that were already loaded before the test. E.g. if can
is already loaded (but unused) and the test loads can-raw, then
'modprobe -r can-raw' removes both, i.e. cleanup would unload a module
the test did not load.

With delete_module() we remove only the module we loaded ourselves.
That always works, since dependencies do not hold a reference on the
module that uses them. The downside is that dependencies pulled in by
modprobe stay loaded after the test.

It's a trade-off: I'd rather leave a few extra modules loaded on the
SUT than remove modules that were there before the test started.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
