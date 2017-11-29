From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Nov 2017 16:45:59 +0100
Subject: [LTP] [RFC PATCH 2/4] travis: Add 32 cross-compile build + use
 build.sh
In-Reply-To: <20171128232130.4843-3-pvorel@suse.cz>
References: <20171128232130.4843-1-pvorel@suse.cz>
 <20171128232130.4843-3-pvorel@suse.cz>
Message-ID: <20171129154559.GD15160@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +        - os: linux
> +          env: BUILD="32"
> +          compiler: gcc-6
> +          addons:
> +              apt:
> +                  sources: ['ubuntu-toolchain-r-test']
> +                  packages: ['gcc-6', 'gcc-6-multilib', 'linux-libc-dev:i386']

Can we enable this for one old compiler as well? I would expect that
apart from generic 32bit compilation failures we will end up with
problems on older 32bit distros as well.

-- 
Cyril Hrubis
chrubis@suse.cz
