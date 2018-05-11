From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 10 May 2018 21:51:47 -0400
Subject: [LTP] [PATCH v2 2/4] tpm: Move eventlog files to a subdirectory
In-Reply-To: <20180509145121.z3jmvznojhi5mjiz@dell5510>
References: <20180412101350.210547-1-tweek@google.com>
 <20180412101350.210547-3-tweek@google.com>
 <20180420053926.GB15364@linux.intel.com>
 <1525725397.3551.10.camel@linux.vnet.ibm.com>
 <20180509145121.z3jmvznojhi5mjiz@dell5510>
Message-ID: <1526003507.3545.4.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, 2018-05-09 at 16:51 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> > [Cc'ing Petr Vorel and the ltp mailing list]
> 
> > Hi Jarrko,
> 
> > On Fri, 2018-04-20 at 08:39 +0300, Jarkko Sakkinen wrote:
> > > On Thu, Apr 12, 2018 at 12:13:48PM +0200, Thiebaud Weksteen wrote:
> > > > Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> > > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> > I just noticed this is queued in your next branch.
> 
> > Petr Vorel has been updating the IMA LTP tests.  One of those IMA LTP
> > tests includes walking the TPM binary_runtime_measurements in order to
> > calculate the IMA boot-aggregate.  The IMA boot-aggregate is the first
> > measurement in the IMA measurement list.
> 
> Did you meant that this commit ([2]) in linux-tpmdd/next changed location of
> binary_runtime_measurements in sysfs?
> 
> IMHO these commits ([1], [2], [3]) just put source code into eventlog/ subdirectory:

I mistakenly thought the eventlog itself was being moved, not the
source code.

thanks,

Mimi

> 
> Kind regards,
> Petr
> 
> [1] 75d647f5de69 tpm: Move eventlog declarations to its own header
> [2] 9b01b5356629 tpm: Move shared eventlog functions to common.c
> [3] 0bfb23746052 tpm: Move eventlog files to a subdirectory
> 

