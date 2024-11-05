Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794B7D2B920
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 13:08:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E94433D21DD
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 14:08:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C56A63D1DE3
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 14:08:25 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7A0A9140E480
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 14:08:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ED01A1FC04;
 Tue,  5 Nov 2024 13:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730812102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ygqwG2u653oSgJEc0HPAvDtnQ8KkgwzBhhaZoio7dLk=;
 b=nw68BXF3TUEdju3UqLdLsdgClboAwkG6+e/nF6fD2hArDw/j6dydxsFwn71/EjgAmfiSQK
 Fnl8jhUuMwIker5Aomp+yvhTvnnbcHMkfSPNGV8r4O+eYnUFU/AFApvw0vH5qqxw8sBK1J
 5CvvfkT5mFI0CTXVssLJdnLhzmyrUqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730812102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ygqwG2u653oSgJEc0HPAvDtnQ8KkgwzBhhaZoio7dLk=;
 b=usazlHBpoLO/XUYrddP0z1XNcPJRUv+k8XoUQ4G4zAmHlOZtHffeUvwX9W7tHjeT7myej7
 iBW3sS35a/sAaTDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730812101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ygqwG2u653oSgJEc0HPAvDtnQ8KkgwzBhhaZoio7dLk=;
 b=EtTF8xMjj83xFCKhjJ1jKMUQSCdIJ1pWHgAHByMJ4jJxPyAiVEEzlNqWVzjPDXJn66VffI
 +vIriVcfvXkzjcpw5BjfUnWlN9hzScaERtf6tpJH/2hw8KxL/Oc5KT7zN1S7VfxAXtLahC
 lcHZz7tUT43boXlIAFsPuyn6rxIm07Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730812101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ygqwG2u653oSgJEc0HPAvDtnQ8KkgwzBhhaZoio7dLk=;
 b=QQ82F9qI6bIaDxHp404/EfEKsoazVpUP+nejlpbKcvfXrkizEnNO/7Pdm6WqVNnvwYPiFD
 Yqk8PGnNqoj8myDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAA811394A;
 Tue,  5 Nov 2024 13:08:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qp9+NMUYKmfkBgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 Nov 2024 13:08:21 +0000
Date: Tue, 5 Nov 2024 14:08:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZyoYxqE423FxFuPc@yuki.lan>
References: <20241105-landlock_network-v2-0-d58791487919@suse.com>
 <20241105-landlock_network-v2-1-d58791487919@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241105-landlock_network-v2-1-d58791487919@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] Fallback landlock network support
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

Hi!
> Landlock network support has been added in the ABI v4, adding features
> for bind() and connect() syscalls. It also defined one more member in
> the landlock_ruleset_attr struct, breaking our LTP fallbacks, used to
> build landlock testing suite. For this reason, we introduce
> tst_landlock_ruleset_attr_abi[14] struct(s) which fallback ABI v1 and v4
> ruleset_attr definitions.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  configure.ac                                       |  3 ++-
>  include/lapi/capability.h                          |  4 ++++
>  include/lapi/landlock.h                            | 28 ++++++++++++----------
>  testcases/kernel/syscalls/landlock/landlock01.c    | 15 ++++--------
>  testcases/kernel/syscalls/landlock/landlock02.c    |  8 +++----
>  testcases/kernel/syscalls/landlock/landlock03.c    |  6 ++---
>  testcases/kernel/syscalls/landlock/landlock04.c    |  6 ++---
>  testcases/kernel/syscalls/landlock/landlock05.c    | 10 ++++----
>  testcases/kernel/syscalls/landlock/landlock06.c    | 14 ++++-------
>  testcases/kernel/syscalls/landlock/landlock07.c    |  6 ++---
>  .../kernel/syscalls/landlock/landlock_common.h     | 12 ++++------
>  11 files changed, 53 insertions(+), 59 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index d327974efa71f263d7f7f5aec9d2c5831d53dd0e..e2e4fd18daa54dbf2034fa9bcc4f2383b53392f4 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -34,6 +34,8 @@ m4_ifndef([PKG_CHECK_EXISTS],
>  AC_PREFIX_DEFAULT(/opt/ltp)
>  
>  AC_CHECK_DECLS([IFLA_NET_NS_PID],,,[#include <linux/if_link.h>])
> +AC_CHECK_DECLS([LANDLOCK_RULE_PATH_BENEATH],,,[#include <linux/landlock.h>])
> +AC_CHECK_DECLS([LANDLOCK_RULE_NET_PORT],,,[#include <linux/landlock.h>])
>  AC_CHECK_DECLS([MADV_MERGEABLE],,,[#include <sys/mman.h>])
>  AC_CHECK_DECLS([NFTA_CHAIN_ID, NFTA_VERDICT_CHAIN_ID],,,[#include <linux/netfilter/nf_tables.h>])
>  AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
> @@ -172,7 +174,6 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
>  ])
>  
>  AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
> -AC_CHECK_TYPES([enum landlock_rule_type],,,[#include <linux/landlock.h>])
>  AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
>  AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
>  AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
> diff --git a/include/lapi/capability.h b/include/lapi/capability.h
> index 0f317d6d770e86b399f0fed2de04c1dce6723eae..14d2d3c12c051006875f1f864ec58a88a3870ec0 100644
> --- a/include/lapi/capability.h
> +++ b/include/lapi/capability.h
> @@ -20,6 +20,10 @@
>  # endif
>  #endif
>  
> +#ifndef CAP_NET_BIND_SERVICE
> +# define CAP_NET_BIND_SERVICE 10
> +#endif
> +
>  #ifndef CAP_NET_RAW
>  # define CAP_NET_RAW          13
>  #endif
> diff --git a/include/lapi/landlock.h b/include/lapi/landlock.h
> index 211d171ebecd92d75224369dc7f1d5c5903c9ce7..b3c8c548e661680541cdf6e4a8fb68a3f5029fec 100644
> --- a/include/lapi/landlock.h
> +++ b/include/lapi/landlock.h
> @@ -7,6 +7,7 @@
>  #define LAPI_LANDLOCK_H__
>  
>  #include "config.h"
> +#include <stdint.h>
>  
>  #ifdef HAVE_LINUX_LANDLOCK_H
>  # include <linux/landlock.h>
> @@ -14,13 +15,16 @@
>  
>  #include "lapi/syscalls.h"
>  
> -#ifndef HAVE_STRUCT_LANDLOCK_RULESET_ATTR
> -struct landlock_ruleset_attr
> +struct tst_landlock_ruleset_attr_abi1
> +{
> +	uint64_t handled_access_fs;
> +};
> +
> +struct tst_landlock_ruleset_attr_abi4
>  {
>  	uint64_t handled_access_fs;
>  	uint64_t handled_access_net;
>  };
> -#endif
>  
>  #ifndef HAVE_STRUCT_LANDLOCK_PATH_BENEATH_ATTR
>  struct landlock_path_beneath_attr
> @@ -30,12 +34,12 @@ struct landlock_path_beneath_attr
>  } __attribute__((packed));
>  #endif
>  
> -#ifndef HAVE_ENUM_LANDLOCK_RULE_TYPE
> -enum landlock_rule_type
> -{
> -	LANDLOCK_RULE_PATH_BENEATH = 1,
> -	LANDLOCK_RULE_NET_PORT,
> -};
> +#if !HAVE_DECL_LANDLOCK_RULE_PATH_BENEATH

These are more usually ifndef at least it's more readable.

> +# define LANDLOCK_RULE_PATH_BENEATH 1
> +#endif
> +
> +#if !HAVE_DECL_LANDLOCK_RULE_NET_PORT

Here as well.

> +# define LANDLOCK_RULE_NET_PORT 2
>  #endif
>  
>  #ifndef HAVE_STRUCT_LANDLOCK_NET_PORT_ATTR
> @@ -123,8 +127,7 @@ struct landlock_net_port_attr
>  #endif
>  
>  static inline int safe_landlock_create_ruleset(const char *file, const int lineno,
> -	const struct landlock_ruleset_attr *attr,
> -	size_t size , uint32_t flags)
> +	const void *attr, size_t size , uint32_t flags)
>  {
>  	int rval;
>  
> @@ -143,8 +146,7 @@ static inline int safe_landlock_create_ruleset(const char *file, const int linen
>  }
>  
>  static inline int safe_landlock_add_rule(const char *file, const int lineno,
> -	int ruleset_fd, enum landlock_rule_type rule_type,
> -	const void *rule_attr, uint32_t flags)
> +	int ruleset_fd, int rule_type, const void *rule_attr, uint32_t flags)
>  {
>  	int rval;
>  
> diff --git a/testcases/kernel/syscalls/landlock/landlock01.c b/testcases/kernel/syscalls/landlock/landlock01.c
> index 083685c64fa6d1c0caab887ee03594ea1426f62f..bd3a37153449b8d75b9671f5c3b3838c701b05ae 100644
> --- a/testcases/kernel/syscalls/landlock/landlock01.c
> +++ b/testcases/kernel/syscalls/landlock/landlock01.c
> @@ -17,14 +17,14 @@
>  
>  #include "landlock_common.h"
>  
> -static struct landlock_ruleset_attr *ruleset_attr;
> -static struct landlock_ruleset_attr *null_attr;
> +static struct tst_landlock_ruleset_attr_abi4 *ruleset_attr;
> +static struct tst_landlock_ruleset_attr_abi4 *null_attr;
>  static size_t rule_size;
>  static size_t rule_small_size;
>  static size_t rule_big_size;
>  
>  static struct tcase {
> -	struct landlock_ruleset_attr **attr;
> +	struct tst_landlock_ruleset_attr_abi4 **attr;
>  	uint64_t access_fs;
>  	size_t *size;
>  	uint32_t flags;
> @@ -60,13 +60,8 @@ static void setup(void)
>  {
>  	verify_landlock_is_enabled();
>  
> -	rule_size = sizeof(struct landlock_ruleset_attr);
> -
> -#ifdef HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET
> +	rule_size = sizeof(struct tst_landlock_ruleset_attr_abi4);
>  	rule_small_size = rule_size - sizeof(uint64_t) - 1;

I guess that the safest bet here would be:

sizeof(struct tst_landlock_ruleset_attr_abi1) - 1

That is by definition one byte less than the smallest size, this will
also in 99.99% cases evaluate to 7 since structure with single 64 bit
number will not need padding so hardcoding 7 should be safe as well.

Also I guess that we can use the v1 ABI for the whole invalid inputs
tests, all we need here is to pass a size that is valid in most cases,
which is v1 I suppose.


The rest looks fine to me:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
