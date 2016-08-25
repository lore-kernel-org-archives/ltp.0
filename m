From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 25 Aug 2016 08:21:41 +0300
Subject: [LTP] [PATCH V2 1/4] memcg/functional: rewrite
In-Reply-To: <20160824134217.GB12443@rei.lan>
References: <1471951555-4230-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160824134217.GB12443@rei.lan>
Message-ID: <57BE8065.7050100@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

On 08/24/2016 04:42 PM, Cyril Hrubis wrote:
> Hi!
>>  shmmax=`cat /proc/sys/kernel/shmmax`
>>  if [ $shmmax -lt $HUGEPAGESIZE ]; then
>> -	echo $(($HUGEPAGESIZE)) > /proc/sys/kernel/shmmax
>> +	ROD "$HUGEPAGESIZE" \> /proc/sys/kernel/shmmax
>            ^
> 	   Missing echo here?
> 
> The rest looks fine.
> 

Added the missing 'echo' and pushed the series.

Thank you for review.
