From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Jun 2019 16:14:50 +0200
Subject: [LTP] [PATCH v4 4/4] ima: Add overlay test + doc
In-Reply-To: <55f6fec4-ef01-db2b-62c0-cbbbf79c6c12@suse.de>
References: <20190613161414.29161-1-pvorel@suse.cz>
 <20190613161414.29161-5-pvorel@suse.cz>
 <55f6fec4-ef01-db2b-62c0-cbbbf79c6c12@suse.de>
Message-ID: <20190614141449.GA24614@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ignaz,

thanks for pointing out all the typos and wrong grep (previous patch).
Going to sent v5 with fixes. Just one question below.

...
> > +++ b/testcases/kernel/security/integrity/ima/tests/README.md
> > @@ -0,0 +1,83 @@
> > +IMA + EVM testing
> > +=================
> > +
> > +IMA tests
> > +---------
> > +
> > +`ima_measurements.sh` require builtin IMA tcb policy to be loaded
> > +(`ima_policy=tcb` or `ima_policy=appraise_tcb` kernel parameter).

> This test requires "appraise_tcb" ("tcb" is not enough), as the errors only
> occur during appraisal.
Are you sure? This is a note for ima_measurements.sh test (not for evm_overlay.sh).
I require ima_policy=tcb here, according to Mimi [1]

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2019-June/012363.html
