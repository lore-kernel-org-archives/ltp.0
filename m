From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 10 Oct 2018 08:14:50 -0300
Subject: [LTP] [PATCH] futex/futex_wake04.c: fix issues with hugepages
 and usleep
In-Reply-To: <20181010104317.GB1990@rei>
References: <6903290a-523f-7130-b64f-d1a73b601c38@linaro.org>
 <20181009210602.23261-1-rafael.tinoco@linaro.org> <20181010104317.GB1990@rei>
Message-ID: <74eefcb6-34d2-46e6-8611-0dbdc4cd3ed9@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/10/18 7:43 AM, Cyril Hrubis wrote:
> Hi!
>> This commit fixes 2 observed issues:
>>
>> 1) usleep() time is too small if test is being executed in slower
>> terminal devices (specially embedded systems). Raising it to 0.001
>> seconds was enough to finish 10240 iterations in around 90 seconds in a
>> 4 vcpu kvm guest (fully emulated serial being used as console).
>>
>> 2) Test was changing number of hugepages during setup()/cleanup() phase
>> despite the system had (or not) available hugepages. This was causing
>> overhead of destroying (or creating) hugepages during the test
>> execution.  Now, if system has > 0 hugepages available, the test doesn't
>> touch it.
> 
> Can you please split this into separate patches? Generally it's
> considered a good practice to split unrelated changes like these.

Yes, will do. Ignore my last sentence in the other e-mail on the same 
thread (about this patch). Will post 2 patches "v2".

Thanks a lot Cyril!
