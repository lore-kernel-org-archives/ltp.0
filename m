From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Nov 2020 15:42:49 +0100
Subject: [LTP] [PATCH 2/2] lib/tst_virt: support IBM/Z LPAR and z/VM
 virtualization environments
In-Reply-To: <20201106130624.454614-3-egorenar@linux.ibm.com>
References: <20201106130624.454614-1-egorenar@linux.ibm.com>
 <20201106130624.454614-3-egorenar@linux.ibm.com>
Message-ID: <20201109144249.GA25892@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static int is_ibmz_lpar(void)
> +{
> +	FILE *cpuinfo;
> +	char line[64];
> +	int found_lpar, found_zvm;
> +
> +	if (access("/proc/sysinfo", F_OK) != 0)
> +		return 0;
> +
> +	cpuinfo = SAFE_FOPEN(NULL, "/proc/sysinfo", "r");
> +	found_lpar = 0;
> +	found_zvm = 0;
> +	while (fgets(line, sizeof(line), cpuinfo) != NULL) {
> +		if (strstr(line, "LPAR"))
> +			found_lpar = 1;
> +		else if (strstr(line, "z/VM"))
> +			found_zvm = 1;
> +	}
> +
> +	SAFE_FCLOSE(NULL, cpuinfo);
> +	return found_lpar && !found_zvm;
> +}
> +
> +static int is_ibmz_zvm(void)
> +{
> +	FILE *cpuinfo;
> +	char line[64];
> +	int found_lpar, found_zvm;
> +
> +	if (access("/proc/sysinfo", F_OK) != 0)
> +		return 0;
> +
> +	cpuinfo = SAFE_FOPEN(NULL, "/proc/sysinfo", "r");
> +	found_lpar = 0;
> +	found_zvm = 0;
> +	while (fgets(line, sizeof(line), cpuinfo) != NULL) {
> +		if (strstr(line, "LPAR"))
> +			found_lpar = 1;
> +		else if (strstr(line, "z/VM"))
> +			found_zvm = 1;
> +	}
> +
> +	SAFE_FCLOSE(NULL, cpuinfo);
> +	return found_lpar && found_zvm;
> +}

These two function are nearly identical apart from the last line, I
guess that it would be cleaner to have one function and pass the
VIRT_IBMZ_LPAR and VIRT_IBMZ_ZVM constants to select which result we
want.

Other than this, the rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
