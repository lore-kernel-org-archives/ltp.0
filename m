From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Jan 2021 20:27:48 +0100
Subject: [LTP] [PATCH v3 1/2] lib: Fix kernel module detection on BusyBox
In-Reply-To: <YAhMCz4j9Q2ltGcJ@yuki.lan>
References: <20210119160316.4776-1-pvorel@suse.cz>
 <20210119160316.4776-2-pvorel@suse.cz> <YAg6wTVc6AB28smR@yuki.lan>
 <YAhKe84FcrNEYFcC@pevik> <YAhMCz4j9Q2ltGcJ@yuki.lan>
Message-ID: <YAiENOUzMVpDThsk@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > modules.dep has format:
> > module:[dependency [another-dependency ...]]

> > e.g.:
> > kernel/arch/x86/kernel/cpu/mce/mce-inject.ko.xz:
> > kernel/arch/x86/crypto/twofish-x86_64.ko.xz: kernel/crypto/twofish_common.ko.xz
> > kernel/arch/x86/crypto/aesni-intel.ko.xz: kernel/crypto/crypto_simd.ko.xz kernel/crypto/cryptd.ko.xz kernel/arch/x86/crypto/glue_helper.ko.xz

> > First reading "%s" reads only first module with ':' separator.
> > Searching without it could find first module which is as dependency (e.g.
> > "/twofish_common.ko.xz" instead of "/twofish-x86_64.ko.xz"). Although that
> > shouldn't be a problem, because it's very unlikely that module dependency is
> > missing. Do you want me to drop sscanf() or put some comment?

> Well it would be probably cleaner to do something as:

> 	/* Cut dependencies after : */
> 	if ((sep = strchr(buf, ':')))
> 		*sep = 0;

> No need to copy the string just because we neet to cut part of it.
+1, thanks!

> > Also man modules.dep(5) warns about using text format as "their format is
> > subject to change in the future". Hopefully we can depend on it. Or should we
> > use binary format?

> That depends on how complicated is to parse the binary format...
I'll have a look.

I was also thinking whether whole thing really works on toolchains which use
BusyBox. BusyBox's depmod implementation does not generate modules.builtin
(it generates only modules.{alias,dep,symbols}, i.e. only few text files, no
binary). But the only distro I know which installs BusyBox depmod/modinfo/modprobe
instead of kmod is Alpine Linux and even this distro clearly generates all
modules.* files for its kernel package with kmod.

It looks to me that kernel supports generating modules.builtin.modinfo
since v5.2-rc1 (898490c010b5 "moduleparam: Save information about built-in
modules in separate file") and kmod used this change in v27 (in 60084cf
"libkmod: Add parser for modules.builtin.modinfo" released a year ago).
Thus built-in modules are impossible to detect on old kernels no matter we use
kmod or our own implementation.

But built-in modules are mostly problem for embedded: we require modules like
btrfs, loop, tun, uinput, ...  which are loadable modules on typical linux
distros.

Thus generally using modules.{dep,builtin} seems to me as a good approach for
linux distros including embedded ones and we could also use binary variants.

Other possible improvements:
* last resort effort search in /lib/modules/$(uname -r) or a directory defined
in environment variable (with or without version) - fallback for old android or
some embedded (again - not working for built-in modules)
* environment variable to skip the detection.

Kind regards,
Petr
