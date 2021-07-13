From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 13 Jul 2021 14:32:26 +0200
Subject: [LTP] Failing test on failing shell commands
In-Reply-To: <YO1/J2pTbSsX2dGb@yuki>
References: <9c05b592-e474-6a3e-2dc1-ec075a0bc558@canonical.com>
 <YO1/J2pTbSsX2dGb@yuki>
Message-ID: <c253160b-7326-8583-9713-8b3978473c7d@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 13/07/2021 13:55, Cyril Hrubis wrote:
> Hi!
>> I have a failing memcg_use_hierarchy_test (in
>> testcases/kernel/controllers/memcg/functional/) which hits unexpected
>> OOM on one of earlier commands, already in the test:
>>
>>  18         echo 1 > memory.use_hierarchy
>>  19         echo $PAGESIZE > memory.limit_in_bytes
>>  20 
>>  21         mkdir subgroup  
>> mkdir: cannot create directory ???subgroup???: Cannot allocate memory
>> /home/ubuntu/ltp-install/testcases/bin/memcg_use_hierarchy_test.sh: 22: cd: can't cd to subgroup
>>
>> The command did not fail, as there is no "set -e" and test fails later.
>> However there could be a case where such failure does not trigger later
>> issue and test is a false-positive.
>>
>> What is the practice for LTP shell tests to handle kind of preparation
>> commands? Maybe this should be something like:
> 
> We do have ROD (as a shorthand for "run or die") in the shell test
> library, so this really should be:
> 
> 	ROD mkdir subgroup

Thanks. This will however fail entire suite (memcg_use_hierarchy_test)
and other tests won't get executed. The failure could be only local, so
other tests are still meaningful.


Best regards,
Krzysztof
