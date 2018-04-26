From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 26 Apr 2018 10:32:52 -0400
Subject: [LTP] [RFC PATCH v3 02/10] security/ima: Change order of tests
In-Reply-To: <20180424180953.vbn2cancyxk7ghnk@dell5510>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <20180419195503.7194-3-pvorel@suse.cz>
 <20180424180953.vbn2cancyxk7ghnk@dell5510>
Message-ID: <1524753172.5349.7.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Tue, 2018-04-24 at 20:09 +0200, Petr Vorel wrote:
> Hi,
> 
> > Unfortunately in some circumstances there are interdependencies between
> > tests.
> > measurements test require loaded IMA policy. If it's not loaded, policy
> > test do it for us => run measurements test after policy test.
> 
> > Policy test somehow breaks violations test => run it before policy test.
> > TODO: this does not help if CONFIG_IMA_WRITE_POLICY=y and without auditd
> > daemon. Maybe we should require auditd for violation tests.
> ...
> > +++ b/runtest/ima
> > @@ -1,5 +1,5 @@
> >  #DESCRIPTION:Integrity Measurement Architecture (IMA)
> > -ima_measurements ima_measurements.sh
> > +ima_violations ima_violations.sh
> >  ima_policy ima_policy.sh
> > +ima_measurements ima_measurements.sh
> >  ima_tpm ima_tpm.sh
> > -ima_violations ima_violations.sh
> 
> I don't want to apply this patch any more. The behavior depends on ima_policy
> settings.
> 
> What is meaningful setup for testing anyway? I suppose at least some tests need
> to have some policy set (ima_policy=tbc ?).
> 
> Without this patch and with no ima_policy ima_measurements.sh test is failing, it needs to
> be skipped.

The original tests assumed a builtin IMA-measurement policy.  Either
the boot command line "ima_tcb" or "ima_policy=tcb" options should
work.  When checking the "ima_policy" for "tcb", it could be specified
anywhere in the list of builtin policies (eg.
ima_policy=appraise_tcb|secure_boot|ima).

Mimi

