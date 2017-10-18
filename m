From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 18 Oct 2017 14:25:25 +0800
Subject: [LTP] [PATCH] syscalls/keyctl06: Print TFAIL if keyring_read()
 returns wrong size
In-Reply-To: <20171017161239.GA555@zzz.localdomain>
References: <1508244792-10109-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20171017161239.GA555@zzz.localdomain>
Message-ID: <59E6F3D5.8040001@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Eric,

On 2017/10/18 0:12, Eric Biggers wrote:

> Hi Xiao,
>
> On Tue, Oct 17, 2017 at 08:53:12PM +0800, Xiao Yang wrote:
>> According to keyctl06's message, the mentioned bug is introduced
>> by the following patch which is merged into kernel since v3.13:
>> 'b2a4df200d57 ("KEYS: Expand the capacity of a keyring")'
>>
>> However, we still got the following output before v3.13:
>>   tst_test.c:958: INFO: Timeout per run is 0h 05m 00s
>>   keyctl06.c:60: BROK: KEYCTL_READ returned 8 but expected 4
>>
>> In old kernels, the output exposed that keyring_read() could not
>> return the size of data read into buffer, because it just returned
>> the size of a keyring.  So i think this issue should be targeted
>> as TFAIL.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/keyctl/keyctl06.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/syscalls/keyctl/keyctl06.c b/testcases/ker=
nel/syscalls/keyctl/keyctl06.c
>> index 8873431..bf30fb6 100644
>> --- a/testcases/kernel/syscalls/keyctl/keyctl06.c
>> +++ b/testcases/kernel/syscalls/keyctl/keyctl06.c
>> @@ -56,7 +56,7 @@ static void do_test(void)
>>   		tst_brk(TBROK, "KEYCTL_READ didn't return correct key ID");
>>
>>   	if (TEST_RETURN !=3D sizeof(key_serial_t)) {
>> -		tst_brk(TBROK, "KEYCTL_READ returned %ld but expected %zu",
>> +		tst_brk(TFAIL, "KEYCTL_READ returned %ld but expected %zu",
>>   			TEST_RETURN, sizeof(key_serial_t));
>>   	}
>>
> It was actually pointed out yesterday that the short return value is a bu=
g in
> the kernel patch.  The documented behavior of keyctl_read() (as well as t=
he
> actual behavior for the other key types that implement it) is to return t=
he full
> count on a short read, rather than a short count.  It's not really intuit=
ive but
> I'm going to have to fix it with another kernel patch.
Thanks for your explanation.
Sorry, i misunderstood the expected return value before.


> For now we probably should just make the test accept both return values:
>
> 	if (TEST_RETURN !=3D sizeof(key_serial_t)&&
> 	TEST_RETURN !=3D sizeof(key_ids)) {
> 		tst_brk(TBROK, "KEYCTL_READ returned %ld but expected %zu or %zu",
> 			TEST_RETURN, sizeof(key_serial_t), sizeof(key_ids));
> 	}
>
> Then once there is another kernel patch, I'll update the test to referenc=
e that
> commit too, and accept only TEST_RETURN =3D=3D sizeof(key_ids).
Could we update the test to check both return values? as below:
if (TEST_RETURN !=3D sizeof(key_ids)) {
	/* keyctl_read() should return the size of buffer required, rather than th=
e size
	 * of data read into buffer. This bug was introduced by the commit:
	 * e645016abc80 ("KEYS: fix writing past end of user-supplied buffer in ke=
yring_read()")
	 */
	if (TEST_RETURN =3D=3D sizeof(key_serial_t)) {
		tst_brk(TFAIL, "KEYCTL_READ returned %ld but expected %zu",
			TEST_RETURN, sizeof(key_ids));
	}

	tst_brk(TBROK, "KEYCTL_READ returned %ld but expected %zu",
		TEST_RETURN, sizeof(key_ids));
}

We probably should expose the short return value as a bug, rather than igno=
re it.


> There is also the question of whether anything should be read at all when=
 the
> buffer is too small.  Currently the test assumes that a short read is don=
e.
> Unfortunately, there is no simple answer to that question as the document=
ation
> for keyctl_read() and implementations are all inconsistent.
I also find the documentation and implementations are inconsistent, and eit=
her of
them may need to update.

Thanks=EF=BC=8C
Xiao yang


> Eric
>
>
>



