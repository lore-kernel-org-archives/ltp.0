Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DEDC48BF6
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708504436; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=gEkWFs4VtxLuir56e0x7nxAOnVRzJSu0dBHfFT6mcdU=;
 b=Xp8lC3kJ5meSat9EDEVHJPq1ekL5Rr9sAUFizgD87zXAv8d4De8wGe3an+7H13w22/w5F
 pRbb2cvnHu5JDv47jK46x70QZ4KzQlHp3B7kPG+HYznVRXhokJB6tSOR8l6O79gFKPkzVfA
 Vi814nVGlKIhNzdlG9N6jsCQRGy+Q70=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F1C53D042C
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 09:33:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A4BE3CAB6B
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 09:33:30 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DF55120116F
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 09:33:29 +0100 (CET)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-512ab55fde6so4962531e87.2
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 00:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708504409; x=1709109209; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fTpFyypml9PceitWYJYnBOlGiCKtT0tq+52nGo9U/c8=;
 b=DA7AJIZFUvxrN2oZMklorIb3CVY/38HAW7illMPJp7bdi8ib/CCLxqdI79SKbAjf6k
 NKRBbVxjHL7Lf/DujujJgTiIx2MohYXzJ5vfjgjuSp/f1FAIZfZ7ZVFki2W2E8JAodjj
 zF9G//bKpil/fjVn8p18iT9zYAVrEsXj3Ev/jzXnH9B9yDFnpapudUUaIW45XU5wNhTd
 OMrXWKCSRzb/PwRZ3babhr283wg1Nzbf8hFQn1LaVVMXzhsVaFg00dRGFoJdiF214Lhe
 BDYT8KpqLaitr4IG/nH57Br2Aqf3vu927QxDLu8PfjUIVViDArikYZEzsQDDU9zEIg/s
 mEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708504409; x=1709109209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTpFyypml9PceitWYJYnBOlGiCKtT0tq+52nGo9U/c8=;
 b=aTRAEOZNWNkOe5Rwhl1cegyPqB0k6KRDGmXO/Aahg+7/OTM4gd1CL+yxuKFgQCS92h
 9wP2nEU6XudPQ4wwLtoNwn0eHaev4HUTrS+gyp8ilAr1txrc4h3FtGT6QdCTVmH1oFpC
 YLsiTxWIEqNEXwYzpvuFO1N8h+fmucoYhwmqqeEpYL6zQ2g89Uir5fBjna02NmwhqmO/
 4Nw3FFLlp44Z5SDkyKpMKlsBaFtTbDGhyCvoE5ThhfanGrWfjoDcDTTRsz976Y8IHYWk
 S2b7f1ycTJwvTCF5VjpjL25FXybn/mdpGH2Q2C3SkFJx/J0RaZWLBpHQ7iV2c04eaF45
 vigw==
X-Gm-Message-State: AOJu0Yw873trU8WKSfkBdfKeu682ebA1lmsTzej1Q1JCEsLY5NqU32g1
 UUqHGmO1hUuaLCMDyXQq5NoTBTuBmplSuoWYE5jdfD+hmsJR6QFZA7Dm9KNFjEK/0lycjgFFci4
 =
X-Google-Smtp-Source: AGHT+IG/DLfz5Zh3zqEyLLJCzDsO/U+JUqTwuyovnn8fosBCcfd//DqjAmYSWstkz0pN6sq0HGXpmg==
X-Received: by 2002:a05:6512:251:b0:512:aa71:5def with SMTP id
 b17-20020a056512025100b00512aa715defmr5577387lfo.28.1708504409088; 
 Wed, 21 Feb 2024 00:33:29 -0800 (PST)
Received: from wegao ([223.72.38.233]) by smtp.gmail.com with ESMTPSA id
 p9-20020aa79e89000000b006e35c1aceeesm7526448pfq.197.2024.02.21.00.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 00:33:28 -0800 (PST)
Date: Wed, 21 Feb 2024 03:33:20 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZdW1UDq17nHx0eE2@wegao>
References: <20231204002623.17302-1-wegao@suse.com>
 <20240219134845.22171-1-wegao@suse.com>
 <20240220091837.GA1088847@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240220091837.GA1088847@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_test.c: Set system default umaks to 0022
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Feb 20, 2024 at 10:18:37AM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> >  	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
> 
> > +	umask(0022);
> 
> I don't think this is a good idea. Changing umask() in the library can influent
> tests. Could you please instead add umask(0) (to reset umask) on the tests which
> need it? The way it's done in open07.c.

cgroup_core01.c and statx07.c can use umask(0) in tests and i have updated the patch.

But chdir01 will still failed on vfat and exfat. Like following error msg:
chdir01.c:100: TFAIL: nobody: chdir("subdir") returned unexpected value -1: EACCES (13)

The reason is umask(0) should set before mount /dev/loop0 to /tmp/xxx/mntpoint, otherwise you 
have no chance modify permission of file. What's your suggestion?

susetest:/tmp/LTP_chd5JtblL/mntpoint # mount | grep loop0
/dev/loop0 on /tmp/LTP_chd5JtblL/mntpoint type vfat (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
/dev/loop0 on /var/tmp/LTP_chd5JtblL/mntpoint type vfat (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)

susetest:/tmp/LTP_chd5JtblL # chmod 777 mntpoint <<<< 
susetest:/tmp/LTP_chd5JtblL # ll
total 307216
drwx------ 4 root root     16384 Dec 31  1969 mntpoint  <<<<<<<< group and other has no any permission even try chmod
-rw------- 1 root root 314572800 Feb 19 04:51 test_dev.img

susetest:/tmp/LTP_chd5JtblL/mntpoint # touch aa
susetest:/tmp/LTP_chd5JtblL/mntpoint # ll
total 16
-rwx------ 1 root root    0a
drwx------ 2 root root 8192 Feb 19 04:50 keep_out
drwx------ 2 root root 8192 Feb 19 04:50 subdir
-rwx------ 1 root root    0 Feb 19 04:50 testfile <<<<<<

Thanks.

> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
