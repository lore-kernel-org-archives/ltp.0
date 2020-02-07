From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 Feb 2020 18:11:08 +0100
Subject: [LTP] [PATCH 1/1] build: Disable make install for most of builds
In-Reply-To: <20200207160831.27493-1-pvorel@suse.cz>
References: <20200207160831.27493-1-pvorel@suse.cz>
Message-ID: <20200207171108.GA11283@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> build.sh: add -i option which enables make install (default off)
> Enable it in Debian powerpc64le cross-compilation (out of tree)
> and latest Fedora.

> This 1) speedup builds 2) fixes often "No space left on device" on s390x.
Merged.
There still might be some failures on s390x, when space isn't enough for even
starting docker, but that should be less often.

Kind regards,
Petr
