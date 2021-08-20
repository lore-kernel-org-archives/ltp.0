From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Fri, 20 Aug 2021 10:35:15 +0200
Subject: [LTP] [PATCH v4 3/4] syscalls/msgstress03: fix fork failure on
 small memory systems
In-Reply-To: <YR5/qcQyAiFjmVR0@yuki>
References: <20210629121047.100391-1-krzysztof.kozlowski@canonical.com>
 <20210629121047.100391-4-krzysztof.kozlowski@canonical.com>
 <YR5/qcQyAiFjmVR0@yuki>
Message-ID: <b6ea17f6-e31f-8056-c5a1-776a5970eebc@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 19/08/2021 17:58, Cyril Hrubis wrote:
> Hi!
>> +	free_pids = tst_get_free_pids(cleanup);
>> +	if (free_pids < 0) {
>> +		tst_brkm(TBROK, cleanup, "Can't obtain free_pid count");
>> +	} else if (!free_pids) {
>> +		tst_brkm(TBROK, cleanup, "No free pids");
>> +	}
> 
> This looks like copy&paste from msgstress04.c, can we please move this
> snippet to the library function instead?
> 

I can move it.


Best regards,
Krzysztof
