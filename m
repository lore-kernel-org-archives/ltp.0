From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 1 Nov 2017 15:33:06 +0300
Subject: [LTP] [PATCH 2/3] lib: tst_rhost_run: new option -B for saving
 background log
In-Reply-To: <20171031101847.o5yimjvbwhkvecs7@dell5510>
References: <1507812041-2068-1-git-send-email-alexey.kodanev@oracle.com>
 <1507812041-2068-2-git-send-email-alexey.kodanev@oracle.com>
 <20171031101847.o5yimjvbwhkvecs7@dell5510>
Message-ID: <24ecad00-a467-5d33-5fb0-f5512b8062e8@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/31/2017 01:18 PM, Petr Vorel wrote:
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
>> ---
>>  testcases/lib/test_net.sh |   10 ++++++----
>>  1 files changed, 6 insertions(+), 4 deletions(-)
> <snip>
>
>>  		case "$opt" in
>> -		b) [ "$TST_USE_NETNS" ] && pre_cmd="" || pre_cmd="nohup"
>> -		   post_cmd=" > /dev/null 2>&1 &"
>> +		b|B) [ "$TST_USE_NETNS" ] && pre_cmd="" || pre_cmd="nohup"
> Minor nit: use cmd=
> 		b|B) [ "$TST_USE_NETNS" ] && pre_cmd= || pre_cmd="nohup"

Corrected and pushed.

Thanks,
Alexey

