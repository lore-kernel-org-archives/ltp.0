From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Feb 2018 10:16:08 +0100
Subject: [LTP] [RFC PATCH 0/2] travis: out-of-tree cross-compile + some
 builds in-tree => out-of-tree
In-Reply-To: <20180130074350.4032-1-pvorel@suse.cz>
References: <20180130074350.4032-1-pvorel@suse.cz>
Message-ID: <20180227091608.e6k2q2gzxv3jgbpy@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> this brings to travis to have also cross-compile out-of-tree builds + I
> changed some builds to be out-of-tree (not sure if it's useful).

> Kind regards,
> Petr

> Petr Vorel (2):
>   build.sh: Allow to choose in-tree or out-tree for all build types
>   travis: Update params for build.sh + change builds

>  .travis.yml | 42 ++++++++++++++++++++++-----------------
>  build.sh    | 65 ++++++++++++++++++++++++++++++++++++++-----------------------
>  2 files changed, 65 insertions(+), 42 deletions(-)

Pushed.

Kind regards,
Petr
