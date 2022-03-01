Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD013C433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 09:24:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D93A3CA309
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 10:23:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 962823CA2D1
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 10:23:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 29B301A01239
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 10:23:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 60BB52111A;
 Tue,  1 Mar 2022 09:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646126627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hf2evJIU+fYPk9N4yc/41gTNzKwGdqALk9QfQlWKO8I=;
 b=cjA4GlrxjSzOEUwxsu3+YwFrszFuRwSoacyMtwc6TxR4k3Tn1PTWBKsH4NmUkFSpnahsmj
 GWU6JAn/pP3hnVN4oicEtYZZPF09iw5W7dpgGa2MOrhZ3PTYx+5r25I9CuWmm8S+XHHs5d
 iutRLivuIIVodIcUZby3s50/KPuR3II=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646126627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hf2evJIU+fYPk9N4yc/41gTNzKwGdqALk9QfQlWKO8I=;
 b=Qdo2s2LrqSL480goEgAgxYoxJhjNVG6wVrpBqRRWfg+VNw5NgQei8zuXgLS+8LE/VRMWpr
 qOqVQGccLWBJm3Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43A1213B08;
 Tue,  1 Mar 2022 09:23:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id C7UsDyPmHWJ+WwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 01 Mar 2022 09:23:47 +0000
Date: Tue, 1 Mar 2022 10:26:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yh3mr5MNvjVRECso@yuki>
References: <20220228094659.21959-1-chrubis@suse.cz>
 <CAEemH2c-ZKrKVTqt-tSFvt36r5-P7c_9qTv7Q55QOhBC=TzWhw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c-ZKrKVTqt-tSFvt36r5-P7c_9qTv7Q55QOhBC=TzWhw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] ksm06 fixes
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
> Absolutely yes, that will make mem library a bit shorten to read, we can do
> that in a separate patch.
> (sorry for overlooking this patch cover letter)

I will send another cleanup patchset later on, I wanted the test fixed
ASAP which is why I limited the first patchset strictly to obvious
fixes.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
