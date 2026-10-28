Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17522606A333
	for <ltp@archiver.kernel.org>; Wed, 28 Oct 2026 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=h6pQ6IQC;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1 header.b=fyRz1u7J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793221639; h=date : to :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=HUKG+A1x1lO7A9TD1e9Vrh5EHjRZCqs0J6dvkLO2pHk=;
 b=h6pQ6IQC9elRH1CwvxC33cXJdEwHiOj/vGgmQPQEDBUqqeqVm/G6Be8I514cJF3VtAwlk
 4E1Tc0QSEYWbUPea8o1mJctBEvT4S1KQqBoQ03p3qvILE0aEE8Fyf/1/OCyX2LEPEJ3VwY5
 lexaxRlDJGg6exRiyHo7G1MW2DCp+OQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 924B53EADFA
	for <ltp@archiver.kernel.org>; Wed, 28 Oct 2026 22:07:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E5783C0200
 for <ltp@lists.linux.it>; Wed, 28 Oct 2026 22:07:00 +0100 (CET)
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 87CF41400BE4
 for <ltp@lists.linux.it>; Wed, 28 Oct 2026 22:06:59 +0100 (CET)
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
 by mail.w14.tutanota.de (Postfix) with ESMTP id 449B719E3EDEF
 for <ltp@lists.linux.it>; Wed, 28 Oct 2026 22:06:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793221618; 
 s=s1; d=tuta.io;
 h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
 bh=1B1yG4XO8EXkiRM4RWkICSYjVRzz8XcoV476NdC5R5E=;
 b=fyRz1u7J10cIoRB1Dy27qmn4/4ZxdTl+KSxMgOBD7aNkxQum6AU4DTSxGNjmckw9
 ImNJ3KfXHp8mDzLRzrBQjGGtAaFHpdLNQEPK2v6i5nZliAg/kbqoziSjvTIbj/b+2pk
 JvczojqrnZgddbTUmfLhxhodU2oZVh6nJzWias9gwm+ETs2/57XWeAod5QPM2xZillT
 rdcyv2L6AuUY6Udra1NB+9mm+fumiWcA8IOWtwMhM39nry9j3bE765cZ8wC7YIq1pL+
 MlgoEorL+SPEwaMrmsNhQeHGqGcISTAu3S/7VsrEQtU8Q2tjrqZ/ldwBClRXCTrgShi
 49u2V/0c+A==
Date: Wed, 28 Oct 2026 22:06:58 +0100 (CET)
To: "linuxtestproject.agent@gmail.com" <linuxtestproject.agent@gmail.com>
Message-ID: <P53Ka_W--F-9@tuta.io>
In-Reply-To: <20261028091542.5840-1-linuxtestproject.agent@gmail.com>
References: <P50G-yE--F-9@tuta.io>
 <20261028091542.5840-1-linuxtestproject.agent@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Feedback-ID: 0127f977f5e13e8051b46c6e7f57d0f95a0470d24b79d7c31d07fdf611cc427ab823e0f4692a810119c92d8768973a9281:TurnOnPrivacy!:tutamail
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/fanotify26: Add test for nested permission events
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Edvard Conrad via ltp <ltp@lists.linux.it>
Reply-To: Edvard Conrad <edvard@tuta.io>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 Edvard Conrad <edvard@tuta.io>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On Wed, Oct 28, 2026 at 09:15:42AM +0000, linuxtestproject.agent wrote:
> Since the test is added to runtest/staging for an unreleased kernel fix,
> the commit subject must include the [STAGING] prefix:
>
>     [STAGING] syscalls/fanotify26: Add test for nested permission events

ground_rules.rst asks for the keyword in the patch subject, and gives

  Subject: [PATCH v1][STAGING] fanotify: add test for <feature> (requires v6.19-rc3)

as the example. The mail went out as "[PATCH v2][STAGING] syscalls/fanotify26:
..." and the archive shows it arrived that way. fanotify23, the last test added
to runtest/staging in a8cd03037, likewise carries no [STAGING] in its commit
subject, so I have left the commit subject alone.

> Please use SAFE_READ_ALL instead of the literal 1, matching
> SAFE_WRITE_ALL below:

Done in v3.

> This SAFE_WAITPID() is redundant and discards the child's exit status.
> The test library calls tst_reap_children() automatically after each
> run() iteration [...]

Right, and dropped in v3 for the opener.

Worth noting it does not generalise to the other child: the reader is killed
with SIGKILL on the failure path, and check_child_status() reports TBROK for a
signal-killed child, so that one still has to be reaped by the test itself.

Thanks for the review.

Edvard

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
