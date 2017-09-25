From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Sep 2017 18:04:41 +0200
Subject: [LTP] [PATCH v4 3/7] fzsync: Add long running thread support
 and deviation stats
In-Reply-To: <20170925095137.31491-3-rpalethorpe@suse.com>
References: <20170925095137.31491-1-rpalethorpe@suse.com>
 <20170925095137.31491-3-rpalethorpe@suse.com>
Message-ID: <20170925160441.GC31931@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This does not replace the delay method of synchronisation which can be used in
> addition to the new method. Also the precision of the averages has been
> reduced because double precision appears to be unnecessary.

Just a quick question, have you tested this on arm as well? The x86 FPU
computes with greater than float precission internally and I've seen a
cases where code would run perfectly fine on x86 with floats but failed
horrinbly on arm.

-- 
Cyril Hrubis
chrubis@suse.cz
