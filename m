From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 May 2021 13:02:59 +0200
Subject: [LTP] [PATCH 1/2] build.sh: Support passing configure options
In-Reply-To: <YJ4/d4pTsWNRYX02@pevik>
References: <20210512165702.22883-1-pvorel@suse.cz> <YJ4p7636z0iYSsy0@yuki>
 <YJ4/d4pTsWNRYX02@pevik>
Message-ID: <YJ5Y4x4muY18L6QO@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > Hi!
> > Looks good, but is it even used for the second patch? We just pass extra
> > options there, right?
> Yes, CONFIGURE_OPT_EXTRA. I added also CONFIGURE_OPT to allow local build.sh
> without realtime and openposix: 
> $ CONFIGURE_OPT= ./build.sh

> I document it in the commit.

Whole patchset merged.
In the end I really added only CONFIGURE_OPT_EXTRA.

to allow CONFIGURE_OPT be empty it would have to be added as:
CONFIGURE_OPTS_OUT_TREE=${CONFIGURE_OPT: --with-realtime-testsuite ...}"
i.e. remove -, but that would again require to always define CONFIGURE_OPT.
=> postpone it for now.

Kind regards,
Petr

> Kind regards,
> Petr
