Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4B0C36002
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 03:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742873598; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Z5agj/urri9LAiceOnFYHTxP3Tg1+JCnm+WkNsL9Qv0=;
 b=pzFcP5zpuZFH7FmqjSrz5ZDWPigIRwqKwPquztcwNUCgJwlZPsQFkRHcoW9JFXiOpgzQM
 tzvU0sVR9R8/0+hT9faoR7unQMpOvyR1SdP30v4sHruGDqtwCXIY2eD1mKZURZptStavfAS
 0z9FhQQjauooDxVemFjZjZ7SKy3+uAQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB5003C919F
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 04:33:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E14113C919F
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 04:32:57 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6BA4F608A7B
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 04:32:56 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-399737f4fa4so2782878f8f.0
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 20:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742873576; x=1743478376; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o/SdpqdlWghx6R+F4issr43sFFORmUsbiJehC5kz5lA=;
 b=Pn/7j1YnV4cFWlWhCYge2HgJFzgUCDuoxnPa0xWtME5HYn+NSjum2MY3EpkiuTIbyB
 5lRmscUDC48eO+vFqGqB1h0dsOI5nNPqHsmcXuJIhPI07xA+NrHFMB3c28kMpC+hhjhI
 nYYpHbxKYcAHAAAY/kKfa2m/02NSgdV+0nv8lEXRb6T3RKsRFk7muQQaCMMVDgyFU5uw
 HLrBJupVE7AKS2er+6bwOSObYK+Dtv781Wk/U5OLSXxgZ4aKQ8E6gPBv+asU977c14ax
 4PmTcsRg7zlINjHSeG7WrqblqIy+YwmjJq74vuyzWclHZcmaGdkxyqkTKTmVNYFwilnz
 pk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742873576; x=1743478376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/SdpqdlWghx6R+F4issr43sFFORmUsbiJehC5kz5lA=;
 b=wOhNa2GfVVuIzf3OT3AG94uZg3XA90hAy6KWHGFD1ApRc7NREXH2eV5Zkl2l0d2yIs
 virtF+IwIjiu3q+7OPqubzeBAIQzw+NwcJoJWhAE7/ht3S8wfUEr9X1qfXDdrhTlqvO5
 439jO99TThTRLa9r8UxKKqN+DQwGW8KlScTafJVV8a6gTu1FuzaiJ+MpO+a1xnW2La6+
 CW5wSKHRgumwbjohdNS5lNz4IfcNxEo0K/ZfLkk1imUw0SJqbGUGgophYzFNc4e8InoT
 u8j2U0cnKr5OEBL5j8FRPDTprJW6gOHIyPI3V83nT9yubis5cDHcxrgv3yiS9fUYEnsU
 +clw==
X-Gm-Message-State: AOJu0Ywpp1fsfVijzunyJrmnrIjLAbfCo4MPUa9mJcCPei5dtpyhKPU1
 uR57Rz+5yjYhHb+oOSLK7uHi2/5eMPX3PAB9D6PwRNrJtYC5VAwn57Bp/oLPJQ==
X-Gm-Gg: ASbGnctVyGWfKI1OdkNlhLLifQ4CtSGqqqdLsb9sS9mIeSCEKmdJOULkRLzI/dzWtDJ
 pT86TfacrCQAO4NTuxVb1gfo6hhtPSu0So2Bmuw5aQNpJywlQN2dV/ykTDbBULyr/YD8r7/vxRr
 /IfMi87AvPj4Ri8qXLWt4+EpT1CTl8qA+YmcCmSa3x9H6zxHGytbt39uBXpjXkj5aHOU73jlM1a
 Ho8OC/l/5TCehN3O+g40QI3DQpIpk4lCmUT+kndlCRGDeBD68GuozKCS+bAijcLfPBXn0AVp9Lq
 X7fh2jQcPnGJNaUHxfcU5sgBnyotOMxGqfoz8w==
X-Google-Smtp-Source: AGHT+IE5msgyGNFCNu1ZBVQSg3ZwKTZeS1l+/LRBoA69t1qyT5tUmoWRXk3bktE/hnDj6BO8arFEWA==
X-Received: by 2002:a05:6000:1fa5:b0:399:6d26:7752 with SMTP id
 ffacd0b85a97d-3997f937d1fmr14932021f8f.38.1742873575831; 
 Mon, 24 Mar 2025 20:32:55 -0700 (PDT)
Received: from wegao ([223.72.86.148]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390600a5f6sm8872333b3a.82.2025.03.24.20.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 20:32:55 -0700 (PDT)
Date: Mon, 24 Mar 2025 23:32:34 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z+Ij0gSOYnsJ+pio@wegao>
References: <20250305050805.7905-1-wegao@suse.com>
 <20250324120049.29270-1-wegao@suse.com>
 <20250324120049.29270-3-wegao@suse.com>
 <20250324153252.GB251879@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250324153252.GB251879@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/2] cpuset_memory_testset.sh: Remove test6
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

On Mon, Mar 24, 2025 at 04:32:52PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> it's helpful in the commit message to write *the reason* why doing change.
> There should be a note that C test in the previous commit implemented the test.
> 
Got it, the previous commit change mainly base Cyril v6's feedback.
> Also generally it helps a review process if you add a changelog what changed in
> the previous version.
Thanks for point this out.

v6: https://patchwork.ozlabs.org/project/ltp/patch/20250305050805.7905-2-wegao@suse.com/
Changes v6-v7:
* choose a node from the nodemap which get from setup instead of using hardcode node0
* remove unnecessary steps such as locking process into specific node and sched_load_balance
* update allocate memory size to single page
* remove unnecessary checkpoints


> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
