Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27EAD5E130
	for <ltp@archiver.kernel.org>; Fri,  8 Nov 2024 05:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731044753; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=aePeqgy8oSo8NT9HW7AsaTVL1sTRcwYogD5TbLUn8Cc=;
 b=ILDa8xQN1NiI65xF+ET3ILJgYBCnED02LVc0CW2JLUyvpjoMyOwTdkCkCascEQrz09oA5
 jtghj5qv82fCLYneHJEh0upSQHsUrv9mDB0MX2eLAcnHpFpsAA3gC+VkhaSgewxCH35QD9P
 q1iJUxrXTL9GcT6ZrNyn+00hUPqmvfo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A15B13D46ED
	for <ltp@archiver.kernel.org>; Fri,  8 Nov 2024 06:45:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E64133D46D8
 for <ltp@lists.linux.it>; Fri,  8 Nov 2024 06:45:33 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 89F3B21AC5B
 for <ltp@lists.linux.it>; Fri,  8 Nov 2024 06:45:32 +0100 (CET)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso289457366b.1
 for <ltp@lists.linux.it>; Thu, 07 Nov 2024 21:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731044732; x=1731649532; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oISMPN1SCLVXcxrjd+nyRdV6SBvkb9W+jkuGeTTMDxk=;
 b=Ch+p16bKIppJydgWw5nspAUhA2ZuwCVcM9y3P5qN6ROi21F3BVlpG8ItjvpzRiUhcu
 HEuHpNhtT99/muw5MRn7jh6pO40oXO0+TUl022svQysi6LQWDNXxVjKUMtQF0uqabjny
 L6XeE+GWKzt7FZt6fY4W6izYYYol02UH9v5KA6POS1Z4N4pkxxqH9ak5c8Rm63HPjXe/
 ErxGcKmnqoJ2fpe1J10q2z54FzhGtGoMZqPDQFi7iizjTZNF2T0g4iFu8TFMfdOxxwkz
 eZtcmxDFxgoBVLj7F2BewjWIlcRDHNucJ3H6thBSX7OYY9FYpUaboLpyaohIE6vaHzvp
 amlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731044732; x=1731649532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oISMPN1SCLVXcxrjd+nyRdV6SBvkb9W+jkuGeTTMDxk=;
 b=dd90kZDFbYOIFniOFbXwPQwUrcIBevuaELBTSybgrc+bFk9WVWPRL0+TxI8FLmppdz
 bmi13cKfMZ0RzYjnuw748YnUlqth6yg8hZDtPIh0aY3fV8aWSPjlPx/8us+VtzkHUvxs
 kiEKIl/xZz7d29UJLhr6f4ZjiQDvas0UvnWFDJ0ra3mMinnqMfxb++erz8PD9Caw868t
 VzY6NUc+FAnbkC30HzOizUgmZtzpPIXZmjK1RLdnDa2fOHgR6FRoeU6Oh6ypqqoA0gbZ
 8RXskyZhbx1SpkZM8AHAJ92Y+a3xdKLbUVhMIzKJdGXVjA98Q9rkjA/xeaTi0jmKLGak
 3zew==
X-Gm-Message-State: AOJu0YzoZTSrERz1oBagJywPh6qGfGnOda32NE8GKWyzfvJh8TWFrxKP
 7T2CTU1z/Ma23n88Y0rF5RKQz9welzMqUIyJIEqw6E+WFScuRqiZmkXf6eLoFxBQWfQjE+NyO7Q
 =
X-Google-Smtp-Source: AGHT+IFAbV1a+Hfl03Dg95onsoqQwDQeoSwok7XsU3fTq7uMG6hSn/y4D1kVnhZI4HOwMk+rNaEH2A==
X-Received: by 2002:a17:906:730d:b0:a89:f5f6:395 with SMTP id
 a640c23a62f3a-a9eefeade4cmr124467166b.1.1731044731865; 
 Thu, 07 Nov 2024 21:45:31 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a18521sm191383866b.20.2024.11.07.21.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 21:45:31 -0800 (PST)
Date: Fri, 8 Nov 2024 00:45:25 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zy2ldSShkyMtLMfR@wegao>
References: <20240926061936.21499-1-wegao@suse.com>
 <20240930135809.9300-1-wegao@suse.com>
 <20241105114427.GB1576432@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241105114427.GB1576432@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] cpuset02: Reimplementing the test6 of
 cpuset_memory_testset.sh as a separate C testcase
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

On Tue, Nov 05, 2024 at 12:44:27PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> This fails to build.
> https://github.com/pevik/ltp/actions/runs/11628250882
> 
> Kind regards,
> Petr

I also make another proposal for cpuset02 test case. 
This will force check/create cgroupv1 test regardless current test system support cgroupv2 or not.

https://patchwork.ozlabs.org/project/ltp/patch/20241108053710.8639-1-wegao@suse.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
