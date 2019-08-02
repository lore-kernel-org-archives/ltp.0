From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 2 Aug 2019 17:31:13 +0200
Subject: [LTP] [PATCH v2 2/4] utils/ffsb: Add missing fhstat() signature
 + includes
In-Reply-To: <20190802151401.GA24157@rei>
References: <20190802150445.10984-1-pvorel@suse.cz>
 <20190802150445.10984-3-pvorel@suse.cz>
 <20190802151401.GA24157@rei>
Message-ID: <20190802153113.GA4609@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > To be hones I'd rather delete this The Flexible Filesystem Benchmark
> > (FFSB) (in utils/ffsb-6.0-rc2). Does anyone uses it?
> > If kept, I'd prefer to have it as a separate project in [1]

> It's a dependency because the ext4-new-features tests use it.

> But these tests already check for ffsb so we may as well remove it from
> LTP and either maintain it in a separate repo or point out our users to
> the fork.
OK, I overlooked it's really installed. In that case I'd postpone the solution
(hosting at separate project looks cleaner to me, but then we'd need to setup
git subproject) and merge this unchanged.

Kind regards,
Petr
