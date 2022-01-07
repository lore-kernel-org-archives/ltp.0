Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55449C433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 09:45:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15FEB3C7B52
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 10:45:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 726053C2005
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 10:44:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CCAB8600670
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 10:44:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D99541F3A6;
 Fri,  7 Jan 2022 09:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641548688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ma92Ix04dbHy3I1HD/woRxNq5RNd7XG8m9pHAdT//8=;
 b=aCNt2VJF4EiPcOYxognl4XZ8hukCDr+S3JZ2+i4QAkiMSAWsTmK2re1Hr9Q9RXxTV5oRo6
 aqfJlFteVhKJAznZx8/KZ51knD1Dv1p2UCJd6S3hQORwqkGQMNb7FxkIb4RHucHJl+9TNy
 wBXT3ufWWnij8xsXFjC/BKFPTdk8lvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641548688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ma92Ix04dbHy3I1HD/woRxNq5RNd7XG8m9pHAdT//8=;
 b=nPxsi1YfD09MObZW5c0VyO4M5KGl8/PIVmOMQp6iikTfSHcYFbI2qSSbrVNRXVfWQVP8q8
 DblFKG7O0fobKNBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C635613CC8;
 Fri,  7 Jan 2022 09:44:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ydHAL5AL2GGqVwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 07 Jan 2022 09:44:48 +0000
Date: Fri, 7 Jan 2022 10:46:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YdgL7VPflx6N5BfZ@yuki>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbQLuuSAiN+d+Cs@yuki>
 <CAEemH2ddfS3v-v62vWjMGzr34-NfT=OBt1s-x6+dCSQD4p0YEg@mail.gmail.com>
 <61D7BD03.4040200@fujitsu.com>
 <CAEemH2cZ3mUMK3=QbJGSZ7=RP2D9+d0umP-4iDA3D=drrw1qNg@mail.gmail.com>
 <61D7F9AA.9020401@fujitsu.com>
 <CAEemH2dryR-JbgK51VUvNbZbGgw_kK0oA3ry-W29zkBd7uR8ww@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dryR-JbgK51VUvNbZbGgw_kK0oA3ry-W29zkBd7uR8ww@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
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
> > > Maybe we can combine the arguments into one kconfigs struct and
> > > just do once check? something like:
> > Yes, it works well. Thanks.
> 
> Btw, seems const char *kconfigs[64] is not enough for a long
> string combination, you can dynamically allocate memory
> according to arguments size. Or, just raise to a big number.

Just loop over the string twice and count the occurencens of IFS
character in the first loop.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
