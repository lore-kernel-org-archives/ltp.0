From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 24 Sep 2019 11:52:31 +0200
Subject: [LTP] [PATCH] fzsync: Add reproducing race-conditions section
 to docs
In-Reply-To: <BYAPR11MB362484D50E4178C05B7D09C3CD850@BYAPR11MB3624.namprd11.prod.outlook.com>
References: <20190923125914.2572-1-rpalethorpe@suse.com>
 <20190923155215.GA2531@dell5510>
 <BYAPR11MB362484D50E4178C05B7D09C3CD850@BYAPR11MB3624.namprd11.prod.outlook.com>
Message-ID: <87y2yeja1s.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Steve East <sge@cray.com> writes:

>>> +2.2.33 Reproducing race-conditions
>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> +
>>> +If a bug is caused by two tasks in the kernel racing and you wish to 
>>> +create a regression test (or bug-fix validation test). The 
>>> +'tst_fuzzy_sync.h' library should be used.
>>Looks a bit strange to have this in 2 sentences (I'd write single one), but you're a native speaker, so you must know what is correct :).
>
> It is strange... 
>
> "If a bug is caused by two tasks in the kernel racing and you wish to create a regression test (or bug-fix validation test) then the 'tst_fuzzy_sync.h' library should be used."
>
> Steve.

OK, I was trying to make the sentences shorter, but obviously that was
not the correct way to do it.

Metan feel free to merge with fix :-)

-- 
Thank you,
Richard.
