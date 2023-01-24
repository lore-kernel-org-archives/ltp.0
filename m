Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A33EC61D97
	for <ltp@archiver.kernel.org>; Tue, 24 Jan 2023 12:48:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB3703CC77E
	for <ltp@archiver.kernel.org>; Tue, 24 Jan 2023 13:48:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDE593CB3A0
 for <ltp@lists.linux.it>; Tue, 24 Jan 2023 13:48:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 081236007B6
 for <ltp@lists.linux.it>; Tue, 24 Jan 2023 13:48:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D1E9C1F45B;
 Tue, 24 Jan 2023 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674564479;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p2hPpeKowlGR8niNQlQXxxNolSySVBaJDmmf+OzMI5c=;
 b=jYwQkjNmith4xt85ke7bv9PHiuo55CGyCFe3nT+Rr38ak7qxsBrxmElUp39W4lOULYJOLM
 8U3BzVwrR2GnvLe7MGA4n7cVhTFp0hz+KSxYtHq4FCs+dH22EndbI1v98nOKkK9sDnIFrJ
 53JOal+H/EHcviaodes5OnzvFzeRIJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674564479;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p2hPpeKowlGR8niNQlQXxxNolSySVBaJDmmf+OzMI5c=;
 b=mivPS7y+qGZ3/yxhgHxU4JhJKHBFS7zxUb2Mi2MVTdeQLRzsZQb7YZFtbQn70ruhS9RUOW
 eSVHvaKATam7NyCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF044139FB;
 Tue, 24 Jan 2023 12:47:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0pc1KX/Tz2NdSQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 24 Jan 2023 12:47:59 +0000
Date: Tue, 24 Jan 2023 13:47:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y8/TfYoRjXqVwVHq@pevik>
References: <Y8VRpdW7LUh4uFm9@yuki>
 <Y8qGFOF2M+VuTpmD@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8qGFOF2M+VuTpmD@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi!
> I did my share of pre-release testing and apart from the statvfs01 I've
> send a patch for there rest of results looks green.

> I also did test the runltp-ng and we fixed a few bugs there in order to
> have a flawless experince since it will be introduced in the LTP
> tarball. It would be great if anyone else would do so as well.

> And given that the mailing list is mostly silent I suppose, unless
> anybody objects, that we can freeze the git now and declare the next
> week as pre-release testing week. With that we would be aiming for the
> release either at Friday 27.01. or at Monday or Tuesday 29-30.01.

I'd be for Friday (given there is SUSE hackweek since Monday).
I'm going to do build testing for various architectures.
I can help to tag the release and upload files (as I did last release).

But before I'll try to fix nft01.sh -6, which is broken on newest 1.8.9:

nft01 2 TINFO: Use nft to DROP packets from particular IP
nft01 2 TINFO: Rule to block icmp from ::1
nft01 2 TFAIL: nft command failed to append new rule
Error: syntax error, unexpected junk
'add rule ip6 filter INPUT meta l4proto ipv6-icmp ip6 saddr ::1 counter drop'

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
