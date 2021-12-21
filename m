Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46447C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 13:02:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EFB53C9264
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 14:02:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 894983C0C9F
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 14:02:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 04BA61001340
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 14:02:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 335021F3A5;
 Tue, 21 Dec 2021 13:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640091733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1VtViezznLDYRsJ+NqriGqSY63Aj0AK5afM+cWP8sY=;
 b=G8MALqm6O5az3Th3gO0y2KST8SqzpSl2qRep99fRzB5+yOEA0QbPmPqwU5k89hhsUoxgjg
 MjOMMVbuUKdAlysrj09hVjktj91OCsgVXaFwYagyr5ZZvztg2hyBbLXW7VPKmluOvYVLIm
 APB9eY3xytFwCj0Nyg5hpvUPlb2PECA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640091733;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1VtViezznLDYRsJ+NqriGqSY63Aj0AK5afM+cWP8sY=;
 b=NqOcFS0mkFMUslmsih2uD0m++AGI2X1NCe/OSwqA2k7mJlYXqmn2nVd3T0fF7Ej4ZzWze5
 fRdag8s57IqBFACA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FB7213C3D;
 Tue, 21 Dec 2021 13:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gHrFBlXQwWGVJgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 21 Dec 2021 13:02:13 +0000
Date: Tue, 21 Dec 2021 14:03:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YcHQr22KuWECB1aa@yuki>
References: <CAEemH2eZDBODpZwjcCq=M=wT0uiSUSM+iS88F7-OQP-pkYRn=A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eZDBODpZwjcCq=M=wT0uiSUSM+iS88F7-OQP-pkYRn=A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Question] Why test C API failed in github CI
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
> Firstly, I'm sorry to push the patchset about oom protection cursorily.

No problem.

> The GitHub CI complained about the following failures, I feel confused
> when I add a bit of debug code in my private branch then. It gets passed
> in access(score_path, R_OK|W_OK) but failed in closing the file and
> give no EACCESS errno, that's wired.
> 
> Did I miss anything?
> 
> https://github.com/wangli5665/ltp/runs/4594473907?check_suite_focus=true

It does fail the same for me locally when I run the test05 under an
unpriviledged user. I guess that the error when we write negative number
to the file actually manifests when we attempt to close the file because
we use the FILE interface in safe_file_printf(). That way the actuall
write is buffered and deffered until the fclose() call.

So it looks like writing negative value to the file does return with
error for an unprivileged user.

I was looking at file_printf() as a potential solution, but that one
does produce warnings. But it looks like we do not actually use the
file_printf() function anywhere in the code so we may as well change it
so that it just returns if the operation was successful or not and make
it silent so that it does not produce any messages at all.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
