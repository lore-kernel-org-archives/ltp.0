Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C67C5478C
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 08:59:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01FCC3CED2D
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 09:59:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4F1A3CED2D
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 09:59:23 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2218A10124CF
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 09:59:22 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F16BD1FF99;
 Fri,  1 Mar 2024 08:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709283562;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmoVt+TysnLt+OTL/u8lDoeJAPJ6D3qmlMOLm6tMu4U=;
 b=hQ1cpV1+UdjoOku4uk89A0HUgAkqvpQ1XDDbnK6s0vSk1C8cvRhJVPAwZ8BtIVf5/d4jeN
 Dn09xc7kRpR73IMV/oyJz2SSHukRhyABX8OL4EGm4j2otgWVKz+MFxa7ESOqzG11HtVjF+
 226/6+yWcE9VRTsSjS5GrkJ9Amz3XC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709283562;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmoVt+TysnLt+OTL/u8lDoeJAPJ6D3qmlMOLm6tMu4U=;
 b=bxNefflp4EiK/vxE3k+cdrcavS++/f0KiaMdaPNaPFtafUfxOMgenTOw1Zn4Gf9O3IAR/a
 hanZguguSpVAIPAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709283562;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmoVt+TysnLt+OTL/u8lDoeJAPJ6D3qmlMOLm6tMu4U=;
 b=hQ1cpV1+UdjoOku4uk89A0HUgAkqvpQ1XDDbnK6s0vSk1C8cvRhJVPAwZ8BtIVf5/d4jeN
 Dn09xc7kRpR73IMV/oyJz2SSHukRhyABX8OL4EGm4j2otgWVKz+MFxa7ESOqzG11HtVjF+
 226/6+yWcE9VRTsSjS5GrkJ9Amz3XC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709283562;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmoVt+TysnLt+OTL/u8lDoeJAPJ6D3qmlMOLm6tMu4U=;
 b=bxNefflp4EiK/vxE3k+cdrcavS++/f0KiaMdaPNaPFtafUfxOMgenTOw1Zn4Gf9O3IAR/a
 hanZguguSpVAIPAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 85DA113A39;
 Fri,  1 Mar 2024 08:59:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id RVf2HemY4WVPDQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 01 Mar 2024 08:59:21 +0000
Date: Fri, 1 Mar 2024 09:59:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240301085916.GA1661970@pevik>
References: <20240214170949.793338-1-pvorel@suse.cz>
 <20240214170949.793338-4-pvorel@suse.cz>
 <CAEemH2cuq7P_eK8fFR37ZgAF+w84Fkcat_BRM9nmXpmoODkuYg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cuq7P_eK8fFR37ZgAF+w84Fkcat_BRM9nmXpmoODkuYg@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.60 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[11]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[lists.linux.it,fujitsu.com,suse.cz,gmail.com,mbobrowski.org,redhat.com,richiejp.com];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.30)[90.11%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] tree: Relicense GPL-2.0 (v2 only) =>
 GPL-2.0-or-later
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
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <mbobrowski@mbobrowski.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Hi Petr,

> All looks good to me. Feel free to merge this patchset.

Thank you! FYI I'm still waiting for Amir's ack.

I guess we could relicense Richie's work without his ack (SUSE work actually),
but at least testcases/kernel/syscalls/close_range/close_range01.c is from
kselftest (tools/testing/selftests/core/close_range_test.c), which is GPL v2
only, I suppose I should use GPL-2.0-only for this one.
I haven't found a record that other two from Richie would be from kselftest,
thus I'll use GPL-2.0-or-later for them.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
