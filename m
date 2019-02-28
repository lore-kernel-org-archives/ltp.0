From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 28 Feb 2019 16:04:34 +0300
Subject: [LTP] [PATCH 1/2] lib/tst_net.sh: don't treat TWARN/TCONF as
 failure in tst_netload()
In-Reply-To: <20190226182607.GB27937@dell5510>
References: <1551198213-10024-1-git-send-email-alexey.kodanev@oracle.com>
 <20190226182607.GB27937@dell5510>
Message-ID: <2a8114f2-93b2-0925-c4af-0d8c40b66281@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26.02.2019 21:26, Petr Vorel wrote:
...
>> -	if [ "$expect_ret" -ne "$ret" ]; then
>> +	if [ "$expect_ret" -ne 0 ]; then
>> +		if [ $((ret & expect_ret)) -ne 0 ]; then
>> +			tst_res_ TPASS "netstress failed as expected"
>> +		else
>> +			tst_res_ TFAIL "unexpected pass, ret is $ret"
> I like the previous one, which mentioned what was expected. maybe something
> like:
> 			tst_res_ TFAIL "unexpected pass, expected '$expect_ret', but ret: $ret"
> 
> Or even mention $expect_res, which is word (not number)?

Applied with $expect_res. Thanks for review Petr!
