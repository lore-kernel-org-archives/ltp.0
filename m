From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 7 Jan 2020 17:09:08 +0100
Subject: [LTP] [PATCH v3] Use real FS block size in fallocate05
In-Reply-To: <20200107152108.GA27182@rei.lan>
References: <461386048.17251961.1576663655809.JavaMail.zimbra@redhat.com>
 <20191218131533.15323-1-mdoucha@suse.cz> <20200107152108.GA27182@rei.lan>
Message-ID: <c0d44447-8bd2-8dbe-b865-3323ad6bb5b0@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1/7/20 4:21 PM, Cyril Hrubis wrote:
>> +	bufsize = FALLOCATE_BLOCKS * blocksize;
>> +	buf = realloc(buf, bufsize);
>> +
>> +	if (!buf) {
>> +		SAFE_CLOSE(fd);
>> +		tst_brk(TBROK, "Buffer allocation failed");
>> +	}
> 
> Why realloc()? Each filesystem is tested in separately forked process so
> buf can't be anything but NULL here.
> 
> So this should just simply be SAFE_MALLOC() and this piece of code, the
> part that gets the blocksize and allocates the buffer should be moved
> into the test setup() function that is executed also once per
> filesystem. And the free should be in the test cleanup().
> 
> That way we would allocate the buffer only once if the test was executed
> with -i option.

Where is this control flow documented? When some behavior is not
documented, I assume it may change without notice and write my code so
that it will work in every case.

>> -	tst_res(TPASS | TERRNO, "fallocate() on full FS");
>> +	for (tmp = extsize; tmp > 0; tmp -= TST_RET) {
>> +		TEST(write(fd, buf, MIN(bufsize, tmp)));
>>  
>> -	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, FALLOCATE_SIZE);
>> -	if (ret == -1) {
>> -		if (errno == EOPNOTSUPP)
>> +		if (TST_RET <= 0)
>> +			tst_brk(TFAIL | TTERRNO, "write() failed unexpectedly");
> 
> tst_brk(TFAIL, is not allowed at the moment, see:
> 
> https://github.com/linux-test-project/ltp/issues/462
> 
> The only current solution is to tst_res() + return
> 
> Also shouldn't we check for the write size here as well?

I'll fix the tst_brk().

The code above will either fill the extra allocated space to the last
byte, or hit the tst_brk(). No other result is possible. I don't want to
pedantically check for short writes because we're not testing write() here.

I'll implement the rest of your suggestions and resubmit when we get a
reply from Btrfs devs.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
