From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Jan 2017 14:54:44 +0100
Subject: [LTP] [PATCH v2 1/2] travis: use various gcc and clang versions
 + using containers
In-Reply-To: <20170116102519.GC20956@rei.lan>
References: <20170113090706.29130-1-pvorel@suse.cz>
 <20170116102519.GC20956@rei.lan>
Message-ID: <20170116135444.hrpikajps735uhmk@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

> Applied thanks.
Thanks :-).

> What I would be intersted in in the long term would be running LTP build
> on some sligthly older distribution (debian stable or oldstable should
> be quite easy with debootstrap) as well as do a 32bit build [1]. So
> maybe we can omit build for some gcc versions and rather work on these
> two options.
I thought that old gcc and clang versions would emulate older distros (currently defined compilers have similar versions to gcc for Debian from oldstable to unstable, Ubuntu from precise zesty and to clang from Debian stable to unstable and xenial to zesty).
But true, at least 32bit and cross compilation wouldn't be solved by it.

> [1]
> https://github.com/patricksnape/test-travis-chroot-32/blob/master/setup_travis.sh
Looks interesting, I'll test it in near future. It uses sudo, which is declared to be
slower, but it looks the same to me.


Kind regards,
Petr
