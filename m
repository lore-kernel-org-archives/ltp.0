From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Tue, 16 Mar 2021 09:23:57 -0700
Subject: [LTP] [PATCH v2] IMA: Allow only ima-buf template for key
 measurement
In-Reply-To: <YFC7j4+wA8xorNgu@pevik>
References: <20210314233646.2925-1-nramas@linux.microsoft.com>
 <YFC7j4+wA8xorNgu@pevik>
Message-ID: <deeb4320-a064-fd0f-bc1e-8e52be079ff9@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 3/16/21 7:07 AM, Petr Vorel wrote:
> Hi Lakshmi, Mimi,
> 
>> ima-buf is the default IMA template used for all buffer measurements.
>> Therefore, IMA policy rule for measuring keys need not specify
>> an IMA template.  But if a template is specified for key measurement
>> rule then it must be only ima-buf.
> 
>> Update keys tests to not require a template to be specified for
>> key measurement rule, but if a template is specified verify it is
>> only ima-buf.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
Thanks Petr.

> 
> Just a double check does it always work without template=ima-buf for all kernel versions?
> Or only for kernels with dea87d0889dd ("ima: select ima-buf template for buffer measurement")
> i.e. v5.11-rc1 or backport?
The above change is required. Prior to this change, template has to be 
specified in the policy, otherwise the default template would be used.

> 
> Also, don't we want to change also keycheck.policy?
> Currently it contains:
> measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf
> Do we want to drop template=ima-buf to test the default value? Or have two rules
> (one with template=ima-buf, other w/a?)
Good point.

I will send you the v3 patch - with two rules: one with template=buf and 
other without a template, like the following example:

measure func=KEY_CHECK 
keyrings=.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf

measure func=KEY_CHECK keyrings=.ima|.evm

  -lakshmi

> 
> Mimi, any comment on this?
> 
> Kind regards,
> Petr
> 

