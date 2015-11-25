From: Cedric Hnyda <chnyda@suse.com>
Date: Wed, 25 Nov 2015 11:34:11 +0100
Subject: [LTP] [PATCH V3] controllers/pids: Add new testcases
In-Reply-To: <56557D6F.80906@oracle.com>
References: <1448026487-6079-1-git-send-email-chnyda@suse.com>
 <56557D6F.80906@oracle.com>
Message-ID: <56558EA3.5000607@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 11/25/2015 10:20 AM, Alexey Kodanev wrote:
>> +
>> +    while (1) {
>> +    }
>
> Is it necessary to add a busy loop to completely load CPU? If we only 
> wait, I would add a sleep, something like
>
> while (1)
>      usleep(10);
>

You are absolutely right, it is not needed at all to completely load CPU.
Maybe it would also be better to use sleep rather than usleep.

Best regards,
Cedric

-- 
Cedric Hnyda

