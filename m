Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4C4C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 15:07:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 249FB3C89C6
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 16:07:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D2943C1448
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 16:07:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C4D1F60011F
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 16:07:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D6B9210F2;
 Mon, 13 Dec 2021 15:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639408020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mTuF2B62XHxAKYD5NOam3rtlb51xliX+14HvKXxfMhY=;
 b=k8h+6yuDg1o2LwktuUo/H5EmRlpjJAkqwyPyMzW0KGvjc+ap0MhQXFW/nygnwUGa2Z7ail
 MePfAExWIEorv70e7A8FHBGVhRnudyI0qM5oJGBPpcmWYl4mLT8zTE11KL97CRzcCMNpJf
 Fpzukc3CzDA/dBbqWdm67FVJuRlHL9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639408020;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mTuF2B62XHxAKYD5NOam3rtlb51xliX+14HvKXxfMhY=;
 b=KGTaqoCSIzf65Wg86txumDocCVbLYkHxnmxCthZqBK6wZ5DZFfSY8hNMFUtsLcFQEFGA78
 jxxBj/ee1nQD6TCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84D4513DE2;
 Mon, 13 Dec 2021 15:07:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WXuRH5Rht2HXOwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 13 Dec 2021 15:07:00 +0000
Date: Mon, 13 Dec 2021 16:08:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Ybdh6Q8OFheyDBn9@yuki>
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
 <CAASaF6zRCAYo3f4bRc+mxKHnprwtworq-fCif81ECZUWawumbQ@mail.gmail.com>
 <CAEemH2f_bkCkGiAnB3-8G07rYuVb9hZzKAKO3EMXUExDnx1Fdw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f_bkCkGiAnB3-8G07rYuVb9hZzKAKO3EMXUExDnx1Fdw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] enable OOM protection for the library and test
 process?
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
> > (if we haven't tried already) Could we make expected victim process
> > more appealing target by tweaking its oom_score/oom_score_adj ?
> >
> 
> This might not be a good way.
> 
> Because OOM Killer counts the oom_score by itself algorithm for
> choosing which process to kill. If we tweak that, it will interfere with
> the scientificity of the OOM test. But if we only do protect the
> lib-process,
> we know that shouldn't be killed and the test will report correctly for us.

Agree here, we shouldn't really touch the score of the process that is
supposed to be killed unless we want to test different scenarios. It
would make sense to run the test with slightly different score for the
child too, but we shouldn't remove the original score.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
