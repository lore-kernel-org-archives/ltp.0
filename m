From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Sep 2020 13:43:35 +0200
Subject: [LTP] [PATCH v2 1/2] vxlan0{3,4}.sh: Fix exit on error
In-Reply-To: <20200930102855.5967-1-pvorel@suse.cz>
References: <20200930102855.5967-1-pvorel@suse.cz>
Message-ID: <20200930114335.GA20377@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> we need return, continue was for original loop (in vxlan03.sh regression
> from f275363d7, then copy pasted to vxlan04.sh).

> Fixes: f275363d7 ("net/{stress,virt}: Migrate virt_lib.sh, ipsec_lib.sh + tests using them")
> Fixes: 503b1cb1e ("network: add new gre02, geneve02, macsec03 and vxlan04 tests")

FYI: Patchset merged.

Kind regards,
Petr
