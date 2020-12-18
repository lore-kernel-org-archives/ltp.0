From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 18 Dec 2020 07:10:37 -0500
Subject: [LTP] [PATCH v5 1/4] IMA: Move get_algorithm_digest(),
 set_digest_index() to ima_setup.sh
In-Reply-To: <X9ySNMlhYIMKd+SY@pevik>
References: <20201214221946.6340-1-pvorel@suse.cz>
 <20201214221946.6340-2-pvorel@suse.cz>
 <aed2e8ee7b05772a8cc2988ae275282bec7ef504.camel@linux.ibm.com>
 <X9ySNMlhYIMKd+SY@pevik>
Message-ID: <aa87efd5d1b3290347af8ada73deab6b5e2beb3b.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Fri, 2020-12-18 at 12:27 +0100, Petr Vorel wrote:
> > On Mon, 2020-12-14 at 23:19 +0100, Petr Vorel wrote:
> > > To be reusable by more tests (preparation for next commit).
> 
> > > Call set_digest_index() inside get_algorithm_digest() if needed
> > > instead of expecting get_algorithm_digest() caller to call
> > > set_digest_index() before.
> 
> > For the existing builtin templates, the algorithm/digest field is
> > consistent.  With support for per policy rule template formats, there
> > isn't necessarily a single template format for the entire list.
> 
> > In the future "set_digest_index" might need to be renamed to
> > "get_digest_index" and the lookup done for each line.
> Thanks for info, noted as TODO. Policy example would speedup fixing.

The simplest way of forcing this to happen would be by specifying a
custom format on the boot command line ("ima_template_fmt=") and
measuring buffer data (ima-buf), like the kexec boot command line.

measure func=KEXEC_CMDLINE template=ima-buf

where "template=ima-buf" isn't needed on kernels with commit
dea87d0889dd ("ima: select ima-buf template for buffer measurement") .

thanks,

Mimi

