From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Jan 2017 11:25:19 +0100
Subject: [LTP] [PATCH v2 1/2] travis: use various gcc and clang versions
 + using containers
In-Reply-To: <20170113090706.29130-1-pvorel@suse.cz>
References: <20170113090706.29130-1-pvorel@suse.cz>
Message-ID: <20170116102519.GC20956@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Using containers is declared to be faster, but does not allow us to use
> sudo => install into $HOME.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Applied thanks.

> ---
> Used gcc: 4.6, 4.7, 4.8. 4.9, 5, 6
> Used clang: 3.5, 3.8, 3.9
> 
> I simplified patch. This way we cannot install clang-3.3, but I suppose it's ok.
> Which versions are you interested? We can have even more versions, but even this subset is IMHO quite a lot.

I guess that we cover more than enough compiler versions now.

What I would be intersted in in the long term would be running LTP build
on some sligthly older distribution (debian stable or oldstable should
be quite easy with debootstrap) as well as do a 32bit build [1]. So
maybe we can omit build for some gcc versions and rather work on these
two options.

[1]
https://github.com/patricksnape/test-travis-chroot-32/blob/master/setup_travis.sh

-- 
Cyril Hrubis
chrubis@suse.cz
