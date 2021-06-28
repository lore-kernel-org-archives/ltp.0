From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Mon, 28 Jun 2021 12:47:57 +0300
Subject: [LTP] [PATCH 1/2] lib/tst_test: setup TCID earlier in do_setup()
In-Reply-To: <YNWhdgAUp5e/hNwx@yuki>
References: <20210624081500.11715-1-aleksei.kodanev@bell-sw.com>
 <YNWhdgAUp5e/hNwx@yuki>
Message-ID: <e65771c9-709e-e6a6-977b-90c6ca194d08@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Cyril,
On 25.06.2021 12:27, Cyril Hrubis wrote:
> Hi!
>> TCID can be NULL in tst_tmpdir() because it is set after do_setup():
>>
>>     tst_run_tcases()
>>         do_setup()
>>             ...
>>             tid = get_tid();
>>             ...
>>             tst_tmpdir()  /* using TCID here */
>>         TCID = tid;
> 
> Good catch, I wonder how we missed this for so long...

Ran into this with musl, it pastes "(null)" to the tmpdir path if
TCID is NULL, so the final template looked like "/tmp/(nuXXXXXX".
But glibc skips it because the same string doesn't fit in 3 chars
template in snprintf(..., "%s/%.3sXXXXXX",...).

Applied the patch. Thanks for review!
