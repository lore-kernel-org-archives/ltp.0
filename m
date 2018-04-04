From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 4 Apr 2018 16:58:47 +0300
Subject: [LTP] [RFC] tst_check_cmds to exit only current test
In-Reply-To: <20180404134612.y23nxu27r3eoyx4t@dell5510>
References: <20180329114536.vsmsjzatryu4h5dm@dell5510>
 <20180404131501.GH32109@rei> <20180404134612.y23nxu27r3eoyx4t@dell5510>
Message-ID: <54d0b42c-55ed-0f10-8e6c-ba901c08b54b@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04.04.2018 16:46, Petr Vorel wrote:
> Hi Alexey,
> 
>>> Is it valid approach approach or should we use getopts to run the test twice?
> 
>> That is a valid approach as well, we can just do:
> 
>> if-addr-adddel_ifconfig if-addr-adddel ifconfig
>> if-addr-adddel_ip if-addr-adddel ip
> 
>> in the runtest file, which would make the test results more detailed,
>> as it will be clear what was actually skipped, which is always nice.
> Any objection to this? I'd prefer to use this way (changed in all interface tests).

No, I agree.
