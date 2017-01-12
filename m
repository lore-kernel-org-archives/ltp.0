From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Jan 2017 13:26:35 +0100
Subject: [LTP] [PATCH 1/1] travis: use various gcc and clang versions +
 using containers
In-Reply-To: <20170112110632.11906-1-pvorel@suse.cz>
References: <20170112110632.11906-1-pvorel@suse.cz>
Message-ID: <20170112122635.GB17988@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +        - os: linux
> +          compiler: clang
> +          addons:
> +              apt:
> +                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-precise']
> +                  packages: ['clang-3.9']
> +          env:
> +              - COMPILER=clang-3.9

Hmm, does this actually work? Looking at the log for this particular
build:

Setting environment variables from .travis.yml

$ export COMPILER=clang-3.9
$ export CC=clang

$ clang --version
clang version 3.4 (tags/RELEASE_34/final)

Shouldn't we set the compiler: to clang-3.9 as well, export
CC=clang-3.9 or something?

-- 
Cyril Hrubis
chrubis@suse.cz
