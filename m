Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FD7D20691
	for <ltp@archiver.kernel.org>; Wed, 16 Oct 2024 03:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1729048450; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4BiKsvYUJle3PfO9NON2CGl/ewSFppfRlojLBP669HA=;
 b=aqbvGy/eVIVoeqW+Vy5hTk0jKMDUOlrPr1WCpVxUmKKIeYzmClO/bMG4y2AXcn26/cp3H
 X16o2Im7v1CBg4vKQ5GqiU9B0KkNdQb7Ry1Nk9pZwFjoMulu5Uz2gK/A8eaHITDiZcHTXD7
 McTt2ILmiKpfggcmitFESdIwFWcGVoo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0A543C6785
	for <ltp@archiver.kernel.org>; Wed, 16 Oct 2024 05:14:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D00623C6667
 for <ltp@lists.linux.it>; Wed, 16 Oct 2024 05:13:50 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 92617140B596
 for <ltp@lists.linux.it>; Wed, 16 Oct 2024 05:13:48 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-431137d12a5so57146745e9.1
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 20:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1729048428; x=1729653228; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MSJK03KZcGslowKdtfnxtKb79dWC1aZ5p5CdUEDqqMo=;
 b=N1HmvZszrk0wb5vAoNKic5oh5PU39BUDVHZnrZsvnkWwJYlCwHwPa6wVqLW5p1/OUE
 5sEKcGdPZi0mnt4XNapLkEUVX89Dc0DC1XABuKNxol2ue7K+gXtMpA4P6GzqaBj2Bp+x
 wNw5pAYQkycBtsD07Z+n+fqPnKp9hzqyCL9/2+t38Za9HmeENXClPsrJxabNFR2PQrIa
 5hwr1/Jo+iaDqzC9szCtuPoYxzjNxp2krNyduPnQX4oZqPQ3xiGkzA8QUCXB2Ytjuq4M
 DGiGY38gkFdpcmUJ623j5pKCYxKcQ83P1UWXOcKVeB/psm7FR63Xw4Q0E8AYdqvvMt0g
 1EIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729048428; x=1729653228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSJK03KZcGslowKdtfnxtKb79dWC1aZ5p5CdUEDqqMo=;
 b=G4MDuIrHgpWzYTLgwUvWLRxaT+a7VNW62A+8ckGEekLDED016aPv1pLddRDGXFVKFX
 Jl984nyvcttv+fjiBbosLGLOxOYTPfe0LWqoUjVF1nUFgpomCr/ei4YpvfwpWDV4swaK
 jnfR4Vv2HsYi9iphwlAii+3Ov5a96ST6AbPEfMPg92MxeCKpT4pEFwQgekhI+vrju7kV
 Kn4ZsgWZP1Oyl/YnNijgjYymtGGTZU8WXuMa1rm3iF5kKQ/jR1ARAVu8lauiwJrAhSSE
 ZbiLhRPPlp9nOERosOf3nZk1gH/29WzC6/zcieZ0ldhZv1AnQGkZaL1ULZABtazz9rit
 k3wA==
X-Gm-Message-State: AOJu0YxO8+tSIA7FQza/1OOLw16mv+wPmdbXs1Z9PeLLvrqqlPb6YU9k
 VdWkVjshy+OjqYL01w0pfYk1O7SPjgzJdrMzCkurWHE/upgHliM5Z+jbvjImBQ==
X-Google-Smtp-Source: AGHT+IFuUcL1BOJHK4VvpdRPL/YB13BXh56P6+3GG9UpL7wpqTk6NjCL8Y0bGkdZkX5fl/s+7o9dYA==
X-Received: by 2002:a05:6000:4f0:b0:37d:5103:e41d with SMTP id
 ffacd0b85a97d-37d5529f022mr12358397f8f.39.1729048427909; 
 Tue, 15 Oct 2024 20:13:47 -0700 (PDT)
Received: from wegao.216.228.5 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa908fdsm3072479f8f.52.2024.10.15.20.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 20:13:47 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:13:42 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zw8vZlmv2R0BngBY@wegao.216.228.5>
References: <20240918100344.21316-1-wegao@suse.com>
 <20240925035756.14873-1-wegao@suse.com>
 <20241015193958.GC46536@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241015193958.GC46536@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ftp01.sh: Add support for test lftp
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Oct 15, 2024 at 09:39:58PM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> I suppose the v1 is
> https://patchwork.ozlabs.org/project/ltp/patch/20240918100344.21316-1-wegao@suse.com/
Correct
> 
> To be honest, I would rather to remove this FTP test because FTP protocol is
> legacy. I know it is supposed to be a smoke test, but maybe using modern tools
> would be better than keeping test working among various old FTP implementations.
> (Also nontrivial setup is required just for few FTP tests:
> https://github.com/linux-test-project/ltp/tree/master/testcases/network )
> But probably Cyril would be against. @Cyril @Martin WDYT?
> 
> @Wei I suppose the reason for adding lftp (you did not explain it in the commit
> message) is that is the only supported client in SLE Micro? Or something else?
Adding lftp is used for fix SLE test such as SLE-15SP6, on SLE Micro will result TCONF
since no any ftp command support currently.

BTW: there is another PR on openqa side to setup local ssh network env.
https://github.com/os-autoinst/os-autoinst-distri-opensuse/pull/20278 

All detail discussion can be also found in:
https://progress.opensuse.org/issues/165848

> 
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  testcases/network/tcp_cmds/ftp/ftp01.sh | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> > diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
> > index 53d1eec53..12d32a9a9 100755
> > --- a/testcases/network/tcp_cmds/ftp/ftp01.sh
> > +++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
> > @@ -4,6 +4,7 @@
> >  # Copyright (c) 2003 Manoj Iyer <manjo@mail.utexas.edu>
> >  # Copyright (c) 2001 Robbie Williamson <robbiew@us.ibm.com>
> 
> > +TST_SETUP=setup
> >  TST_TESTFUNC=do_test
> >  TST_CNT=4
> >  TST_NEEDS_CMDS='awk ftp'
> > @@ -11,6 +12,16 @@ TST_NEEDS_TMPDIR=1
> 
> >  RUSER="${RUSER:-root}"
> >  RHOST="${RHOST:-localhost}"
> > +FTP_CMD="ftp -nv"
> > +
> > +setup()
> > +{
> > +    if tst_cmd_available lftp; then
> > +        FTP_CMD="lftp --norc"
> > +    else
> > +        tst_brkm TCONF "No FTP client found"
> Test was converted to the new API, it must be tst_brk.
> Also, this code basically means that testing is done only for lftp,
> otherwise TCONF.
Thanks for point out this. it should replace to following code as Martin suggested:

if tst_cmd_available ftp; then
	FTP_CMD="ftp -nv"
elif tst_cmd_available lftp; then
	FTP_CMD="lftp --norc"
else
	tst_brk TCONF "No FTP client found"
fi

> + You keep requiring ftp in TST_NEEDS_CMDS, but at least on Tumbleweed and
> current Debian testing lftp does not provide symlink to ftp, only tnftp does
> this. Therefore you require both lftp and tnftp for testing.
> 
I suppose ONLY requiring ftp in TST_NEEDS_CMDS is enough, lftp is specific case for sle check.
For Tumbleweed and other OS will directly use ftp(TW only contain ftp by default).

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
