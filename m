Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90633C79F80
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 06:53:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A6C03E936B
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 08:53:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBFD53E60EA
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 08:52:52 +0200 (CEST)
Received: from mta1.migadu.com (out-130.mta1.migadu.com [95.215.58.130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5705D1000F2D
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 08:52:52 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=YKEQabRl0fQioyu2WzAuihYD+MHX/wbN4AxMjNDtuMc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788504771; v=1; x=1789109571;
 b=dEtOQtOOhspD3R/pBM1vMGUIL+VLQYv00jdCTxVZh8vXcrTKmC1HAZzEsOP3VmnNiaaxwtWc
 dDewWSBslsrOdgwgjlCcUhxs+uXjOQrvb23p4VvqFV5QY9sCV+SCbRRrzoGDQOZXVb6outzh1yt
 tEsJLhONPZ3iuNM8zzp55r+E=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 6bacfda66b8af91d;
 Fri, 04 Sep 2026 06:52:41 +0000
X-Mizu-Trace-ID: 6bacfda66b8af91d
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 14:52:36 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <appqtLIfarlxCyER@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <apo-YSqDGDNbrzcc@linux.dev>
 <6a9a6469.3d30ac2e.110181.4b84@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a9a6469.3d30ac2e.110181.4b84@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] coredump01: New core_pattern specifiers test
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Generally this checks is really nice, but it'd be better to
> > add more checks for the core dump file?
> > 
> > e.g. file size > 0, ELF magic valid, and type == ET_CORE.
> 
> this is already done, but we can introduce ELF type check (read below).

+1

> > +static int verify_core_dump(const char *path, long long expected_size)
> > +{
> > +       int fd;
> > +       struct stat st;
> > +       unsigned char magic[SELFMAG];
> > +       Elf64_Ehdr ehdr;
> 
> Ehdr is not portable on 32 bit systems breaking our testing, so I
> wouldn't use it in this case. We need Elf32_Half which is in both
> 32bit and 64bit.

+1

> > +
> > +       fd = SAFE_OPEN(path, O_RDONLY, 0);
> > +       SAFE_READ(0, fd, magic, SELFMAG);
> > +       SAFE_CLOSE(fd);
> > +
> > +       TST_EXP_EXPR(!memcmp(magic, ELFMAG, 4),
> > +                       "core file has valid ELF magic");
> > +
> > +       fd = SAFE_OPEN(path, O_RDONLY, 0);
> > +       SAFE_READ(0, fd, &ehdr, sizeof(ehdr));
> > +       SAFE_READ(0, fd, &ehdr, sizeof(ehdr));
> 
> double read? I guess it's an error

Oh sorry, that's a duplicate from the vim y&p.

> I will send a new version with some of the proposed checks

Thanks!


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
