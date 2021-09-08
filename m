Return-Path: <SRS0=D2qq=N6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E3BC433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 10:44:58 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F55861108
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 10:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F55861108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BFD93C32BD
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 12:44:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 921A73C2266
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 12:44:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8A05B1A0037B
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 12:44:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C8882012D;
 Wed,  8 Sep 2021 10:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631097884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ilkbXsSXeAtUWjI1lMOqfQQC2bLHEBQrANTfjxeMmd0=;
 b=zs3SBFIRaSAR4yhPQixRSqlY6L0tcva2fxMYCFbCQNfU2pFilG01pQB0VhnggMeWRCF3kq
 ntA+msyn84/NyOZDwRB0UQavAikIHrrGy/VXSDfpzJIXXeh6N0Lc+KVIABHpA/fX8GZZVE
 bh4py7lDXJM3ZDafP5PMKXSOaffisdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631097884;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ilkbXsSXeAtUWjI1lMOqfQQC2bLHEBQrANTfjxeMmd0=;
 b=rUEseFpdGX24muwFvCYKhdUYv6W/YDS4ePt1ZKcEOJWLvEmFMPZwGTMgTtb9Q66exu7+pf
 2mUkYZ9Ac9VQe0AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C0A613CC6;
 Wed,  8 Sep 2021 10:44:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UMifFRyUOGFpTQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 08 Sep 2021 10:44:44 +0000
Date: Wed, 8 Sep 2021 12:44:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YTiUKRnhWh6b6iS9@yuki>
References: <1630897958-2160-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <613864D4.5030400@fujitsu.com>
 <5b7f4a92-983f-2a7b-21f3-f9e2110bc0c2@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5b7f4a92-983f-2a7b-21f3-f9e2110bc0c2@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED] runtest/cve: Fix wrong cve tag
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210908104457.CyQpyWInM8eFRHq_skPBPbkxyrIOUBQUbfFL4AoY4vM@z>

Hi!
> > In fact, Look the following url:
> > https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3609
> > 
> > It said nothing and seems this cve number doesn't exist.
> > 
> > Do you know what happen?
> 
> This vulnerability is tracked under this CVE number in SUSE Bugzilla and
> RedHat security portal:
> https://bugzilla.suse.com/show_bug.cgi?id=1187215
> https://access.redhat.com/security/cve/cve-2021-3609
> 
> I didn't check any "upstream" CVE databases.

Looks like the CVE has been allocated though, so possibly somehow the
the notification that it has been assigned has failed. I guess that
RedHat security team should look into this.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
