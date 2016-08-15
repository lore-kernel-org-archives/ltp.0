From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Aug 2016 13:40:54 +0200
Subject: [LTP] [PATCH v2 2/2] test.sh: make the loop device size can be
 customized
In-Reply-To: <1469683059-6318-1-git-send-email-liwang@redhat.com>
References: <1469683059-6318-1-git-send-email-liwang@redhat.com>
Message-ID: <20160815114054.GB20680@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  tst_acquire_device()
>  {
> +	local acq_dev_size=${1:-150}
> +
>  	if [ -z ${TST_TMPDIR} ]; then
>  		tst_brkm "Use 'tst_tmpdir' before 'tst_acquire_device'"
>  	fi
>  
> -	if [ -n "${LTP_DEV}" ]; then
> +	if [ -n "${LTP_DEV}" ] && [ ${acq_dev_size} -eq 150 ]; then

This is, unfortunately, not as simple as this either.

The $LTP_DEV could be passed to runltp as a command line parameter and
could point to a real block device backed up by a disk. So there is no
guarantee that it will be 150MB in size.

What we have to do is to get the size of whatever is in $LTP_DEV here
and return it if it has at least the requested size.

>  		tst_resm TINFO "Using test device LTP_DEV='${LTP_DEV}'"
>  		if [ ! -b ${LTP_DEV} ]; then
>  			tst_brkm TBROK "${LTP_DEV} is not a block device"
> @@ -274,7 +276,7 @@ tst_acquire_device()
>  		return
>  	fi
>  
> -	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=153600
> +	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=$((1024*$acq_dev_size))
>  
>  	TST_DEVICE=$(losetup -f)
>  	if [ $? -ne 0 ]; then

-- 
Cyril Hrubis
chrubis@suse.cz
