From: Milosz Wasilewski <milosz.wasilewski@linaro.org>
Date: Fri, 27 Jan 2017 13:40:06 +0000
Subject: [LTP] open14 and openat03 failed on arm64
In-Reply-To: <746496870.1567645.1485523265470.JavaMail.zimbra@redhat.com>
References: <CA+G9fYsrnhpUMa3VZ-q7qw8XHFycOuH6hUigZXAhjCcoaiNQHQ@mail.gmail.com>
 <746496870.1567645.1485523265470.JavaMail.zimbra@redhat.com>
Message-ID: <CAJrz+7L9WcMwK7CVQ_0E2OaU=TSETTNTmqu-q-Ox0Cwps3rgtA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 27 January 2017 at 13:21, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
>> From: "Naresh Kamboju" <naresh.kamboju@linaro.org>
>> To: ltp@lists.linux.it
>> Cc: "Milosz Wasilewski" <milosz.wasilewski@linaro.org>
>> Sent: Friday, 27 January, 2017 2:03:27 PM
>> Subject: [LTP] open14 and openat03 failed on arm64
>>
>> Hi LTP Team,
>>
>> Test cases open14.c and openat03.c failed on arm64 on latest Linux kernel
>> 4.9.x.
>
> There was a known glibc bug associated with these 2 tests, and also possible

Do you mean this bug: https://sourceware.org/bugzilla/show_bug.cgi?id=17912 ?
We tested with the patch applied.

Best Regards,
milosz

> issue with tmpfs, see this for details:
>   https://github.com/linux-test-project/ltp/issues/118
>
>>
>> Have you noticed these failures on x86_64 and other architectures and
>> which kernel version ?
>>
>> Test output:
>> -----------------
>> create multiple directories, link files into them
>> and check file permissions
>> file mode read 0, but expected
>> file mode read 0, but expected 7755
>> file mode read 0, but expected 1
>> file mode read 0, but expected 755
>> file mode read 0, but expected 644
>> file mode read 0, but expected 440
>>
>> Linux version 4.9.0-rc6-00086-g3b404a5 (broonie@optimist) (gcc version
>> 5.1.1 20150608 (Linaro GCC 5.1-2015.08) ) #1 SMP PREEMPT Tue Nov 22
>> 04:14:54 GMT 2016
>>
>> Test case is trimmed version of LTP,
>> you can find test case here in this link
>> [1] http://people.linaro.org/~naresh.kamboju/open14-arm64-test.c
>> [2] http://people.linaro.org/~naresh.kamboju/open14-x86-test.c
>>
>> Best regards
>> Naresh Kamboju
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>>
