From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Jan 2017 16:37:01 +0100
Subject: [LTP] [PATCH 1/1] travis: use various gcc and clang versions +
 using containers
In-Reply-To: <20170112122635.GB17988@rei.suse.cz>
References: <20170112110632.11906-1-pvorel@suse.cz>
 <20170112122635.GB17988@rei.suse.cz>
Message-ID: <20170112153701.umezavmleroldzxr@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> $ export COMPILER=clang-3.9
> $ export CC=clang

> $ clang --version
> clang version 3.4 (tags/RELEASE_34/final)

> Shouldn't we set the compiler: to clang-3.9 as well, export
> CC=clang-3.9 or something?
It's not like that, travis sets CC itself, so I'm setting COMPILER variable and pass it to
make (see and of the patch).

I just need fix it to v2 as I'm passing CXX - wrong variable, as we have C not, C++. Now
it's really not working :-(.
I'll explain it more in v2.


Kind regards,
Petr
