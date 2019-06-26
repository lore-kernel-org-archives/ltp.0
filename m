From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 26 Jun 2019 04:19:54 -0400 (EDT)
Subject: [LTP] [PATCH v4 2/2] pkey: add test for memory protection keys
In-Reply-To: <20190626071538.29486-2-liwang@redhat.com>
References: <20190626071538.29486-1-liwang@redhat.com>
 <20190626071538.29486-2-liwang@redhat.com>
Message-ID: <285629943.30156546.1561537194409.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> +
> +static void setup(void)
> +{
> +	int i, fd;
> +
> +	if (access(PATH_VM_NRHPS, F_OK)) {
> +		tst_res(TINFO, "Huge page is not supported");
> +		size = getpagesize();
> +		no_hugepage = 1;
> +	} else {
> +		int val;
> +
> +		SAFE_FILE_PRINTF(PATH_VM_NRHPS, "%d", 1);

This is still SAFE write, which may trigger TBROK:

# ./pkey01 
tst_test.c:1100: INFO: Timeout per run is 0h 05m 00s
safe_file_ops.c:301: BROK: Failed to close FILE '/proc/sys/vm/nr_hugepages' at pkey01.c:67: EOPNOTSUPP
safe_macros.c:773: WARN: pkey01.c:91: umount(tmp_pkey) failed: ENOENT
safe_macros.c:184: WARN: pkey01.c:92: rmdir(tmp_pkey) failed: ENOENT

> +
> +		SAFE_FILE_SCANF(PATH_VM_NRHPS, "%d", &val);

safe_file_ops.c:157: BROK: The FILE '/proc/sys/vm/nr_hugepages' ended prematurely at pkey01.c:69

> +		if (val != 1)
> +			tst_brk(TBROK, "nr_hugepages = %d, but expect %d",
> +					val, 1);
> +
> +		size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
> +	}
> +

