From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Apr 2018 20:09:53 +0200
Subject: [LTP] [RFC PATCH v3 02/10] security/ima: Change order of tests
In-Reply-To: <20180419195503.7194-3-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <20180419195503.7194-3-pvorel@suse.cz>
Message-ID: <20180424180953.vbn2cancyxk7ghnk@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Unfortunately in some circumstances there are interdependencies between
> tests.
> measurements test require loaded IMA policy. If it's not loaded, policy
> test do it for us => run measurements test after policy test.

> Policy test somehow breaks violations test => run it before policy test.
> TODO: this does not help if CONFIG_IMA_WRITE_POLICY=y and without auditd
> daemon. Maybe we should require auditd for violation tests.
...
> +++ b/runtest/ima
> @@ -1,5 +1,5 @@
>  #DESCRIPTION:Integrity Measurement Architecture (IMA)
> -ima_measurements ima_measurements.sh
> +ima_violations ima_violations.sh
>  ima_policy ima_policy.sh
> +ima_measurements ima_measurements.sh
>  ima_tpm ima_tpm.sh
> -ima_violations ima_violations.sh

I don't want to apply this patch any more. The behavior depends on ima_policy
settings.

What is meaningful setup for testing anyway? I suppose at least some tests need
to have some policy set (ima_policy=tbc ?).

Without this patch and with no ima_policy ima_measurements.sh test is failing, it needs to
be skipped.

Kind regards,
Petr
