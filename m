Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3714F513E9
	for <ltp@archiver.kernel.org>; Fri,  6 Mar 2026 02:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772765943; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=bRGZWxu3ZkAcMd+IAl0fVw3dc8UzIegLrPv8fK4p7L8=;
 b=eOe6CEJio/1iEbH34Z+rZrjBlIgKBeJv1Ouzn6wZoamp5mctrBlbPNm0zQpkzeqDBWrQc
 +K0STWnhBbKJfKd6Zr+RTe4aU+qAuwpslHw+idYo14kliQ9AhI/N3eqSx54A19+yaryMgew
 hvJn+6q12FIO5f33iYCqsI08/zfEjvo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C1193DD142
	for <ltp@archiver.kernel.org>; Fri,  6 Mar 2026 03:59:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C0173C67EE
 for <ltp@lists.linux.it>; Fri,  6 Mar 2026 03:58:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E4F4B1400E57
 for <ltp@lists.linux.it>; Fri,  6 Mar 2026 03:58:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772765914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHys10WryeCAdNRHE1aImPIA64j6h/qyvrvUUpU0BDc=;
 b=aZqOUoEE/IopFBJN9nWwvuxWRXaPuKC9MWYyE8/YJ8HgBzpQUjeL0/nEIyf/CvlMulOqIW
 88GmXvDId3RvPVWBCN7dTPBt5POd60x0rlOGttOapdDS4XQHsv7m9/pluFM9ux93WXQ9cT
 dHTBYtX9km03tAcszXeCu2c0wtLAcIE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-x14pMytCNlyGPkAGXi2GaA-1; Thu, 05 Mar 2026 21:58:33 -0500
X-MC-Unique: x14pMytCNlyGPkAGXi2GaA-1
X-Mimecast-MFC-AGG-ID: x14pMytCNlyGPkAGXi2GaA_1772765912
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c738f71723aso823484a12.2
 for <ltp@lists.linux.it>; Thu, 05 Mar 2026 18:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772765912; x=1773370712;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHys10WryeCAdNRHE1aImPIA64j6h/qyvrvUUpU0BDc=;
 b=Mm2EzaVbbNfXZ6J+dRP0j1Ty2W+P5slDOCs4XMJcrdV9u6o3dlTn7337kAxaDyDXng
 yAIvlxWdaXGc48Y7IBnj3QibIEy0FM00tV81Q1bTLHUFC88HOzBJsB2M8FuU/hTkpxHX
 uwwSAW2sfZIce5PXHNblnnxLUkOxl9ZwqXUc3+IobdA/HvnNmWxrUY2fIbSlnzDHZ2I/
 noRy38N3vC+7gFiyWzO4M6CxM/ZyNFGm1xTm19G12tFZL6Qhh99KZ8fHH83VuDufRLV4
 70VldQ2asgAlmmAMJQ7bquIwiP1uYRxBCTr0Plr938cj5STG9mgP7FKw/BHpAj1bgJSP
 egcg==
X-Gm-Message-State: AOJu0YzI7OjG3QOT0PvW6uVzhD2a5w6h8HtnVaT+PvEvuTv8G4QJHnoh
 YCKU01mZKEx3uk89vQFaCNL4+o7J1NfvRjoFOkYg0908pd5xcfnFapYp5jwzvm/wKl4DbhLgA1j
 v5PiTxhyYy2Kwnb8sjSDcTbteGYHKtFTiGNjDHOY8XvUWgvz7/WC3
X-Gm-Gg: ATEYQzzxDF4BBqB4HpH4vEvVuDdOn8d7rdt/AqYiwsTWNy/zMntJN5K2+CNQDcp8kq7
 6dOnW47MpdCWqIeu9fcihWAIVENGVxSbvhNc2mseGfS/d6ZPdeHG44RNmX41fbnw/FgTBSn28td
 craAYkOVkZK+QFufLebH0fhxM9079k+VYGZvHm6Jw2cnz6mwjsKAdJvRjS2PHEPHC3tafk41Fo1
 llzHmXQ5VULN1O7pg/U3fnZmWMUfDQD27Ka3+uIcv3jrHg+YocenDrC/yWKayf3Yn5CWTIt1tS4
 qcRtijD8pLmDEDl2l3uialMqgVOovGkEuRTrMbMeUdG8gZEknpIlplocNjsVuNPoOuVCmPdPtiB
 YhA5Z33V/ZbYqY/7r
X-Received: by 2002:a05:6a20:d80c:b0:350:d523:80a4 with SMTP id
 adf61e73a8af0-39858fed2f6mr781174637.28.1772765911986; 
 Thu, 05 Mar 2026 18:58:31 -0800 (PST)
X-Received: by 2002:a05:6a20:d80c:b0:350:d523:80a4 with SMTP id
 adf61e73a8af0-39858fed2f6mr781160637.28.1772765911571; 
 Thu, 05 Mar 2026 18:58:31 -0800 (PST)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c739e183020sm77426a12.26.2026.03.05.18.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:58:30 -0800 (PST)
Date: Fri, 6 Mar 2026 10:58:29 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aapC1ZHA_XopT50y@redhat.com>
References: <20260304161425.12461-1-chrubis@suse.cz>
 <aajhsZYkb9WqTho2@redhat.com> <aamSaHica1WmVDIT@yuki.lan>
MIME-Version: 1.0
In-Reply-To: <aamSaHica1WmVDIT@yuki.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vNqrH3DQwMX3EWNg1qtircdUk2mrIuOh-cy7URO9VXk_1772765912
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: newuname01: Convert to the new library.
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 05, 2026 at 03:25:44PM +0100, Cyril Hrubis wrote:
> Hi!1
> > > +	SAFE_FILE_SCANF("/proc/sys/kernel/hostname", "%1023[^\n]", proc_val);
> > > +	TST_EXP_EQ_STR(name->nodename, proc_val);
> > >  
> > > -	tst_parse_opts(ac, av, NULL, NULL);
> > > +	SAFE_FILE_SCANF("/proc/sys/kernel/osrelease", "%1023[^\n]", proc_val);
> > > +	TST_EXP_EQ_STR(name->release, proc_val);
> > >  
> > > -	setup();
> > > +	SAFE_FILE_SCANF("/proc/sys/kernel/version", "%1023[^\n]", proc_val);
> > > +	TST_EXP_EQ_STR(name->version, proc_val);
> > 
> > We'd better clear proc_val between reads:
> > 
> >   proc_val[0] = '\0';
> 
> I'm looking at safe_file_scanf() code and it calls tst_brkm_() in any
> case that no conversion was done. So the buffer should be either be
> filled with new data or the test should exit with an error. Do I miss
> something?

You're right, I somehow overlooked the SAFE_ macro, which will cause an
error if the read fails. Please ignore this comment.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
