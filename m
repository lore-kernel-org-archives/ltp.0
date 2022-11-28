Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5099EC433FE
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 11:11:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34BEA3CC65B
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 12:11:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84FDF3C288D
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 12:11:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7D6151A000B9
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 12:11:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5964A1F381;
 Mon, 28 Nov 2022 11:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669633870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H5uIdBjWmDgB0N8yaa5hWAnSL65ZSIdfj/Qf2MU1cNM=;
 b=mqJlN8cOvINYxSbK5hnidJZLPFGcD6wxYlIdTKB7sWqzWEhWvRXuwHhrPECQHTBieGMe9C
 9VQh/BNs4OA246/T6cReX+ZmEIvz3XJvxHbGvjxKniLQSm3L+KyeRl/jUXON/UecgFS2uP
 1XkQKZZU4Gd5wzYVZjP3EN6wgXuR5I8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669633870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H5uIdBjWmDgB0N8yaa5hWAnSL65ZSIdfj/Qf2MU1cNM=;
 b=UZPZQskd2qKvXJliExkjjNMoXdETfCBvv2+sCTWW/UmaSKImBpWCvFlo/hngyEYRtB87F5
 Z23h/d57mavO84Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 258DE13273;
 Mon, 28 Nov 2022 11:11:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nc4fB06XhGM/NwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 28 Nov 2022 11:11:10 +0000
Date: Mon, 28 Nov 2022 12:11:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <Y4SXTPBViJiqulow@pevik>
References: <20221125122546.99144-1-david@redhat.com> <Y4DL5928NpuPI2Q6@pevik>
 <58d046ff-c89c-611c-0607-c2ec8f556526@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58d046ff-c89c-611c-0607-c2ec8f556526@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] execl(),
 execlp() and execle() require proper termination of argument list
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
Cc: ltp@lists.linux.it, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

sorry to bother you, could you please comment our discussion about execl{,e,p}()
termination of argument list being NULL vs. (char *)NULL vs. (void*)0?

Martin reported [2] that man page suggests (char*)NULL, his view of reason [3]:
NULL may be defined as simple integer 0. When int is 32bit and pointers
64bit, this will cause trouble in variadic functions such as execlp().

Cyril pointed out [4]: NULL is required to be 0 cast to void* in POSIX. [5]

Therefore what should be really used?

Kind regards,
Petr

[2] https://lore.kernel.org/ltp/8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz/
[3] https://lore.kernel.org/ltp/af63ed9a-7108-fd19-fe2c-4b56be85d068@suse.cz/
[4] https://lore.kernel.org/ltp/Y4DSmk7uY9zUUQsV@yuki/
[5] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/stddef.h.html

> On 25.11.22 15:06, Petr Vorel wrote:
> > Hi David,

> > thanks for fixing this!

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> This seems to be quite a controversial topic :)

> I stumbled over [1], which still left me confused regarding what to do and
> what to not do.

> Interestingly, the problem doesn't seem to be that NULL is defined in a
> strange way, but that the representation of (void *)NULL and (char *)NULL
> might be (weirdly enough) different, and that no explicit cast could result
> in undefined behavior.


> IIUC, the second answer indicates that with C99 it might be fine, because
> that case is defined behavior ("one type is pointer to void and the other is
> a pointer to a character type.").


> Having that said, I have cannot really tell if this change must be
> performed. :)


> [1] https://stackoverflow.com/questions/52195275/can-the-compiler-cast-void-0-in-execlprog-arg-void-0-to-a-null-po

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
