From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 14 Aug 2019 14:54:21 +0300
Subject: [LTP] [PATCH 1/1] zram01: Improve error detection
In-Reply-To: <20190812073837.18016-1-pvorel@suse.cz>
References: <20190812073837.18016-1-pvorel@suse.cz>
Message-ID: <9f601d2c-e0cd-8d9d-d47d-123bc42fbe67@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 12.08.2019 10:38, Petr Vorel wrote:
> * print dd stderr, if any
> * TBROK when detected size is 0
> * TBROK if actually used memory is 0, this fixes division by 0:
> 
> Sometimes free reports no memory use by zram, which leads to division by 0:
> zram01 8 TINFO: zram used 0M, zram disk sizes 104857600M
> /opt/ltp/testcases/bin/zram01.sh: line 87: 100 * 104857600 / 0: division by 0 (error token is "0")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Not sure what is a small memory which should be detected. 100 KB?
> Maybe we could TBROK on 0 and TWARN on some small value.
> 
> I found this problem on ppc64le, but I can reproduce it on intel VM.
> zram driver gets into some broken state, so next run of this test it
> does not work at all:
> can't set 'lzo' to /sys/block/zram0/comp_algorithm
> 
> after reboot it's shows it's no space error, but test works (huh):
> zram01 7 TINFO: fill zram0...
> zram01 7 TWARN: dd error: dd: error writing 'zram0/file': No space left on device
> zram01 7 TINFO: zram0 can be filled with '20628' KB
> zram01 7 TINFO: fill zram1...
> zram01 7 TWARN: dd error: dd: error writing 'zram1/file': No space left on device
> zram01 7 TINFO: zram1 can be filled with '20140' KB
> zram01 7 TINFO: fill zram2...
> zram01 7 TWARN: dd error: dd: error writing 'zram2/file': No space left on device
> zram01 7 TINFO: zram2 can be filled with '24724' KB
> zram01 7 TINFO: fill zram3...
> zram01 7 TWARN: dd error: dd: error writing 'zram3/file': No space left on device
> zram01 7 TINFO: zram3 can be filled with '24724' KB
> zram01 7 TINFO: zram used 92M, zram disk sizes 104857600M
> zram01 7 TPASS: compression ratio: 1139756.52:1
> zram01 8 TINFO: zram cleanup
> 
> Thus there are error messages from zram_cleanup. Do we want to suppress
> them? (I'd keep it).
> sh: echo: I/O error

Such TWARNs can be misleading, the test is writing until this error,
so this is part of the normal test run...

> 
> Kind regards,
> Petr
> ---
>  testcases/kernel/device-drivers/zram/zram01.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
> index b3ed5170d..a06c0dc17 100755
> --- a/testcases/kernel/device-drivers/zram/zram01.sh
> +++ b/testcases/kernel/device-drivers/zram/zram01.sh
> @@ -67,9 +67,11 @@ zram_fill_fs()
>  		while true; do
>  			dd conv=notrunc if=/dev/zero of=zram${i}/file \
>  				oflag=append count=1 bs=1024 status=none \
> -				> /dev/null 2>&1 || break
> +				2>err.txt || break
>  			b=$(($b + 1))
>  		done
> +		[ -s err.txt ] && tst_resm TWARN "dd error: $(cat err.txt)"
> +		[ $b -eq 0 ] && tst_brkm TBROK "cannot fill zram"
>  		tst_resm TINFO "zram$i can be filled with '$b' KB"
>  	done
>  
> @@ -82,6 +84,8 @@ zram_fill_fs()
>  		total_size=$(($total_size + $s))
>  	done
>  
> +	[ $used_mem -eq 0 ] && tst_brkm TBROK "no memory used by zram"
> +
>  	tst_resm TINFO "zram used ${used_mem}M, zram disk sizes ${total_size}M"
>  
>  	local v=$((100 * $total_size / $used_mem))
> 

