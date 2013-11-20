Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <deller@gmx.de>) id 1VjDqo-000250-0x
	for ltp-list@lists.sourceforge.net; Wed, 20 Nov 2013 19:54:14 +0000
Received: from mout.gmx.net ([212.227.17.22])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1VjDqm-0000oQ-OH
	for ltp-list@lists.sourceforge.net; Wed, 20 Nov 2013 19:54:13 +0000
Received: from [192.168.178.60] ([84.173.36.225]) by mail.gmx.com (mrgmx102)
	with ESMTPSA (Nemesis) id 0MATlG-1VqPem0cZO-00BfxM for
	<ltp-list@lists.sourceforge.net>; Wed, 20 Nov 2013 20:54:06 +0100
Message-ID: <528D135D.5060204@gmx.de>
Date: Wed, 20 Nov 2013 20:54:05 +0100
From: Helge Deller <deller@gmx.de>
MIME-Version: 1.0
References: <20131119214612.GA2120@p100.box>
	<236728861.37114527.1384935019282.JavaMail.root@redhat.com>
In-Reply-To: <236728861.37114527.1384935019282.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] fix readv01 testcase for parisc architecture
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi Jan,

On 11/20/2013 09:10 AM, Jan Stancek wrote:
>> From: "Helge Deller" <deller@gmx.de>
>> Sent: Tuesday, 19 November, 2013 10:46:12 PM
>> Subject: [LTP] [PATCH] fix readv01 testcase for parisc architecture
>>
>> In the second test of readv01 the rd_iovec[] array was not defined or
>> zero-initialized for vectors which will be accessed by the readv() syscall.
>> This leads to the fact that on the parisc platform the readv syscall accessed
>> random memory which is located behind the array.  Fix this problem by adding
>> two more vectors with address NULL and length 0.
> 
> Hi,
> 
> It shouldn't be behind, since rd_iovec array has size of MAX_IOVEC == 16.

True!
I didn't saw that.
 
> It's partially initialized, and looking at C99 6.7.8.21, I'd expect the
> rest to be zero-initialized as well:
> "If there are fewer initializers in a brace-enclosed list than there are elements or members
> of an aggregate, or fewer characters in a string literal used to initialize an array of known
> size than there are elements in the array, the remainder of the aggregate shall be
> initialized implicitly the same as objects that have static storage duration."
> 
> If you add 'static' to rd_iovec array, does the problem go away?
> What compiler are you using?

Ok, it turned out that it wasn't the fault of the compiler.
It was me who was trying to fix the parisc kernel with all the errors I found
with this testcase and by accident had a buggy kernel running.

So, please ignore this part of my patch.
This specific code in readv01 is correct.

>> Furthermore, in the test2 itself we tell readv() to read 4 vecors, while
>> the error message behind it says that it has read CHUNK bytes "followed
>> by *two* NULL vectors", which then sums up to a total of 3 vectors
>> instead of 4.
>> Fix this by calling readv() with only 3 vectors instead of 4.
> 
> Agreed.

Ok, so if you could just apply this second hunk it would be great!

Thanks for maintaining LTP!
It helped me a lot to find bugs in the parisc arch code of the kernel.

Helge 

>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/testcases/kernel/syscalls/readv/readv01.c
>> b/testcases/kernel/syscalls/readv/readv01.c
>> index d92c1be..ca83310 100644
>> --- a/testcases/kernel/syscalls/readv/readv01.c
>> +++ b/testcases/kernel/syscalls/readv/readv01.c
>> @@ -66,7 +66,9 @@ struct iovec rd_iovec[MAX_IOVEC] = {
>>  	{(buf2 + CHUNK * 10), CHUNK},
>>  
>>  	/* Test case #2 */
>> -	{(buf2 + CHUNK * 11), CHUNK}
>> +	{(buf2 + CHUNK * 11), CHUNK},
>> +	{NULL, 0},
>> +	{NULL, 0}
>>  };
>>  
>>  char f_name[K_1];
>> @@ -112,7 +114,7 @@ int main(int ac, char **av)
>>  
>>  //test2:
>>  		l_seek(fd, CHUNK * 12, 0);
>> -		if (readv(fd, (rd_iovec + 1), 4) != CHUNK) {
>> +		if (readv(fd, (rd_iovec + 1), 3) != CHUNK) {
>>  			tst_resm(TFAIL, "readv failed reading %d bytes, "
>>  				 "followed by two NULL vectors", CHUNK);
>>  		} else {
>>


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
