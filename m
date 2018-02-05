From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 05 Feb 2018 10:42:27 +0200
Subject: [LTP] Hidden TPM questions in the LTP IMA posts
In-Reply-To: <1517416161.3469.142.camel@linux.vnet.ibm.com>
References: <1516978199.29187.43.camel@linux.vnet.ibm.com>
 <20180131133241.rbxy252l6p5rqlh2@linux.intel.com>
 <1517416161.3469.142.camel@linux.vnet.ibm.com>
Message-ID: <1517820147.7570.4.camel@linux.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 2018-01-31 at 11:29 -0500, Mimi Zohar wrote:
> On Wed, 2018-01-31 at 15:32 +0200, Jarkko Sakkinen wrote:
> > Hi
> > 
> > On Fri, Jan 26, 2018 at 09:49:59AM -0500, Mimi Zohar wrote:
> > > Hi Jarkko,
> > > 
> > > There are a few TPM questions for the fixing the IMA Linux Test
> > > Program (LTP) tests:
> > > 
> > > - The maximum size of the TPM 1.2 event record is unspecified.  What
> > > is the expected maximum size?
> > > - Is there a way of knowing the location of the TPM 1.2 PCRs without
> > > grepping for them?
> 
> I responded (in the original thread) to my own question:
> 
> Commit 313d21e "tpm: device class for tpm" moved the TPM sysfs
> location from /sys/class/misc/tpmX/device/ to
> /sys/class/tpm/tpmX/device/.

I was wondering what you meant by "location". That was the reason why I
postponed my response in the first place. I did not understand that you
were talking about the sysfs path. The only location I know for PCRs is
that they are inside the TPM.

For the first question, I don't think there is a hard coded limit but I
could be wrong. In the area of event log I think the TCG documentation
is just utter shit.

There is some documentation in EFI platform and protocol specifications
but it quite lacking.

It is awkward that this stuff is in EFI specifications in the first
place when with TPM 1.2 you access the log through ACPI and on some
platforms the event log is available through DT. It is hard to find
answers even to simple questions like what is put into the event log,
which is a very basic question that I do not have to day a definitive
answer.

/Jarkko
