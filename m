Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B48C433EF
	for <ltp@archiver.kernel.org>; Sun, 13 Mar 2022 21:59:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0018D3C91BC
	for <ltp@archiver.kernel.org>; Sun, 13 Mar 2022 22:59:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32ABF3C0CEA
 for <ltp@lists.linux.it>; Sun, 13 Mar 2022 22:59:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A6962600116
 for <ltp@lists.linux.it>; Sun, 13 Mar 2022 22:59:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DE4EC218FD;
 Sun, 13 Mar 2022 21:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647208758;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YpMDxDxobp4yQeR/1MgHO/+tnGS7VTYmjsCYJKFzLEo=;
 b=wXZzL/SrubHmMNx7hR+t/W3n+Pb2iohjA65ViXuXEVlVnN0q6CvvpX1PJQuygFDuHCJpXO
 sN8qrBKJm6H7bjvVbqrbtWcU9dlVK/5+cFDwN5DVZmg+uUq5X+HSSTFaIpbVmqZhldGt05
 Yp9UpOv2E7mkn+5jrECgLmfH3Ke4g1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647208758;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YpMDxDxobp4yQeR/1MgHO/+tnGS7VTYmjsCYJKFzLEo=;
 b=QiEBoNrO32i2UyhD3IPLVhuwOQujcQmu1UwA38BNWG7VO8ziSZWz2+EKnu+SByojfoFT26
 o7SvCkHDqSSEfPDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 930D713B16;
 Sun, 13 Mar 2022 21:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2wJuIDZpLmIjNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sun, 13 Mar 2022 21:59:18 +0000
Date: Sun, 13 Mar 2022 22:59:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yi5pNVRQOvNyFcuh@pevik>
References: <20220210162739.30159-1-pvorel@suse.cz>
 <20220210162739.30159-7-pvorel@suse.cz> <YitgFixpNYs/ydVi@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YitgFixpNYs/ydVi@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/6] doc: Add missing shell variables
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

Hi Xu, Cyril,

whole patchset merged with fixes you pointed out and your tags.

Hope we find some better solution for relative path links.

Thanks for your review.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
