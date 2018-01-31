From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Wed, 31 Jan 2018 11:29:21 -0500
Subject: [LTP] Hidden TPM questions in the LTP IMA posts
In-Reply-To: <20180131133241.rbxy252l6p5rqlh2@linux.intel.com>
References: <1516978199.29187.43.camel@linux.vnet.ibm.com>
 <20180131133241.rbxy252l6p5rqlh2@linux.intel.com>
Message-ID: <1517416161.3469.142.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, 2018-01-31 at 15:32 +0200, Jarkko Sakkinen wrote:
> Hi
> 
> On Fri, Jan 26, 2018 at 09:49:59AM -0500, Mimi Zohar wrote:
> > Hi Jarkko,
> > 
> > There are a few TPM questions for the fixing the IMA Linux Test
> > Program (LTP) tests:
> > 
> > - The maximum size of the TPM 1.2 event record is unspecified.  What
> > is the expected maximum size?

> > - Is there a way of knowing the location of the TPM 1.2 PCRs without
> > grepping for them?

I responded (in the original thread) to my own question:

Commit 313d21e "tpm: device class for tpm" moved the TPM sysfs
location from /sys/class/misc/tpmX/device/ to
/sys/class/tpm/tpmX/device/.

> > Additional question:
> > - Are the TPM 2.0 PCRs and event log exported by the kernel?  If not,
> > how are they accessed?

Nayna, just responded (in the original thread) that only the binary
event log is exported for TPM 2.0, initially for device tree.  Similar
support for EFI is being upstreamed in this open window (linux-4.16).

> Have not missed this email. I'll answer this as soon as I have time
> to write a proper response.

(I was hoping someone else on the mailing list would respond.)
 Between Nayna and me, I think we responded to all the questions
except the first one.

Mimi

