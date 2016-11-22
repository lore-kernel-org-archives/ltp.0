From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Nov 2016 17:52:44 +0100
Subject: [LTP] [PATCH v2 1/1] testcases: bashisms: s/==/=/
In-Reply-To: <20161122142828.GB8384@rei.lan>
References: <20161121205300.28375-1-petr.vorel@gmail.com>
 <20161122142828.GB8384@rei.lan>
Message-ID: <20161122164824.2pb7ekiy4srrk2ce@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> I've dropped the part that fixed mv_test.sh since that test was
> rewritten by the big patchset I've just commited and pushed, thanks.
Thanks! I hoped not to clash with your work, sorry! There are still some bashisms left,
are you planning any big rewrite, so I should wait for fixing them?

BTW there is a file pushed with my commit
testcases/kernel/controllers/memcg/functional/memcg_getpagesize, IMHO it shouldn't
(it was removed in 5e65d837ee4e3390c885db1d2eb340c80c2b6c36).

OT: testcases/kernel/controllers/memcg/README seems to be outdated.


Kind regards,
Petr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161122/f33295fa/attachment.sig>
