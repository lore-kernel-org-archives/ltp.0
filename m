From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Fri, 16 Dec 2016 13:04:48 +0000 (UTC)
Subject: [LTP] [PATCH] Fix wrong checking of aarch64
In-Reply-To: <5853BCC7.5090704@huawei.com>
References: <20161216010048.7820-1-the_hoang0709@yahoo.com>
 <5853BCC7.5090704@huawei.com>
Message-ID: <1305741347.4446218.1481893488832@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,
I've sent the 2nd version, please let me know if there's any issue.
Thanks and regards,
Hoang

      From: Cui Bixuan <cuibixuan@huawei.com>
 To: ltp@lists.linux.it 
 Sent: Friday, 16 December 2016, 17:07
 Subject: Re: [LTP] [PATCH] Fix wrong checking of aarch64
   
On 2016/12/16 9:00, the_hoang0709@yahoo.com wrote:
> 
> Signed-off-by: Vertigo <the_hoang0709@yahoo.com>
> ---
>  testcases/kernel/mem/tunable/max_map_count.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Oh, I don't notice this mail and send a patch today(when I find it error in ARM).
I forward it to you :-)

I guess you can add message into your patch to explain it.
And I find the same error in aarch64be system. Could you help me to add check for the aarch64_be?

Thank you very much,
Cui Bixuan
> 
> 
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp


   
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161216/a3f3a15d/attachment.html>
