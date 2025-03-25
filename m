Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F09C35FFC
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742895558; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1Yb1DPT2kTaE1i0NEvyRDbzND4iGA7Z3bM6zbJtESMM=;
 b=QJ4oEr6WM+lDkYPn3rSEI/ApBuPsirRLLrNOtzClUOAqbQZHXAH/sxaSvKniGyrXVENvt
 y+cRrIjdsQZL+jmSO9V5WYeLLZcwZhm+eMfqXnYshiFq4/FByrBsHHMGMQ2E1ArbQSRTUdh
 d6XJwJv+Pbx0qWiLhPsYrn752NadipU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA0B23C977C
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 10:39:18 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAF513C19F4
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 10:38:55 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 951E61A0C260
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 10:38:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742895532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JykISlpzQe6A+645FRs1QnjvhF6veofuANqIWuqPf0I=;
 b=IAyBJVxwGtjIGAk2gv7Ga84kwy4ofVfQUWtYO2QxI8dNWcX9z0uV5PcdJcWRvr24NpzEM6
 U0pEVgxmS8mxA7tRHyDl8P6F/t3wWVlpAdp83zrfmra0V6NelZ3R9/kkYBjCQtj0a9nZFf
 U040iKt5stfIUGrdv/OZmqbeJOoHLP4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-McRkL1fLM6mJOALXqVcdxA-1; Tue, 25 Mar 2025 05:38:49 -0400
X-MC-Unique: McRkL1fLM6mJOALXqVcdxA-1
X-Mimecast-MFC-AGG-ID: McRkL1fLM6mJOALXqVcdxA_1742895528
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff6af1e264so15558421a91.3
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 02:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742895528; x=1743500328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JykISlpzQe6A+645FRs1QnjvhF6veofuANqIWuqPf0I=;
 b=BYDKDK0lJw3qUbdsGMgRE+M4bq3WzypT627VAuthEYu2oolRtSAjpUGpjcnj2cTPcz
 47Zv+1Rba+UgMI8SHXinDn/H03BkGEYZtP9SUlG3i0UL4Je3eNZNrOxcYHcdhNWjwkVV
 2BrOZ38CP7N53RDUeuV8bo63PCM/Y6y2+0KVEFcg5zLU1DyYnkokWmSH8bwJMyxEXnQ9
 2SMB3iLkGb3jknX8Un4/FhfR90q2lxZoyS55O7guY6QvrKgd7Q3ynLFULgXFR6YGhDof
 RI74JLZmU8I95hjIhfbinJl20R/re9vdgqjON7cpqBzLNZpio0oZDwdoHWLkb19yPAXL
 xBLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIaNH+lz6xRSIZNpHmVuv+bgk9Sg2f5O6S5fFEBtzcYkmdS4xwrHImJlN8u3O0tAAy5gw=@lists.linux.it
X-Gm-Message-State: AOJu0YyDIqlAEfm6NJUknXpKwv+S8mDAkHTIlhFtpkNKwjtea7wl9ZnS
 Tnybh+u5iDatGNJKnBpJGlJznlehTQxUxMfXmuREeo+kJj0cABZ8yiYTfbbuwcUwRUqOflAT3JP
 3vrsji44ylCBccv/qkQb8Y72Oxc+dUjtUEpjkuc4K3igpXi7bpcQzCcHdCAwu8tlbceEP1fnFqC
 urLyneNgQmCcvOdtSY21Zu9ys=
X-Gm-Gg: ASbGncu7DRyfkVlYma2/U30tDgI2QaslB2d65kjLNwasJ0w2N/58fXnmdgSKt0jNZov
 EcNo2qvXuC4+zY2cnt4m8FiMxPkavJ6Ei8FnBN9eAD+CEXwQ/LDMgdB9C4d6GvHSsmM/HaDIVoA
 ==
X-Received: by 2002:a17:90a:e18e:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-3030feea3d2mr25349340a91.28.1742895528393; 
 Tue, 25 Mar 2025 02:38:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa+HDXfzijYobIcKPM/ECq3hfL0KP65Ezv1Bo65hNacX6YeL+aa7uAnBDV4OBY0qMosiGNqIXP01HOw7PD1k8=
X-Received: by 2002:a17:90a:e18e:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-3030feea3d2mr25349315a91.28.1742895527961; Tue, 25 Mar 2025
 02:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250324-ignore_vmx01-v1-1-5959aea16d7f@suse.com>
 <90cc11b5-7e96-45ca-8db4-05a5d60e5c2c@suse.cz>
In-Reply-To: <90cc11b5-7e96-45ca-8db4-05a5d60e5c2c@suse.cz>
Date: Tue, 25 Mar 2025 17:38:36 +0800
X-Gm-Features: AQ5f1Jrhv7B5tCoP6G473saDnToND_7TuI7CMTKD12lbn-bos0yWfb6btseeP3c
Message-ID: <CAEemH2e8_AX=XzOXT2KsUmdJCSREH_LW41Verj16oGan70awCQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jA9KJ31iaGdw8SctXZdvKWSwefSBOKvqGwhcWwKVOME_1742895528
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] KVM: Add "kvm_vmx01" to .gitignore
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Linux Test Project <ltp@lists.linux.it>, rbm@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Patch merged.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
