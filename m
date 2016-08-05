From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Aug 2016 14:51:45 +0100
Subject: [LTP] [PATCH] tst_test: Propagate SIGINT to test process
In-Reply-To: <321891608.1353493.1470404076410.JavaMail.zimbra@redhat.com>
References: <20160804144508.GA8001@rei.lan>
 <321891608.1353493.1470404076410.JavaMail.zimbra@redhat.com>
Message-ID: <CAFEAcA8aMpXvLYNaqoRCO0x+rkMQ=4oTUM8MZqjoHaaxkbZi+A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 5 August 2016 at 14:34, Jan Stancek <jstancek@redhat.com> wrote:
> ----- Original Message -----
>> From: "Cyril Hrubis" <chrubis@suse.cz>
>> diff --git a/lib/tst_test.c b/lib/tst_test.c
>> index 1bd2619..cd5b049 100644
>> --- a/lib/tst_test.c
>> +++ b/lib/tst_test.c
>> @@ -724,6 +724,16 @@ static void heartbeat_handler(int sig
>> LTP_ATTRIBUTE_UNUSED)
>>       alarm(results->timeout);
>>  }
>>
>> +#define SIGINT_MSG "Sending SIGKILL to test process...\n"
>> +
>> +static void sigint_handler(int sig LTP_ATTRIBUTE_UNUSED)
>> +{
>> +     if (test_pid > 0) {
>> +             (void)write(2, SIGINT_MSG, sizeof(SIGINT_MSG) - 1);
>
> Hi,
>
> This still gives me a warning:
>   tst_test.c: In function ‘sigint_handler’:
>   tst_test.c:732:3: warning: ignoring return value of ‘write’, declared with attribute warn_unused_result [-Wunused-result]
>    (void)write(2, SIGINT_MSG, sizeof(SIGINT_MSG) - 1);
>    ^
> We could use fprintf(stderr):
>   fprintf(stderr, "%s\n", SIGINT_MSG);

fprintf() isn't guaranteed to work inside a signal handler,
unlike write() [see the list of "async-signal-safe" functions
in the signal(7) manpage]. I think the officially recommended
way to shut up this warning is something like

    if (write(fd, msg, len) < len) {
        /* It's OK to ignore the error because ... */
    }

which is a bit longwinded but works.

thanks
-- PMM
