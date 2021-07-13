From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Jul 2021 14:35:40 +0200
Subject: [LTP] Failing test on failing shell commands
In-Reply-To: <c253160b-7326-8583-9713-8b3978473c7d@canonical.com>
References: <9c05b592-e474-6a3e-2dc1-ec075a0bc558@canonical.com>
 <YO1/J2pTbSsX2dGb@yuki>
 <c253160b-7326-8583-9713-8b3978473c7d@canonical.com>
Message-ID: <YO2InGIKtRJOZPOy@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We do have ROD (as a shorthand for "run or die") in the shell test
> > library, so this really should be:
> > 
> > 	ROD mkdir subgroup
> 
> Thanks. This will however fail entire suite (memcg_use_hierarchy_test)
> and other tests won't get executed. The failure could be only local, so
> other tests are still meaningful.

If you want to exit the subtest you really have to handle the return
values yourself, report the error, and return from the test function.

The question is which status to report. The TBROK status means that test
has failed setup phase and there is no point to continue, so this
probably should map to tst_res TWARN "...".

Another solution would be splitting the test into three seprate tests
so that we can use ROD.

-- 
Cyril Hrubis
chrubis@suse.cz
