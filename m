Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C68C54E69
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 10:41:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6C9A3CDE24
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 11:41:51 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 245253C196B
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 11:41:36 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 627701A0109A
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 11:41:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710499293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eIVbPfOcQboK8o9H8lTAIJhmtDZfeGQ+5w4horKjgKM=;
 b=DtL3J6tnIQoIiwX23aB5gLcbS7T2zFKlyNXh46DYbS5fJNRVDc/b4/6uTKFJ96/UnqAVfi
 lBaTnHsQRzF0a38rSogSfb3wN/zw2cyQiYbeO36GtLFu3gc1fQLykpqb1Ib9vWCNuK5Ea/
 zitegE2f4CGj2pfTx+r69KPCEho+qkk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-9ACL-UwiNZyPOsIJ0SMrRA-1; Fri, 15 Mar 2024 06:41:31 -0400
X-MC-Unique: 9ACL-UwiNZyPOsIJ0SMrRA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5d8bcf739e5so1499997a12.1
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 03:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710499288; x=1711104088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eIVbPfOcQboK8o9H8lTAIJhmtDZfeGQ+5w4horKjgKM=;
 b=Hjl2cAKLHLlLH1UsbQxj8N8+Ceyv7YeALbSEgzNdYf9GzbDfFSvtwVRInjzhR68XU/
 Ctj0lEQEQ+Jr8zaAw6CM4OY6PiKMrjpkeoAaEv0uvUpwwAdnSzBMWaG9HnRDLn5m2+0I
 6WCu5hQNGdXt3ID77lDuJTDusksu/OHX1944HDP9i2K3bqX30Fkncek1mhnaAcKDxxhq
 QOLGr47vnoDd1GZS0rtO4kI9qVbXWWPLxfShCwye8dBBmUIDl4qIgBHrdfAdWS6hau43
 +gR+O0h/IVlYH9dp7a5Opc2o3EIlbamtjkoZv8kff3hYd5cvo6yvV5nO44Q9y6uBViYa
 Cpkg==
X-Gm-Message-State: AOJu0YwEn8URl6q4gBidbcAngth1LjsvoYP3zh8v+7+nol+juzqN6z0v
 itFjlUC8nXmGOROw/2COyc5WcndT0tEmPVQRj/crvm8eGWtcO9/DukFs00QCbsIw3+Md4r01Dxt
 t9ICXnkEIsGjm1sBRTBALh5KOuMZgJqR4D1d3KDxHFLBOGFKC3lMuaWQLB0zlO8BuTP5nJC49fv
 YQOKVyTkmt2FYy/1N92DJmano=
X-Received: by 2002:a05:6a21:1a3:b0:1a3:3d6c:245b with SMTP id
 le35-20020a056a2101a300b001a33d6c245bmr5478436pzb.38.1710499288754; 
 Fri, 15 Mar 2024 03:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYGXBjGLi71ih6tOuOyjJBnkB0s2wo1O97bXf6hVrVB5elsmSE/IykgU0IgMoYYE+VCyRW818thd5bC3duvYY=
X-Received: by 2002:a05:6a21:1a3:b0:1a3:3d6c:245b with SMTP id
 le35-20020a056a2101a300b001a33d6c245bmr5478428pzb.38.1710499288506; Fri, 15
 Mar 2024 03:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240315085019.3183671-1-liwang@redhat.com>
 <20240315090625.GA171573@pevik>
In-Reply-To: <20240315090625.GA171573@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 15 Mar 2024 18:41:16 +0800
Message-ID: <CAEemH2chUt7gT+_rR+B-_25za7an7fNugGqCLy5NF+SQ4037ag@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] tools: fix broken failure-detection when using
 individual dmesg logs
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
Cc: sbertram@redhat.com, Shizhao Chen <shichen@redhat.com>, rasibley@redhat.com,
 Bruno Goncalves <bgoncalv@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Patch applied, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
