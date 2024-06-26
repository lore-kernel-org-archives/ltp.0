Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D8AC27C4F
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 11:17:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A50573D113D
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 13:17:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 066CF3C1037
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 13:17:22 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 472B61A01176
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 13:17:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719400640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ENqPcZrvyERU+qXSpFTCdzdDC4X2wCqR7okEBUVCFdk=;
 b=IR0Ac2uzmpu602XZOZPb61LEvtxZfZeiFPAzqR7kTRQxc1/I2jqw+A7TIOlUBSYf4Zg9wy
 FbPBedWjPbq6/lqUMr1a5ZeltqaqqhdBXBQ+HKWXlblHuGVK+kuvp2NzBc53ymcFEH7hFj
 3BEPKdU7I48r9y6qXD4BoxEyNnI3Uu8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-z1UwSYfuMNu30Hx3tMbLeA-1; Wed, 26 Jun 2024 07:17:18 -0400
X-MC-Unique: z1UwSYfuMNu30Hx3tMbLeA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-649731dd35bso7190169a12.0
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 04:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400635; x=1720005435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ENqPcZrvyERU+qXSpFTCdzdDC4X2wCqR7okEBUVCFdk=;
 b=WgXIco/Y4/Bgs6hpKZfI5mD+FFfv5TYNycGJXHwsp6mESS2GJmpzOkzDiazdIVpAZC
 IsfHvviQI2LLKHgDuut48Zf1jmFz7aHKVVSZs8YuesC4lx9+EFHe+nAxgqwGe3rupDEb
 5xThqucUyVFEi14/jRWxFeo0EfFxsPV8f/iG/R1ysAFB7F0cdLV0P1QhNLkEfDrZNHRZ
 z0VrV7lrSHaTos8jumTshbRn2/ujBAMmy8H2oCconby66jNv+VC2IWOuy2HUBkwvQjEZ
 Kem8QiNmYgHliHjgJKpwW9iuoBinHlgwnwgl9qpkwlkb0EZuiPmgYttVQK+Ug8PfSX9T
 mvow==
X-Gm-Message-State: AOJu0Yw9y8H3EtIv4/HwiUDQGSQZTyxsKAlKRtsRzGex0aMJyunl7y5R
 t4XjE50zNbCe5vrtVv+C7ewPTYNnoyLI++qr5ceuaz1WLimipkqEBJ+10vPl9SE4YJMVncL5QPC
 7yR+VISHLfLPRgkYn+871QqTJGCc0SQzp+bCa8iTr21Lpoakh9+GmRl1oW4V15bNBIYzka5kjfs
 dX6NEkfdrcLcq4ZxRF/WX37xMArZ7d95Q7OK49
X-Received: by 2002:a05:6a21:33a8:b0:1b7:577c:7180 with SMTP id
 adf61e73a8af0-1bcf7e36f04mr11270256637.12.1719400635704; 
 Wed, 26 Jun 2024 04:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ9T0rhQONQ71+UjsHGbk9mib+CG6bXCRPmlQTA462mBqyny+mmn0L4oux3ZltJWSAS4FmYMcdGFtfhuasRyQ=
X-Received: by 2002:a05:6a21:33a8:b0:1b7:577c:7180 with SMTP id
 adf61e73a8af0-1bcf7e36f04mr11270237637.12.1719400635325; Wed, 26 Jun 2024
 04:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240626065257.14367-1-wegao@suse.com>
In-Reply-To: <20240626065257.14367-1-wegao@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 26 Jun 2024 19:17:03 +0800
Message-ID: <CAEemH2d7zFqeHEi1gyMRepkW4AqJfrqvpF=14eZVY4epT_HSqw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] cgroup_fj_common.sh: Disable cgroup controller
 in cleanup function
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Good catch, patch merged.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
