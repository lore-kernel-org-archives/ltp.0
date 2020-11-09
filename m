From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Mon, 09 Nov 2020 16:13:45 +0100
Subject: [LTP] [PATCH v2 1/1] lib/tst_virt: support IBM/Z LPAR and z/VM
 virtualization environments
In-Reply-To: <20201109150943.GB25892@yuki.lan>
References: <20201109145657.602251-1-egorenar@linux.ibm.com>
 <20201109150943.GB25892@yuki.lan>
Message-ID: <875z6e5zrq.fsf@oc8242746057.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
> Actually we can simplify the code like this:
>
> +static int is_ibmz(int virt_type)
> +{
> +	FILE *sysinfo;
> +	char line[64];
> +	int found_lpar, found_zvm;
> +
> +	if (virt_type != VIRT_IBMZ_LPAR && virt_type != VIRT_IBMZ_ZVM)
> +		return 0;

Missed VIRT_IBMZ.

Otherwise is good.
Shall i create a new patch ?

Regards
Alex
