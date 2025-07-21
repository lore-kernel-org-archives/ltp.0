Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF403C83F1A
	for <ltp@archiver.kernel.org>; Mon, 21 Jul 2025 02:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753064593; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ycVL62ivlwJFQI2rgzrJq4QgxVQZv1ch2/L2ZJKY8ng=;
 b=aheLRqlpB/zh9MRRy87GB7p+tZrLYZ8C6lycXpvCnotUqoXjHpPKx3mIcFg2dyF6y3QU+
 hm7mhNC6SBZQ8mQLNQNajqdwwLapqTnv6c3c5l7jFlWOJfnJmcFV1rpECyYDMNj6JxpjZ7X
 Qi/HkpSnhTLzjTql88+Tn3tpG4TRFPc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD5D33CCB38
	for <ltp@archiver.kernel.org>; Mon, 21 Jul 2025 04:23:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2E3B3CC5C0
 for <ltp@lists.linux.it>; Mon, 21 Jul 2025 04:22:50 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7AA1E2002AF
 for <ltp@lists.linux.it>; Mon, 21 Jul 2025 04:22:49 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so2916110f8f.1
 for <ltp@lists.linux.it>; Sun, 20 Jul 2025 19:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753064569; x=1753669369; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PqZ1MYAtHQNGSFr0QKLl0hnsBzzOttTO8c3o/NdHam4=;
 b=Gy8v5g7wjvAfD2OorTOUPEDY7gtEO5OvBWRfr96H9wm/DC6TE9AtyUl+Qob+YRfkO/
 04uLpZfYPo1vQyq0mx00+ekT4p6q11Qo7gHmEsKTCUvxJU+8HuJzwCiKMi2e36Ni/Tgf
 esCefYpN+egz8Uqysxw3bj3J0Cla5Nlz5UMvjezORySXx2Efbw3AUud3DWawFRC4vbDv
 +dlrOBl86aDT0K5Z3bXYOty/b2GDJZIhp2ul1yC/1rUWF2yCNGE6wZ5rb5k5CiAx0To/
 5BLv3gPEj40aymx4bwRSnF+ncZAOaV9y9cm+rpv2tJ3dha9HdKjnkyVUFVBm5Pl6HIHS
 4R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753064569; x=1753669369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PqZ1MYAtHQNGSFr0QKLl0hnsBzzOttTO8c3o/NdHam4=;
 b=XtM1HRzctQwRfS3vwEvqGJfD3Xle4KqE18dXJIFheX9qH7iFodD9qIJqr4J8PdBpWN
 Q/jAGRwwsfmv7K6t959j14Yt1Ib9OpxfYYTR+deCFfFdjC7wG63/I6bjeh/fGiUvccTL
 GD2Akk5FQ3p4lxJfWnkgEYG1sG5mvP3iEZ4j+UT+OsRFHzR/Y7gt9TP2lru4umOIdM6Y
 9YEJbvCs/o3dublIHOJjGZ8zbN0rKbBYys2rZsaB6FmbtL7/e1oJp7IZV5k8fr2zH5vI
 02LonLDKtajOtPoT0TOW+w+cp4t7B8xr6fAG+UL2voR2ornqg35mx+omqcNYrYmCRVI3
 2qXQ==
X-Gm-Message-State: AOJu0Yz6jnya2zaEttOKPjKLQsgLIjZewcngRMFffZRAJtM3vbfg7NKf
 itDLiqS8aGZ8ov2PhzGnRtPCd4Ii7K5Fq3UEIPp6GWWtSYQzpwJk8KhIz5ynPez0ww==
X-Gm-Gg: ASbGncvt6+rp0cRDybUzNe2MLsJcsPGhnvj8NN93iNJZsrcZq7ei27DnY6ulyOQ25um
 Wb7mPCTYpOjc4Ke/MCG5bsgtYBCVElijl6RAc0tzxaNlU9YjGcQCqyCSoEgnlRyJL2ilrfqnU4y
 9w99XZ/T2o14oi35+ana8jCRHSOxJp7okaUiw0F2NoNF/Dw2EoufxLaBRQLE/Qjep+Lp2ULWq5e
 LQJw7VKwufVuRtTHIH4lhizxmoyug6gT7N+25IYE7Cw56ZnaLtVJg9Y3JKOhbb+c0kI4EEfK8aQ
 kMJKPvozvRHqAYwCmZlFOLQLM+GWLSvuC+unEexBldpLGmTfX/QxC73oPUVAA9IVjC2ZbRhSKYk
 Rsul2v4eVoSTh+NvCR8H8jfFk2g47x0RF
X-Google-Smtp-Source: AGHT+IFAAaMmCFaaT5S4w/5g4md7rxybCRFW5EqVjEe4b+i5XFrvjZ47853EqJLCK/jm07mTATj9fw==
X-Received: by 2002:adf:b646:0:b0:3a4:f50a:bd5f with SMTP id
 ffacd0b85a97d-3b60dd7303cmr11394613f8f.31.1753064568856; 
 Sun, 20 Jul 2025 19:22:48 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3c3b2c4esm47161665ad.189.2025.07.20.19.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Jul 2025 19:22:48 -0700 (PDT)
Date: Mon, 21 Jul 2025 10:22:01 -0400
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aH5NCcXw3tgpGeci@MiWiFi-CR6608-srv>
References: <20250716120600.2855395-1-wegao@suse.com>
 <a1a3bf02-5d2a-454d-bbe5-5460cb2dda60@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a1a3bf02-5d2a-454d-bbe5-5460cb2dda60@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] splice10.c: New splice tests involving memfd
 secret
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

On Wed, Jul 16, 2025 at 09:13:14AM +0200, Andrea Cervesato wrote:
> Hi!
> 
> > +{
> > +	char buf[1024];
> > +	int fd;
> > +	int pipefd[2];
> Since we are testing only a failure, it makes sense to create input
> arguments via tst_test.bufs and initialize them in the setup().
> > +
> > +	memset(buf, 0xff, sizeof(buf));
> > +
> > +	if (!tst_selinux_enforcing())
> Maybe it's better to use tst_selinux_enabled() after merging: https://patchwork.ozlabs.org/project/ltp/patch/20250709-xattr_bug_repr-v3-1-379c2c291bb7@suse.com/
This case need check selinux runing status instead of enable or not.
So i will keep this unchanged for next patch, correct me if any
misunderstanding, thanks :)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
