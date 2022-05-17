Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38750C433EF
	for <ltp@archiver.kernel.org>; Tue, 17 May 2022 15:31:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B31343CAA86
	for <ltp@archiver.kernel.org>; Tue, 17 May 2022 17:31:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C952B3C04EF
 for <ltp@lists.linux.it>; Tue, 17 May 2022 17:30:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 44B8F100041E
 for <ltp@lists.linux.it>; Tue, 17 May 2022 17:30:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C2B121BAB;
 Tue, 17 May 2022 15:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652801454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BRQPzFbZHeCOj+nxl7Q8V4AvqC0dXjYKDwBduzirS7k=;
 b=vos5w90sQ4R+c8bqqZgadadwNdaYf720YbvNe6P8pekVL8fhXcagg2DkChxofIA/YMbfQN
 iEEV3sqITuU5up5MFywgUDvVCGJs1eJlYurQ+cuEfUxoTnxIgAiPFL3CoBxv/GbEem/rAr
 o9FQG/Al2+pQRNz7ekOhBbZ4qnfxWdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652801454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BRQPzFbZHeCOj+nxl7Q8V4AvqC0dXjYKDwBduzirS7k=;
 b=/+WUgExLU4ECHQmPALnr37paI1a0xICYcrVq+lob6ECqPaFAqhxlRLJWSrmMJaSpADmEup
 +gaEBYzDH3HGyKCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3194913AA2;
 Tue, 17 May 2022 15:30:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 86vnCK6/g2JsdAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 17 May 2022 15:30:54 +0000
Date: Tue, 17 May 2022 17:33:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YoPAMBxU5zuQ5xDk@yuki>
References: <f38ee2905aa8b765c243896fa326b5507919a446.1651061197.git.jstancek@redhat.com>
 <65a82dbc6ea54c5d02a1238f5fa26d19388c5d2a.1652789936.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <65a82dbc6ea54c5d02a1238f5fa26d19388c5d2a.1652789936.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_find_backing_dev: match mount point if
 major/minor can't be found
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +		len = count_match_len(path, mnt_point);
> +		if (len > best_match_len) {

I wonder if we should also check for minimal len to avoid trival prefix
matches such as "/". Maybe we should set the best_match_len to 1 to
begin with.

> +			strcpy(dev, pre);
> +			best_match_len = len;
> +		}
>  	}
>  
>  	SAFE_FCLOSE(NULL, file);
> -- 
> 2.27.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
