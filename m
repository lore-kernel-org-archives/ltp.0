From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 15 Jan 2021 11:49:42 +0100
Subject: [LTP] [PATCH] fs/proc01.c:add known issues
In-Reply-To: <1610672031-5044-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1610672031-5044-1-git-send-email-liuxp11@chinatelecom.cn>
Message-ID: <b575ead7-dcc2-f4ab-49d2-eac727469187@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 1/15/2021 1:53 AM, Xinpeng Liu wrote:
> Test in ubuntu20.10,there are several failure tests.
>
> proc01      1  TFAIL  :  proc01.c:396: read failed:
> /proc/self/task/61595/attr/smack/current: errno=EINVAL(22): Invalid argument
> proc01      2  TFAIL  :  proc01.c:396: read failed:
> /proc/self/task/61595/attr/apparmor/prev: errno=EINVAL(22): Invalid argument
> proc01      3  TFAIL  :  proc01.c:396: read failed:
> /proc/self/task/61595/attr/apparmor/exec: errno=EINVAL(22): Invalid argument
> proc01      4  TFAIL  :  proc01.c:396: read failed:
> /proc/self/attr/smack/current: errno=EINVAL(22): Invalid argument
> proc01      5  TFAIL  :  proc01.c:396: read failed:
> /proc/self/attr/apparmor/prev: errno=EINVAL(22): Invalid argument
> proc01      6  TFAIL  :  proc01.c:396: read failed:
> /proc/self/attr/apparmor/exec: errno=EINVAL(22): Invalid argument
>
> Signed-off-by: Xinpeng Liu <liuxp11@chinatelecom.cn>

Reviewed-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Tested on ubuntu 20.04.
I guess it is ok to completely exclude smack and apparmor folders from 
the test. Maybe there are some files in there, that can be read without 
error, but I think that should be up to testcases for these features.

J?rg
