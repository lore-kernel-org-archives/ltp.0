Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDAFC4332F
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 09:21:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2609C3CE988
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 10:21:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A63283CC81F
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 10:21:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CEBEE600765
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 10:21:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08DBB2195F;
 Thu,  2 Nov 2023 09:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698916897;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fIs2lBSthsVCJOR+gvTdlM8jfVH2X4QBs7zuQKjey9s=;
 b=1yHnrEMoAm8N+GNKCOKd9Mu8RIzD/QGKNZVIlL83D/rePVCxfnanh/2opJzfbsyDoFov/O
 ouXuqVtuGWpVUfK2UnRba3/KCdaZr3Oofjrram7QdiU5hX6ygsjOoy+oEbGmiN9NhOLMZX
 agKaAYAGlFeoYc/D/IEjQOIQwGq1UE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698916897;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fIs2lBSthsVCJOR+gvTdlM8jfVH2X4QBs7zuQKjey9s=;
 b=uVIX1atBT2Rdp1uOEhSvHPox6SeXn4x7/hK4Iiq/NyjdWhJDML2S7vZDTJQpxWbdLMA6jA
 MADkLhziIoIm2wBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3BE6138EC;
 Thu,  2 Nov 2023 09:21:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MFN/JSBqQ2XNZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 02 Nov 2023 09:21:36 +0000
Date: Thu, 2 Nov 2023 10:21:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231102092135.GA921952@pevik>
References: <20231102072030.1800796-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231102072030.1800796-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
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

Hi Li,

> This is base on Peter's patch:
>   CI: ReAplace CentOS 7 with openSUSE Leap 42.2, Ubuntu xenial

> Ci: https://github.com/wangli5665/ltp/actions/runs/6729379565

Reviewed-by: Petr Vorel <pvorel@suse.cz>

ATM we have 18 jobs, IMHO we should not add more without removing others just to
have reasonable CI runtime.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
