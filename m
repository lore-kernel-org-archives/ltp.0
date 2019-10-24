From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Thu, 24 Oct 2019 20:26:46 -0300
Subject: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
In-Reply-To: <20191024213842.c6cl4tlnsi56pgcy@cantor>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510> <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
 <20191024213842.c6cl4tlnsi56pgcy@cantor>
Message-ID: <20191024232646.GE23952@ziepe.ca>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 24, 2019 at 02:38:42PM -0700, Jerry Snitselaar wrote:
> On Thu Oct 24 19, Jarkko Sakkinen wrote:
> > On Thu, Oct 24, 2019 at 02:18:48PM +0200, Petr Vorel wrote:
> > > Hi all,
> > > 
> > > I wonder what to do with this patch "ima: skip verifying TPM 2.0 PCR values" [1].
> > > Is it a correct way to differentiate between TPM 1.2 and TPM 2.0?
> > > Or something else should be applied?
> > > 
> > > How is the work on TPM 2.0 Linux sysfs interface?
> > > But even it's done in near future, we'd still need some way for older kernels.
> > > 
> > > Kind regards,
> > > Petr
> > > 
> > > [1] https://patchwork.ozlabs.org/patch/1100733/
> > 
> > version_major sysfs file would be acceptable if someone wants to proceed
> > and send such patch.
> > 
> > Also replicants for durations and timeouts files would make sense for
> > TPM 2.0.
> > 
> > /Jarkko
> 
> Is it as simple as doing this?
> 
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index edfa89160010..fd8eb8d8945c 100644
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -309,7 +309,17 @@ static ssize_t timeouts_show(struct device *dev, struct device_attribute *attr,
> }
> static DEVICE_ATTR_RO(timeouts);
> 
> -static struct attribute *tpm_dev_attrs[] = {
> +static ssize_t version_major_show(struct device *dev,
> +                                 struct device_attribute *attr, char *buf)
> +{
> +       struct tpm_chip *chip = to_tpm_chip(dev);

> +       return sprintf(buf, "TPM%s\n", chip->flags & TPM_CHIP_FLAG_TPM2
> +                      ? "2.0" : "1.2");

Probably no TPM prefix here

The usual sysfs naming would be more like 'major_version'

Jason
