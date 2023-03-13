Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BEFC6FD19
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 22:24:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 969EA3CC002
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 23:24:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E57DD3C03AE
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 23:24:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 52D1F1400B62
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 23:24:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 405CA229AB;
 Mon, 13 Mar 2023 22:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678746279;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qigfN53DF15nFE3xLogXh9mWLgTC3vbDI2FYm/VPVcM=;
 b=dWm2z+YYRzNg4Da8YeSxOnF82TgbVvDsUDkQ1T7Jq+PQEFkW8kiZryUcwdYPeSeS8woj7d
 qWjlbQuiTFhxP0u9I+Rk7f5y/um6DNwBjePTmAffzn8CA8DT9aHhPGdxw5BYGD6ID1Iqgi
 48+Zpl2hkFvWdxoLQdfN2N/Q9hUwXlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678746279;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qigfN53DF15nFE3xLogXh9mWLgTC3vbDI2FYm/VPVcM=;
 b=zj7pgOLJ+wZRzJlFLytzV4eU/mfvNqKRlvYcbIQ4Wu3yao59NC6w9gVb8rghhr6LeZO4UB
 WUo7rgeL7RJxUHDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A03A13582;
 Mon, 13 Mar 2023 22:24:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id o6e6OaaiD2TLPgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Mar 2023 22:24:38 +0000
Date: Mon, 13 Mar 2023 23:24:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Ping Fang <pifang@redhat.com>
Message-ID: <20230313222437.GA27892@pevik>
References: <20230309085454.735531-1-pifang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230309085454.735531-1-pifang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] setfsuid02_16: Fix uid -1 too large for
 testing 16-bit version
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

Hi Ping,

> __kernel_old_uid_t is not defined as 16bit on s390, ppc64le

I suppose limitation on s390 is because __kernel_old_uid_t is guarded only for
kernel, right?

arch/s390/include/uapi/asm/posix_types.h
#ifdef __KERNEL__
typedef unsigned short __kernel_old_uid_t;
typedef unsigned short __kernel_old_gid_t;
#define __kernel_old_uid_t __kernel_old_uid_t
#endif

> Then -1 will be translated into UINT_MAX fails the size check.
> s390, ppc64le use definition in /usr/include/asm-generic/posix_types.h
BTW do you test LTP syscalls on s930 and ppc (32bit)?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
