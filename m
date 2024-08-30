Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ADFCA0EFD
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 17:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725040341; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=YH1tRctQv3YAy5xSBAX8ezra1kxsCqpgs9BVWEgY4es=;
 b=cqrBkPcL3gP3WvOBmXnnzIbQlVuKnsXY/AYD8kCtkemfOcW1kvF1K3p+s4QswPvWh2xLN
 jFoLh19o44sHN1eqgjwCsgRzqUecMKhvDt6znwQOhLpoQ0MwTW4wQZEfWkXEl53J5Ho6iGW
 d63HYz+yVOhJ0jcE2cB7WjpCVOduEEI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8173E3D2871
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 19:52:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91EF63D278F
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 19:52:01 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 65694201DB6
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 19:51:59 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CE43F5C10B5;
 Fri, 30 Aug 2024 17:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F24AC4CEC2;
 Fri, 30 Aug 2024 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725040316;
 bh=uWhMmjJ50H1qYWLeYvBQd6Nv7WH9zgHdxdtD0x/kJv8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lRgzNm8+2G8pziDOMsiYugWgkPs3lXCnFeOZogB2bmerJAFS9ATZvAU8Z0LncZdq8
 +Y9jqkfu43WNnJ9SzKGrlfsatf6adScShb6fEHaLPjljMxUEc6jXfMYMv/eQcJE2sw
 zBAtitYvz+WV/aUZjNrXJZ3+IJ7xVsGEg9gY6QGfWBSvVslPRuTNq9is9BkxQtccTC
 Y/evok2+IS081uo4qn941Gc87BEoBnsvLznvdeY8eyaVh6qx5kuG5jkzPG3qyV1gMS
 frgFuWmkUbGn6t6HK68/vUqeV3fBNdtl6Ku79+5H4S0L7w77k4C/Y/CBpSkwjtcbUQ
 Y0PvzhYWctVPQ==
Date: Fri, 30 Aug 2024 10:51:54 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20240830175154.GA48019@sol.localdomain>
References: <ZrbTUk6DyktnO7qk@gondor.apana.org.au>
 <202408161634.598311fd-oliver.sang@intel.com>
 <ZsBJs_C6GdO_qgV7@gondor.apana.org.au>
 <ZsBJ5H4JExArHGVw@gondor.apana.org.au>
 <ZsBKG0la0m69Dyq3@gondor.apana.org.au>
 <20240827184839.GD2049@sol.localdomain>
 <Zs6SiBOdasO9Thd1@gondor.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zs6SiBOdasO9Thd1@gondor.apana.org.au>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [v3 PATCH 3/3] crypto: simd - Do not call
 crypto_alloc_tfm during registration
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
From: Eric Biggers via ltp <ltp@lists.linux.it>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: lkp@intel.com, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
 "Russell King \(Oracle\)" <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>,
 kernel test robot <oliver.sang@intel.com>, linux-crypto@vger.kernel.org,
 oe-lkp@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Aug 28, 2024 at 10:59:20AM +0800, Herbert Xu wrote:
> On Tue, Aug 27, 2024 at 11:48:39AM -0700, Eric Biggers wrote:
> > On Sat, Aug 17, 2024 at 02:58:35PM +0800, Herbert Xu wrote:
> > > Algorithm registration is usually carried out during module init,
> > > where as little work as possible should be carried out.  The SIMD
> > > code violated this rule by allocating a tfm, this then triggers a
> > > full test of the algorithm which may dead-lock in certain cases.
> > > 
> > > SIMD is only allocating the tfm to get at the alg object, which is
> > > in fact already available as it is what we are registering.  Use
> > > that directly and remove the crypto_alloc_tfm call.
> > > 
> > > Also remove some obsolete and unused SIMD API.
> > > 
> > > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > > ---
> > >  arch/arm/crypto/aes-ce-glue.c     |  2 +-
> > >  arch/arm/crypto/aes-neonbs-glue.c |  2 +-
> > >  crypto/simd.c                     | 76 ++++++-------------------------
> > >  include/crypto/internal/simd.h    | 12 +----
> > >  4 files changed, 19 insertions(+), 73 deletions(-)
> > > 
> > 
> > I'm getting a test failure with this series applied:
> > 
> > [    0.383128] alg: aead: failed to allocate transform for gcm_base(ctr(aes-generic),ghash-generic): -2
> > [    0.383500] alg: self-tests for gcm(aes) using gcm_base(ctr(aes-generic),ghash-generic) failed (rc=-2)
> > 
> > This is on x86_64 with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.
> 
> Could you please send me your config file?
> 
> Thanks,

Given below in defconfig form, use 'make olddefconfig' to apply.  The failures
are nondeterministic and sometimes there are different ones, for example:

[    0.358017] alg: skcipher: failed to allocate transform for cbc(twofish-generic): -2
[    0.358365] alg: self-tests for cbc(twofish) using cbc(twofish-generic) failed (rc=-2)
[    0.358535] alg: skcipher: failed to allocate transform for cbc(camellia-generic): -2
[    0.358918] alg: self-tests for cbc(camellia) using cbc(camellia-generic) failed (rc=-2)
[    0.371533] alg: skcipher: failed to allocate transform for xts(ecb(aes-generic)): -2
[    0.371922] alg: self-tests for xts(aes) using xts(ecb(aes-generic)) failed (rc=-2)

Modules are not enabled, maybe that matters (I haven't checked yet).

CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_CGROUPS=y
CONFIG_USER_NS=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_SMP=y
CONFIG_X86_X2APIC=y
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_MCORE2=y
CONFIG_NR_CPUS=48
CONFIG_NUMA=y
CONFIG_HZ_300=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_IA32_EMULATION=y
CONFIG_JUMP_LABEL=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=y
CONFIG_INET=y
CONFIG_PCI=y
CONFIG_PCI_MSI=y
CONFIG_DEVTMPFS=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_VIRTIO_BLK=y
CONFIG_NETDEVICES=y
CONFIG_VIRTIO_NET=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=32
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_MMIO=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_AUTOFS_FS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_CRYPTO_USER=y
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_CURVE25519=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ESSIV=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_VMAC=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_RNG_CAVP=y
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_CURVE25519_X86=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_POLYVAL_CLMUL_NI=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SM3_AVX_X86_64=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=y
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
CONFIG_CRYPTO_DEV_QAT_C62X=y
CONFIG_CRYPTO_DEV_QAT_4XXX=y
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRC_CCITT=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY4=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_FS=y
CONFIG_PANIC_TIMEOUT=5
CONFIG_UNWINDER_FRAME_POINTER=y

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
