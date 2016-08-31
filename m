From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 31 Aug 2016 14:44:22 +0530
Subject: [LTP] [PATCH] readahead02: fix read_ahead_kb file not found
In-Reply-To: <20160830122119.GA23854@rei.lan>
References: <1472296459-31507-1-git-send-email-naresh.kamboju@linaro.org>
 <20160830122119.GA23854@rei.lan>
Message-ID: <CA+G9fYusW=0DSxoM3KDzO-bYpxZNYAcqcOHa4ZmDTdDBQKTB+g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 30 August 2016 at 17:51, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> @@ -193,7 +193,7 @@ static long get_device_readahead(const char *fname)
>>       if (stat(fname, &st) == -1)
>>               tst_brkm(TBROK | TERRNO, cleanup, "stat");
>>       snprintf(buf, sizeof(buf), "/sys/dev/block/%d:%d/queue/read_ahead_kb",
>> -              major(st.st_dev), minor(st.st_dev));
>> +              major(st.st_dev), minor(st.st_dev) & ~31);
>
> So we clear lower five bits of the minor number here. Why exactly that amount?
>
> Shouldn't we just pass zero as a minor number there anyway?

For block device like sda the read_ahead_kb is present in 8:0. if it
sdb it is present at 8:16. like wise
 8:0   sda
 8:16 sdb
 8:32 sdc
 8:48 sdd

I changed my patch to clear lower four bits of the minor number

  minor(st.st_dev) & ~15);

- Naresh

>
>>       SAFE_FILE_SCANF(cleanup, buf, "%ld", &ra_kb);
>>
>>       return ra_kb * 1024;
>> --
>> 1.9.1
>>
>
> --
> Cyril Hrubis
> chrubis@suse.cz
