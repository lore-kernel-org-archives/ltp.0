From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 24 Oct 2019 22:14:02 +0300
Subject: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
In-Reply-To: <20191024182005.GZ23952@ziepe.ca>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510> <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
 <20191024182005.GZ23952@ziepe.ca>
Message-ID: <20191024191402.GB12038@linux.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 24, 2019 at 03:20:05PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 24, 2019 at 08:20:23PM +0300, Jarkko Sakkinen wrote:
> > Also replicants for durations and timeouts files would make sense for
> > TPM 2.0.
> 
> These ones don't meet the sysfs standard of one value per file, which
> is why they didn't make it to tpm2

They would be still useful to have available in some form as there is
no way deduce them from the user space.

I'd prioritize in this particular case the compatibility with the legacy
files over sysfs standard with a clear note in the commit message.

/Jarkko
