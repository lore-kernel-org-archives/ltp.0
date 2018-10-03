From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Oct 2018 13:30:23 +0200
Subject: [LTP] [PATCH v2 4/4] Add delay bias for difficult races
In-Reply-To: <87h8iw5rbr.fsf@rpws.prws.suse.cz>
References: <20180910084442.17720-1-rpalethorpe@suse.com>
 <20180910084442.17720-5-rpalethorpe@suse.com>
 <20180910223806.GA9189@dell5510> <87h8iw5rbr.fsf@rpws.prws.suse.cz>
Message-ID: <20181003113023.GE23398@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Minor warning due being in header and not in C file:
> > ../../../include/tst_fuzzy_sync.h:753:13: warning: ???tst_fzsync_pair_add_bias??? defined but not used [-Wunused-function]
> >  static void tst_fzsync_pair_add_bias(struct tst_fzsync_pair *pair, int change)
> >
> >
> > Kind regards,
> > Petr
> 
> OK, I have added unused attribute to this function for the next version

static inline is a canonical way for functions implemented in headers,
that shouldn't produce warnings.

-- 
Cyril Hrubis
chrubis@suse.cz
