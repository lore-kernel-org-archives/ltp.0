From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Oct 2016 16:16:52 +0200
Subject: [LTP] [PATCH] readahead02: estimate max readahead size
In-Reply-To: <04ff8b784a23cb62c1413b0b6575238bd5474ca4.1476098569.git.jstancek@redhat.com>
References: <04ff8b784a23cb62c1413b0b6575238bd5474ca4.1476098569.git.jstancek@redhat.com>
Message-ID: <20161010141651.GB1684@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +		do {
> +			TEST(readahead(fd, offset, fsize - offset));
> +			if (TEST_RETURN != 0) {
> +				check_ret(0);
>  				break;
> -		}
> -		check_ret(0);
> +			}
> +
> +			/* estimate max readahead size based on first call */
> +			if (!max_ra_estimate) {
> +				*cached = get_cached_size();
> +				if (*cached > cached_start) {
> +					max_ra_estimate = ((*cached - cached_start)
> +						* 1024 & (~(pagesize - 1)));

I'm just curious, why do we round the value down to pagesize?



I've tried this on the /tmp on Btrfs and got max_ra_estimage nearly ten times
greater than the sysfs value. But apart from that the measured times are pretty
much comparable with the previous version, which suggests that maximal
readahead size on Btrfs is set to ~4M and the limit per device is not
applicable.

Did you get the estimate close to the value of the sysfs file in your
environment?

Your version:

readahead02    0  TINFO  :  creating test file of size: 67108864
readahead02    0  TINFO  :  read_testfile(0)
readahead02    0  TINFO  :  read_testfile(1)
readahead02    0  TINFO  :  max ra estimate: 4177920
readahead02    0  TINFO  :  readahead calls made: 17
readahead02    1  TPASS  :  offset is still at 0 as expected
readahead02    0  TINFO  :  read_testfile(0) took: 103324 usec
readahead02    0  TINFO  :  read_testfile(1) took: 22291 usec
readahead02    0  TINFO  :  read_testfile(0) read: 67190784 bytes
readahead02    0  TINFO  :  read_testfile(1) read: 0 bytes
readahead02    2  TPASS  :  readahead saved some I/O
readahead02    0  TINFO  :  cache can hold at least: 75140 kB
readahead02    0  TINFO  :  read_testfile(0) used cache: 65592 kB
readahead02    0  TINFO  :  read_testfile(1) used cache: 65592 kB
readahead02    3  TPASS  :  using cache as expected


With my patch for Btrfs:

readahead02    0  TINFO  :  creating test file of size: 67108864
readahead02    0  TINFO  :  Looking for device in '/sys/fs/btrfs/60cb755a-ae5c-4059-ae0f-7a11ee9d0e9d/devices/'
readahead02    0  TINFO  :  Reading /sys/fs/btrfs/60cb755a-ae5c-4059-ae0f-7a11ee9d0e9d/devices//sda2/../queue/read_ahead_kb
readahead02    0  TINFO  :  max readahead size is: 524288
readahead02    0  TINFO  :  read_testfile(0)
readahead02    0  TINFO  :  Looking for device in '/sys/fs/btrfs/60cb755a-ae5c-4059-ae0f-7a11ee9d0e9d/devices/'
readahead02    0  TINFO  :  Reading /sys/fs/btrfs/60cb755a-ae5c-4059-ae0f-7a11ee9d0e9d/devices//sda2/../queue/read_ahead_kb
readahead02    0  TINFO  :  max readahead size is: 524288
readahead02    0  TINFO  :  read_testfile(1)
readahead02    0  TINFO  :  Looking for device in '/sys/fs/btrfs/60cb755a-ae5c-4059-ae0f-7a11ee9d0e9d/devices/'
readahead02    0  TINFO  :  Reading /sys/fs/btrfs/60cb755a-ae5c-4059-ae0f-7a11ee9d0e9d/devices//sda2/../queue/read_ahead_kb
readahead02    0  TINFO  :  max readahead size is: 524288
readahead02    1  TPASS  :  expected ret success - returned value = 0
readahead02    2  TPASS  :  offset is still at 0 as expected
readahead02    0  TINFO  :  read_testfile(0) took: 117244 usec
readahead02    0  TINFO  :  read_testfile(1) took: 34219 usec
readahead02    0  TINFO  :  read_testfile(0) read: 67190784 bytes
readahead02    0  TINFO  :  read_testfile(1) read: 0 bytes
readahead02    3  TPASS  :  readahead saved some I/O
readahead02    0  TINFO  :  cache can hold at least: 67068 kB
readahead02    0  TINFO  :  read_testfile(0) used cache: 65592 kB
readahead02    0  TINFO  :  read_testfile(1) used cache: 65592 kB
readahead02    4  TPASS  :  using cache as expected



Btw the test should probably be cleaned up a bit, there are couple of places
that could use SAFE_FILE_SCANF/PRINTF and it should also use monotonic timers
instead of gettimeofday as well...

-- 
Cyril Hrubis
chrubis@suse.cz
