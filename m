From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 27 Jan 2017 17:07:08 +0300
Subject: [LTP] [PATCH 3/3] netstress.c: convert to new library API
In-Reply-To: <20170123145734.GC25788@rei.lan>
References: <1482154595-4641-1-git-send-email-alexey.kodanev@oracle.com>
 <1482154595-4641-3-git-send-email-alexey.kodanev@oracle.com>
 <20170123145734.GC25788@rei.lan>
Message-ID: <837482ef-0ac4-0a3b-3c4e-598ed6ce96e1@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 01/23/2017 05:57 PM, Cyril Hrubis wrote:
> Hi!
>>   	shutdown(*fd, SHUT_WR);
>> -	SAFE_CLOSE(cleanup, *fd);
>> +	SAFE_CLOSE(*fd);
>>   	*fd = -1;
> FYI the SAFE_CLOSE() already sets fd to -1.

Ah, it's not, 'fd' passed by value there... I've blindly removed it
from code but now I need to return it back.

Best regards,
Alexey

