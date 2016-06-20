From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 20 Jun 2016 18:58:26 +0300
Subject: [LTP] new ltp lib doesn't print actual error
In-Reply-To: <20160620121758.GB22157@rei.lan>
References: <57618B7B.9070402@oracle.com> <20160620121758.GB22157@rei.lan>
Message-ID: <576812A2.50600@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 06/20/2016 03:17 PM, Cyril Hrubis wrote:
> Hi!
>> When running a test with the new LTP lib, noticed that if some error
>> occurs in a library (tst_tmpdir.c), it'll print the same message:
>>
>> TMPDIR=/usr ./creat01
>> tst_tmpdir.c:155: BROK: Non-NULL cleanup in newlib!
>>
>> but should be:
>> TMPDIR=/usr ./creat01
>> tst_tmpdir.c:155: BROK: tst_tmpdir: mkdtemp(/usr/creF5DhMS) failed: EACCES
>>
>>
>> May be we should remove the strict check in tst_res.c? Otherwise we
>> don't see the actual error.
> Passing a cleanup callback from newlib testcase is always a mistake
> because it's never executed. I would prefer keeping the check in the
> library.
>
> It does not matter in case of tmpdir_cleanup() since that function only
> prints a warning message. What about removing the tmpdir_cleanup()
> cleanup instead? It does not seem to be useful to me anyway.

Agree, I've checked both old/new lib, and now it looks good. Applied patch.

Thanks,
Alexey

