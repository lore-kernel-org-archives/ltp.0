Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93DBC433EF
	for <ltp@archiver.kernel.org>; Fri,  6 May 2022 14:59:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4703C3CA8D3
	for <ltp@archiver.kernel.org>; Fri,  6 May 2022 16:59:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D60BD3C0F84
 for <ltp@lists.linux.it>; Fri,  6 May 2022 16:58:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F19651A001D6
 for <ltp@lists.linux.it>; Fri,  6 May 2022 16:58:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2391A1F920;
 Fri,  6 May 2022 14:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651849132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8tnRNK9Aqs4MdhiadG9xrKYZ8/sLCc7XhioVJjaSD0=;
 b=dnID6zXyw4dJz1OInH7jTl76bYJvZtOGpQm7FzS4uQfgExABcPK5Lb70pegOzaRN+mTZk+
 PdJLU596R1l7rRfYbuoHawoRQGIuRjsW+xCMry1smRBUWoLq9mt+mJcqAakhDixNqacKpA
 UdY3J0jlqWBqKWaNAYym72QgRM0kHvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651849132;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8tnRNK9Aqs4MdhiadG9xrKYZ8/sLCc7XhioVJjaSD0=;
 b=sBsxBcgg4csYLy8ZwgzeYOpC8x/TCQQ2VBIg0+cs4mUsjpy/9lb+cB5I0ydmt8yJZDcV7V
 vdLDXySQASd2UuDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 109FF13A1B;
 Fri,  6 May 2022 14:58:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NldQAqw3dWJ2AQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 06 May 2022 14:58:52 +0000
Date: Fri, 6 May 2022 17:01:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YnU4M739i3HCtC8q@yuki>
References: <20220427125003.20815-1-pvorel@suse.cz>
 <20220427125003.20815-5-pvorel@suse.cz> <YnU0XII0YSf0CUnb@yuki>
 <d4552f0b-9f73-ec2b-0c81-3d86eeb36fc1@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d4552f0b-9f73-ec2b-0c81-3d86eeb36fc1@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/5] tst_test.sh: Cleanup getopts usage
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
> >> +. netns_helper.sh
> >> +
> >> +PROG=$1
> >> +IP_VER=$2
> >> +COM_TYPE=$3
> > 
> > Can't we just keep these at the top along with the rest of the
> > variables? I do not see them redefined anywhere but maybe I miss
> > something.
> 
> tst_test.sh has to process command line arguments before these variables
> can be set. Otherwise you'd have to put all command line switches
> *AFTER* the positional arguments.

Ah, right, that's the thing that I missed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
