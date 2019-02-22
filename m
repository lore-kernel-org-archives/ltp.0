From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 22 Feb 2019 14:04:00 +0100
Subject: [LTP] [PATCH 1/1] net/virt: Introduce MIN_VIRT_PERF_THRESHOLD
	variable
In-Reply-To: <954c744c-62c2-58d8-1b2c-09c0e7734b28@oracle.com>
References: <20190222090109.19824-1-pvorel@suse.cz>
 <954c744c-62c2-58d8-1b2c-09c0e7734b28@oracle.com>
Message-ID: <20190222130359.GA841@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > -VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
> > +MIN_VIRT_PERF_THRESHOLD=160

> Looks good, except may be add "MIN" to the end so it is closer to 'threshold'?
Sure, I'll apply it with VIRT_PERF_THRESHOLD_MIN.
Thanks for review.


Kind regards,
Petr
