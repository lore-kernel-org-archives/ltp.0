From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Nov 2017 16:48:06 +0100
Subject: [LTP] [RFC PATCH 4/4] travis: Install all dependencies (headers
 and libraries)
In-Reply-To: <20171128232130.4843-5-pvorel@suse.cz>
References: <20171128232130.4843-1-pvorel@suse.cz>
 <20171128232130.4843-5-pvorel@suse.cz>
Message-ID: <20171129154806.GE15160@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  before_install:
> +    - sudo apt install -f -y
> +      libacl1-dev
> +      libacl1:amd64
> +      libacl1:i386
> +      libaio-dev
> +      libaio1:amd64
> +      libaio1:i386
> +      libcap-dev
> +      libcap2:amd64
> +      libcap2:i386
> +      libc6
> +      libc6-dev
> +      libc6-dev-i386
> +      libc6:i386
> +      libkeyutils-dev
> +      libkeyutils1:amd64
> +      libkeyutils1:i386
> +      libmm-dev
> +      libnuma-dev
> +      libnuma1:amd64
> +      libnuma1:i386
> +      libselinux1-dev:amd64
> +      libssl-dev:amd64
> +      libssl-dev:i386
> +      libsepol1-dev:amd64
> +      libssl-dev
> +      libtirpc1:amd64
> +      libtirpc1:i386
> +      linux-libc-dev

This runs before each compilation, right? Can we have one build
just with the basic C devel packages as well, since that have found
most bugs in stubs and fallback code so far.

-- 
Cyril Hrubis
chrubis@suse.cz
