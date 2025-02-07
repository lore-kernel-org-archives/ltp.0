Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB33C02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 11:24:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59A1B3C9391
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 12:24:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05B8D3C297B
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 12:24:05 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E28B71BDB9DF
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 12:24:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2FC4A2116A;
 Fri,  7 Feb 2025 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738927443;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8XbUwqR8Ds0rEDgSClQXUKLABXUg8gV+xuTO+Rb04nA=;
 b=dYSKs6KzQE4MsNogWhOs+bh/21cgw+lSe+L/q7LL18ceu/4HN5AutVwexBcWpJp2r/inrd
 t3U8+CVfAuhhJ6fC/2YF6g+/IWcbKBZiWsKLxtH7r5Vuo73LUmmZTL3MTfSUeU6PBsQerr
 w2fJzVlxId3nrlEmcnJTXN4LXDOSYJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738927443;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8XbUwqR8Ds0rEDgSClQXUKLABXUg8gV+xuTO+Rb04nA=;
 b=1+9ns25gqjzwMjLmDVOTNUjJ+zHS1iN287rq9B1w1vJ+ctj6upm+UNn8AEMNFN02Kg3d0F
 PmKxe4bUMmoEUdAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738927443;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8XbUwqR8Ds0rEDgSClQXUKLABXUg8gV+xuTO+Rb04nA=;
 b=dYSKs6KzQE4MsNogWhOs+bh/21cgw+lSe+L/q7LL18ceu/4HN5AutVwexBcWpJp2r/inrd
 t3U8+CVfAuhhJ6fC/2YF6g+/IWcbKBZiWsKLxtH7r5Vuo73LUmmZTL3MTfSUeU6PBsQerr
 w2fJzVlxId3nrlEmcnJTXN4LXDOSYJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738927443;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8XbUwqR8Ds0rEDgSClQXUKLABXUg8gV+xuTO+Rb04nA=;
 b=1+9ns25gqjzwMjLmDVOTNUjJ+zHS1iN287rq9B1w1vJ+ctj6upm+UNn8AEMNFN02Kg3d0F
 PmKxe4bUMmoEUdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBFC713694;
 Fri,  7 Feb 2025 11:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KhZCOFLtpWdNAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Feb 2025 11:24:02 +0000
Date: Fri, 7 Feb 2025 12:23:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID: <20250207112353.GA1739723@pevik>
References: <20250203220903.399544-1-jmoyer@redhat.com>
 <20250203220903.399544-4-jmoyer@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250203220903.399544-4-jmoyer@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] lib/tst_device.c: add support for overlayfs
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jeff,

> Add checks for overlayfs in tst_find_backing_dev.  As with btrfs, only
> a single device is checked (the upper one) and returned from
> tst_find_backing_dev().

...
> +++ b/INSTALL
> @@ -6,15 +6,15 @@ package in any Linux distribution (no specific version is required).

>  Debian / Ubuntu

> -	# apt install gcc git make pkgconf autoconf automake bison flex m4 linux-headers-$(uname -r) libc6-dev
> +	# apt install gcc git make pkgconf autoconf automake bison flex m4 linux-headers-$(uname -r) libc6-dev libmount-dev

>  openSUSE / SLES

> -	# zypper install gcc git make pkg-config autoconf automake bison flex m4 linux-glibc-devel glibc-devel
> +	# zypper install gcc git make pkg-config autoconf automake bison flex m4 linux-glibc-devel glibc-devel libmount-devel

>  Fedora / CentOS / RHEL

> -	# yum install gcc git make pkgconf autoconf automake bison flex m4 kernel-headers glibc-headers
> +	# yum install gcc git make pkgconf autoconf automake bison flex m4 kernel-headers glibc-headers libmount-devel

FYI it's good to update docs, but this is not enough.
You need to add libmount devel packages to ci/*.sh scripts otherwise it fails,
see [1].


We have note about ci/*.sh in INSTALL, maybe we should explicitly state that
build dependencies must be updated there.

I updated it for you (see diff below or use branch
jmoyer/tst_device-overlayfs.fixes in my fork [2]), but it still not enough [3].

It is reproducible even locally:

$ make autotools && ./configure
$ cd lib && make
AR libltp_internal.a
RANLIB libltp_internal.a
/usr/bin/ld: cannot find -lltp: No such file or directory
collect2: error: ld returned 1 exit status
make[1]: *** [../../include/mk/rules.mk:48: test01] Error 1
make[1]: *** Waiting for unfinished jobs....
/usr/bin/ld: cannot find -lltp: No such file or directory
collect2: error: ld returned 1 exit status
make[1]: *** [../../include/mk/rules.mk:48: test02] Error 1
/usr/bin/ld: cannot find -lltp: No such file or directory
collect2: error: ld returned 1 exit status
make[1]: *** [../../include/mk/rules.mk:48: test04] Error 1
/usr/bin/ld: cannot find -lltp: No such file or directory
collect2: error: ld returned 1 exit status
make[1]: *** [../../include/mk/rules.mk:48: test03] Error 1
make: *** [../include/mk/generic_trunk_target.inc:92: all] Error 2

> --- /dev/null
> +++ b/lib/libltp.a
> @@ -0,0 +1 @@
> +INPUT (libltp_internal.a -lmount)

'rm -fv lib/libltp.a' is required to apply the patchset.

Kind regards,
Petr

[1] https://github.com/pevik/ltp/actions/runs/13198563478
[2] https://github.com/pevik/ltp/tree/refs/heads/jmoyer/tst_device-overlayfs.fixes
[3] https://github.com/pevik/ltp/actions/runs/13198676398/job/36845555749

Fix CI for missing packages.

diff --git ci/alpine.sh ci/alpine.sh
index 93acd6267b..26a3775ac6 100755
--- ci/alpine.sh
+++ ci/alpine.sh
@@ -26,7 +26,8 @@ apk add \
 	numactl-dev \
 	openssl-dev \
 	perl-json \
-	pkgconfig
+	pkgconfig \
+	util-linux-dev
 
 cat /etc/os-release
 
diff --git ci/debian.cross-compile.sh ci/debian.cross-compile.sh
index 95cf11da22..18ee44ef58 100755
--- ci/debian.cross-compile.sh
+++ ci/debian.cross-compile.sh
@@ -21,4 +21,5 @@ apt install -y --no-install-recommends \
 	gcc-${gcc_arch}-linux-gnu \
 	libc6-dev-${ARCH}-cross \
 	libmnl-dev:$ARCH \
+	libmount-dev:$ARCH \
 	libtirpc-dev:$ARCH
diff --git ci/debian.i386.sh ci/debian.i386.sh
index 2846053098..b0f916d05f 100755
--- ci/debian.i386.sh
+++ ci/debian.i386.sh
@@ -14,6 +14,7 @@ apt install -y --no-install-recommends \
 	libc6-dev-i386 \
 	libc6:i386 \
 	libkeyutils-dev:i386 \
+	libmount-dev:i386 \
 	libnuma-dev:i386 \
 	libssl-dev:i386 \
 	libtirpc-dev:i386 \
diff --git ci/debian.sh ci/debian.sh
index fc1c1b3ec6..5fe1bf18da 100755
--- ci/debian.sh
+++ ci/debian.sh
@@ -27,6 +27,7 @@ pkg_minimal="
 	git
 	iproute2
 	libc6-dev
+	libmount-dev
 	libtirpc-dev
 	linux-libc-dev
 	lsb-release
diff --git ci/fedora.sh ci/fedora.sh
index 623dbb5cb6..244e2dae37 100755
--- ci/fedora.sh
+++ ci/fedora.sh
@@ -15,6 +15,7 @@ $yum \
 	findutils \
 	iproute \
 	numactl-devel \
+	libmount-devel \
 	libtirpc \
 	libtirpc-devel \
 	perl-JSON \

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
