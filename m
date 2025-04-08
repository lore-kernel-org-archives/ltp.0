Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81DAC36010
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 19:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744139521; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : cc : content-type : content-transfer-encoding
 : sender : from; bh=Jhb6IRGZg/ZpBqOG2KiVzrpVDyGZTIIVJcHdP1NiNio=;
 b=LpU5mX1Wcx0XYWQ8YdpBL5Yjrhbd1+3ExCC85ocgSdL0g1rs7PkzUv4OFkf2lJnZC+A3N
 1s8ZOlNfkozeAxTHa4fP8PQqUiq4NBzE+bh+V8rBB5TVsUxfzINugfpTTCg5Er7HaOo2+8c
 Oc2gvUSQ1xN15RdDNCRgAwtGd79lzY4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6DED3CB3C3
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 21:12:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id 583063C048F
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 21:11:38 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with UTF8SMTPS id 04CCA1000D09
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 21:11:37 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso3563580f8f.2
 for <ltp@lists.linux.it>; Tue, 08 Apr 2025 12:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744139497; x=1744744297;
 h=in-reply-to:references:cc:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jFxfjpMoHaB491Jrtlof6LmICiKzHrAylJDjw3Hb3u8=;
 b=Vmbdbv3YYp7O9Jck2Rz+z/EeRxm0lilOkAR5sFAmIjIA9nVKO2BK0DBT9HJSM4RLgw
 qIi8tJnMgYVMHf3JVtLeGUdQ6XzFjjlxrR7ppwwHaNFoeixcN6IA9NoZEVI1Bnx7lUu3
 ZEO7T8O02Z1dskDmIio2uKj746SJ9ll6y5HXdMdM9+o3bv+3IAyWwrIFA9n36WEiFPSd
 A0DEdRCdzpiC0c1a/4+J1AV0ufeGd9TYFcIE7Qvzyok5K1VT36CQAhcKK4c7/D1G6McM
 SmxHiOuN9TKLvzy45YIX2/gLkjsdx7nkNbH+crO9eRE1odSjuvboYb47kVoS8EDEJdqS
 g5Fg==
X-Gm-Message-State: AOJu0YzR9rGgjoOa65OlUZV3JgB4GSZYnGyMQu2IKetDEYgXA2TIFulI
 TdyXLoaSXjXI22/lUAhmKj3vqJ4eiPLbrTQJBM1oygTIiJdW6pxw7OaaURm60+4=
X-Gm-Gg: ASbGnctimYDlfwHRhDzA1+uSTvtCfCHm4H9SWjd7/IqWM7ulPzS7dIV/Mo0nTT9vmmv
 ZZfGzQanYidGl1HF6D/ceMTqTYxpHfE/qG3k1n8X/pjTT1l/BpPO8/t0yFWOSu6JulkEZDx3DGI
 7AkWTIT3ZDo9Bu14OvAm2lCRu7HLWV0zExaG791C09Ga9Vj8UXzIlJ9ZVZ6X3EXcqb9jptX2NEQ
 uCSjJoQ+wDPu8lua3YiUZpec6pGdvWMjGjejszVe3ZHX4vqArbPmQNAPj8avjr7QDj5Mwh1eA+V
 Db7RkyHnsvkaswR6WtDdeTbWtGKVh0C/bQ==
X-Google-Smtp-Source: AGHT+IG2LgXhycu4VUf4lGWptKQeemSQcrI4g97XPKXsw1FTPphAzs9q8HX5Kj9nBx5NmsU7hBS/aw==
X-Received: by 2002:adf:9cca:0:b0:39c:1257:dbaa with SMTP id
 ffacd0b85a97d-39d87cdd005mr241127f8f.58.1744139497296; 
 Tue, 08 Apr 2025 12:11:37 -0700 (PDT)
Received: from localhost ([179.228.213.210]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ad88bsm104087415ad.48.2025.04.08.12.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 12:11:36 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 08 Apr 2025 16:11:30 -0300
Message-Id: <D91HUKSMMOZO.2YOCEDPG2QE0E@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250328095747.169011-1-pvorel@suse.cz>
 <20250328095747.169011-5-pvorel@suse.cz>
 <D8RV9V5D07EO.ORPMFWGXAMSO@suse.com> <20250407145312.GA101494@pevik>
In-Reply-To: <20250407145312.GA101494@pevik>
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

On Mon Apr 7, 2025 at 11:53 AM -03, Petr Vorel wrote:
>> Hi Petr,
>
>> On Fri Mar 28, 2025 at 6:57 AM -03, Petr Vorel wrote:
>> > 'doc' target previously run docparse documentation. Point it to doc/
>> > directory so that it build sphinx docs. doc/ dir has metadata/ dir as
>> > dependency, no need to specify it. Call also '.venv' target.
>
>> > NOTE: it's still possible to avoid virtualenv by calling 'make -C doc'
>
>> > Add 'doc-clean': to remove only generated data (not optional .venv).
>
>> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> > ---
>> > Changes in v4:
>> > * Use 'setup' instead of '.venv' in the top level doc target
>
>> >  Makefile | 8 +++++++-
>> >  1 file changed, 7 insertions(+), 1 deletion(-)
>
>> > diff --git a/Makefile b/Makefile
>> > index 5066789349..6aa77e1b9b 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -170,7 +170,13 @@ INSTALL_TARGETS		+= $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))
>> >  $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)
>
>> >  .PHONY: doc
>> > -doc: metadata-all
>> > +doc:
>> > +	$(MAKE) -C $(abs_builddir)/doc setup
>> > +	$(MAKE) -C $(abs_builddir)/doc
>> > +
>> > +.PHONY: doc-clean
>> > +doc-clean:
>> > +	$(MAKE) -C $(abs_builddir)/doc clean
>
>> IMO the top-level clean and distclean targets should be responsible of
>> calling the respective targets in doc/Makefile, what do you think?
>
> Well, we have in the top level other clean targets:
> lib-clean, libs-clean, ac-clean, ac-distclean, ac-maintainer-clean.
> Therefore I thought add at least doc-clean would be good. I ignored
> doc-distclean.
>
> Most of LTP is compiled and therefore handled by
> include/mk/generic_leaf_target.mk. kirk and sparse are special (submodule anyway),
> but even they allows to use generic_leaf_target.mk. I'm not sure if I want to
> rewrite whole doc/Makefile to support generic_leaf_target.mk, I should, but my
> goal was to simplify creating venv. I guess I drop this atm and send v5 and
> without it and get to it later.
>

Right, I tried out something (below) which kind of works but it would require
the setup target becoming the default... The sad part is that even if
the user chooses not to use a virtualenv, linuxdoc does not seem to be
packaged in the major distros (I checked Tumbleweed, Debian and Fedora
only Fedora has it)

diff --git a/Makefile b/Makefile
index 506678934983..69a8016535a9 100644
--- a/Makefile
+++ b/Makefile
@@ -41,7 +41,7 @@ $(1):: | $$(abs_top_builddir)/$$(basename $$(subst -,.,$(1)))
 endif
 endef

-COMMON_TARGETS         += testcases tools metadata
+COMMON_TARGETS         += testcases tools metadata doc

 # Don't want to nuke the original files if we're installing in-build-tree.
 ifneq ($(BUILD_TREE_STATE),$(BUILD_TREE_SRCDIR_INSTALL))
@@ -169,8 +169,8 @@ INSTALL_TARGETS             += $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))

 $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)

-.PHONY: doc
-doc: metadata-all
+#.PHONY: doc
+#doc: metadata-all

 .PHONY: check
 check: $(CHECK_TARGETS)
diff --git a/doc/Makefile b/doc/Makefile
index 2062d6e93561..7f11e659cab8 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -23,15 +23,17 @@ setup: $(VENV_DIR)
 ${abs_top_builddir}/metadata/ltp.json:
        $(MAKE) -C ${abs_top_builddir}/metadata

-all: ${abs_top_builddir}/metadata/ltp.json
+all: ${abs_top_builddir}/metadata/ltp.json setup
        $(RUN_VENV); sphinx-build -b html . html

 spelling:
        $(RUN_VENV); sphinx-build -b spelling -d build/doctree . build/spelling

-clean:
+clean::
        rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
                ${abs_top_builddir}/metadata/ltp.json

-distclean: clean
+distclean:: clean
        rm -rf $(VENV_DIR)
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk

Thanks,
		rbm

> Kind regards,
> Petr
>
> The rest of LTP final directories is handled by
> include/mk/generic_leaf_target.mk, but doc/ is somehow special, that's why I
> added these targets.
>
> If you call make clean or distclean
>
>
>> >  .PHONY: check
>> >  check: $(CHECK_TARGETS)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
