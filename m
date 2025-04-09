Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D537C36002
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 12:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744201360; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : cc : content-type : content-transfer-encoding
 : sender : from; bh=NMoHDVMpAA3YVmt4uZDvLahDdJWWjBWx9ttn9GfGDT8=;
 b=gt0QMkhOA9Fju90ISizixj5Uv1MS6FspZvn6NqnfspzFnhKTEnS/zG/prAXNdXRSKyKBy
 BfoYTIAoaEguvkWfvnpfIKBUhrlrH1Uta49rTiddC1j7tN/Kcbn7452LwsdwMtkXISkP2S0
 N4LSta/Gp/jIF82e+YIbAvdyjhZbFjU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D1653CB408
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 14:22:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id 06B2F3CB33A
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 14:22:18 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with UTF8SMTPS id 0790410009E9
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 14:22:16 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-399737f4fa4so3709667f8f.0
 for <ltp@lists.linux.it>; Wed, 09 Apr 2025 05:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744201336; x=1744806136;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vHOGjAuCu3LF6EEmyU6+BBkEnAW8PaXfFdbItR0sV2o=;
 b=t/gRbTgQ736+uRK7tMdmMFA9ZcTxiehsYFOcvNm9Y8ztdRzywFhNJDaTDLz9sCdcAv
 D8jx9jOqRBe/7N7NS1N/x97rFLrjTMsehPIq0iRIQj4Mxk4L0xNRc8LcdsyAsh/0P4UF
 rxRQD0nOVzzmDDUxgXh03dLFBxQ9va6ejsEhsY/tEfWRI5frL+KhrwdmmvS7OPSPJpe4
 5DwICPF2AxWkKc455JWBxjILpdGUWc7R6xstk5BpBmNYkITKrTXStQM4vko+wyqQRpTR
 RPU8OOcF6n7Dr6JzpfKclmnVTk90t31JS2HS3zHk5PvJIJ/GEg/lnjFrMv6hNmZDbDZ0
 ZRIg==
X-Gm-Message-State: AOJu0YxUeNILTgXr4UDOyB+lCyrcLxrXnx7/GjFN1wKBJLidOJbb3kyM
 iQPIBC2EYm4XAXeg94+d9bH/bHsXDETLCdv6Dssl6TIpHs/gNYny6u4QgNFEuJo=
X-Gm-Gg: ASbGncsABOeQduag9kSZSs1U9sFLYn1xbpGw8NkZK19SXFanSH8aAb0nKSUn31y5PU6
 6xU1mLomi5sV3tPXZRWVYbLARqbbZXvN/RX/lv7uKSRWZu2A/hMLPfFwzI3mJxPMz5/D4ZBMkhu
 Rf5O3kiJHOt3Kg6rQKVcHHLSJ+Y/+UhWjMbyatyJLTGNQT4AICZuIIlvQXZ/7/cBo8LavFwIgjW
 NReaOapLfHWJP6vzNqDWmRtfDDG1dJZVge6qAo5VoervJUnXXZNjMvtpGhmWwTdIFk1g6zb+0bp
 qyZWg1xW+nAP55BHDh+YzpfPglyZaA==
X-Google-Smtp-Source: AGHT+IEoh1DDlYxl1gjGnUYPHq3Lo+CujyPNvpVpIt8WZADPTKiDePoKkkwhZ53yecnKzFlJDJDXrg==
X-Received: by 2002:adf:b641:0:b0:39c:1257:cd40 with SMTP id
 ffacd0b85a97d-39d87cdb14cmr1556144f8f.58.1744201336181; 
 Wed, 09 Apr 2025 05:22:16 -0700 (PDT)
Received: from localhost ([179.228.213.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b02a12c9c05sm1067132a12.42.2025.04.09.05.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 05:22:15 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 09 Apr 2025 09:22:09 -0300
Message-Id: <D923RP7LIXZZ.2QBXXZH9AOOS3@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250328095747.169011-1-pvorel@suse.cz>
 <20250328095747.169011-5-pvorel@suse.cz>
 <D8RV9V5D07EO.ORPMFWGXAMSO@suse.com> <20250407145312.GA101494@pevik>
 <D91HUKSMMOZO.2YOCEDPG2QE0E@suse.com> <20250409081210.GA286967@pevik>
In-Reply-To: <20250409081210.GA286967@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/5] Makefile: Update 'doc' target,
 add 'doc-clean'
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
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsae+/ve+/vXJlIHZpYSBsdHA=?=
 <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marlière" <rbm@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed Apr 9, 2025 at 5:12 AM -03, Petr Vorel wrote:
> Hi Ricardo,
>
>> >> > -doc: metadata-all
>> >> > +doc:
>> >> > +	$(MAKE) -C $(abs_builddir)/doc setup
>> >> > +	$(MAKE) -C $(abs_builddir)/doc
>> >> > +
>> >> > +.PHONY: doc-clean
>> >> > +doc-clean:
>> >> > +	$(MAKE) -C $(abs_builddir)/doc clean
>
>> >> IMO the top-level clean and distclean targets should be responsible of
>> >> calling the respective targets in doc/Makefile, what do you think?
>
>> > Well, we have in the top level other clean targets:
>> > lib-clean, libs-clean, ac-clean, ac-distclean, ac-maintainer-clean.
>> > Therefore I thought add at least doc-clean would be good. I ignored
>> > doc-distclean.
>
>> > Most of LTP is compiled and therefore handled by
>> > include/mk/generic_leaf_target.mk. kirk and sparse are special (submodule anyway),
>> > but even they allows to use generic_leaf_target.mk. I'm not sure if I want to
>> > rewrite whole doc/Makefile to support generic_leaf_target.mk, I should, but my
>> > goal was to simplify creating venv. I guess I drop this atm and send v5 and
>> > without it and get to it later.
>
>
>> Right, I tried out something (below) which kind of works but it would require
>> the setup target becoming the default... The sad part is that even if
>> the user chooses not to use a virtualenv, linuxdoc does not seem to be
>> packaged in the major distros (I checked Tumbleweed, Debian and Fedora
>> only Fedora has it)
>
> I'm surprised that any distro package linuxdoc. And IMHO all linux distros
> require pip install to run inside virtualenv.
>

I was surprise it isn't :(

>> diff --git a/Makefile b/Makefile
>> index 506678934983..69a8016535a9 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -41,7 +41,7 @@ $(1):: | $$(abs_top_builddir)/$$(basename $$(subst -,.,$(1)))
>>  endif
>>  endef
>
>> -COMMON_TARGETS         += testcases tools metadata
>> +COMMON_TARGETS         += testcases tools metadata doc
>
> I was testing doc part of COMMON_TARGETS as well (that requires that
> generic_leaf_target.mk to be included). But that means that doc will be always
> built, which means that user either has linuxdoc and others installed as a
> package or via 'make -C doc setup'.
>

+1

>>  # Don't want to nuke the original files if we're installing in-build-tree.
>>  ifneq ($(BUILD_TREE_STATE),$(BUILD_TREE_SRCDIR_INSTALL))
>> @@ -169,8 +169,8 @@ INSTALL_TARGETS             += $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))
>
>>  $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)
>
>> -.PHONY: doc
>> -doc: metadata-all
>> +#.PHONY: doc
>> +#doc: metadata-all
>
> 'doc: metadata-all' is a part I suggested to be deleted (useless now).
> But IMHO it should be replaced by other phony target - my plan was to use
> generic_leaf_target.mk (reuse existing LTP build system instead writing from
> scratch), but don't have doc/ part of build from top level Makefile (avoid
> dealing with virtualenv). Therefore I guess at least doc target in this patchset
> is more or less correct. Maybe having doc as a part of CLEAN_TARGETS
> variable will work.

Adding it to CLEAN_TARGETS will work, as it will create the `doc-clean`
target.

>
>>  .PHONY: check
>>  check: $(CHECK_TARGETS)
>> diff --git a/doc/Makefile b/doc/Makefile
>> index 2062d6e93561..7f11e659cab8 100644
>> --- a/doc/Makefile
>> +++ b/doc/Makefile
>> @@ -23,15 +23,17 @@ setup: $(VENV_DIR)
>>  ${abs_top_builddir}/metadata/ltp.json:
>>         $(MAKE) -C ${abs_top_builddir}/metadata
>
>> -all: ${abs_top_builddir}/metadata/ltp.json
>> +all: ${abs_top_builddir}/metadata/ltp.json setup
>>         $(RUN_VENV); sphinx-build -b html . html
>
> Using virtualenv by default was something which Andrea did not want (equivalent
> of this was in my v1). And I agree we don't want packagers to deal with
> virtualenv (FYI atm there are at least SUSE, Buildroot and Yocto packages; Red
> hat plans to use it as well).
>

Hm, but if we have a top-level target "doc" which setup the venv by
default, it will be even more confusing... Maybe having both doc and
doc-setup would make sense?

With this, we can opt-in the venv by doing `make doc-setup` first. We
can clean it with `make doc-clean` or the top-level `make clean` and
`make distclean`

>>  spelling:
>>         $(RUN_VENV); sphinx-build -b spelling -d build/doctree . build/spelling
>
>> -clean:
>> +clean::
> +1, I did not have enough time to figure out '::'.
>
>>         rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
>>                 ${abs_top_builddir}/metadata/ltp.json
>
>> -distclean: clean
>> +distclean:: clean
>>         rm -rf $(VENV_DIR)
>> +
>> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
>
>> Thanks,
>> 		rbm
>
>> > Kind regards,
>> > Petr
>
>> > The rest of LTP final directories is handled by
>> > include/mk/generic_leaf_target.mk, but doc/ is somehow special, that's why I
>> > added these targets.
>
>> > If you call make clean or distclean
>
>
>> >> >  .PHONY: check
>> >> >  check: $(CHECK_TARGETS)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
