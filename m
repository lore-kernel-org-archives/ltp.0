Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C15FC3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743076262; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : cc : content-type : content-transfer-encoding
 : sender : from; bh=BU5UxoiaMPTUBTSNDSKRp2Od//ROTDdL8l4vMWzkfNU=;
 b=SpGwoVf/USClqmQ47oXA613rR0LPMmSR1tMnuvatzAb1q7lvXwWuTP511DQx1FoKhrto+
 PfzZ0t3qwIwWiIsLjSJU7bUNk6rR90poDElFrhBeqP9Bv1NzjqMMKGPapE097oxSSXbS5mT
 ROIAOeNgHRsjsJ6bMGSCy1+TIV8TSss=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB8863C9E1E
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 12:51:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id 8C2A53C726B
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:50:40 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with UTF8SMTPS id 18E4D600061
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:50:40 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso5995505e9.2
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 04:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743076239; x=1743681039;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LcXehMuKkoCCNc2pefiNGr/DrOUM+Q32bJ+jrjkOv2I=;
 b=cgslttNWIL2B7vG+w2jbmX9F9lRzXSUisq9uSQSYuZCf8cZaRRXNWHJseuXx9XIVNr
 kv0UNOMSqJsJla7sSCb50hZzknARv/moDNsxcniN4OOPPzJ4g9V44q28JK4LUvsXSYM9
 ictJQSjlB6Jj/h9nEr3pBVx4HgkjQxpmMVYDBWRWiE6lPsBVP8V3bBQB8sEckYb8SNKk
 kXUT0lS0hqxucsP3hbdDatvzqGwRdJsuTL/FIApbEgEsEj3Dr+qQrAiUHrvitnjkVTDy
 wkPQ9yif//d4Vc2PNa9qlkevtuXh0ZTbP571HkUJYwN6Yic3ZegDZt/Q1FGh9ZbUtf0H
 XbVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+Y/bx97iaJ2AJU+I5gT9/sMSwAzXfNoQS8W5QjipANRNTMRfGAzabAU4u+8CQo9IFv9k=@lists.linux.it
X-Gm-Message-State: AOJu0YyKy77Mr2riomUBPmYXl8eyRyw0g9bdXVTV6KZU8S/r2Z+j74L8
 zrtsOn7XmT0GQ9aseThWOVcgPzqGxS51o8p9CS+iyiRdV42t8KJWUqE3ZZujC84=
X-Gm-Gg: ASbGncuInmdyjn5OLD7Ma+TcqUjZAR8qZqqdvT/Lzhnr07T5kpmw79ZKMxb/iAYcScP
 HjKLV895m+3xXb0lJTZBNEPoPmb0EmbpuyMHRGg60EVUnjike/os8JV1N+RFmfWvROI0vMiNNlU
 PQZMtt6XBqU///MmcoMO8n+2FOHJJC+8yA24PF1OEn3g8DV6ETGAb9Ki9N9IGstW5n6JjsDYAhZ
 nVSz20DyQoNLhmsQh9pLCGUBpgE96ytn2IyrDfpoUZVqRhfeSy3sgxsZaZiIUIjIqUzZj2eb775
 Wal2rQrxTVEL4UKAlhpw+DbexbEQKnH4mTvrhIfCU8Jd
X-Google-Smtp-Source: AGHT+IGVAWj2txVQLkrUehKAHkd6YcRnzxRrkc7N8ju4tEyBAQcySO4N/aEe2cTMg74GibQbx2NSfg==
X-Received: by 2002:a5d:47ad:0:b0:390:fc83:a070 with SMTP id
 ffacd0b85a97d-39ad1717242mr2996103f8f.0.1743076239397; 
 Thu, 27 Mar 2025 04:50:39 -0700 (PDT)
Received: from localhost ([179.228.213.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a284695dsm12662854a12.44.2025.03.27.04.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 04:50:38 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 27 Mar 2025 08:50:33 -0300
Message-Id: <D8R0YF9GVL4S.276WLTALPPSQ5@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250324234016.367228-1-pvorel@suse.cz>
 <20250324234016.367228-4-pvorel@suse.cz>
In-Reply-To: <20250324234016.367228-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] Makefile: Update 'doc' target,
 add 'doc-clean'
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
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsae+/ve+/vXJlIHZpYSBsdHA=?=
 <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marlière" <rbm@suse.com>
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon Mar 24, 2025 at 8:40 PM -03, Petr Vorel wrote:
> 'doc' target previously run docparse documentation. Point it to doc/
> directory so that it build sphinx docs. doc/ dir has metadata/ dir as
> dependency, no need to specify it. Call also '.venv' target.
>
> NOTE: it's still possible to avoid virtualenv by calling 'make -C doc'

From the root dir ?

$ make -C doc
make: Entering directory '/mnt/ext/src/linux/ltp/mail/doc'
make -C /mnt/ext/src/linux/ltp/mail/metadata
make[1]: Entering directory '/mnt/ext/src/linux/ltp/mail/metadata'
/mnt/ext/src/linux/ltp/mail/metadata/parse.sh > ltp.json
make[1]: Leaving directory '/mnt/ext/src/linux/ltp/mail/metadata'
if [ -d .venv ]; then . .venv/bin/activate; fi; sphinx-build -b html . html
/bin/sh: line 1: sphinx-build: command not found
make: *** [Makefile:24: all] Error 127
make: Leaving directory '/mnt/ext/src/linux/ltp/mail/doc'

>
> Add 'doc-clean': to remove only generated data (not optional .venv).
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes since v2:
> * 'doc' target: call also '.venv' target
> * Add 'doc-clean' target
>
>  Makefile | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 5066789349..0c572248a4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -169,8 +169,14 @@ INSTALL_TARGETS		+= $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))
>  
>  $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)
>  
> -.PHONY: doc
> -doc: metadata-all
> +.PHONY: doc doc-clean
> +
> +doc:
> +	$(MAKE) -C $(abs_builddir)/doc .venv
> +	$(MAKE) -C $(abs_builddir)/doc
> +
> +doc-clean:
> +	$(MAKE) -C $(abs_builddir)/doc clean
>  
>  .PHONY: check
>  check: $(CHECK_TARGETS)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
