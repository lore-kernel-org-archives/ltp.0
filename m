From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Jun 2021 12:42:22 +0200
Subject: [LTP] [RFC PATCH 2/3] lib: Add $LTPROOT/testcases/bin into PATH
In-Reply-To: <YMnLEjDAVQqwH7Wq@yuki>
References: <20210615163307.10755-1-pvorel@suse.cz>
 <20210615163307.10755-3-pvorel@suse.cz> <YMnLEjDAVQqwH7Wq@yuki>
Message-ID: <YMnVjvuMnymDD2cA@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> I guess that we can also fairly simplify the code by expecting that PATH
> is never unset from the start, maybe we should just check it and WARN if
> it's not. Also we can assume that if LTPROOT is set we do not have to
> add the start_dir since the start_dir is only useful when tests are
> executed from the git checkout.

I'm sorry to sent patchset with full of bugs, thanks for all your explanation.
While your suggestion could work, it's a question if my effort help to anything
(as Li noted). My intend was to require only LTPROOT, but even we expect
script/binary is called by full path (otherwise adjusting PATH would be required
anyway) fix work only for C API. tst_test.sh PATH is missing for shell API :(.
(discussed with Li under 3rd patch)

Kind regards,
Petr
