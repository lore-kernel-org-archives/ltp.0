Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEFFC433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 09:10:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 088A33C926B
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 10:10:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03D623C620F
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 10:10:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 67FAC10007AE
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 10:10:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6FEB9210F6;
 Wed, 22 Dec 2021 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640164230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EsLHxbYaydSzdgFM3yIoRgE2DfHG6G1yyZn0m/XXz3Q=;
 b=FSHKRqru3nWWsatD3DA05l4BnoLap6HOU/g84iz0bkoDHpiDvOaCZpnqgL/WPWZ8Y/bejr
 Rez3lh9QLSJJgYLK5P7Q2H148NIwTbblYJx0wUWxHi3LmmYr/paIO4F/li2+st0vRc7YSA
 HjAn7DwzZ6rmFtpjDxKmJI70R6g0knM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640164230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EsLHxbYaydSzdgFM3yIoRgE2DfHG6G1yyZn0m/XXz3Q=;
 b=ePKObNGFEHjMarsnxuUL0udXQ+fPTz1PK0sTeStk7rIF35rNzSoIOnCD+wFEAfqbQY1j73
 mCJBt39x1IAPxDAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DCFF13CE7;
 Wed, 22 Dec 2021 09:10:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d7FMDYbrwmGSVAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Dec 2021 09:10:30 +0000
Date: Wed, 22 Dec 2021 10:10:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Nageswara Sastry <rnsastry@linux.ibm.com>
Message-ID: <YcLrhP62jewzFgqn@pevik>
References: <20211221023721.129689-1-yaelt@google.com>
 <aafb5351-a73a-dac3-b0fa-3faad707bafa@linux.ibm.com>
 <YcGw5Lyo+hBEnlFD@pevik>
 <8c785afa-4564-d7ca-0bb8-34d5b5ca89bd@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8c785afa-4564-d7ca-0bb8-34d5b5ca89bd@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/keyctl09: test encrypted keys.
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
Cc: linux-integrity@vger.kernel.org, Yael Tiomkin <yaelt@google.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On 21/12/21 4:18 pm, Petr Vorel wrote:
> > Hi Nageswara,

> > > On 21/12/21 8:07 am, Yael Tiomkin wrote:
> > > > Test that encrypted keys can be instantiated using
> > > > both user-provided decrypted data
> > > > (https://lore.kernel.org/linux-integrity/20211213192030.125091-1-yaelt@google.com/),
> > > > or kernel-generated numbers.

> > > > Signed-off-by: Yael Tiomkin <yaelt@google.com>

> > > Tested on ppc64le platform

> > I suppose it also fails on ppc64le when run more iterations.


> Tried with -i500, -i5000 and -i50000 also ... no failures were seen on
> ppc64le architecture.

> Summary:
> passed   500
> failed   0

> Summary:
> passed   5000
> failed   0

> Summary:
> passed   50000
> failed   0

Interesting, thx for info. It's either arch specific or specific to openSUSE
kernel on my laptop (~ 5.16.0-rc5) where I tested it. Testing on
various VM it works well (including openSUSE with latest kernel stable). It also
works on RPI 4 with openSUSE kernel.

Also it fails on 2 VMs with fips enabled: Debian testing (immediately) and SLES
15-SP4 (after 63 iterations - the same number as 5.16.0-rc5 on my laptop):
keyctl09.c:33: TBROK: Failed to instantiate encrypted key using payload decrypted data

but on my laptop I don't use fips.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
