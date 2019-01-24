From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Jan 2019 08:38:56 +0100
Subject: [LTP] [PATCH v3 5/6] ima: Rename the folder name for policy
 files to datafiles
In-Reply-To: <49244744-3546-c477-f443-a70ced4a4ed4@linux.alibaba.com>
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547607461-11233-6-git-send-email-zhang.jia@linux.alibaba.com>
 <20190123170409.GA11731@dell5510>
 <49244744-3546-c477-f443-a70ced4a4ed4@linux.alibaba.com>
Message-ID: <20190124073856.GA12189@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jia,

> > I wasn't sure about this one as make install isn't that hard to do even during
> > debugging and policy is more descriptive. But other tests use datafiles as well,
> > therefore taken as well.

> Actually, this patch resolves the issue if we just follow this step to
> run IMA-only test:

> $ git clone https://github.com/linux-test-project/ltp.git
> $ cd ltp
> $ export LTP_ROOT="$PWD"
> $ make autotools
> $ ./configure
> $ cd testcases/lib
> $ make
> $ cd ../kernel/security/integrity/ima
> $ make
> $ sudo PATH=$LTP_ROOT/testcases/lib:tests:$PATH ./tests/ima_policy.sh

> A full LTP installation doesn't have this issue.
Just a side note: there is only one LTP installation: make install :).
Your example is compilation and running test *without* installation.

The fact we require installation suggest runltp (still not replaced LTP runner):
$ ./runltp
FATAL: LTP not installed correctly
INFO:  Follow directions in INSTALL!

I usually do installation, also because I test patches on various VMs.

Kind regards,
Petr
