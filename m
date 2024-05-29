Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D773DC25B75
	for <ltp@archiver.kernel.org>; Wed, 29 May 2024 06:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716962662; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fHx2jG+D20DSwzZUUuG5QZ6obOZiJ42vP2pu4zUFzIA=;
 b=piOPxO3wsYT3POevgHSVf7G7ZnnY4obqWOhPdPoGs4L5sZMDZ7dC4eMjAWSrtjoOuEQNm
 7mTRWUxAK4QBOQkm7ocIOAhOBQblurK0TIb+JXU0AmMqQYpYKhi7E/Y8NVxqeQhAMyqA9oH
 GRB11zkzPVAJDbrlre5Cb2CuiKBik8E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1A313D0646
	for <ltp@archiver.kernel.org>; Wed, 29 May 2024 08:04:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A56F73D063B
 for <ltp@lists.linux.it>; Wed, 29 May 2024 08:04:00 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 877291400159
 for <ltp@lists.linux.it>; Wed, 29 May 2024 08:03:59 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-578626375ffso1821100a12.3
 for <ltp@lists.linux.it>; Tue, 28 May 2024 23:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716962639; x=1717567439; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S9NF7DmixSHyykPubMmi+fDGnwNijGJdWF/OzS908q0=;
 b=f6coGhaOwjh0v/t6LQyARu4cKNPHUQUln/zR0xjm8MuhOzTTLHPAkMz924DYSjz3QX
 WRHnhoxbzP2yGyDSeGO0NAhCutJfWIaD0YO8nTR/pWRc3HusjVA0gZ9qJQpPfTBYchBU
 a6a19jm0T035sfmC3dn6AfRnvj7aZg1ww2/BX1GQLpqik+aVV5bLWiByK3Sp+tNmzWU8
 /yd38sO0V5REM5V6V2MnqNnKtPOrA+D/NVGNYTIPRuIYfoxorGw2T7j8TyjlXO8U1IPx
 bGOTnDM0jpDeC1vcOz/RPBwTjzk7sTBkEsud9GqlqlT9f//LZdKo0spcRnYaYnzbnagP
 PgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716962639; x=1717567439;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9NF7DmixSHyykPubMmi+fDGnwNijGJdWF/OzS908q0=;
 b=VZuAPMYphqYPZbhv6uVjfgG6CFPqHGFUT47ETZ4cQemqn4aEJ3dOlxeKKDhHug+RsJ
 NgLg4o9b5o9iw/hoELiE44jqqjEZ/8l4fpoVeIkeGy+bjVVLRRJxY2wNqMPrRbz429Mh
 BA4tHuwEmkCqCoXiUukFCwGFVVyLPRda2mgzmvpsNdcMIQuHT/uChQOPPJBDuZxeQzTm
 srZOT3L0zRuK1ToZlbN6gZOeDANrNObLqXiBNQH483j9Q/YZd6tdF0/RQGD4CLzHryYx
 4fG2jf+UCQ/7Z8RW1gvio5o7zfkhiwsetf5q1QptSzoz+f9HcFOPBb4ZEJpZ01AtREWd
 lBWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA3fhKiDl9zUQNlmgMV8L6hSF3bOqorJrMRuleqFoOAMINPUFEuAX8jClgr6X96ansD1mjC1yQACexnD3VJ/9uLdk=
X-Gm-Message-State: AOJu0Yx4N5lL1WiPnDQR5RQF0XY9z0FNXSMg+jwHXQMap6HjoFuuiZcZ
 2a0gjxORHjmyQ5rYmJ6YlH72WhcgdKCEdSVF660mVRxkzNH/b22xBprsU+aF6R+81z91ks+zasg
 =
X-Google-Smtp-Source: AGHT+IHtd2bqUvBEIqs0E1URmBemH3JPbVaqU8bpY2UG4cowuxkagodLnBfW0SQcM9uUg1tR4Xo2HA==
X-Received: by 2002:a17:906:abd0:b0:a5a:896f:9be0 with SMTP id
 a640c23a62f3a-a62642eb70bmr1075632666b.27.1716962638825; 
 Tue, 28 May 2024 23:03:58 -0700 (PDT)
Received: from wegao.185.172.241 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6556c5240dsm6368366b.59.2024.05.28.23.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 23:03:58 -0700 (PDT)
Date: Wed, 29 May 2024 02:03:52 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZlbFSIp6h+sB5Oqt@wegao.185.172.241>
References: <20240522124754.9599-1-wegao@suse.com>
 <20240527231636.GA375669@pevik>
 <20240528095030.valplwc5t3m3betn@quack3>
 <20240528123945.GC435237@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240528123945.GC435237@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] msync04: Check disk content if dirty bit check
 failed
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, May 28, 2024 at 02:39:45PM +0200, Petr Vorel wrote:
> > Hi Petr!
> 
> > Overall this looks correct. But what this test really does is that it
> > verifies msync(2) is clearing dirty page bits. That is not very useful
> > verification from userspace point of view (as IMO it leans too much on
> > internal kernel implementation details). msync(2) is really a data
> > integrity operation so ideally its tests would verify data integrity
> > guarantees are met after a power failure - that is what userspace is
> > interested in. But probably these test are more within the realm of fstests
> > (where we do similar tests) as LTP lacks necessary infrastructure to do
> > this low-level filesystem manipulation so I guess what you have is fine.
> 
> Thanks for having a deeper look and explanation! I guess we take it and we can
> think how hard would be to implement the hard way (abort fs), as Cyril wanted we
> do it.  Or we at least add direct IO. (update that in the ticket:
> https://github.com/linux-test-project/ltp/issues/1157).
> And sure, if anybody adds msync() support to fstests, that would be the best.
> 
> But for now I merged it with your RBT (I'm sorry if I was too inventive to add
> it) to get some improvement (hope that without direct IO we did not actually
> turned it into false negative).
> 
> @Wei: feel free to further improve it.
Thanks Petr and Jan's feedback, i will continue do improve on this case such as
add direct IO firstly.

> 
> Kind regards,
> Petr
> 
> > 								Honza

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
