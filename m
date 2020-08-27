From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 27 Aug 2020 15:55:03 +0200
Subject: [LTP] [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
In-Reply-To: <20200827132354.GA20439@dell5510>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-5-pvorel@suse.cz>
 <b58057275ecdc06bb512d39ea46118197f33c33f.camel@linux.ibm.com>
 <20200827132354.GA20439@dell5510>
Message-ID: <20200827135503.GA11990@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi,

> ...
> > > +	if ! tst_is_num $KEYRING_ID; then
> > > +		tst_brk TBROK "unable to parse the new keyring id ('$KEYRING_ID')"
> > > +	fi
> > > +

> > Instead of using TST_DATAROOT, which is defined as
> > "$LTPROOT/datafiles", use LTPROOT directly to define the path to the
> > cert.  Adding the following will allow the test to run from the build
> > directory.

> >       if [ ! -f $cert_file ]; then
> >               cert_file="$LTPROOT/../datafiles/ima_keys/x509_ima.der"
> >       fi
> Yes, this will work if you set LTPROOT to <ltp git>/testcases/kernel/security/integrity/ima/tests/:

> $ cd <ltp git>/testcases/kernel/security/integrity/ima/tests/
> $ LTPROOT=$PWD PATH="../../../../../lib/:.:$PATH" ./ima_keys.sh

> But, according to doc [1] $LTPROOT is "Prefix for installed LTP, the default is
> /opt/ltp.". Using it like this is confusing (if we want to misuse $LTPROOT, one
> would expect it's a cloned git root directory). Running from git root it'd have
> to be:

> $ cd <ltp git>
> $ LTPROOT=$PWD/testcases/kernel/security/integrity/ima/tests/ \
> PATH="testcases/lib:testcases/kernel/security/integrity/ima/tests/:$PATH" ima_keys.sh

> TL;DR: I'd really prefer people run IMA from installed LTP (make && make install
> in both testcases/lib and testcases/kernel/security/integrity/ima/ is just enough),
> but I'll add this hack to make your testing easier :). But fixing this in
> tst_test.sh is really needed.

Suggesting this diff from v4:

+	# hack when running ima_keys.sh locally from ima_keys.sh directory
+	# LTPROOT=$PWD PATH="../../../../../lib/:.:$PATH" ./ima_keys.sh
+	if [ ! -f "$cert_file" ]; then
+		cert_file="$LTPROOT/../datafiles/ima_keys/x509_ima.der"
+	fi

Visible also on
https://github.com/pevik/ltp/tree/Lachlan_Sneff/ima_keys.sh-second-test.v4.fixes

Not sure if you still doing review & testing, thus waiting for your comments
or tags.

Kind regards,
Petr

> > Mimi

> Kind regards,
> Petr

> [1] https://github.com/linux-test-project/ltp/wiki/User-Guidelines
