Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3DEC61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 08:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787820689; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=N5DZN658OkDvtaSmmeAzHLF73IJxRacNeaciVFwWywY=;
 b=PA46Y4A+lMgdo8HwshoKz6hPydChs3UgS9qeNqmAsVcuKnBpoeGkT4a4xr/3B1aCozZHu
 hhSuEJQP8wYWVh0DXF8XbXnYCY9ULrTQIH/0Hol9KKDE8Xfs0lHLePmO8dvdxVYSyBe/Mxf
 DWwHghJ0WLESJ/VNZ//9J5CJrcw+958=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E19A3D0EA6
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 10:51:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7519D3C8484
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:51:08 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B48FF20090D
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:51:07 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so988716f8f.3
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 01:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787820667; x=1788425467; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2E706IjQStMNilmj/VMJ6lWBei2U3d2QivVWxtVIVdw=;
 b=MKgqwqHZFUsZw0FQpA7NJqIqKR2jc4mFPZLYvX7DTX6hADKwzPB3EWFbOCmKpBGUcg
 VkiOe8ppt84UJfbXZz1DS7KfmH6rjl7xOOioJxEAUuTDtZzubhWqFkVWRzYmppnX8Z51
 ejQmFLZb1g+B+PMqZkQmzDGxiyfUxj9yD2k+S5WtBG5AId7dKytv746ptV1gkCTvBsyx
 Bn4V/nadWo3biPIY/Xgor+v6RMDmpZwg1Ti96rmzQKa6lyBiiMKF5GMxVkaH1Fofjh+u
 RlovXUzNZOmgMhx56X8JJ1sTMLkUW1yzVxIj5TO0dtqVCn19QDKHV2/fr8hqY7RtHhjO
 ZVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787820667; x=1788425467;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2E706IjQStMNilmj/VMJ6lWBei2U3d2QivVWxtVIVdw=;
 b=oHV0RiqN7Otnv0ijoUZ2/WJQA3aLx73h+46IIr+7OAQ4qdQk2beAoX2nLkgYp8kHeG
 LrjQv0Qz4I5whoWwIJcZK2teA65FVyPcECesDccWMQsXdTSXAh/07Wy4S/j9RMmLoYiL
 OncMdTTMnnCRmwQDbiM3mN8ew1l8+QhkST26Ec+P+FFudKfI/DHnRTgGC6DE+4+C9ZTT
 oIarL5Idk0NGWOMBem4MqAo/GXDONTPZOM9CzwHRScYLRNVtENRtrUEt2tBJBNhkkjUG
 2lxNOc0QFXLxw+clgbidULtTls8oNj6r6Fqvh6c2jcn3XghNI4R6L+EtZb+uEv29v+WP
 RHNg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoP48EmTbFJENFgYdDMBl8IspfdC4APLXIFPJUfFB41TaYpbkhIM+NeCCcpS6NVH+sqW48=@lists.linux.it
X-Gm-Message-State: AFuF++mPQyHuwHVSZPjiS3P2u/mt9TJLu6GcKXIEhVj7eGsV/Es320Uk
 VZS/C6RCc6JlEK4XfveVzWUOMpgVaqcEmutKy7CAw/rItPUcQMfov/kghO+2hR7IQKM=
X-Gm-Gg: AR+sD1293ut69AYHS3f2crgeYq+PpQXZ0f1YBOmECvEwEVBAErVPwrZ1uDKmBueXw6D
 dhlYwYyFkRfo1HAmEJ/nIp/2BI3bicId27wpqcuctR5iZZgh0BXzqEyN88eBASgI+mAF814fT5e
 174zuKMJBigYI4GzRMWIf2bpB9EHbT8XlRORQ/BPBp4QyBtC95sAvTiFrylxHvOA6CTdeDbbz/T
 YHTO0560z1BVOpw5dgg1mVB+SbO8lyJFQt8s3O7Z6Rzagw2RtBHbtlQI1aWC679iIp6q7au90nb
 vzqD8o0xs21zy5LsQNCpWlqJ6yLpPMTWz1ioblJT/qiMqHiGjapXJH8JRDv3F+5aHdYGb1Gwpf1
 EYowIm/E3ThsOAIWlD5TamIt9O66sPrD3pxZ5EXdvdrBK9XJF4V1hJVaNn3uyDw5yGg+LOrQc31
 QvxllIv+lUWz7xB9ZAdjxxu/EPP6r9dbldinCJzEXN3UbmOU2/o09FG++kAbXviX5AZOYJvC8Bj
 j++gxj6fFgmUdhstLYd/mW5/nnLMof7CRc7G3kN+fiuqqT1f2LafeDIE7f6KDV5Pta7h00=
X-Received: by 2002:a05:600c:34c3:b0:499:93b3:91ea with SMTP id
 5b1f17b1804b1-499dc82e965mr148447605e9.15.1787820667044; 
 Thu, 27 Aug 2026 01:51:07 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499e7170b72sm74165805e9.0.2026.08.27.01.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 01:51:06 -0700 (PDT)
Message-ID: <6a8ffa7a.ed0817e7.d5305.0f1b@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260827083636.8672-1-linuxtestproject.agent@gmail.com>
Date: Thu, 27 Aug 2026 08:51:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/prctl: add more fallback definitions
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > +static struct tst_test test = {
> > +	.setup = setup,
> > +	.test_all = run,
> > +	.runtime = 180,
> 
> Could this declare .min_kver = "3.18", or otherwise treat EINVAL from
> PR_SET_MM_MAP_SIZE as an unavailable prerequisite? PR_SET_MM_MAP was added in
> Linux 3.18, while the CVE affects older kernels. On such a kernel,
> SAFE_PRCTL() currently reports TBROK rather than TCONF.
> 
> >  cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053 refluxfs:  CFLAGS += -pthread
> > +cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053 ghostlock:  CFLAGS += -pthread
> 
> Could ghostlock be added to the existing assignment instead? The new line
> passes -pthread twice to every pre-existing target listed there.
> 
> >  refluxfs
> >  sctphantom
> > +ghostlock
> 
> Could ghostlock be inserted in sorted order?

only these two are valid, the rest can be ignored.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
