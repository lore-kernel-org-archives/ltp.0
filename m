From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 5 Feb 2021 17:03:07 +0100
Subject: [LTP] [PATCH v2 2/4] Add safe functions for io_uring to LTP
 library
In-Reply-To: <YB1qyucNa+aN3p2V@pevik>
References: <20210204110342.11821-1-mdoucha@suse.cz>
 <20210204110342.11821-2-mdoucha@suse.cz> <YB1qyucNa+aN3p2V@pevik>
Message-ID: <28ce5f25-ee74-adad-ba59-d25e3e72aa1d@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05. 02. 21 16:56, Petr Vorel wrote:
> Hi Martin,
> 
>> +++ b/lib/tst_safe_io_uring.c
> ...
>> +	uring->sqr_base = safe_mmap(file, lineno, NULL, uring->sqr_mapsize,
>> +		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, uring->fd,
>> +		IORING_OFF_SQ_RING);
>> +
>> +	if (uring->sqr_base == MAP_FAILED)
>> +		return -1;
> IMHO this is not needed, safe_mmap() breaks on rval == MAP_FAILED.

Except when called in cleanup() where it prints a warning and returns as
usual. That's why safe_io_uring_init() returns int instead of void in
the first place.

I don't expect that safe_io_uring_init() will be used in cleanup() very
often but I've made all the other SAFE_*() functions cleanup()-safe and
I want to stick with that here as well.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
