From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 06 Nov 2015 14:54:29 +0300
Subject: [LTP] [PATCH] commands/mkswap: Added new testcase to test
	mkswap(8).
In-Reply-To: <563C37D6.1050707@cn.fujitsu.com>
References: <1446692628-12706-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <563B404D.8040504@oracle.com> <563C37D6.1050707@cn.fujitsu.com>
Message-ID: <563C94F5.9040803@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 11/06/2015 08:17 AM, Guangwen Feng wrote:

>>> +            tst_resm TFAIL "'${mkswap_cmd}' failed."
>>> +            cat temp
>>> +            return
>>> +        fi
>>> +    fi
>>> +
>>> +    if [ -n "$device" ]; then
>>> +        mkswap_verify "$mkswap_op" "$op_arg" "$device" "$size"
>>> +        if [ $? -ne 0 ]; then
>>> +            tst_resm TFAIL "'${mkswap_cmd}' failed, not expected."
>>> +            return
>>> +        fi
>>> +    fi
>>> +
>>> +    tst_resm TPASS "'${mkswap_cmd}' passed."
>>> +}
>>> +
>>> +test1()
>>> +{
>>> +    mkswap_test "" "" "$TST_DEVICE"
>>> +}
>> May be it would be better to call mkswap_test() without such wrappers and the for loop in the end.
>>
> Sorry, do you mean just call mkswap_test() straightforward with different arguments for all these tests?

Right, the same way it is done inside each test*().

Best regards,
Alexey
