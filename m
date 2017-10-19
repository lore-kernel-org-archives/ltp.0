From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 19 Oct 2017 10:14:07 +0800
Subject: [LTP] [PATCH] syscalls/keyctl06: Print TFAIL if keyring_read()
 returns wrong size
In-Reply-To: <20171018171912.GA126485@gmail.com>
References: <1508244792-10109-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20171017161239.GA555@zzz.localdomain> <59E6F3D5.8040001@cn.fujitsu.com>
 <20171018171912.GA126485@gmail.com>
Message-ID: <59E80A6F.3030803@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/10/19 1:19, Eric Biggers wrote:
> On Wed, Oct 18, 2017 at 02:25:25PM +0800, Xiao Yang wrote:
>>> It was actually pointed out yesterday that the short return value is a bug in
>>> the kernel patch.  The documented behavior of keyctl_read() (as well as the
>>> actual behavior for the other key types that implement it) is to return the full
>>> count on a short read, rather than a short count.  It's not really intuitive but
>>> I'm going to have to fix it with another kernel patch.
>> Thanks for your explanation.
>> Sorry, i misunderstood the expected return value before.
>>
>>
>>> For now we probably should just make the test accept both return values:
>>>
>>> 	if (TEST_RETURN != sizeof(key_serial_t)&&
>>> 	TEST_RETURN != sizeof(key_ids)) {
>>> 		tst_brk(TBROK, "KEYCTL_READ returned %ld but expected %zu or %zu",
>>> 			TEST_RETURN, sizeof(key_serial_t), sizeof(key_ids));
>>> 	}
>>>
>>> Then once there is another kernel patch, I'll update the test to reference that
>>> commit too, and accept only TEST_RETURN == sizeof(key_ids).
>> Could we update the test to check both return values? as below:
>> if (TEST_RETURN != sizeof(key_ids)) {
>> 	/* keyctl_read() should return the size of buffer required, rather than the size
>> 	 * of data read into buffer. This bug was introduced by the commit:
>> 	 * e645016abc80 ("KEYS: fix writing past end of user-supplied buffer in keyring_read()")
>> 	 */
>> 	if (TEST_RETURN == sizeof(key_serial_t)) {
>> 		tst_brk(TFAIL, "KEYCTL_READ returned %ld but expected %zu",
>> 			TEST_RETURN, sizeof(key_ids));
>> 	}
>>
>> 	tst_brk(TBROK, "KEYCTL_READ returned %ld but expected %zu",
>> 		TEST_RETURN, sizeof(key_ids));
>> }
>>
>> We probably should expose the short return value as a bug, rather than ignore it.
>>
> This will confuse people when the comment at the top of the file says
> "regression test for commit e645016abc80", so people will waste time trying to
> figure out why the test is still failing.  I'd prefer to wait to require the
> full return value until I get a second fix applied, which can then be explicitly
> referenced from the test.
Hi Eric

OK, i got it.  I will send the v2 patch as you suggested.

Thanks,
Xiao Yang
> Eric
>
>
>



