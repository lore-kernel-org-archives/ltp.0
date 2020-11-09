From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Mon, 09 Nov 2020 16:11:31 +0100
Subject: [LTP] [PATCH v2 1/1] lib/tst_virt: support IBM/Z LPAR and z/VM
 virtualization environments
In-Reply-To: <20201109150943.GB25892@yuki.lan>
References: <20201109145657.602251-1-egorenar@linux.ibm.com>
 <20201109150943.GB25892@yuki.lan>
Message-ID: <878sba5zvg.fsf@oc8242746057.ibm.com>
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
> +
> +	if (access("/proc/sysinfo", F_OK) != 0)
> +		return 0;
> +
> +	sysinfo = SAFE_FOPEN(NULL, "/proc/sysinfo", "r");
> +	found_lpar = 0;
> +	found_zvm = 0;
> +	while (fgets(line, sizeof(line), sysinfo) != NULL) {
> +		if (strstr(line, "LPAR"))
> +			found_lpar = 1;
> +		else if (strstr(line, "z/VM"))
> +			found_zvm = 1;
> +	}
> +
> +	SAFE_FCLOSE(NULL, sysinfo);
> +
> +	switch (virt_type) {
> +	case VIRT_IBMZ:
> +		return found_lpar;
> +	case VIRT_IBMZ_LPAR:
> +		return found_lpar && !found_zvm;
> +	case VIRT_IBMZ_ZVM:
> +		return found_lpar && found_zvm;
> +	default:
> +		return 0;
> +	}
> +}
> +
>  static int try_systemd_detect_virt(void)
>  {
>  	FILE *f;
> @@ -102,6 +138,9 @@ static int try_systemd_detect_virt(void)
>  	if (!strncmp("xen", virt_type, 3))
>  		return VIRT_XEN;
>  
> +	if (!strncmp("zvm", virt_type, 3))
> +		return VIRT_IBMZ_ZVM;
> +
>  	return VIRT_OTHER;
>  }
>  
> @@ -118,11 +157,15 @@ int tst_is_virt(int virt_type)
>  
>  	switch (virt_type) {
>  	case VIRT_ANY:
> -		return is_xen() || is_kvm();
> +		return is_xen() || is_kvm() || is_ibmz(VIRT_IBMZ);
>  	case VIRT_XEN:
>  		return is_xen();
>  	case VIRT_KVM:
>  		return is_kvm();
> +	case VIRT_IBMZ:
> +	case VIRT_IBMZ_LPAR:
> +	case VIRT_IBMZ_ZVM:
> +		return is_ibmz(virt_type);
>  	case VIRT_OTHER:
>  		return 0;
>  	}
>
>
> Do you agree with these changes?
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz

Hi, perfect.

Thanks

Regards
Alex
