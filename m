From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jul 2016 11:17:53 +0200
Subject: [LTP] [PATCH 1/2] test.sh: make the loop device size can be
	customized
In-Reply-To: <1469598247-23993-1-git-send-email-liwang@redhat.com>
References: <1469598247-23993-1-git-send-email-liwang@redhat.com>
Message-ID: <20160727091753.GA10645@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  tst_acquire_device()
>  {
> +	local dev_size=${1:-100}
> +
>  	if [ -z ${TST_TMPDIR} ]; then
>  		tst_brkm "Use 'tst_tmpdir' before 'tst_acquire_device'"
>  	fi
> @@ -274,7 +276,7 @@ tst_acquire_device()
>  		return
>  	fi
>  
> -	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=102400
> +	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=$(($dev_size*1024))

This is unfortunately not a complete solution. If we want to add
parameter(s) to tst_acquire_device() to specify minimal (and possibly
maximal) device size we have to check the $LTP_DEV device size and fall
back to loopback device if it's not in between the bounds, otherwise the
test will still fail if smaller than requested device was created in
runltp (which is the case at the moment).

-- 
Cyril Hrubis
chrubis@suse.cz
