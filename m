From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 11 Oct 2016 09:39:21 +0200
Subject: [LTP] [PATCH v2 3/3] writev01: rewrite and drop partially valid
 iovec tests
In-Reply-To: <20161010160346.GG1684@rei>
References: <81176684cd5c6bf764a070b79783f03f0037658a.1475827191.git.jstancek@redhat.com>
 <d6b408e9dcb22db9c362377a2d35876fdb6d7096.1475827191.git.jstancek@redhat.com>
 <20161010160346.GG1684@rei>
Message-ID: <57FC9729.7000107@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/10/2016 06:03 PM, Cyril Hrubis wrote:
>> +
>> +static void test_writev(unsigned int i)
>> +{
>> +	struct testcase_t *tcase = &testcases[i];
>> +	int ret;
>> +
>> +	TEST(writev(*(tcase->pfd), *(tcase->piovec), tcase->iovcnt));
>> +
>> +	ret = (TEST_RETURN == tcase->exp_ret);
>> +	if (TEST_RETURN < 0 || tcase->exp_ret < 0)
>> +		ret &= (TEST_ERRNO == tcase->exp_errno);
>> +
>> +	if (ret) {
>> +		tst_res(TPASS | TTERRNO, "%s, ret: %ld", tcase->desc,
>> +			TEST_RETURN);
>> +	} else {
>> +		tst_res(TPASS | TTERRNO, "%s, ret: %ld", tcase->desc,
>                          ^
> 			 TFAIL?
> 
>> +			TEST_RETURN);
>> +	}
> 
> Also I would have created separate functions for failure/success tests
> so that we can print more informative results, i.e. include the expected
> errno in the TFAIL result message.
> 
> Apart from that this is much better than the original.
> 

How about:

static void test_writev(unsigned int i)
{
        struct testcase_t *tcase = &testcases[i];
        int ret;

        TEST(writev(*(tcase->pfd), *(tcase->piovec), tcase->iovcnt));

        ret = (TEST_RETURN == tcase->exp_ret);
        if (TEST_RETURN < 0 || tcase->exp_ret < 0) {
                ret &= (TEST_ERRNO == tcase->exp_errno);
                tst_res((ret ? TPASS : TFAIL),
                        "%s, expected: %d (%s), got: %ld (%s)", tcase->desc,
                        tcase->exp_ret, tst_strerrno(tcase->exp_errno),
                        TEST_RETURN, tst_strerrno(TEST_ERRNO));
        } else {
                tst_res((ret ? TPASS : TFAIL),
                        "%s, expected: %d, got: %ld", tcase->desc,
                        tcase->exp_ret, TEST_RETURN);
        }
}

$ ./writev01
tst_test.c:756: INFO: Timeout per run is 0h 05m 00s
writev01.c:139: PASS: invalid iov_len, expected: -1 (EINVAL), got: -1 (EINVAL)
writev01.c:139: PASS: invalid fd, expected: -1 (EBADF), got: -1 (EBADF)
writev01.c:139: PASS: invalid iovcnt, expected: -1 (EINVAL), got: -1 (EINVAL)
writev01.c:143: PASS: zero iovcnt, expected: 0, got: 0
writev01.c:143: PASS: NULL and zero length iovec, expected: 64, got: 64
writev01.c:139: PASS: write to closed pipe, expected: -1 (EPIPE), got: -1 (EPIPE)

Regards,
Jan

