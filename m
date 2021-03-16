From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Mar 2021 18:21:24 +0100
Subject: [LTP] [PATCH v2] IMA: Allow only ima-buf template for key
 measurement
In-Reply-To: <deeb4320-a064-fd0f-bc1e-8e52be079ff9@linux.microsoft.com>
References: <20210314233646.2925-1-nramas@linux.microsoft.com>
 <YFC7j4+wA8xorNgu@pevik>
 <deeb4320-a064-fd0f-bc1e-8e52be079ff9@linux.microsoft.com>
Message-ID: <YFDpFL3CSwMfZ6wo@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lakshmi,

> > Just a double check does it always work without template=ima-buf for all kernel versions?
> > Or only for kernels with dea87d0889dd ("ima: select ima-buf template for buffer measurement")
> > i.e. v5.11-rc1 or backport?
> The above change is required. Prior to this change, template has to be
> specified in the policy, otherwise the default template would be used.
The default template is ima-ng, right?
From what you write I understand that "measure func=KEY_CHECK
keyrings=.ima|.evm" will work only on newer kernel, thus we should always use
template=ima-buf as the policy example so that it's working also on that few
kernels between <v5.6,v5.10> (which have IMA key functionality, but not
dea87d0889dd), right?

But we should mention that in the README.md.

Kind regards,
Petr

> > Also, don't we want to change also keycheck.policy?
> > Currently it contains:
> > measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf
> > Do we want to drop template=ima-buf to test the default value? Or have two rules
> > (one with template=ima-buf, other w/a?)
> Good point.

> I will send you the v3 patch - with two rules: one with template=buf and
> other without a template, like the following example:

> measure func=KEY_CHECK
> keyrings=.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf

> measure func=KEY_CHECK keyrings=.ima|.evm

>  -lakshmi
