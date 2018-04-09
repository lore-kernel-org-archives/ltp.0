From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 9 Apr 2018 11:34:49 +0800
Subject: [LTP] [PATCH v2 1/2] preadv/preadv03.c: Add new testcase
In-Reply-To: <20180406130248.GB6328@rei>
References: <20180405110242.GA22835@rei>
 <1523011818-5412-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180406130248.GB6328@rei>
Message-ID: <5ACADF59.5020709@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/04/06 21:02, Cyril Hrubis wrote:
> Hi!
>> +static void setup(void)
>> +{
>> +	pgsz = getpagesize();
>> +	tst_off1 = pgsz;
>> +	tst_off2 = pgsz * 3 / 2;
>> +	exp_sz1 = pgsz;
>> +	exp_sz2 = pgsz / 2;
>> +
>> +	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT | O_DIRECT, 0644);
>> +
>> +	pop_buf = SAFE_MEMALIGN(pgsz, pgsz);
>> +	memset(pop_buf, 0x61, pgsz);
>> +	SAFE_WRITE(1, fd, pop_buf, pgsz);
>> +
>> +	memset(pop_buf, 0x62, pgsz);
>> +	SAFE_WRITE(1, fd, pop_buf, pgsz);
>> +
>> +	rd_iovec = SAFE_MEMALIGN(pgsz, pgsz + sizeof(size_t));
>> +	rd_iovec->iov_base = SAFE_MEMALIGN(pgsz, pgsz);
>> +	rd_iovec->iov_len = pgsz;
> The open(2) manual page says that O_DIRECT buffers should be aligned to
> disk block size which can be queried by BLKSSZGET ioctl(). And I suppose
> that the offsets should be multiple of the disk block size as well.
Hi Cyril,

OK, i will replace page size with block size as you suggested.

Thanks,
Xiao Yang
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	free(pop_buf);
>> +	free(rd_iovec->iov_base);
>> +	free(rd_iovec);
>> +
>> +	if (fd>  0)
>> +		SAFE_CLOSE(fd);
>> +}



