From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 1 Mar 2021 16:35:49 +0100
Subject: [LTP] [PATCH v2 3/6] zram: Move zram_compress_alg() to zram02.sh
In-Reply-To: <YD0AUrSXxGabE+jB@yuki.lan>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-4-pvorel@suse.cz> <YD0AUrSXxGabE+jB@yuki.lan>
Message-ID: <YD0J1eQ162gmyd4C@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > Quit at setup in case there is no fs support (change in previous commit)
> > can lead to skipping zram_compress_alg(). Move to zram02.sh where is no
> > such limitation.

> Actually I think that we should keep it in both for now, since the tests
> do depend on each other, the zram_fill_fs actually checks compression
> ration, which only makes sense if compression is enabled.
Makes sense.

> Ideally we should use different compression algorithms in the zram01
> test, so I guess that we can, later on distribute the compression
> algorithms between the created devices, but that shouldn't stop this
> patchset.
OK. I'll change this patchset to *add* zram_compress_alg() to zram02.sh (keep it
in zram01.sh) and update following commit.

Kind regards,
Petr

