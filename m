From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Jun 2019 15:59:21 +0200
Subject: [LTP] [PATCH v4 4/4] ima: Add overlay test + doc
In-Reply-To: <20190614144611.GA869@dell5510>
References: <20190613161414.29161-1-pvorel@suse.cz>
 <20190613161414.29161-5-pvorel@suse.cz>
 <55f6fec4-ef01-db2b-62c0-cbbbf79c6c12@suse.de>
 <20190614141449.GA24614@dell5510>
 <794ee977-463f-6670-fac6-3e27e25d64ab@suse.de>
 <20190614144611.GA869@dell5510>
Message-ID: <20190618135921.GA30776@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi, Ignaz,

> > > > This test requires "appraise_tcb" ("tcb" is not enough), as the errors only
> > > > occur during appraisal.
> > > Are you sure? This is a note for ima_measurements.sh test (not for evm_overlay.sh).
> > > I require ima_policy=tcb here, according to Mimi [1]

> > Oh, sorry, you are correct - "tcb" is correct in this case. I got confused
> > as the documentation is included in the overlayfs reproducer patch.
> Maybe I should put it into separate commit.
Whole patchset merged.

Thanks a lot both for your help!


Kind regards,
Petr
