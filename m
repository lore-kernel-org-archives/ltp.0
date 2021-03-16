From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Mar 2021 15:07:11 +0100
Subject: [LTP] [PATCH v2] IMA: Allow only ima-buf template for key
 measurement
In-Reply-To: <20210314233646.2925-1-nramas@linux.microsoft.com>
References: <20210314233646.2925-1-nramas@linux.microsoft.com>
Message-ID: <YFC7j4+wA8xorNgu@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lakshmi, Mimi,

> ima-buf is the default IMA template used for all buffer measurements.
> Therefore, IMA policy rule for measuring keys need not specify
> an IMA template.  But if a template is specified for key measurement
> rule then it must be only ima-buf.

> Update keys tests to not require a template to be specified for
> key measurement rule, but if a template is specified verify it is
> only ima-buf.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Just a double check does it always work without template=ima-buf for all kernel versions?
Or only for kernels with dea87d0889dd ("ima: select ima-buf template for buffer measurement")
i.e. v5.11-rc1 or backport?

Also, don't we want to change also keycheck.policy?
Currently it contains:
measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf
Do we want to drop template=ima-buf to test the default value? Or have two rules
(one with template=ima-buf, other w/a?)

Mimi, any comment on this?

Kind regards,
Petr
