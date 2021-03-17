From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 Mar 2021 21:37:27 +0100
Subject: [LTP] [PATCH v2] IMA: Allow only ima-buf template for key
 measurement
In-Reply-To: <5cbe66e7-aebf-e75a-cd9a-d0a69e8a1edd@linux.microsoft.com>
References: <20210314233646.2925-1-nramas@linux.microsoft.com>
 <YFC7j4+wA8xorNgu@pevik>
 <deeb4320-a064-fd0f-bc1e-8e52be079ff9@linux.microsoft.com>
 <YFDpFL3CSwMfZ6wo@pevik>
 <5cbe66e7-aebf-e75a-cd9a-d0a69e8a1edd@linux.microsoft.com>
Message-ID: <YFJoh++5vxSuwJiz@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lakshmi,

> > > > Just a double check does it always work without template=ima-buf for all kernel versions?
> > > > Or only for kernels with dea87d0889dd ("ima: select ima-buf template for buffer measurement")
> > > > i.e. v5.11-rc1 or backport?
> > > The above change is required. Prior to this change, template has to be
> > > specified in the policy, otherwise the default template would be used.
> > The default template is ima-ng, right?
> Yes: ima-ng is the default template.

> > > From what you write I understand that "measure func=KEY_CHECK
> > keyrings=.ima|.evm" will work only on newer kernel, thus we should always use
> > template=ima-buf as the policy example so that it's working also on that few
> > kernels between <v5.6,v5.10> (which have IMA key functionality, but not
> > dea87d0889dd), right?
> Yes: In the kernels between v5.6 and v5.10, ima-buf template needs to be
> specified in the policy for KEY_CHECK.

OK, thus your original version - i.e. don't require template=ima-buf,
but keep it in policy example is the best approach.

> > But we should mention that in the README.md.

> Agreed - will update the README.md
Thanks!

Kind regards,
Petr

> thanks,
>  -lakshmi
