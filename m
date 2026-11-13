Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64E606A8BD
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=ehduri9O;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JejqE2gf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794565908; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type : sender : from;
 bh=H3PKpoxwdazs/WmRK3RluhMugk1s8e5/wdSCFu3PawY=;
 b=ehduri9O67Zs1+1wsCdyPNkO5/2QqVn3q2Cji2Uky4ydgLFhE8RJlHq2j4RaJ7QYJKvxZ
 mPQykNSlP14sGGJmMQI/qwZlJMQOYQW62s9tryrDc6NwBlc6w1BjZn/D+7/JF+hP4QeU/kc
 bhyRQhzV7G+2eTQWaz1LD9vtPdaneyU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25D583EAABB
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 11:31:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 782FD3E2562
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 11:31:28 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C103B600BCF
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 11:31:27 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so4369185e9.3
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 02:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794565887; x=1795170687; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rq8BRpHo5FNUOOU9M+t8WEL1yVPEmF7a3E2fQStaOu8=;
 b=JejqE2gfVcOMR9OSjjRrIQXwD0BfLPRkhecOchrVSQkSBhcI+EAY550DizMdOg4EHg
 WmAosAi2cHc4lfysIAQ1+iXe6cNfmAef8BUD+lNBXORT8hja22II52TBg1eIMzoA4Snk
 VaAGz1D2FtcO5NuLT0VtVIoh6brwpRGol7UKAlM02EhCZAf1UXJNNSTfdXTR3X0tUBC/
 bR2Y5J5g1S6iMk8wSAV+ruiyoehRF0CCJ//lVVA5dZs7KxaQ7WiWIEAUqBQR2e3h8vYZ
 fylVu07363AY/QUkQ/Fmhihif8bePwzZqAXwiqByB3tpockqlnMpYVqkfVe3NjZ3+sto
 9/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794565887; x=1795170687;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rq8BRpHo5FNUOOU9M+t8WEL1yVPEmF7a3E2fQStaOu8=;
 b=Uknl4dpDNw1k+T6jnPx+uv3XS1ebIUbEFUqAFf2oNxEUUstQ7/ZL52KPoGHKhz0ZpV
 38cOpmwX2H5itw2UoDoMTvIDXsMziYCpdlbrWCej5v1Y8AhNqGhoFBED660EZ+HlqZEc
 ku3UGlta11eQRhRBmmo/sVgsT9xwAU2p9/0D2sImQXyyUxgnaaxK1b6fzofd2ZvUb1Ty
 53lTMlfwigGN3IKS+qVw1ELTUeT7Rt5205cx4w3FoO0rsgiw1f8Pg9KOAWdnZvB9hzSb
 VrWKARueBpHT+E/TJxs5OvTlCpk/sVUIeHvi52noKunaDEm3FdEa4QKgveyd88GtSF/G
 RzDg==
X-Gm-Message-State: APuU4Z9Ffc42OmGbh2OIrlOkvHdUKn33VGmsObiTQXH3n+vr2tmSNfk9
 Izs4MqZ0OQxf7qirvrHki4pIYjWtnIz4BRQtLzhaOGzJkee0APTr5B9f2MBzq6GgHfs=
X-Gm-Gg: AYBFou2jJd8PcjT2eQXL29HHeGsmzvIIfARW4GbxZ03d2yL7cal1GqqVBc1GXjbIi47
 04w+gLcHU0K/M2IOJGTu7Jxqr5mG+SAT21aGONH9RNV7thrDVqP9FXWYo/dOiPrQeFcYENKuAJi
 X8mEDzrwxoYZx6OpgCdPuKMbb16lA266Ixr+Re1kG0oc/AXGS+f6AUzP3boD6PLtdji3v/Qo3yj
 apvgj/QGPkyo55EvWx68EHjGm0VVwTnLwPRSbMOloQUBAeuT+WjuFJUxewKMdTksqS/lQXC2At9
 UdEB6/HHYamgOGu+f0P2emvXtKu6Xb7r5oHuq6L4cXKXz+HrhICalmW2pEA4ov3Js3DAdct+Bmw
 QEfs9xvOPJyAVyxdU+T0SNyCiV73XlNoSCPS3MSBAtO5SX2v6Jq26dKBeobPDM1dXm91fI53sXy
 7W/S0aqcG8SGWS6fLaQxgCsKmCHhhGhjsO5g17MbOhux37TZ/jUB7aY8BM2I8EuZY0q6jtoOFPh
 X3h+PLI1HFWQ0XVzGsYBi54Eox0IcXMBoubXTvXGJK15vgi7lg7C69l0aPnG2N6QZz//6qKcqfK
 4bcTvXMGD80SBkhrbd3/sYOOVk7eDziC
X-Received: by 2002:a05:600d:11:b0:4ba:4395:56d3 with SMTP id
 5b1f17b1804b1-4bb55a5d6c6mr39647325e9.7.1794565886648; 
 Fri, 13 Nov 2026 02:31:26 -0800 (PST)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c604ecda5sm4345690f8f.37.2026.11.13.02.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 02:31:26 -0800 (PST)
Date: Fri, 13 Nov 2026 11:31:24 +0100
To: pavrampu <pavrampu@linux.ibm.com>
Message-ID: <20261113-wilder-limelight-626ba4e4e4ec@there>
References: <20261108062034.41022-1-pavrampu@linux.ibm.com>
 <avSp8HV3he2he28I@localhost.localdomain>
 <8a045cf3096d2293c7e35cd001566de6@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8a045cf3096d2293c7e35cd001566de6@linux.ibm.com>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v8] memcg/memcontrol05: add cgroup v2 task
 migration charge accounting test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: =?utf-8?q?Michal_Koutn=C3=BD_via_ltp?= <ltp@lists.linux.it>
Reply-To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1131496249=="
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


--===============1131496249==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="faslya6g4f5bbabl"
Content-Disposition: inline


--faslya6g4f5bbabl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8] memcg/memcontrol05: add cgroup v2 task migration
 charge accounting test
MIME-Version: 1.0

On Fri, Nov 13, 2026 at 11:18:57AM +0530, pavrampu <pavrampu@linux.ibm.com>=
 wrote:
> Thanks for the inputs, basically trying to migrate
> testcases/kernel/controllers/memctl/ test to cgroupv2

Aha, that context wasn't clear to me from the message.
It'd make sense (to me) to include removal of the migrated test in the
series.

> Depending on its applicability to v2, we can determine whether to
> proceed with this patch.

v2 doesn't have the memory.move_charge_at_immigrate switch, so it can
only test the implicit behavior of charging in v2. With such tests, I'm
always worried that it'd detect noise in test environment rather than
memcg bug (what could it be?).

=46rom practical experience, more useful would be a test that checks that
charge reparenting [1] eventually happens (without any pins).

HTH,
Michal


[1] You can think of it like migration from child->parent after
    `rmdir child` (so that in-kernel child memcg can be truly gone,
    cgroup.stat:nr_dying_subsys_memory)). The challenge is that it is
    quite asynchronous (again noisy) but at the moment I'd assess the
    impact of such bugs more relevant to encountered bugs.

--faslya6g4f5bbabl--

--===============1131496249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1131496249==--
