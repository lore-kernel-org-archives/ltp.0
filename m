From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 10 May 2018 04:39:25 +0300
Subject: [LTP] [PATCH v2 2/4] tpm: Move eventlog files to a subdirectory
In-Reply-To: <1525725397.3551.10.camel@linux.vnet.ibm.com>
References: <20180412101350.210547-1-tweek@google.com>
 <20180412101350.210547-3-tweek@google.com>
 <20180420053926.GB15364@linux.intel.com>
 <1525725397.3551.10.camel@linux.vnet.ibm.com>
Message-ID: <20180510013925.GJ6190@linux.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Mon, May 07, 2018 at 04:36:37PM -0400, Mimi Zohar wrote:
> [Cc'ing Petr Vorel and the ltp mailing list]
> 
> Hi Jarrko,
> 
> On Fri, 2018-04-20 at 08:39 +0300, Jarkko Sakkinen wrote:
> > On Thu, Apr 12, 2018 at 12:13:48PM +0200, Thiebaud Weksteen wrote:
> > > Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> I just noticed this is queued in your next branch.
> 
> Petr Vorel has been updating the IMA LTP tests.  One of those IMA LTP
> tests includes walking the TPM binary_runtime_measurements in order to
> calculate the IMA boot-aggregate.  The IMA boot-aggregate is the first
> measurement in the IMA measurement list.
> 
> Mimi

Sorry, not following how these connect directly?

/Jarkko
