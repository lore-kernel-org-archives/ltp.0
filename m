From: Jeff Moyer <jmoyer@redhat.com>
Date: Tue, 26 Sep 2017 09:36:50 -0400
Subject: [LTP] io_submit test failed in latest kernel
In-Reply-To: <f6facbe34ead4b8db35bc2e13392531c@SHMBX04.spreadtrum.com> ("Orson
 Zhai \=\?utf-8\?B\?KOe\/n+S6rCkiJ3M\=\?\= message of "Mon, 25 Sep 2017 06:23:20
 +0000")
References: <20170915043644.GA27514@spreadtrum.com>
 <x49mv5w9nn9.fsf@segfault.boston.devel.redhat.com>
 <20170922093616.GB27514@spreadtrum.com>
 <x49lgl6gb0x.fsf@segfault.boston.devel.redhat.com>
 <f6facbe34ead4b8db35bc2e13392531c@SHMBX04.spreadtrum.com>
Message-ID: <x49shf9bmz1.fsf@segfault.boston.devel.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

"Orson Zhai (翟京)" <Orson.Zhai@spreadtrum.com> writes:

> Hi Jeff,
>
> But all test itmes will pass on ARM64 test with hikey board (one kind of A53 SoC from Huawei).

You're feeding in stack contents as the iocb.  The test case was removed
from the latest LTP.  I don't think we need to worry about this.

Cheers,
Jeff
