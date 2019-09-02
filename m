From: Zhang, Yixin <yixin.zhang@intel.com>
Date: Mon, 2 Sep 2019 09:39:47 +0800
Subject: [LTP] [PATCH ltp 4/5] runtest/crashme: rename mem01 to avoid
 duplication
In-Reply-To: <20190830131359.GA28103@dell5510>
References: <20190809062000.8671-1-yixin.zhang@intel.com>
 <20190809062000.8671-4-yixin.zhang@intel.com>
 <20190830131359.GA28103@dell5510>
Message-ID: <20190902013947.GA19200@yixin-dev.sh.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Understood and thanks.
Could you aslo have a look at "[PATCH ltp 3/5] runtest/ltp-aiodio.part4:
rename aiodio_append tests to avoid duplication"? That case is different
than this one. In that case cases with differnt commands share the same
name.

Br.
Yixin

On 2019-08-30 at 15:14:00 +0200, Petr Vorel wrote:
> Hi Yixin,
> 
> > mem01 is already in runtest file mm. Rename the test to mem01_crashme
> > here.
> 
> ...
> > -mem01 mem01 -r
> > +mem01_crashme mem01 -r
> >  # Memory eater. Loves to be run in parallel with other programs.
> >  # May panic on buggy systems if the OOM killer was not fast enough :-)
> >  fork12 fork12
> 
> Refused this one, as it's the same case as [5/5]. Quote Cyril:
> https://patchwork.ozlabs.org/comment/2234376/
> The test names in runtest files were never promised to be unique, if the
> command line is the same the test id should probably stay the same.
> 
> 
> Kind regards,
> Petr
