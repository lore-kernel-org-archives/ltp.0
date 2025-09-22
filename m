Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34078CAC592
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 15:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758553988; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=t4WT/zffyk5PNM6RWge2/oqt8cUDpv7USDRuz3W16XM=;
 b=BZSiVguh1FeTU5nJshKBaGTAtzj71zh05+pPBopK8V5LdYIHOs2NBEodbTKxhquTDUgqW
 J3F3tvbKIY+zP6sflhRzAqUGSi/GUiumesj1wJlyptf2Hzcn/AD2kdsXbacxeUb9erPpg5Y
 dOnizk1nHLor8Kc0cqeBhfUdxjLG5HY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 912333CDE5F
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 17:13:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60E513C2566
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 17:12:47 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C79521000223
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 17:12:46 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3eebc513678so2882496f8f.1
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758553966; x=1759158766; darn=lists.linux.it;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j96YbgmFbVkN9JW+49mMOKUN6Y0hYVsp6iGVbzvPBjw=;
 b=TT7jtix7sdejAQU20NFNfayhE5zjAPAiuiDWdzqqz4wXuG4FSI1E5UQw4CzBt3XVGM
 JRa67DloLUnrBBN1TAk+t4Pr0E3c3PgWyB1M3FLu+v9jAXmJSEQ/lIeB7PWvpOT5rBCA
 0MkWqL9SEJzXyuIVrJq6nE+PXBAuLi6cwOtuiiqQnvlEWwORQU1NpW7gG79UQlPnGx9n
 C4SdgW+e02jE++xrPGSim4tF2q/1oMBh4ElVo0eAW7wCymaSuaR+CcQgcfJVe0xv+8Eb
 wylKQi/qX2vFICWdUndyWOIL/HjtPPEwT9/q81PSvrH0RS4Ki7hawH56PnKsnXePOVwt
 +QCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758553966; x=1759158766;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j96YbgmFbVkN9JW+49mMOKUN6Y0hYVsp6iGVbzvPBjw=;
 b=cKfkbcvodc/bYRHpBL/565FXDaRTgyOmjX+x07n8qp8BACV4jAN15kO2mQwqjN70Qo
 m+acBJfoDkgbDHHATZwq3HKHcUT5VPmlVAUkHHL5qfL9Q+/XNRnAmCNLRNje5QpnF9aK
 zYvDpWb+m6Z/ydNl0BSon1JpkvHanDFEjgCOPgeRy7xdKQifubwGsvxxMa5T+jqPGfo9
 rYgzr3tOxn00Xh4+aTHlBXQ0EecNDyKkQxLxvXts9d7ff6b1S0ZgruEPjvUAa7sgoPL8
 i9ZIAEsIt6L0GgzxzcAvk7LCyvwdDaNocj87hVhrgrKdHCpXiPoSspkr1+GzK29jZ+k8
 ljBA==
X-Gm-Message-State: AOJu0Yw7n/urmbRJEog2GSi8QqWr6flETcgryKfEfJetfLH2ZaS3OMPS
 zGN2pJMu9m9YegMuo0/ERszcm6rGoey+Rnt06ZzWgt0DT6Vp4id7IxhPjf9HO570Cr+u9Qav60m
 1arik
X-Gm-Gg: ASbGncuXpMRMsazEFnUNtbNFKkBKpFT7GIfPtIL5tQ7Mjq6g6b/H0qO1sC0EG/ymnkX
 caiO+PeeSA2+RiRCsGx+vw72UVnxZWUa4hGs1GgKF2GJ8FpytQyToowYPcHSNrHkj7Bvg6yGdTg
 khVFWupA+NmCnv3ldVE6z96YjVsorIPWcTymqx/LLTWvsDOnlj/Xdvwv4Rw9qLt3+FetF2x6xif
 XTzg304XXgsc7xyCHbeWRZV8yVoCSW/jbVxM6HOEWk0ephIh7bCLCvZiXJHnKu5nA9s/xz9fl38
 X5RnFihcad5ZFcUXeTNxo0ZTHRh7XKoZucRdUPuV5VG6QQpeQQJz3UttzL47gxxkG8o4t1jjytn
 NW40JOxhn4w==
X-Google-Smtp-Source: AGHT+IFFDcm2E5cUjjn+HbypUlS4hUX+r9u+AG1BMnwB/1g7/fGUyntJEaLoyfz7afRAPo/mTDwQ9w==
X-Received: by 2002:a05:6000:2383:b0:3eb:c276:a361 with SMTP id
 ffacd0b85a97d-3ee85a47d0fmr10624868f8f.54.1758553965814; 
 Mon, 22 Sep 2025 08:12:45 -0700 (PDT)
Received: from localhost ([177.94.120.255]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-54a729b9222sm2704722e0c.22.2025.09.22.08.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 08:12:44 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 22 Sep 2025 12:12:38 -0300
Message-Id: <DCZFCNZXJDTF.P7C1U2N3TYXM@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
X-Mailer: aerc 0.21.0-0-g5549850facc2-dirty
References: <20250922-fixes-pthread_rwlock_rdlock-v2-0-21802b93c2e0@suse.com>
 <aNFZ5EKAVTJNyZSO@yuki.lan>
In-Reply-To: <aNFZ5EKAVTJNyZSO@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/2] Update pthread_rwlock_rdlock 2nd assertion
 and add GLIBC workaround
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon Sep 22, 2025 at 11:15 AM -03, Cyril Hrubis wrote:
> Hi!
> This version looks good:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Nice, thanks for the review and help!
-	RBM


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
