Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E29FC4332F
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 11:01:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 172073CE879
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 12:01:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B39653C1B13
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 12:00:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 124711000C03
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 12:00:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 328E91F45A;
 Mon,  6 Nov 2023 11:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699268452;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1u6+NEYAYkms9nBUaExwkYTHeA/EX3a8kNNx03qxrnA=;
 b=AyXUuzTXKAcGUNd/mkAKAwiVNZlGSImRHuy8h6R24WqJEQcuPesp446avH3tZyj28RsBts
 /CT3xvrwzYzS0iVkUbpmHeJUSqJvO2ltqFF33DPIVosNgcEh7pKuNiAEkbSgqjKmjeYro0
 64tz5ktBPVtxp+IDY7cA4ELU5tstuuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699268452;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1u6+NEYAYkms9nBUaExwkYTHeA/EX3a8kNNx03qxrnA=;
 b=9/MIqN95RStU7NX8Pu6UWpvcUwS2oTwQIONauxhfkZixnZxfBS1u7HiaLnRSTTE16CC1f2
 WcxytpFTVsgkK1Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04E3D138E5;
 Mon,  6 Nov 2023 11:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id f3dVO2PHSGWwIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Nov 2023 11:00:51 +0000
Date: Mon, 6 Nov 2023 12:00:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231106110050.GA1241377@pevik>
References: <20231102072030.1800796-1-liwang@redhat.com>
 <20231102092135.GA921952@pevik>
 <CAEemH2fWDQgPv+9TR9nb4rw5CsJx3uGKS+Yvb3YqgNEOUSVYmg@mail.gmail.com>
 <20231103091439.GA1026385@pevik>
 <CAEemH2ewUHBC17LL+4OXd8AZqciGrRqo4Ty+Hik2KcXP+t4fNA@mail.gmail.com>
 <20231106104023.GA1236692@pevik>
 <CAEemH2fbsZaK11MRgS+jqowWihStX9NX5dc4fcgcDrbFfJULOA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fbsZaK11MRgS+jqowWihStX9NX5dc4fcgcDrbFfJULOA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: add centos stream support
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
Cc: Chao Ye <cye@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Petr Vorel <pvorel@suse.cz> wrote:



> > > > If we want to add both CentOS 8 and 9, we could remove some of
> > > > debian:oldstable (bullseye)
> > > > (similar kernel).

> > > > And, we could add just openSUSE Leap 42.2, which has older glibc and
> > gcc
> > > > than
> > > > Ubuntu 16.04 LTS xenial. For sure there are more people which use
> > xenial
> > > > than
> > > > old Leap 42.2, but as I said, the goal is to test the oldest distro we
> > > > maintainers really care about (and do not have extra work for nothing,
> > > > which is
> > > > IMHO keeping CentOS 7 compilable).

> > > > WDYT?


> > > Your explanation is quite useful, thanks!

> > > I'm fine to remove the CentOS8 build in this patch,
> > > should I resent the new patch or push it directly?

> > You can push it directly. If it does not apply, feel free to push my change
> > first. I'll post a note about keeping only openSUSE Leap 42.2 in the
> > patchset.


> Done, and sorry I just merged the V2 then see you post V3 patches.

No problem, thanks for merging. I'll send a patch which removes xenial.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
