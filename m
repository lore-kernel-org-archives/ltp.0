From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 9 Jun 2016 15:06:25 +0300
Subject: [LTP] [PATCH] tst_test.h: include tst_kvercmp.h
In-Reply-To: <20160606132216.GB21264@rei>
References: <1464956996-26578-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160606132216.GB21264@rei>
Message-ID: <57595BC1.4070803@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 06/06/2016 04:22 PM, Cyril Hrubis wrote:
> Hi!
>> tst_kvercmp.h is included in test.h, but is not included in tst_test.h.
>> Fixed it.
>
> We should remove the include from lib/tst_test.c in this patch as well.
>
> Other than that acked.
>

Li, Cyril, the patch was updated to remove all explicit includes of 
tst_kvercmp.h in .c files and pushed.

Thank you for your feedback.
