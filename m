From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Nov 2017 18:43:40 +0800
Subject: [LTP] [PATCH v3 15/16] fs/fs_fill: Add a test to fill a FS in a
 few threads
In-Reply-To: <20171109101915.GA7738@rei>
References: <20171011144130.29728-1-chrubis@suse.cz>
 <20171011144130.29728-15-chrubis@suse.cz>
 <CAEemH2f8Dya2XUvZZ2t9XMbbVFo_tM5B=LuzjZqyB8ZCA6qvVA@mail.gmail.com>
 <20171109101915.GA7738@rei>
Message-ID: <CAEemH2eNcwa6FpnEHVBtTp=rBFCVwrGBO6sZ9=P1m5hRb=zRDQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 9, 2017 at 6:19 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> This case always broken in SAFE_* operations, seems the reason is no
>> space left on the device,
>> so I wonder if is it necessary to create so many thread "CPUs + 2" to
>> run the test?
>>
>> What about just creating half of CPU number thread (nthreads =
>> tst_ncpus_conf()/2 + 1) there?
>>
>> $ git diff
>> diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c
>> b/testcases/kernel/fs/fs_fill/fs_fill.c
>> index a50a22f..13207c4 100644
>> --- a/testcases/kernel/fs/fs_fill/fs_fill.c
>> +++ b/testcases/kernel/fs/fs_fill/fs_fill.c
>> @@ -106,7 +106,7 @@ static void testrun(void)
>>
>>  static void setup(void)
>>  {
>> -       nthreads = tst_ncpus_conf() + 2;
>> +       nthreads = tst_ncpus_conf()/2 + 1;
>>
>>         tst_res(TINFO, "Running %i writer threads", nthreads);
>>  }
>
> This does not fix the problem, only makes it less likely.

Actually yes. Retest and failed again.

>
> The correct fix is to use open() instead of SAFE_OPEN() in the
> tst_fill_fs() and just return from the function when we get ENOSPC. I
> can fix that, or you can send the patch. Either way thanks for pointing
> out the mistake.

The broken are not only in tst_fills_fs() function but also come from
SAFE_MKDIR(w->dir, 0700),
SAFE_OPENDIR(w->dir) and SAFE_UNLINK(file).

   safe_macros.c:169: BROK: fs_fill.c:49:
mkdir(mntpoint/thread21,0700) failed: ENOSPC

If we just handle the 'ENOSPC' in tst_fill_fs(), I doubt that test
will be broken as well.


-- 
Li Wang
liwang@redhat.com
