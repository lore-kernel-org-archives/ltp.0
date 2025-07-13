Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A83C83F1D
	for <ltp@archiver.kernel.org>; Sun, 13 Jul 2025 15:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752420134; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Tz3miyjMYLUZSsqy21wmdDTEui7obJE0WPRhcElcfjc=;
 b=LETGoz9kYHv2vFVgkbUM2s/bhgIiSEvQdYSZ88CioqFNhvc+2oUyckC9bzGBAVyGnzChq
 pOORM1jMI25PG5/tTW6uQIpkJei/9RYGfa8HgRqS+HFtqByboBmcuO1oICpxp+ch+yzTd+l
 a328OwIH25Nz2MSeDpe+zXKywDARiQg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 479983CB33D
	for <ltp@archiver.kernel.org>; Sun, 13 Jul 2025 17:22:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EB2C3C06B5
 for <ltp@lists.linux.it>; Sun, 13 Jul 2025 17:21:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9FEB61A001D8
 for <ltp@lists.linux.it>; Sun, 13 Jul 2025 17:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752420110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=68imv10L9+iVM1Xf8LR9JFRt4H7OWuXEGgyaE4RyDp8=;
 b=EHLoGPJ0Yv0HWExQSiLsMUylbBSyCLXxmQKWNyFMVV0DzBL6soGyWX2zAyeaUG9y4XHXya
 Vl8r1SZwgwyh0ezA4ibn5mTsQaKLVEpDF09P/8LCefId8nDdm3XVB2d7rt56fsSG4/z+lx
 vluIbu1XGtOtuPOaFS4vrJdd7wTa0w8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-X9jzqspENHu1bYw7Pzbxhw-1; Sun, 13 Jul 2025 11:21:48 -0400
X-MC-Unique: X9jzqspENHu1bYw7Pzbxhw-1
X-Mimecast-MFC-AGG-ID: X9jzqspENHu1bYw7Pzbxhw_1752420107
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-748f13ef248so3258670b3a.3
 for <ltp@lists.linux.it>; Sun, 13 Jul 2025 08:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752420107; x=1753024907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68imv10L9+iVM1Xf8LR9JFRt4H7OWuXEGgyaE4RyDp8=;
 b=u/RCdJY1FLR+ct05KaGk9i88yb6kR2jsRle4wWcjLnqO+JcXYsiwtUPSKjITy+G3+S
 atwXaPWYKZqD5h4pt+pHihCzeU1mwN9a2rEQOMxD7+6EDwKzuzE36BmHr7I/HZujx8Ol
 fQy7ogvc5S/hFxDL3+2QLPQ24vV8tEPlxpd8V2xeT5Iz57ID79qomQemyTq36k68mZ/b
 +q8qh0bHPFLmGOLPwwmr7mFA6hkICtkfSfAD7Dx+5HJ/owcizyBNGTk729TA3/IIPCrH
 pjyoDn/mvhZ5QcnM3IjELfKw3M0NH8mOmfSgugocHT3aId6AuAvGR0YtiIOa9cXhMYbc
 H1Dg==
X-Gm-Message-State: AOJu0YxU8z3AFeAILaJ7N4ZTVqN0ZbyXWUiaEb7BPdc8EYQPKYBhpDpB
 qsPaexVCsr1aVu6mm5x7dIAgnWPcT5o/fvGNf1kbg1Vsflf/N6HaVsmMoCXKOPf9xZ8Do9izomM
 zMF+6Kl4+dZZ+qF4XKauCOnNPUvGSCK/xKKKhDJHWaszA99w/hhRr
X-Gm-Gg: ASbGncvwNWZ1zz6iifOpdtNSBoHzFFhuyfDQmy6xCdj3XWHStMqs8DZEd1jdydHgg59
 fay2VhPgybQ5GcNT1jCB3zEa0ut8Dm0athby9zM0n4TZzseRYXeit9txOMtXtKsEj3v44xr2Z0J
 c3M4XN8+oQBxJYvZ/evmukDtxXmJABdbsRCRxV+uwjx+RcAsg+Iv7LpHfQOCmdNqwbrVy8Vo0Ne
 avrM7LTDxWzdgq+OgfwLsr4sADNXKYerAdVFMFKN/7IeMyrTXOrrGCArCKuHnPtbbTd6Rnq4jdx
 iFE2isZMfgVZfleC9FN69pq7e3K7+aL60f95Y6nh2OinC1OpK4ZXHyOuCAvMCZssi3Rqt65jrUz
 0Hlmo
X-Received: by 2002:a05:6a00:a14:b0:74e:aa6f:eae1 with SMTP id
 d2e1a72fcca58-74ee2160858mr11658507b3a.14.1752420107345; 
 Sun, 13 Jul 2025 08:21:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCyCwJSSDQzTM7JH+tAaB/tZla33GISfNgfXAm2GrZom/wrm9thXqLt7BFqgGSFsRGPbdckw==
X-Received: by 2002:a05:6a00:a14:b0:74e:aa6f:eae1 with SMTP id
 d2e1a72fcca58-74ee2160858mr11658480b3a.14.1752420106777; 
 Sun, 13 Jul 2025 08:21:46 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f1f62bsm8812433b3a.95.2025.07.13.08.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Jul 2025 08:21:46 -0700 (PDT)
Date: Sun, 13 Jul 2025 23:21:42 +0800
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250713152142.2pe2sfgq4s2bd5xv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250708055950.m25zfqyfr4n4qkcm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <c5247046-97ab-4d21-aacc-e4018ed4a366@suse.com>
MIME-Version: 1.0
In-Reply-To: <c5247046-97ab-4d21-aacc-e4018ed4a366@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3tpddu3TQxQ7gAjBHKpTTviUanTjXPlgX3vyiLHgHaE_1752420107
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Bug report] kirk can't run ltp's fs_readonly
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
From: Zorro Lang via ltp <ltp@lists.linux.it>
Reply-To: Zorro Lang <zlang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jul 08, 2025 at 10:59:22AM +0200, Andrea Cervesato wrote:
> Hi!
> 
> fixed by https://github.com/linux-test-project/kirk/pull/61

Hmm... Looks like a regression from this change. After updating kirk to
this fix/commit, old issues disappeared, but I started to hit some gf*
fails (from runtest/fs), e.g.

gf12 fails as:

mkfifo: cannot create fifo '$': File exists
mkfifo: cannot create fifo 'TMPDIR/gffifo17': No such file or directory
growfiles(gf12): 147154 growfiles.c/1453: open($, 0102, 0777) returned -1, errno:21 Is a directory
growfiles(gf12): 147154 growfiles.c/1765: 1 Hit max errors value of 1
gf12        1  TFAIL  :  growfiles.c:134: Test failed

gf19 fails as:
growfiles(gf19): 147261 growfiles.c/1453: open(,, 02, 0777) returned -1, errno:2 No such file or directory
growfiles(gf19): 147261 growfiles.c/1765: 1 Hit max errors value of 1
gf19        1  TFAIL  :  growfiles.c:134: Test failed

gf20 fails as:
growfiles(gf20): 147275 growfiles.c/1453: open($, 0102, 0777) returned -1, errno:21 Is a directory
growfiles(gf20): 147275 growfiles.c/1765: 1 Hit max errors value of 1
gf20        1  TFAIL  :  growfiles.c:134: Test failed

> 
> - Andrea
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
