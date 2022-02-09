Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2E8C433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 12:54:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E94863C9CAB
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 13:54:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16F943C24D6
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 13:53:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6F9DE1400075
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 13:53:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A93991F390;
 Wed,  9 Feb 2022 12:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644411230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8H+Wp/gnJ6wBl8C3cLHO7Re823Q0eh2j91axNYCeAJk=;
 b=vK7Io/RchWBEnDcXfr42h3iRzE7lTByWZ3zpmgvkO3sJH8w/3+O2V/k9OPsJPtbjqV774d
 HhB+vIYjqETwV1pW8a4tm44d/YXy7mRuEi+0l+6sRABYr/JG2aUihmc4/2pt9d4H48k9M3
 fgIA4oGyCnd2bHgaJhwd/7ISczjbV5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644411230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8H+Wp/gnJ6wBl8C3cLHO7Re823Q0eh2j91axNYCeAJk=;
 b=ifGKDvDBLk1UyyJzyQ1ScjsHD3WxlLSI9nwAVlM67u83AzLrKMCKQdYZkHxvMe27jllWbj
 cUktMpv9pHg+58Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 845F413D2F;
 Wed,  9 Feb 2022 12:53:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id q0LsHl65A2JlNQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 09 Feb 2022 12:53:50 +0000
Date: Wed, 9 Feb 2022 13:53:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YgO5XLFXQS+wxu4l@pevik>
References: <20220127171455.9809-1-pvorel@suse.cz>
 <61F609C7.1080803@fujitsu.com> <YfeN6fG28AVNC44n@pevik>
 <CAEemH2fRtV+OqrW+x49RosgpyOYqCZ1ULxvZvqwypK8HQn6EQA@mail.gmail.com>
 <YflwND3aDJ1lg0ps@pevik>
 <CAEemH2dRwXdEN+eA5BhEyfK_cuvqhKu+mQFgJAtLJwWga1z+PQ@mail.gmail.com>
 <620095ED.1040808@fujitsu.com>
 <CAEemH2cs3-rBd+XTkh1A0ZtQxU-1WVx_pQtYGMyZX0zG48csew@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cs3-rBd+XTkh1A0ZtQxU-1WVx_pQtYGMyZX0zG48csew@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print in summary also tests not run
 at all
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Xu,

> > In fact, we don't have mandatory rules that TAPSS or TFAIL only can
> > occur one time. a example ie memcontrol02.c

> Right, that is my hesitant part for counting that.
> Seems many tests abuse the TPASS|TFAIL for defining test fail bound.

OK, while it'd be useful for some tests, it'd be confusing due this for other.
I guess printing (tst_test->tcnt * test_variants) number can be confusing
either.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
