From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Jan 2021 16:28:11 +0100
Subject: [LTP] [PATCH v3 1/2] lib: Fix kernel module detection on BusyBox
In-Reply-To: <YAhKe84FcrNEYFcC@pevik>
References: <20210119160316.4776-1-pvorel@suse.cz>
 <20210119160316.4776-2-pvorel@suse.cz> <YAg6wTVc6AB28smR@yuki.lan>
 <YAhKe84FcrNEYFcC@pevik>
Message-ID: <YAhMCz4j9Q2ltGcJ@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> modules.dep has format:
> module:[dependency [another-dependency ...]]
> 
> e.g.:
> kernel/arch/x86/kernel/cpu/mce/mce-inject.ko.xz:
> kernel/arch/x86/crypto/twofish-x86_64.ko.xz: kernel/crypto/twofish_common.ko.xz
> kernel/arch/x86/crypto/aesni-intel.ko.xz: kernel/crypto/crypto_simd.ko.xz kernel/crypto/cryptd.ko.xz kernel/arch/x86/crypto/glue_helper.ko.xz
> 
> First reading "%s" reads only first module with ':' separator.
> Searching without it could find first module which is as dependency (e.g.
> "/twofish_common.ko.xz" instead of "/twofish-x86_64.ko.xz"). Although that
> shouldn't be a problem, because it's very unlikely that module dependency is
> missing. Do you want me to drop sscanf() or put some comment?

Well it would be probably cleaner to do something as:

	/* Cut dependencies after : */
	if ((sep = strchr(buf, ':')))
		*sep = 0;

No need to copy the string just because we neet to cut part of it.

> Also man modules.dep(5) warns about using text format as "their format is
> subject to change in the future". Hopefully we can depend on it. Or should we
> use binary format?

That depends on how complicated is to parse the binary format...

-- 
Cyril Hrubis
chrubis@suse.cz
