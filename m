Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D32606A319
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 01:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=R/hUpQQB;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KzQP0QlH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792634363; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=M3Yhl/dVEzeH6nZjaoOY91yaVTPsxFJ5I+nFVab6dHw=;
 b=R/hUpQQB7EmOAsnNSFLZlIfKpLofQr/5duJopaptna0UBalwMZ/aC8dmN0aVLndTKa8Ml
 ZbF4hbeONKsWE1PsUl4/e/ekeigIO5P9Fb8qqa8pvkWlGbdgSsrtLBcVjP5NkUzeyzzGGkg
 1BfZ3xgoDga5g3juzNTkr/+uNztAaog=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 338053CFE11
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 03:59:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD3633CFD25
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 03:59:03 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B674B1A00A27
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 03:59:02 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so1173363f8f.2
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 18:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792634342; x=1793239142; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fnsJtZC42VFiPckdXc17tnW4wA46q9TfxDr5dtBz1ew=;
 b=KzQP0QlH89Wf6zza76DAShxmFYDYm/+AnK+2mT+i8JX3YahwiHXAqHMoEzbisJkg+n
 /zjEP5S2lJPBbi8jgNYFIMAR7vAd5V1KVR+atqXZ8sOKJTcm9rc6QGRa5JpsSlAWkfdv
 aICkkBF6fj5ZhOud2z7WHRpwWfyP6I1Cd63bEV+6jB6Ts2bpkmsa3aYtlbaVmEcWcS7u
 uyoy35rQW0VEbQs926/CWhlmPrppRv8jLkJa53GsC7HMnvzOIAuMaJiqZvGH2huXOaDD
 FojaK9DDFbWnCA6Rx/cyCgmVToJY1KurjVDWO71rHU+dwvBt9JKIQI0e8s8qr757D4Vd
 I1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792634342; x=1793239142;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fnsJtZC42VFiPckdXc17tnW4wA46q9TfxDr5dtBz1ew=;
 b=EDGLFwRijj5u1TsTSZK4ATMULN1iqezy8R4wmwvsgrfq0KLUI9gnlX/G0H4pqfl92a
 x1ORaLgtxCwZ+aysJ2eN9emdVztHGerLv86Jizxofp2d3+QheQ5eq9T8C/yz5GBLsI6E
 U9mOQpY3fuWiwGltjoNI8DIggr8CT+qNtbekrkepM/eTQC1yvujAQd8XlePu07xhdPeX
 gtkJz2V7kYfqUTVXnJt449+xcVc4rFFwKABPqaY/nobbyfXjniq2Fl5i82W0/TaM8OXf
 SkxVa2HZkIslT8nLK9aNYetNxtQDtn1ykhXpdqJcR25/c6RlK3C5iS0nZ47saF9tipD9
 TeAA==
X-Gm-Message-State: AFq9FYIlVtEw+DQwas/XjiHRt7qhutDEb6ku5i9Gp/IbxVSavNxJorcK
 HeYYuzVCWt/HPetL9KN89dBHPeyJyGUbHonHKm+MiC888UZtpjfmibVKlO3Xg209tg==
X-Gm-Gg: AYBFou0MptoSKQxao42z1Dv+GykswQX48yQpWiomqbbOBfckT6VPAssr9W7Dmcy/kx5
 yKTyARZ0zY8LbWN2Lh+NkQtKgxJyGyqXjgvk6muBoULFZZ4XaaMVKjXcNf3kDAYWi127DByL256
 NIxCc/eknvoXXTap//diwzR0GEQeKeUwxilVL1huxeoFSVd6kB7TALKUeAl9rwMqkMwtOl0BETu
 KGe0JzjirsQnYMXldCBF0pqOPMotKWj7cu0pJRs++IcczP3UaCJjV5AiYLs9W1tdEYKrOspVXhB
 k+lfc+nvggPg9PuUsyZ4HFAZhOILhPuNB6IQrIed9vWZhxBg4zDPGZb9EOr/lIWAKBke/zbptli
 pnnv/+i/3ZWwk4xq7CMfUVFFy9i0Lkw/u9xdCX/ynLMhs9X1uVAs/wzKbgciEcTodfctjF5LkUt
 3lreejAscNkdPa91L7fMyX0ix6B8uqgVMib3CuEWhjzJ0YcJ5sNWsxf354C+J78ycdjPmFhEmT7
 H2eSvpwGZol8dk7Sxsi/HXt8cx7FvzVXcPFI3u/XxjLwR5EGhwbikaX21UwVlC3KpqKYbntep0K
 e01ODa5lVr+/Nd3fazvFdMP8VoxKBs4xFuJ+GQLLFT5CwevvggZnXw==
X-Received: by 2002:a05:6000:1606:b0:487:27f9:844 with SMTP id
 ffacd0b85a97d-48e264f43demr5761568f8f.57.1792634342105; 
 Wed, 21 Oct 2026 18:59:02 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1casm7066577f8f.7.2026.10.21.18.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 18:59:01 -0700 (PDT)
Date: Thu, 22 Oct 2026 01:59:00 +0000
To: linuxtestproject.agent@gmail.com
Message-ID: <atlt5K-DGjFWSI_V@autotest-wegao.qe.prg2.suse.org>
References: <20261021084933.19097-1-wegao@suse.com>
 <20261021133446.9440-1-linuxtestproject.agent@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261021133446.9440-1-linuxtestproject.agent@gmail.com>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
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
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Oct 21, 2026 at 01:34:46PM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Wei,
> 
> On Wed, 21 Oct 2026 at 08:49:12 +0000, Wei Gao via ltp wrote:
> > fsconfig04: Check FSCONFIG_SET_PATH
> 
> > +	if (dev1[0])
> > +		tst_detach_device(dev1);
> > +
> > +	if (dev2[0])
> > +		tst_detach_device(dev2);
> 
> High severity: If another process claims a loop device between
> tst_find_free_loopdev() and LOOP_SET_FD, attachment fails with EBUSY but
> leaves dev1/dev2 populated, so tst_brk() runs this cleanup against the other
> process's device. Track attachment ownership, including partial-attachment
> failures, and detach only associations created by this test.
> 
> > +	snprintf(path, sizeof(path), "tune2fs -l %s 2>&1", tst_device->dev);
> > +	tune2fs = SAFE_POPEN(path, "r");
> 
> Medium severity: LTP_DEV can name a valid device alias containing spaces;
> the preceding calls preserve that path, but popen() splits it into multiple
> arguments and tune2fs exits with usage, producing a false TFAIL. Use
> tst_cmd() with an argv array and captured output instead of a shell.
> 
> Verdict - Needs revision
Above comments looks like over-engineering to me. If anyone think change is needed,
I can send a follow-up patch.
> 
> ---
> Note:
> 
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
> 
> Regards,
> LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
