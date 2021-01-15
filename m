From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Jan 2021 09:54:05 -0500 (EST)
Subject: [LTP] [PATCH] fs/proc01.c:add known issues
In-Reply-To: <1610672031-5044-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1610672031-5044-1-git-send-email-liuxp11@chinatelecom.cn>
Message-ID: <95241263.33332311.1610722445185.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
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

I'm OK with ignoring it, but commit log could explain more why we get EINVAL
on read here.

