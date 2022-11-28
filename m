Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88615C433FE
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 18:42:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 584FD3CC695
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 19:42:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC4583C130F
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 19:42:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 15A2A2002C9
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 19:42:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C180A1FDC1;
 Mon, 28 Nov 2022 18:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669660932;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GoJgjT9vROvzzIuVNAjV+S7ZYlJwIr8tehpNm6MCnfg=;
 b=Da1vifMyxkiOQeR58L9haYPBRpxgwzgN76fSi3XXm4dtOyKFynA6VY1e4LpCzvYzI6DoYJ
 W7ogeeU6zaWgo0zsljnNRl5k8VKUSgurYW/ylxmPzfXgLN8pyMvPsclFBQLqxdPRF8rVCV
 4TVeCjm3SYwbkBbn8HhIqskspcCQ1ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669660932;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GoJgjT9vROvzzIuVNAjV+S7ZYlJwIr8tehpNm6MCnfg=;
 b=XAKHQlC150K7IwDENr5wj9h8wCJDiQ49fKDqEleHF6eEchJJWri84M3RCwprS3nCvmw5i2
 Ku1uWmedfhupGzAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CCC41326E;
 Mon, 28 Nov 2022 18:42:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1ASuHAQBhWOOKgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 28 Nov 2022 18:42:12 +0000
Date: Mon, 28 Nov 2022 19:42:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: David Hildenbrand <david@redhat.com>
Message-ID: <Y4UBAa9GS9SU/bVt@pevik>
References: <20221128111833.98937-1-david@redhat.com> <Y4SiDZXCSqMafjIb@pevik>
 <7f71a2c3-a66b-b442-3785-3e251ce2f781@suse.cz>
 <abd991c4-e6eb-349e-807c-71e7283ee83e@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <abd991c4-e6eb-349e-807c-71e7283ee83e@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/3] userfaultfd: Fix and remove compile-time
 TCONF handling
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

> On 28.11.22 13:29, Martin Doucha wrote:
> > On 28. 11. 22 12:57, Petr Vorel wrote:
> > > Hi David,

> > > If I remember correctly the reason for runtime check was ppc64le
> > > missing userfaultfd minor fault support which needs to be check in runtime,
> > > right? [1]. At least this is how I understand Martin's suggestion [2] to replace
> > > compile time check with lapi. I'd state this reason at first commit message as
> > > it's not obvious.

> > The reason for runtime check is that the presence of the header file
> > does not guarantee that the kernel supports UFFD API. The reason for
> > LAPI is that we only care about actual kernel support, not build-time
> > header files.
Thx, agree. BTW I was thinking about compile time check #ifdef
UFFD_FEATURE_MINOR_SHMEM, but that's the same as ifdef HAVE_LINUX_USERFAULTFD_H.


> Right. Petr, do you still want a commit message state?

I can just add to commit message of the first commit the reason Martin reported:
ppc64le on kernel 5.14 does not seem to support userfaultfd minor fault.

(no need to resent new version).

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
