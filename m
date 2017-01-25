From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 25 Jan 2017 12:33:41 +0800
Subject: [LTP] [PATCH 1/2] ltp-aiodio/dio_sparse: Fix write in
	dio_sparse()
In-Reply-To: <20170124134057.GC29054@rei.lan>
References: <1484818349-30539-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20170124134057.GC29054@rei.lan>
Message-ID: <58882AA5.90906@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Thanks for your review.

On 01/24/2017 09:40 PM, Cyril Hrubis wrote:
> Hi!
>> Current code looks buggy because when the offset is greater than
>> or equal to the filesize, it will never happen to do the write
>> in the loop, as a result, ADSP080..ADSP087 do not work actually.
>> Fix it by making sure that we do write writesize bytes.
>>
>> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
>> ---
>>  testcases/kernel/io/ltp-aiodio/dio_sparse.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
>> index 41b9929..3828ed7 100644
>> --- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
>> +++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
>> @@ -78,7 +78,7 @@ int dio_sparse(char *filename, int align, int writesize, int filesize, int offse
>>  
>>  	memset(bufptr, 0, writesize);
>>  	lseek(fd, offset, SEEK_SET);
>> -	for (i = offset; i < filesize;) {
>> +	for (i = 0; i < filesize;) {
>>  		if ((w = write(fd, bufptr, writesize)) != writesize) {
>>  			tst_resm(TBROK | TERRNO, "write() returned %d", w);
>>  			close(fd);
> 
> Hmm, it looks to me like the code actually does what it should have.
> Since we pass a filesize and offset so the test should actually write
> filesize - offset bytes. As far as I can tell the bug here is that the
> test is not checking that filesize > offset before it starts.

Sorry, but shouldn't we write the whole "writesize" from the "offset"?
ADSP080 ADSP081 ADSP082 ADSP083 did reproduce the BUG via above modification...

Best Regards,
Guangwen Feng


